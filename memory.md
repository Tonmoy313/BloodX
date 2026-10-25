# memory.md — Shared project memory (all AI models)

**Purpose:** one place that any AI model reads first and updates last, so decisions survive tool and model changes. Chat history is not memory; this file is.

**Rules**
- Read before working. Update before finishing. Never delete history; supersede it with a new line.
- Every item has a status:
  - **DECIDED** — the owner said it. Follow exactly.
  - **PROPOSED** — architect recommendation, not yet confirmed. Implement the default, keep it in config, flag it.
  - **OPEN** — needs an owner answer. Use the documented default behind config, or stop and ask.
- Models may add PROPOSED or OPEN items. Only the owner (or an explicit owner statement) promotes an item to DECIDED.
- Confidence tags in notes: **[Certain]**, **[Likely]**, **[Guessing]**.

---

## 1. Snapshot

| Item | Value |
|---|---|
| Product | Blood request and donor-matching mobile app, plus later a community help feed and a medical equipment marketplace |
| Working title | Blood app (name BloodX) |
| Market |Bangladesh (pilot cities include Dhaka, Chattogram, Sylhet and soon Rajshahi and Khulna) |
| Model | Nonprofit-style trust brand. Blood requests free forever. Revenue later from surrounding services and B2B |
| Platforms | Android and iOS (Flutter) |
| Stack | Flutter · Serverpod (Dart) · Neon Postgres · Cloudflare R2 · Google Cloud Run · FCM push · SMS via adapter |
| Team | Owner solo, about 10 hours a day |
| Build style | Phase by phase with AI models (see `phase.md`) |
| Current phase | **P0 — Foundation** |
| Code written | None yet. Docs only. |

## 2. Owner context

- Flutter developer. Strong on Flutter, less on server/infrastructure, so explain those more.
- Has a legal contact and a medical contact for rules and wording.
- Has an existing website with registered donors and past campaigns. Donor recruiting is handled by the owner outside the app. Do not plan or build recruitment campaigns.
- Wants a production-grade app for mass use, even if first launched with no real data.
- Prefers a direct advisor style: challenge assumptions, confidence tags, no flattery.

## 3. Decision log

### DECIDED (owner stated)

| ID | Decision |
|---|---|
| D-001 | Pilot cities. Nonprofit-style. Blood requests are always free. |
| D-002 | Stack: Flutter, Serverpod, Neon, Cloudflare R2, Google Cloud Run, SMS provider (owner named Twilio; see P-001). |
| D-003 | Target Android and iOS together. |
| D-004 | Build phase by phase. Phase 1 is the blood request core only. Community feed and marketplace come later. |
| D-005 | In-app chat is deferred to a later version. For now, phone call and WhatsApp message after a pledge. |
| D-006 | Flow: requester creates request → searching screen (live progress) → list of accepted donors. Donor answers health questions; if eligible, sees requests and accepts one. |
| D-007 | Requester sets needed-by time and number of bags when creating the request. |
| D-008 | A request for N bags needs N donor pledges, one per bag. If a donor cancels or an unconfirmed pledge times out, that bag automatically goes back to searching. |
| D-009 | Live location is by request-and-accept for a limited time (requester can ask donor and vice versa). Never always-on. |
| D-010 | No numeric score or rating policy. Instead, encourage donors with badges, points, and gifts. |
| D-011 | Track donor health deferrals when a hospital rejects a donor for health reasons. |
| D-012 | Features not built yet show a "coming soon" snackbar when tapped. Tiles look normal. Applies to every deferred component. |
| D-013 | Deferred scope: community feed with verification, marketplace and supplier orders, other blood components and services, ambulance, oxygen, chat. |
| D-014 | Final health-check wording comes from the owner. Ship placeholder questions until then. |

### PROPOSED (architect defaults, awaiting owner confirmation)

| ID | Proposal | Why |
|---|---|---|
| P-001 | SMS through an adapter, with a local Bangladesh gateway as primary instead of Twilio | [Likely] Twilio to Bangladesh is costly and delivery can be unreliable |
| P-002 | Bangla-first UI with an English toggle | Many requesters are stressed family members |
| P-003 | Readiness check (4–5 yes/no questions) required once per 24 h and gates the **pledge button**, not the request list | Gating the list drives drop-off and hides context |
| P-004 | Pledge check-in flow: 10-minute free cancel, "Still coming?" push 30 min before arrival, grace period then auto-release | Fixed-timer auto-cancel would drop donors stuck in traffic |
| P-005 | Searching screen shows live counts and elapsed time. A time estimate range appears only after real data exists | An invented estimate is false reassurance |
| P-006 | Rewards v1: append-only points ledger, badges, shareable card and certificate. Points have no cash value. Redemption through partner vouchers at milestones comes later. Honest rejection (confirmed by both sides) earns a small credit | Avoids incentives to hide health problems and to farm fake requests |
| P-007 | Hospital rejection stored as category only; restricted admin access; audit-logged | Health data sensitivity |
| P-008 | Live location in Phase P6: mutual request-and-accept, 15/30/60 minutes, foreground sharing first, background later | Play Store and iOS background-location review burden |
| P-009 | Flutter: Riverpod, go_router, Serverpod generated client | Owner may override |
| P-010 | Cloud Run: minimum 1 instance and always-allocated CPU; Redis when running multiple Serverpod instances | Cold starts and throttled background work are unacceptable for emergencies |
| P-011 | Contact numbers revealed only after a pledge and consent; every reveal audit-logged | Harassment prevention |
| P-012 | Atomic pledge transaction plus a one-minute reconciliation sweeper job | Prevents double pledges and stuck states |
| P-013 | Max 6 bags per request in v1; larger needs go to an admin | Larger requests need a human |
| P-014 | Cooldown defaults: 90 days male, 120 days female, stored as config | Must be confirmed by the medical contact |
| P-015 | Matching: exact blood group in early waves; compatible groups only in the last wave of critical requests | Hospitals usually prefer exact group; confirm with medical contact |
| P-016 | Repeated releases or no-shows (3 in 90 days) pause donor alerts for 30 days with a friendly message and admin visibility. This is a rule, not a score | Protects requesters without a rating system |

### OPEN questions

| ID | Question | Temporary default |
|---|---|---|
| Q-001 | Can a donor hold more than one active pledge? | One active critical or same-day pledge at a time; scheduled pledges may coexist if arrival times are at least 4 hours apart |
| Q-002 | Final readiness questions and deferral durations per category | Placeholder questions; 30-day placeholder deferral; "other/not told" goes to admin review |
| Q-003 | Consent, privacy policy, and terms wording (legal contact) | Placeholder text, flagged in UI as draft |
| Q-004 | Website donor export format and claim flow | Phase P1 task blocked until owner supplies export format |
| Q-005 | iOS review and "coming soon" placeholders | Remote flags hide unfinished tiles in the iOS review build |
| Q-006 | Partner reward program rules and which partners | Not built until partners exist |
| Q-007 | Which SMS provider | Adapter with a dev/log provider only |
| Q-008 | App name, branding, Bangla copy | Placeholder name "Blood app" |
| Q-009 | Standby pledge for 1-bag critical requests | Not in v1 |
| Q-010 | Does the website expose an API or database access for donor claim? | Unknown |

## 4. Facts and context (not decisions)

- Hospitals test every donor's blood on donation. This lowers safety risk but does not remove wasted-time risk, farming risk, or window-period gaps. [Likely]
- Dhaka traffic makes distance a poor proxy for reach time, so matching uses donor-selected areas (up to 3), not live GPS. [Likely]
- Selling blood may be illegal or restricted in Bangladesh. Confirm with the legal contact before any cash-like reward. [Likely]
- Apple may reject apps with visible placeholder features. [Likely]
- Google Play requires declarations for background location. [Likely]

## 5. Current state

- Docs written: AGENTS.md, memory.md, phase.md, docs/00 through docs/08.
- No repository, server, app, or cloud accounts created yet (unless the owner says otherwise below).
- Next action: start **P0-1** in `phase.md` after the owner confirms the Phase P0 environment checklist in `docs/07_SETUP.md`.

## 6. Dependencies (record every package or service added)

| Name | Where | Why | Added in task |
|---|---|---|---|
| — | — | — | — |

## 7. Known gotchas

- [Likely] Serverpod's built-in auth does not provide phone OTP; phone OTP is a custom flow on top of session handling. Verify against current Serverpod docs before building.
- [Likely] Serverpod future calls are persisted jobs, but still pair them with a sweeper.
- [Likely] Cloud Run may throttle CPU outside request handling. Use always-allocated CPU.
- [Certain] Two donors tapping the last open bag at once will both succeed unless the pledge is one locked transaction.
- FCM on iOS needs an APNs key and real-device testing.

## 8. Glossary

| Term | Meaning |
|---|---|
| Requester | Person (often a family member) asking for blood for a patient |
| Donor | Registered volunteer who can pledge to donate |
| Bag | One unit of blood. A request for N bags needs N pledges |
| Pledge | A donor's commitment to one bag, with a committed arrival time |
| Wave | A batch of donors notified at a scheduled time |
| Release | System removes a stale pledge and reopens the bag |
| Deferral | Temporary period when a donor cannot donate |
| Readiness check | Short health questionnaire valid for 24 hours |
| Needed-by | Time by which the requester needs the blood |
| Critical | Needed within 6 hours |
| Coming-soon flag | Feature flag that makes a tile show a snackbar instead of opening |

## 9. Handoff protocol

When you stop, leave the next model able to continue with no chat history:
1. Phase and task ID you were on.
2. What is done, what is half-done (file paths), what is untested.
3. Any decision you made. Mark it PROPOSED.
4. The exact next step.

## 10. Session log (append only, newest at bottom)

| Date | Tool/model | Tasks | Summary | Untested/next |
|---|---|---|---|---|
| 2026-10-05 | Claude (chat, architect role) | Planning | Product, flow, data model, endpoints, screens, rules, and phase plan documented from owner discussion. No code. | Owner to confirm PROPOSED items and answer Q-001 to Q-010. Next: P0-1. |
