# STATE — single source of truth (keep small; edit only when something changes)

Phase: **P0** (task: P0-7 Auth UI & Flutter shell) · Next: P0-8 Phone OTP Serverpod endpoints.
Tags: **DECIDED** owner said it, follow exactly · **PROPOSED** implement the default behind config, owner may change · **OPEN** needs owner, use the default meanwhile.

## Spec map (read ONE per task)
| Task area | File |
|---|---|
| Sign-in, OTP, flags, min app version, account deletion | spec/auth.md |
| Donor profile, opt-in, readiness, availability, eligibility | spec/donor.md |
| Create/view request, uploads, requester screens | spec/request.md |
| Matching, pledge, waves, timers, notifications, donor screens | spec/pledge.md |
| Confirm donation, rejection, rewards | spec/closeout.md |
| Admin panel, reports, audit | spec/admin.md |
| Live location (P6 only) | spec/location.md |
| Privacy, access matrix, security rules, retention | spec/safety.md |
| Setup, environments, git/CI gates, tests, release | spec/ops.md |
| Enums, state machines, config defaults, errors, stack (slices point here) | spec/core.md |
Later features: `phases/FUTURE.md`. The old long docs were removed; they live in git history.

## Product
Requester posts a request (group, bags, hospital, needed-by) → eligible volunteer donors are alerted in waves → each donor pledges one bag → requester sees the pledged list and calls or WhatsApps → both confirm the donation. Blood is never sold. No pressure on donors. Honest counts, never invented promises. Emergencies first. Bangla-first, low bandwidth.

## DECIDED
- D-021 Use the Serverpod-compatible generated schema for application entities; preserve PostgreSQL-specific safeguards in additive migrations.
- D-022 Restore credentials from secure storage and show the app shell before network validation; on `NOT_AUTHENTICATED`, refresh once and sign out only if refresh fails.
- D-023 Cache only the Serverpod user id, donor scope, and language at startup; profile, availability, and eligibility remain live.
- D-024 Enforce minimum app version `1.0.0` on staging and production by default.
- D-025 Retain phone HMACs only for suspended accounts to block re-registration; suspended-account deletion requires admin review.
- D-026 Account deletion is a soft delete; anonymize the account instead of hard-deleting its row.
- D-027 Audit records capture transaction-local actor (null for migrations), action, target type/key, and source (`api`, `migration`, or `seed`). Block audit-log UPDATE, DELETE, and TRUNCATE; keep secrets and health data out of metadata; write Config audits in the same transaction.
- D-028 Donor re-engagement is an optional, neutral in-app prompt with a server-enforced 30-day cooldown; no push, guilt, or repeated nagging.
- D-029 Donor onboarding requests precise foreground location only; no background location access.
- D-030 Donor blood group, current location/address, and preferred centers are stored for donor registration and nearby matching only.
- D-031 Two shippable theme presets: "classic" (warm crimson over neutral surfaces) and "modern" (crimson over midnight navy and warm off-white). The modern preset is the default; the choice and the light/dark mode persist locally. Both presets share one component-theme base so they cannot drift structurally.
- D-001 Dhaka pilot; nonprofit-style; blood requests always free.
- D-002 Stack: Flutter, Serverpod, Neon, R2, Cloud Run, SMS provider (owner named Twilio; see P-001).
- D-003 Android + iOS.
- D-004 Build by phase. P0–P5 core. Feed and marketplace later.
- D-005 No in-app chat now; phone call + WhatsApp after a pledge.
- D-006 Flow: request → searching screen → accepted donors list; donor passes health questions, if eligible sees requests and accepts.
- D-007 Requester sets needed-by time and bag count.
- D-008 One pledge per bag; cancel or timeout returns the bag to search automatically.
- D-009 Live location only by request + accept, time-limited, never always-on.
- D-010 No scores or ratings. Encourage donors with badges, points, gifts.
- D-011 Track health deferrals when a hospital rejects a donor.
- D-012 Unbuilt features: tile looks normal; tap shows a "coming soon" snackbar.
- D-013 Deferred: feed + verification, marketplace, other components, ambulance, oxygen, chat.
- D-014 Final health-check wording comes from the owner; placeholders until then.
- D-015 No donor/requester roles. Donor mode is opt-in (unchecked box at sign-up or "Become a donor"); can leave any time. Admin roles are staff only.
- D-016 Volunteer principle: availability never automatic, default OFF; modes Off / Critical only / All; duration 7/30/90 days (default 30), auto-expires; quiet hours on for non-critical; one prompt at expiry, "Not now" or silence = Off + 90-day snooze; no guilt, streaks, leaderboards.
- D-017 Name: BloodX.
- D-018 Trunk-based git: main → staging; version tag → production with manual approval; AI pushes task branches only; staging DB = one long-lived Neon branch with fake data.
- D-019 Docs are token-lean: one task reads STATE + one phase file + one spec file.
- D-020 Agents never wait on questions: use the default, record it, ask in parallel (see AGENTS.md).

Implementation status: P0-8 phone/PIN authentication, durable phone-auth sessions, and explicit device-ID binding are not implemented yet. The current phone/PIN controller uses simulated flows; the existing secure-storage restore applies to Serverpod auth credentials.

## PROPOSED
- P-001 SMS via adapter; local Bangladesh gateway primary (Twilio is costly/unreliable here, [Likely]).
- P-002 Bangla-first UI with English toggle.
- P-003 Readiness check (4–5 yes/no) once per 24 h; gates the pledge button, not the list.
- P-004 Pledge: 10-min free cancel; "Still coming?" push 30 min before arrival; grace then auto-release.
- P-005 Searching screen: live counts + elapsed time; time estimate only after real data.
- P-006 Rewards v1: append-only points ledger, badges, share card; no cash value; honest rejection earns a small credit; partner redemption later.
- P-007 Rejection stored as category only; restricted admin; audited.
- P-008 Live location in P6: mutual, 15/30/60 min, foreground first.
- P-009 Riverpod, go_router, generated Serverpod client.
- P-010 Cloud Run min 1 + always-on CPU; Redis when >1 instance.
- P-011 Contact reveal only after pledge + consent; audited.
- P-012 Atomic pledge transaction + 1-minute sweeper.
- P-013 Max 6 bags per request.
- P-014 Cooldown 90 d male / 120 d female (medical contact confirms).
- P-015 Exact blood group in early waves; compatible groups only in the last wave of CRITICAL requests.
- P-016 3 releases/late cancels in 120 d → availability Off for 30 d, framed as a friendly break.
- P-017 Availability controls alerts only; browsing and pledging stay donor-initiated.
- P-018 Backend practices: client_request_id idempotency, keyset pagination, min app version instead of /v1, secure token storage, signed-upload rules, pooled/direct Neon, prod Neon never suspends, cost caps, +880-only + App Check, no RLS in v1.
- P-019 Cache static data only; never live state.
- P-020 Quality gates at commit, PR, and phase exit (spec/ops.md).

## Open questions
| id | question | default used |
|---|---|---|
| Q-001 | Can a donor hold more than one active pledge? | One active critical or same-day pledge; scheduled pledges allowed if arrivals are 4 h or more apart |
| Q-002 | Final readiness questions and deferral durations | Placeholder questions; 30-day placeholder deferral; other or not told goes to admin review |
| Q-003 | Consent, privacy, terms wording (legal contact) | Placeholder text marked draft |
| Q-004 | Website donor export format and claim flow | P1-7 blocked; spec only |
| Q-005 | iOS review vs coming-soon tiles | Flags hide unfinished tiles in the iOS review build |
| Q-006 | Partner reward program rules | Not built until partners exist |
| Q-007 | Which SMS provider | Adapter with a dev log provider only |
| Q-008 | Branding and Bangla copy | Placeholder styling |
| Q-009 | Standby pledge for 1-bag critical requests | Not in v1 |
| Q-010 | Does the website expose an API or database for donor claim | Unknown |
| Q-011 | Is a profile image required during onboarding? | Optional; full name, sex, and date of birth are required |
| Q-012 | Can onboarding profile data be uploaded before the P0-8 auth session exists? | Keep it in AuthState as a draft; defer server/R2 persistence until authenticated |
| Q-013 | Which Bangla typeface ships in the app? | Noto Sans Bengali as a `fontFamilyFallback` (it has no Latin glyphs, so it cannot be the primary family) |
| Q-014 | Are the classic and modern theme presets shippable UI? | Yes — both are user-selectable and the choice persists in `SharedPreferences` |
## Deps (one line each: name · why · task)
flutter_secure_storage · securely persist the signed-in app session · P0-7
package_info_plus · compare the installed app version with server policy · P0-9
shared_preferences · non-sensitive profile cache and first-install marker · P0-7
http · fetch public client config before secure session restoration · P0-9
serverpod · generated PostgreSQL-compatible application entities and protocol · P0-8
permission_handler · request foreground location permission; Android 12.x compatible with current Kotlin Gradle plugin · P0 donor flow
geolocator · check location service state and obtain current foreground location · P0 donor flow
image_picker · select an optional profile image from camera or gallery · P0-7
Noto Sans Bengali (bundled OFL asset, not a pub package) · Bangla glyph coverage for the Bangla-first UI · P0-7

## Staging verification gate
Do not connect to or modify staging until the fake-data staging branch is confirmed. After confirmation, verify the deployed partial unique index on `device_push_token` and rehearse migration and rollback with fake data.
