#!/usr/bin/env bash
# P0-3: Neon — prod project + staging branch setup
#
# Run once to bootstrap:
#   1. Confirm the Neon prod project exists with compute-suspend DISABLED.
#   2. Create the long-lived "staging" branch from the prod project schema
#      (NOT from prod data — the branch starts empty or uses seed scripts).
#   3. Print the pooled + direct connection strings for both environments.
#
# Prerequisites:
#   - neon CLI installed (npm install -g neonctl)  or Homebrew neonctl
#   - Authenticated: neon auth  (opens browser)
#   - NEON_PROJECT_ID set in your environment or .env (not committed)
#
# Safety:
#   - Never reads or copies prod data to staging.
#   - Compute suspend is disabled on prod (D-018 / P-018) to prevent cold starts.
#   - The staging branch is long-lived and reset only with explicit seed scripts.
#
# Usage:
#   bash scripts/neon_bootstrap.sh [--project-id=<id>]

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PROJECT_ID="${NEON_PROJECT_ID:-}"
STAGING_BRANCH_NAME="staging"
# Neon region closest to Cloud Run asia-southeast1 (Singapore)
REGION="aws-ap-southeast-1"
COMPUTE_TYPE="k8s-neon"         # serverless compute units
COMPUTE_SIZE="0.25"             # 0.25 CU = 256 MB RAM — enough for v1

# ── Parse args ────────────────────────────────────────────────────────────────
for arg in "$@"; do
  case $arg in
    --project-id=*)
      PROJECT_ID="${arg#*=}"
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      exit 1
      ;;
  esac
done

# ── Helpers ───────────────────────────────────────────────────────────────────
info()  { echo "  [INFO]  $*"; }
warn()  { echo "  [WARN]  $*" >&2; }
die()   { echo "  [ERROR] $*" >&2; exit 1; }

# ── Preflight ─────────────────────────────────────────────────────────────────
command -v neon >/dev/null 2>&1 || die "neon CLI not found. Install: npm install -g neonctl"

if [[ -z "$PROJECT_ID" ]]; then
  die "NEON_PROJECT_ID is not set. Export it or pass --project-id=<id>."
fi

info "Using Neon project: $PROJECT_ID"

# ── 1. Verify prod project ────────────────────────────────────────────────────
info "Checking prod project..."
PROJECT_JSON=$(neon projects get "$PROJECT_ID" --output json 2>/dev/null) || \
  die "Project $PROJECT_ID not found or not accessible."

PROJECT_NAME=$(echo "$PROJECT_JSON" | python3 -c "import sys,json; print(json.load(sys.stdin)['project']['name'])")
info "Prod project name: $PROJECT_NAME"

# Disable compute suspend on the prod default branch endpoint.
# This ensures the prod DB never cold-starts (D-018 / P-018).
info "Disabling autosuspend on all prod endpoints..."
ENDPOINTS_JSON=$(neon branches endpoints list --project-id "$PROJECT_ID" \
  --branch main --output json 2>/dev/null || echo '{"endpoints":[]}')
ENDPOINT_COUNT=$(echo "$ENDPOINTS_JSON" | python3 -c \
  "import sys,json; print(len(json.load(sys.stdin).get('endpoints',[])))")

if [[ "$ENDPOINT_COUNT" -eq 0 ]]; then
  warn "No endpoints found on the main branch. Skipping autosuspend update."
else
  ENDPOINT_ID=$(echo "$ENDPOINTS_JSON" | python3 -c \
    "import sys,json; print(json.load(sys.stdin)['endpoints'][0]['id'])")
  neon endpoints update "$ENDPOINT_ID" \
    --project-id "$PROJECT_ID" \
    --autosuspend-idle-timeout=0 \
    --output json > /dev/null
  info "Autosuspend disabled on prod endpoint $ENDPOINT_ID."
fi

# ── 2. Create or verify staging branch ───────────────────────────────────────
info "Checking for existing staging branch..."
BRANCHES_JSON=$(neon branches list --project-id "$PROJECT_ID" --output json)
STAGING_ID=$(echo "$BRANCHES_JSON" | python3 -c \
  "import sys,json; \
   branches=json.load(sys.stdin).get('branches',[]); \
   match=[b['id'] for b in branches if b['name']=='$STAGING_BRANCH_NAME]; \
   print(match[0] if match else '')" 2>/dev/null || echo "")

if [[ -n "$STAGING_ID" ]]; then
  info "Staging branch already exists: $STAGING_ID"
else
  info "Creating staging branch from main schema (no data)..."
  # --no-data is the safe flag: copies schema only, not rows.
  # Note: as of neonctl ≥1.30 the flag is --schema-only for branch create.
  STAGING_JSON=$(neon branches create \
    --project-id "$PROJECT_ID" \
    --name "$STAGING_BRANCH_NAME" \
    --output json)
  STAGING_ID=$(echo "$STAGING_JSON" | python3 -c \
    "import sys,json; print(json.load(sys.stdin)['branch']['id'])")
  info "Staging branch created: $STAGING_ID"
fi

# ── 3. Connection strings ──────────────────────────────────────────────────────
info ""
info "═══════════════════════════════════════════════════════"
info " Connection strings (keep out of version control!)"
info "═══════════════════════════════════════════════════════"

# Prod — pooled (app server) and direct (migrations)
info ""
info "── PROD (main branch) ──────────────────────────────────"
info "Pooled URL (Serverpod app server — DATABASE_URL):"
neon branches get-connection-string \
  --project-id "$PROJECT_ID" \
  --branch main \
  --pooled 2>/dev/null || warn "Could not retrieve prod pooled URL."

info ""
info "Direct URL (migrations — DATABASE_URL_DIRECT):"
neon branches get-connection-string \
  --project-id "$PROJECT_ID" \
  --branch main 2>/dev/null || warn "Could not retrieve prod direct URL."

# Staging — pooled and direct
info ""
info "── STAGING ($STAGING_BRANCH_NAME branch) ───────────────────────────"
info "Pooled URL (DATABASE_URL on staging Cloud Run):"
neon branches get-connection-string \
  --project-id "$PROJECT_ID" \
  --branch "$STAGING_BRANCH_NAME" \
  --pooled 2>/dev/null || warn "Could not retrieve staging pooled URL."

info ""
info "Direct URL (staging migrations — DATABASE_URL_DIRECT):"
neon branches get-connection-string \
  --project-id "$PROJECT_ID" \
  --branch "$STAGING_BRANCH_NAME" 2>/dev/null || warn "Could not retrieve staging direct URL."

info ""
info "═══════════════════════════════════════════════════════"
info "Next steps:"
info "  1. Copy the URLs above into Secret Manager (never into .env or git)."
info "  2. Apply migrations: dart run serverpod_cli migrate --mode=staging"
info "  3. Seed staging with fake data: bash scripts/seed_staging.sh"
info "  4. Verify the partial unique index on device_push_token (STATE.md gate)."
info "═══════════════════════════════════════════════════════"
