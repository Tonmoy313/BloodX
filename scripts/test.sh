#!/usr/bin/env bash
# Runs tests for existing packages. Usage: scripts/test.sh [package]
set -uo pipefail
cd "$(dirname "$0")/.."
PKGS="${1:-blood_server blood_client blood_flutter blood_admin}"
fail=0
for p in $PKGS; do
  [ -f "$p/pubspec.yaml" ] || continue
  [ -d "$p/test" ] || continue
  if grep -q '^[[:space:]]*flutter:' "$p/pubspec.yaml"; then cmd="flutter test"; else cmd="dart test"; fi
  if ! out=$(cd "$p" && $cmd 2>&1); then
    echo "FAIL: tests ($p)"
    echo "$out" | tail -n 60
    fail=1
  fi
done
[ "$fail" = 0 ] && echo "test: OK"
exit $fail
