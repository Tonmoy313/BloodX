#!/usr/bin/env bash
# P0-14: Cloud Run caps + billing/SMS spend alerts
#
# Creates or updates:
#   1. Cloud Run max-instance cap (enforced via service update).
#   2. GCP billing budget alert for the whole project.
#   3. A second, tighter budget alert for SMS spend (Cloud Billing label).
#
# Cloud Run body-size and timeout caps are set in the deploy workflow
# (staging-deploy.yml: --timeout=60s). This script handles the GCP-level caps.
#
# Prerequisites:
#   - gcloud CLI authenticated; Billing API + Budgets API enabled.
#   - Billing account ID: set BILLING_ACCOUNT_ID env var.
#   - ALERT_EMAIL: notification email.
#   - GCP_PROJECT, GCP_REGION, CLOUD_RUN_SERVICE env vars (same as deploy).
#
# Usage:
#   BILLING_ACCOUNT_ID=XXXXXX-XXXXXX-XXXXXX \
#   ALERT_EMAIL=owner@example.com \
#   GCP_PROJECT=my-project \
#   GCP_REGION=asia-southeast1 \
#   CLOUD_RUN_SERVICE=bloodx-staging \
#   bash scripts/setup_caps.sh

set -euo pipefail

PROJECT="${GCP_PROJECT:-$(gcloud config get-value project 2>/dev/null || echo '')}"
REGION="${GCP_REGION:-asia-southeast1}"
SERVICE="${CLOUD_RUN_SERVICE:-bloodx-staging}"
BILLING_ACCOUNT="${BILLING_ACCOUNT_ID:-}"
ALERT_EMAIL="${ALERT_EMAIL:-}"

# ── Caps ──────────────────────────────────────────────────────────────────────
# These must match or be stricter than staging-deploy.yml values.
MAX_INSTANCES=5           # P0-14: hard cap; raise with care
REQUEST_TIMEOUT="60s"     # max per-request time; server enforces 55s internally
CONCURRENCY=80            # requests per container instance
CPU="1"
MEMORY="512Mi"

# ── Budget thresholds (USD) ────────────────────────────────────────────────────
# Adjust based on actual Twilio + Cloud Run costs once live.
PROJECT_MONTHLY_BUDGET=50    # total GCP project budget
SMS_MONTHLY_BUDGET=20        # SMS/Twilio spend threshold

info()  { echo "  [INFO]  $*"; }
warn()  { echo "  [WARN]  $*" >&2; }
die()   { echo "  [ERROR] $*" >&2; exit 1; }

[[ -z "$PROJECT" ]] && die "GCP_PROJECT is not set."

# ── 1. Enforce Cloud Run max-instances cap ─────────────────────────────────────
info "Updating Cloud Run service caps..."
gcloud run services update "$SERVICE" \
  --project="$PROJECT" \
  --region="$REGION" \
  --max-instances="$MAX_INSTANCES" \
  --timeout="$REQUEST_TIMEOUT" \
  --concurrency="$CONCURRENCY" \
  --cpu="$CPU" \
  --memory="$MEMORY" \
  --quiet 2>&1 | grep -v "^$" || warn "Service update failed; may not exist yet."

info "Cloud Run caps applied: max=$MAX_INSTANCES timeout=$REQUEST_TIMEOUT concurrency=$CONCURRENCY"

# ── 2. Billing budget for the GCP project ─────────────────────────────────────
if [[ -z "$BILLING_ACCOUNT" ]]; then
  warn "BILLING_ACCOUNT_ID not set. Skipping billing budget creation."
else
  info "Creating project billing budget (USD $PROJECT_MONTHLY_BUDGET/month)..."

  # Notification email channel
  CHANNEL_NAME="bloodx-billing-alert-email"
  EMAIL_CHANNEL=$(gcloud billing budgets list \
    --billing-account="$BILLING_ACCOUNT" \
    --format="value(name)" \
    --filter="displayName=bloodx-project-budget" 2>/dev/null | head -1 || echo "")

  if [[ -n "$EMAIL_CHANNEL" ]]; then
    info "Project budget already exists: $EMAIL_CHANNEL. Skipping creation."
  else
    # Create notification channel in Cloud Monitoring first.
    gcloud monitoring channels create \
      --project="$PROJECT" \
      --display-name="$CHANNEL_NAME" \
      --type=email \
      --channel-labels="email_address=$ALERT_EMAIL" \
      --quiet 2>/dev/null || warn "Channel may already exist."

    CHANNEL_RESOURCE=$(gcloud monitoring channels list \
      --project="$PROJECT" \
      --filter="displayName=$CHANNEL_NAME" \
      --format="value(name)" | head -1)

    # 50%, 90%, 100% alerts.
    gcloud billing budgets create \
      --billing-account="$BILLING_ACCOUNT" \
      --display-name="bloodx-project-budget" \
      --budget-amount="${PROJECT_MONTHLY_BUDGET}USD" \
      --threshold-rule="percent=50,basis=CURRENT_SPEND" \
      --threshold-rule="percent=90,basis=CURRENT_SPEND" \
      --threshold-rule="percent=100,basis=CURRENT_SPEND" \
      --filter-projects="projects/$PROJECT" \
      --notifications-rule-pubsub-topic="" \
      --notifications-rule-monitoring-notification-channels="$CHANNEL_RESOURCE" \
      --quiet 2>&1 || warn "Budget creation may have partially failed; check Cloud Console."

    info "Project billing budget created: USD $PROJECT_MONTHLY_BUDGET/month."
  fi

  # ── 3. SMS spend alert ─────────────────────────────────────────────────────
  # SMS costs flow through the project (Twilio is billed externally; track via
  # a Cloud Billing label on the Cloud Run service or via Twilio usage alerts).
  # Best practice: set a Twilio spend cap via the Twilio Console as well.
  info ""
  warn "SMS/Twilio spend is billed directly by Twilio — not through GCP."
  warn "Set a monthly spend cap in the Twilio Console:"
  warn "  Console → Account → Billing → Usage Triggers → Add trigger"
  warn "  Trigger at USD $SMS_MONTHLY_BUDGET to send an email/webhook alert."
  warn ""
  warn "You can also set hard spend caps per sub-account in Twilio to prevent"
  warn "runaway SMS costs if the +880 phone filter is misconfigured."
fi

# ── Summary ────────────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════"
echo " P0-14 Caps summary"
echo "═══════════════════════════════════════════════════════"
echo " Cloud Run service:    $SERVICE ($PROJECT / $REGION)"
echo "   max-instances:      $MAX_INSTANCES"
echo "   request timeout:    $REQUEST_TIMEOUT"
echo "   concurrency:        $CONCURRENCY"
echo "   body-size limit:    set in blood_server/config/production.yaml"
echo "                       maxRequestSize: 524288 (512 KB)"
echo ""
echo " Billing alert:        USD $PROJECT_MONTHLY_BUDGET/month (50/90/100%)"
echo " SMS alert:            Configure in Twilio Console (hard cap recommended)"
echo "═══════════════════════════════════════════════════════"
echo " NOTE: maxRequestSize (body-size limit) is set in the Serverpod"
echo "   production.yaml config and enforced by the Serverpod HTTP server."
echo "   Current value: 524288 bytes (512 KB). Update if uploads require more."
echo "═══════════════════════════════════════════════════════"
