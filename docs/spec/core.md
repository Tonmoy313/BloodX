# core — shared definitions (read when a slice points here)

## Stack
Flutter (Android + iOS) · Serverpod (Dart) · Neon Postgres (pooled connection for the app, direct for migrations; prod compute never suspends) · Cloudflare R2 (private, signed URLs) · Cloud Run (min 1, max cap, CPU always on; region near Dhaka) · FCM/APNs · SMS via adapter (P-001) · Sentry · Redis only with >1 server instance · admin = Flutter web.
Layout: `blood_server/{protocol,endpoints,services,adapters,futures,jobs,migrations,config}` · `blood_client` (generated) · `blood_flutter/lib/features/*` · `blood_admin` · `scripts/` · `docs/`.
Envs: dev local (log-only SMS) · staging Cloud Run + long-lived Neon branch, fake data only · prod.
Versioning: no `/v1` paths; `min_supported_app_version` in Config → screen S22; additive protocol changes; breaking change → new endpoint class.

## Enums
BloodGroup A±,B±,O±,AB± · Component WHOLE_BLOOD (v1), PLATELETS, PLASMA (later) · Urgency CRITICAL (<6 h), SAME_DAY, SCHEDULED · RequestStatus open, partially_pledged, fully_pledged, partially_fulfilled, fulfilled, cancelled, expired, closed_fake · PledgeStatus pledged, en_route, arrived, donated, withdrawn_free, cancelled, released, not_eligible, unconfirmed · Sex MALE, FEMALE · DonorStatus none, setup_incomplete, active, left · AvailabilityMode off, critical_only, all · DeferralCategory LOW_HEMOGLOBIN, LOW_WEIGHT, BLOOD_PRESSURE, RECENT_ILLNESS_OR_MEDICATION, OTHER_OR_NOT_TOLD · DeferralSource SELF_DECLARED, HOSPITAL_REPORTED, ADMIN · Channel PUSH, SMS · AdminRole ops, medical_reviewer, super_admin · UploadStatus issued, confirmed, attached, expired.

## Whole-blood compatibility (medical contact confirms)
O−→all · O+→O+,A+,B+,AB+ · A−→A−,A+,AB−,AB+ · A+→A+,AB+ · B−→B−,B+,AB−,AB+ · B+→B+,AB+ · AB−→AB−,AB+ · AB+→AB+.

## State machines
Request: open → partially_pledged → fully_pledged → (donations confirmed) partially_fulfilled → fulfilled. A released or cancelled pledge moves it back toward open. Any non-terminal → cancelled | expired | closed_fake. Terminal: fulfilled, cancelled, expired, closed_fake. bags_pledged/bags_donated are cached; pledges are the truth.
Pledge: pledged → en_route → arrived → donated (both confirm). Cancel within free window → withdrawn_free; later cancel → cancelled (reason required). Hospital rejects → not_eligible. No confirmation → unconfirmed. pledged or en_route past arrival+grace → released. withdrawn_free, not_eligible, unconfirmed never count against the donor; late cancelled and released count toward the break rule. Services reject illegal transitions.

## Errors
Shape `{code, message, field?}`, localized, no stack traces. Codes: NOT_AUTHENTICATED, FORBIDDEN, RATE_LIMITED, VALIDATION_FAILED, PHONE_NOT_VERIFIED, HOSPITAL_NOT_FOUND, REQUEST_NOT_OPEN, BAG_ALREADY_TAKEN, DONOR_NOT_ELIGIBLE, DONOR_MODE_REQUIRED, READINESS_REQUIRED, PLEDGE_CONFLICT, PLEDGE_NOT_ACTIVE, CONTACT_NOT_ALLOWED, ACCOUNT_SUSPENDED, FEATURE_COMING_SOON, UPDATE_REQUIRED, UPLOAD_INVALID, INTERNAL.

## Cross-cutting rules
- Every endpoint: session check (unless Public), role + ownership check, server-side validation, rate limit where noted.
- Lists: keyset `cursor, limit`. Idempotency: `client_request_id` (unique per user) on createRequest and pledge; replay returns the original (kept 7 d). Jobs and sends are idempotent.
- Cache only static data (hospitals, areas, flags, questionnaire by version, badge definitions), client and server. Never cache request status, pledges, eligibility, notifications. Cache a query only after EXPLAIN shows it is slow.
- Adapters behind interfaces: SMS, push, storage, maps. Provider calls: retry with backoff + circuit breaker; failures recorded; critical alerts never silent.
- No hard delete of requests, pledges, OutcomeEvents, points ledger (account deletion anonymizes). Health data is purged on deletion.
- Caps: Cloud Run max instances, billing + SMS spend alerts, request body ≤256 KB, timeouts.

## Config defaults (all tunable in config; **medical**/**legal** = confirm before launch; [G] = guess, tune from beta)
- requests: max_bags 6 · max_active_requests 2 · create limit 5/24 h/phone · needed_by ≤30 d
- eligibility: cooldown male 90 d / female 120 d (**medical**) · age 18–60 (**medical** placeholder) · readiness valid 24 h · deferral default 30 d (**medical** placeholder); OTHER_OR_NOT_TOLD → admin review
- pledge: free cancel 10 min · check-in 30 min before arrival · max 2 extensions (+30 min) · grace critical 15 / same_day 30 / scheduled 60 min [G] · unconfirmed auto-close 24 h
- notifications: SMS fallback 5 min (critical, unopened push) · cap 3/24 h non-critical, 5/24 h including critical · quiet hours 22:00–07:00 Asia/Dhaka (non-critical)
- availability: durations 7/30/90 d · default 30 · 1 prompt per expiry · snooze 90 d
- break rule: 3 releases or late cancels in 90 d → availability Off 30 d
- OTP: 6 digits, ttl 5 min, 5 attempts, resend 60 s, 5 sends/h/phone
- uploads: url ttl 10 min · max 5 MB [G] · jpeg/png · pending ttl 24 h · slip retention 90 d after close (**legal**)
- misc: no-pledge help after 20 min · points donation 10, critical +5, honest rejection +2, expiry 12 mo · badges at 1, 3, 5, 10, 25 donations + Emergency donor · location 15/30/60 min, 1 active ask per pair
- retention: location points deleted when request closes · OTP challenges 7 d · readiness answers keep latest valid, purge older after 12 mo · deferrals purge 24 mo after end · audit log ≥24 mo

## Verify before relying [Likely]
Serverpod phone-OTP approach and refresh-token handling · future-call persistence · Cloud Run always-on CPU · Neon pooler with Serverpod prepared statements and row locks · Neon suspend-off on your plan · FCM on iOS background/terminated · Serverpod raw-query helper names (guard script) · branch protection on your GitHub plan · action versions in workflows.
