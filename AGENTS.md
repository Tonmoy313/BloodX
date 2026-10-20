# AGENTS.md — BloodX
Flutter + Serverpod app connecting blood requesters with volunteer donors, Dhaka. Nonprofit; blood requests always free. Any AI tool. Keep this file tiny.

## Read (this order; nothing else unless told)
1. `docs/STATE.md` — decisions, open questions, current phase, spec map.
2. `docs/phases/<current>.md` — your task IDs.
3. ONE spec file from the map in STATE.md (two max); read only the section you need.
Do not read all docs. Do not re-read what is already in context. Precedence: STATE DECIDED > phase file > spec > your assumptions.

## Token rules
- One task per session; fresh session per task.
- Use `bash scripts/check.sh` and `bash scripts/test.sh [pkg]` (quiet). Never paste logs; show at most 20 lines of failures.
- Navigate code with graphify first, then grep or line ranges. Do not open whole large files.
- Final reply ≤ 10 lines: done · not tested · questions. LOG entry ≤ 3 lines. Edit STATE only if a decision, question, or current task changed.

## Questions: ask in parallel, never wait
- On any question or decision: use the documented default (else the safest reversible choice) behind config, add `| Q-nn | question | default used |` to STATE "Open questions", and keep working.
- End your reply with "Questions (blocking)": max 5, each answerable in one word (A / B / default).
- New choices are PROPOSED, never DECIDED.
- STOP and ask first only for: destructive or irreversible data or migration changes; health data, contact reveal, consent wording, donor-facing notification copy; new paid services or permissions (location, background); secrets, staging or prod access.
- Disagree like this, then continue with the decision: "I disagree because X. Instead: Y. Risk: Z."

## Non-negotiables
- Current phase only. "Later" features (chat, feed, marketplace, other components, ambulance, oxygen, partner redemption, RLS) show a "coming soon" snackbar via feature flag.
- One account type; donor mode is opt-in (D-015). Donors are volunteers (D-016): availability never auto-on; no nagging, guilt, or streaks.
- Safety-critical, tests required: pledge transaction + idempotency, state machines, waves/timers/sweeper, notifications, contact reveal, eligibility/availability, authorization on every endpoint, uploads, health data, account deletion.
- Never log OTPs, full phones (mask), health answers, deferral categories. No real data in fixtures or staging.
- Server: thin endpoints, logic in services; validate all input; generated models only; parameterized SQL only; keyset pagination; `client_request_id` on createRequest and pledge; errors `{code,message,field?}`; tunables in config; UTC stored, Asia/Dhaka shown; E.164 (+880 only); bn+en strings; no hard delete of transactional data.
- Flutter: feature-first; no logic in widgets; tokens in secure storage; no secrets in the app.
- New dependency, plugin, or MCP: add one line to STATE "Deps".

## Git (trunk-based)
Never commit or push to `main`; never force-push; never `--no-verify`. Branch `task/P2-04-name`; commit starts with the task ID (or docs: / chore: / ci: / fix:). Session end: `bash scripts/check.sh` → `graphify update .` if code changed → `git add` specific files (never env files or secrets) → commit → `git push -u origin <branch>` → open or update the PR (`Closes #n`; label `safety-critical` if it applies).

## Graph (graphify, `graphify-out/`)
When `graph.json` exists: `graphify query "<q>"`, `graphify path "<A>" "<B>"`, `graphify explain "<x>"` before raw grep; use `wiki/index.md` if present; read `GRAPH_REPORT.md` only for broad reviews. After code changes run `graphify update .`. The graph is a map: open the source before editing safety-critical code.
