#!/usr/bin/env bash
# Creates GitHub labels, one milestone per phase, one issue per task in docs/phases/P*.md,
# and one issue per open question in docs/STATE.md.
#
#   bash scripts/gh_bootstrap.sh            dry run: prints what it would do
#   bash scripts/gh_bootstrap.sh --apply    creates everything (needs `gh auth login`)
#
# Safe to re-run: labels are updated; existing milestones and issues are skipped.
set -euo pipefail
cd "$(dirname "$0")/.."

APPLY=0; [ "${1:-}" = "--apply" ] && APPLY=1
PHASE_GLOB="docs/phases/P[0-7].md"
MEMORY_FILE="docs/STATE.md"

run() {
  if [ "$APPLY" = 1 ]; then "$@"; else printf 'DRY:'; printf ' %q' "$@"; printf '\n'; fi
}

existing_issues=""; existing_milestones=""
if [ "$APPLY" = 1 ]; then
  command -v gh >/dev/null || { echo "gh CLI not found. Install it, then run: gh auth login"; exit 1; }
  gh auth status >/dev/null 2>&1 || { echo "Not logged in. Run: gh auth login"; exit 1; }
  existing_issues=$(gh issue list --state all --limit 1000 --json title --jq '.[].title' || true)
  existing_milestones=$(gh api "repos/:owner/:repo/milestones?state=all&per_page=100" --jq '.[].title' || true)
fi

# ---- labels ----
make_label() { run gh label create "$1" --color "$2" --description "$3" --force; }
make_label "safety-critical" "B60205" "Pledges, timers, notifications, eligibility, health data, contact reveal, authorization"
make_label "blocked"         "D93F0B" "Waiting on a decision or dependency"
make_label "decision-needed" "FBCA04" "Open question for the owner"
for n in 0 1 2 3 4 5 6 7; do make_label "phase:P$n" "0E8A16" "Phase P$n"; done

# ---- milestones (one per phase) ----
cat $PHASE_GLOB | grep -E '^## P[0-7] — ' | sed -E 's/^## //' | while IFS= read -r ms; do
  if printf '%s\n' "$existing_milestones" | grep -Fxq "$ms"; then
    echo "skip milestone: $ms"
  else
    run gh api "repos/:owner/:repo/milestones" -f title="$ms"
  fi
done

# ---- task issues ----
awk '
/^## P[0-7] — / { split($0,a," — "); sub(/^## /,"",a[1]); phase=a[1]; ptitle=a[2]; next }
/^- \[[ ~x!]\] \*\*P[0-7]-[0-9]+\*\* / {
  line=$0
  status=substr(line,4,1)
  match(line,/\*\*P[0-7]-[0-9]+\*\*/)
  id=substr(line,RSTART+2,RLENGTH-4)
  text=substr(line,RSTART+RLENGTH+1)
  print phase "\t" ptitle "\t" status "\t" id "\t" text
}' $PHASE_GLOB | while IFS=$'\t' read -r phase ptitle status id text; do
  [ "$status" = "x" ] && continue
  if printf '%s\n' "$existing_issues" | grep -Eq "^$id "; then echo "skip issue: $id"; continue; fi
  short=$(printf '%s' "$text" | sed -E 's/;.*$//; s/ \(.*$//; s/[[:space:]]+$//')
  [ -z "$short" ] && short="$text"
  title="$id ${short:0:80}"
  labels="phase:$phase"
  if printf '%s' "$text" | grep -Eqi 'pledge|state machine|wave|notification|reveal|eligib|deferral|health|account deletion|sweeper|readiness|release|authoriz|idempoten|upload|availability'; then labels="$labels,safety-critical"; fi
  if [ "$status" = "!" ] || printf '%s' "$text" | grep -qi 'blocked'; then labels="$labels,blocked"; fi
  body=$(printf '**Task %s:** %s\n\n**Phase:** %s — %s\n**Plan:** docs/phases/%s.md (exit criteria are at the end)\n**Read first:** AGENTS.md, docs/STATE.md, then the one spec file the phase file names\n\nStatus lives in the PR that closes this issue: it must also tick the box in the phase file.\n' "$id" "$text" "$phase" "$ptitle" "$phase")
  run gh issue create --title "$title" --body "$body" --label "$labels" --milestone "$phase — $ptitle"
done

# ---- open-question issues ----
awk -F'|' '/^\| Q-[0-9]+ \|/ { for(i=2;i<=4;i++){ gsub(/^[ \t]+|[ \t]+$/,"",$i) }; print $2 "\t" $3 "\t" $4 }' "$MEMORY_FILE" |
while IFS=$'\t' read -r qid question default; do
  if printf '%s\n' "$existing_issues" | grep -Eq "^$qid "; then echo "skip issue: $qid"; continue; fi
  title="$qid ${question:0:90}"
  body=$(printf '**Open question %s**\n\n%s\n\n**Temporary default:** %s\n\nAnswer in this issue. The owner then promotes the answer to DECIDED in docs/STATE.md.\n' "$qid" "$question" "$default")
  run gh issue create --title "$title" --body "$body" --label "decision-needed"
done
echo "done ($([ "$APPLY" = 1 ] && echo applied || echo dry run))"
