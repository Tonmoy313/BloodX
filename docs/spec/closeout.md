# closeout — confirmation, rejection, rewards
Entities: Deferral (see donor.md) · PointsLedger(donor_id, event_type, points, pledge_id, expires_at, created_at; append-only) · BadgeDefinition(key, name_en, name_bn, rule, icon) · DonorBadge(donor_id, badge_key, awarded_at).
Endpoints: confirmDonation(pledge_id, outcome donated|did_not_arrive|not_eligible)[requester] · confirmDonated(pledge_id, outcome)[donor] · reportHospitalRejection(pledge_id, category, date?) · getBadges · getPointsSummary · getShareCard · getCertificate.
Rules:
- A donation is `donated` only when BOTH sides confirm. Mismatch → unconfirmed + admin sample. last_donated_at and cooldown start only then. Auto-close to unconfirmed after 24 h, no penalty.
- Rejection: donor picks a category chip (no free text) + optional date. Requester sees only "Donor couldn't donate"; the bag reopens. Deferral length from config by category (placeholder 30 d; OTHER_OR_NOT_TOLD → admin review). Visible only to the donor and medical_reviewer/super_admin (audited). Never used to rank or shame.
- not_eligible agreed by both sides → small credit (+2), no penalty.
- Points: append-only ledger; corrections are new negative rows; only for both-confirmed donations within cooldown; +10, +5 critical bonus; expire 12 mo; no cash value; no redemption in v1 (partner vouchers later, Q-006). Badges at 1, 3, 5, 10, 25 donations + Emergency donor. Donors can hide badges and points in settings. No streaks, no leaderboards.
- Anti-fraud: flag donor–requester pairs sharing a device or repeating; admin audits a sample of confirmations.
- Share card + certificate generated server-side, private in R2, signed URLs.
Screens: S11 (requester: "Did <donor> donate?" Yes / Did not arrive / Arrived, not eligible; donor: Yes / Hospital couldn't take my donation) · S15 donation complete (thank you, next eligible, total) · S19 badges + points + share.
Tests: one-sided confirmation never awards or starts cooldown · honest rejection earns credit, no penalty · deferral category-only and the requester never sees the reason · ledger has no update/delete path · break rule after threshold and admin lift · auto-close.
