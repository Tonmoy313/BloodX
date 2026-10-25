#!/usr/bin/env bash
# Quiet quality check: pub get, format, analyze, guards. Prints only failures.
set -uo pipefail
cd "$(dirname "$0")/.."
PKGS="blood_server blood_client blood_flutter blood_admin"
fail=0

run_quiet() { # name dir cmd...
  local name="$1" dir="$2"; shift 2
  local out
  if ! out=$(cd "$dir" && "$@" 2>&1); then
    echo "FAIL: $name ($dir)"
    echo "$out" | tail -n 40
    fail=1
  fi
}

bash scripts/guard_sql.sh || fail=1

found=0
for p in $PKGS; do
  [ -f "$p/pubspec.yaml" ] || continue
  found=1
  if grep -q '^[[:space:]]*flutter:' "$p/pubspec.yaml"; then
    run_quiet "pub get" "$p" flutter pub get
    run_quiet "format"  "$p" dart format --output=none --set-exit-if-changed .
    run_quiet "analyze" "$p" flutter analyze
  else
    run_quiet "pub get" "$p" dart pub get
    run_quiet "format"  "$p" dart format --output=none --set-exit-if-changed .
    run_quiet "analyze" "$p" dart analyze
  fi
done

[ "$found" = 0 ] && echo "check: no packages yet (nothing to analyze)"
[ "$fail" = 0 ] && echo "check: OK"
exit $fail
