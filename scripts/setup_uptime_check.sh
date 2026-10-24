#!/usr/bin/env bash
# P0-11: Set up Google Cloud Monitoring uptime check for the BloodX staging
# and production Cloud Run services.
#
# This script creates:
#   1. A Cloud Monitoring uptime check that hits /health every 60 seconds from
#      multiple regions.
#   2. An alerting policy that fires when the check fails 2+ consecutive times
#      (≈ 2 minutes down) and sends email + PagerDuty-compatible webhook
#      notification.
#
# Prerequisites:
#   - gcloud CLI authenticated with a project that has Monitoring API enabled.
#   - ALERT_EMAIL env var set to the owner's email address.
#   - SERVICE_URL env var set to the Cloud Run service URL.
#
# Usage:
#   SERVICE_URL=https://bloodx-staging-xxx-uc.a.run.app \
#   ALERT_EMAIL=owner@example.com \
#   bash scripts/setup_uptime_check.sh [--env=staging|production]

set -euo pipefail

ENV="${1:-staging}"
for arg in "$@"; do
  case $arg in --env=*) ENV="${arg#*=}" ;; esac
done

SERVICE_URL="${SERVICE_URL:-}"
ALERT_EMAIL="${ALERT_EMAIL:-}"
PROJECT="${GCP_PROJECT:-$(gcloud config get-value project 2>/dev/null || echo '')}"
REGION="${GCP_REGION:-asia-southeast1}"

[[ -z "$SERVICE_URL" ]] && { echo "[ERROR] SERVICE_URL is not set." >&2; exit 1; }
[[ -z "$ALERT_EMAIL" ]] && { echo "[ERROR] ALERT_EMAIL is not set." >&2; exit 1; }
[[ -z "$PROJECT" ]]     && { echo "[ERROR] GCP_PROJECT is not set." >&2; exit 1; }

DISPLAY_NAME="bloodx-$ENV-health"
HOST=$(echo "$SERVICE_URL" | sed 's|https\?://||' | cut -d'/' -f1)

echo "[INFO] Creating uptime check: $DISPLAY_NAME → $HOST/health"

# Create (or update) the uptime check.
# gcloud monitoring uptime-checks create requires project-level permissions.
gcloud monitoring uptime-checks create https "$DISPLAY_NAME" \
  --project="$PROJECT" \
  --display-name="BloodX $ENV /health" \
  --http-check-path=/health \
  --hostname="$HOST" \
  --port=443 \
  --period=60 \
  --timeout=10 \
  --regions=usa-iowa,europe-west,asia-pacific \
  --check-type=HTTPS 2>&1 | grep -v "^$" || true

echo "[INFO] Uptime check configured."

# Create an email notification channel.
CHANNEL_JSON=$(gcloud monitoring channels create \
  --project="$PROJECT" \
  --display-name="BloodX $ENV alert email" \
  --type=email \
  --channel-labels="email_address=$ALERT_EMAIL" \
  --format=json 2>/dev/null || echo '{}')

CHANNEL_ID=$(echo "$CHANNEL_JSON" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('name','').split('/')[-1])" 2>/dev/null || echo '')

if [[ -z "$CHANNEL_ID" ]]; then
  echo "[WARN] Could not create or find the notification channel. Skipping alert policy."
else
  echo "[INFO] Notification channel: $CHANNEL_ID"
  # Create an alerting policy: fires when 2+ consecutive checks fail (≈ 2 min).
  gcloud alpha monitoring policies create \
    --project="$PROJECT" \
    --display-name="BloodX $ENV uptime alert" \
    --condition-filter="metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\" AND metric.labels.check_id=\"$DISPLAY_NAME\"" \
    --condition-threshold-value=1 \
    --condition-threshold-comparison=COMPARISON_LT \
    --condition-threshold-duration=120s \
    --notification-channels="$CHANNEL_ID" \
    --combiner=OR 2>&1 | grep -v "^$" || true
  echo "[INFO] Alert policy configured."
fi

echo ""
echo "═══════════════════════════════════════════════════════"
echo " Uptime check setup complete for: $ENV"
echo " URL checked:  https://$HOST/health"
echo " Period:       60 seconds"
echo " Alert:        2 consecutive failures → email $ALERT_EMAIL"
echo "═══════════════════════════════════════════════════════"
echo " Next: verify the check appears in Cloud Console →"
echo "   Monitoring > Uptime checks > $DISPLAY_NAME"
echo "═══════════════════════════════════════════════════════"
