#!/usr/bin/env bash
# Fails if raw SQL helpers or print() appear in server code without review.
# Verify the helper names against the Serverpod version you use.
cd "$(dirname "$0")/.." || exit 1
SRC="blood_server/lib"
[ -d "$SRC" ] || exit 0
bad=0
hits=$(grep -rnE 'unsafeQuery|unsafeExecute|unsafeSimpleQuery|unsafeSimpleExecute' "$SRC" --include=*.dart --exclude-dir=generated | grep -v 'sql-reviewed' || true)
if [ -n "$hits" ]; then
  echo "$hits"
  echo "GUARD: raw SQL found. Use the typed ORM, or add '// sql-reviewed' on a parameterized query with owner approval."
  bad=1
fi
hits=$(grep -rnE '^[[:space:]]*print\(' "$SRC" --include=*.dart --exclude-dir=generated || true)
if [ -n "$hits" ]; then
  echo "$hits"
  echo "GUARD: print() in server code. Use structured logging (session.log)."
  bad=1
fi
exit $bad
