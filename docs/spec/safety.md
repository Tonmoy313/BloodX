# safety — privacy, access, security rules
Data classes: Restricted (readiness answers, deferrals, rejection categories, location points): minimum access, admin reads audited, never in logs or notifications · Sensitive (phones, DOB, patient name, slip images): private storage, signed URLs, masked in logs · Internal (requests, pledges, events) · Public-ish (hospitals, areas, badge definitions).
Access matrix (enforce server-side; one test per row):
| Data | Requester | Pledged donor | Other donor | ops | medical_reviewer | super_admin |
|---|---|---|---|---|---|---|
| Own request | rw | – | – | r | – | r |
| Request detail (hospital, needed-by, bags) | r | r | r if eligible | r | – | r |
| Requester phone | – | after pledge + consent | no | audited | no | audited |
| Donor phone | after pledge + consent | – | no | audited | no | audited |
| Donor health summary / deferrals | no | own only | no | no | audited | audited |
| Readiness answers | no | own only | no | no | summary only | summary only |
| Slip image | own | thumbnail | thumbnail | audited | no | audited |
| Config / flags | no | no | no | no | no | write, audited |
Health rules: categories only; no diagnosis, lab values, or free text; never shown to requesters, other donors, push, or SMS; never used for ranking or display; consent text states what is collected, who sees it, how long (**legal**); separate consent for donor mode and for notifications.
Abuse controls: OTP limits, +880 only, App Check, spend alerts · request limits · report button · contact reveal only via revealContact · admin can mark fake, suspend, release pledges · notification caps · client_request_id · body-size limit and timeouts.
Storage and logs: TLS everywhere; R2 private with signed URLs; secrets in the secret manager, never in the repo or the app; structured logs; mask phones to the last 3 digits; never log OTPs, readiness answers, deferral categories, location points, signed URLs, tokens; audit log separate and append-only; production: debug off, no stack traces to clients, no test endpoints, release builds only.
App security rules: parameterized SQL only (`scripts/guard_sql.sh`; raw helpers need `// sql-reviewed` + owner approval) · sanitize free text (ward note, patient name, report note, broadcast) and never render it as HTML or in a WebView · authorization on every endpoint + tests (the most common bug in AI-written backends) · no RLS in v1 (Serverpod uses one DB role; use shared ownership helpers + tests, F-9) · dependency alerts + weekly update PRs, majors reviewed by hand, remove unused · least-privilege Cloud Run service account, keyless CI deploy · secret scan in hook and CI · registry image scanning · the Claude security-review workflow on `safety-critical` PRs supplements, never replaces, tests and your review.
Retention: see core "Config defaults". Account deletion removes profile + health data and anonymizes history.
Store compliance: both: in-app account deletion, privacy policy URL, data-safety/privacy labels match reality, plain permission strings, review notes with demo access, no visible placeholders that break review (flags, Q-005). Android: Data safety form; background location needs its own declaration (P6, optional). iOS: privacy labels; APNs; "When in use" location first.
Incident (minimum): contact list + on-call owner; pause waves, broadcast status, fall back to manual donor calling, preserve logs; suspected leak → revoke sessions, rotate secrets, preserve evidence, notify per legal advice.
Legal items for your legal contact: matching without being a licensed blood bank + disclaimers · Bangladesh health-data consent · data protection and retention · importing website donors and messaging them (Q-004) · restrictions on rewards tied to donation (Q-006) · terms, privacy, declarations · nonprofit entity structure.
