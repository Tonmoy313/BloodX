#!/usr/bin/env bash
# Protects the main branch. Dry run by default; pass --apply to send.
# Needs repo admin and `gh auth login`. The `ci` check must have run once before it can be required.
# Private repos may need a paid GitHub plan for branch protection. Verify current API fields in GitHub docs.
set -euo pipefail
APPLY=0; [ "${1:-}" = "--apply" ] && APPLY=1
BRANCH="${BRANCH:-main}"
read -r -d '' PAYLOAD <<'JSON' || true
{
  "required_status_checks": { "strict": true, "contexts": ["ci"] },
  "enforce_admins": true,
  "required_pull_request_reviews": { "required_approving_review_count": 0 },
  "restrictions": null,
  "required_linear_history": true,
  "allow_force_pushes": false,
  "allow_deletions": false
}
JSON
if [ "$APPLY" = 1 ]; then
  command -v gh >/dev/null || { echo "gh CLI not found"; exit 1; }
  printf '%s' "$PAYLOAD" | gh api -X PUT "repos/:owner/:repo/branches/$BRANCH/protection" --input -
  echo "Protected $BRANCH."
else
  echo "DRY RUN: would protect '$BRANCH' with:"
  echo "$PAYLOAD"
fi
