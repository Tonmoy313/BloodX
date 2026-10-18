#!/usr/bin/env bash
# Run once per clone.
set -euo pipefail
cd "$(dirname "$0")/.."
git config core.hooksPath .githooks
chmod +x .githooks/* scripts/*.sh
echo "Hooks enabled (core.hooksPath=.githooks)."
command -v gitleaks >/dev/null || echo "Note: gitleaks is not installed; the pre-commit secret scan will be skipped locally (CI still runs it)."
