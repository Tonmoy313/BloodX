# BloodX entity draft

> The current implementation scope is P0 authentication. Other identity, billing,
> KYC, and donor entities below remain design-only until their project phase.

## Group A. Identity and access

### **User:**

* `id` (`bigint` \- PK & NOT NULL) \- Primary key, auto-generated.  
* image\_key (text \- NULL) \- R2 object key for the profile image, not a URL.	  
* `name` (`text` \- NOT NULL)   
* `phone_e164` (`text` \- UNIQUE & NULL) \- E.164 (+880...). Cleared on account deletion.  
* `phone_hmac` (`text` \- NULL) \- Keyed HMAC retained only for suspended accounts to block re-registration; cleared on deletion.   
* tier\_id (bigint \- FK Tier.id & NOT NULL) \- default \= the ‘free’ tier row.   
* `language` (`enum(Language)` \- NOT NULL) \- default 'bn'  
  *  bn                            Bangla (default)  
  *  en                            English  
* `status` (`enum(UserStatus)` \- NOT NULL) \- default 'active'  
  *  active                        Normal  
  * suspended                     Blocked at the session check  
  * deleted                       Anonymized after account deletion  
* `suspended_reason` (`text` \- NULL)  
* `created_at` (`timestamptz` \- NOT NULL) \- default now()  
* `updated_at` (`timestamptz` \- NOT NULL) \- default now()  
* `last_seen_at` (`timestamptz` \- NULL)  
* `deleted_at` (`timestamptz` \- NULL)  
* *Constraints / Notes*: No role column (Donor mode lives on DonorProfile; staff roles live in AdminUser). On account deletion: status \= deleted, phone\_e164 \= null, phone\_hmac \= null, name \= ‘Deleted user’, image\_key \= null.   
* *Indexes*: UNIQUE (phone\_e164), (status),(tier\_id)

### **UserEmail**

* user\_id (bigint \- PK, FK User.id & NOT NULL) \- One optional row per user.  
* email (text \- UNIQUE & NOT NULL) \- Lower-cased on write.  
* verified\_at (timestamptz \- NULL) \- Set only after the user confirms by link or code.  
* created\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: Changing the email updates `email` and clears `verified_at`. No row means no email. If you later make email mandatory, enforce it in the signup flow instead of changing this table.  
* Indexes: UNIQUE (email)

### **UserCredential**

* user\_id (bigint \- PK, FK User.id & NOT NULL) \- One row per user.  
* pin\_hash (text \- NOT NULL) \- Argon2id hash of the 5-digit PIN. Never store or log the raw PIN.  
* failed\_attempts (int \- NOT NULL) \- default 0\. Reset on successful login.  
* locked\_until (timestamptz \- NULL) \- Set after 5 attempts.  
* pin\_changed\_at (timestamptz \- NOT NULL) \- default now()  
* updated\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: Delete the row on account deletion. Lockout thresholds live in Config. A 5-digit PIN has only 100,000 combinations, so the lockout and OTP fallback carry the real security.  
* Indexes: PK (user\_id)

### **UserPreference**

* user\_id (bigint \- PK, FK User.id & NOT NULL) \- One row per user.  
* notify\_requests (boolean \- NOT NULL) \- default true. Blood request notifications.  
* notify\_feed (boolean \- NOT NULL) \- default true.  
* quiet\_hours\_enabled (boolean \- NOT NULL) \- default true  
* quiet\_hours\_start (time \- NULL)  
* quiet\_hours\_end (time \- NULL)  
* updated\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: Theme is stored on the device only, not here. Donor availability settings stay on DonorProfile, not here.  
* Indexes: PK (user\_id)

### **KycVerification**

* id (bigint \- PK & NOT NULL) \- Primary key, auto-generated.  
* user\_id (bigint \- FK User.id & NOT NULL)  
* type (enum(KycType) \- NOT NULL)  
  * nid \- National ID  
* provider (enum(KycProvider) \- NOT NULL) \- Values are added when you choose a provider.  
* provider\_ref (text \- NOT NULL) \- The provider’s reference for this attempt.  
* status (enum(KycStatus) \- NOT NULL) \- default ‘pending’  
  * pending \- Submitted, waiting for the provider  
  * verified \- Approved  
  * rejected \- Declined; the user may retry  
* subject\_hmac (text \- NULL) \- HMAC of the NID number with a server pepper. Set only when verified. The NID number itself is never stored. Confirm with legal.  
* rejection\_code (text \- NULL) \- The provider’s code, not free text.  
* submitted\_at (timestamptz \- NOT NULL) \- default now()  
* completed\_at (timestamptz \- NULL)  
* expires\_at (timestamptz \- NULL)  
* Constraints / Notes: CHECK status \<\> ‘verified’ OR (completed\_at IS NOT NULL AND subject\_hmac IS NOT NULL). One pending row per user and type. “Expired” is derived: verified with `expires_at` in the past, so there is no expired status to keep in sync. Name and date-of-birth matches against the provider are checked at verification time and not stored. Rows are deleted on account deletion. Every status change writes an AuditLog row.  
* Indexes: (user\_id, type, status), UNIQUE (user\_id, type) where status \= ‘pending’, UNIQUE (provider, provider\_ref), UNIQUE (subject\_hmac) where status \= ‘verified’

### **Device:**

* `id` (`bigint` \- PK & NOT NULL) \- Primary key, auto-generated.  
* `install_id` (`uuid` \- UNIQUE & NOT NULL) \- UNIQUE. Created by the app on first launch.  
* `user_id` (`bigint` \- FK to User & NOT NULL) \- FK to User.  
* `platform` (`enum(Platform)` \- NOT NULL)  
  * android                       Android  
  * ios                           iOS  
* `push_token` (`text` \- NULL)  
* `push_token_updated_at` (`timestamptz` \- NULL)  
* `app_version` (`text` \- NOT NULL)  
* `os_version` (`text` \- NOT NULL)  
* `app_check_ok_at` (`timestamptz` \- NULL) \-is it necessary?.  
* `created_at` (`timestamptz` \- NOT NULL) \- default now()  
* `last_seen_at` (`timestamptz` \- NOT NULL)  
* `revoked_at` (`timestamptz` \- NULL)  
* *Notes*: Revoked on logout, refresh-token reuse, or account deletion. Deleted with the account.  
* *Indexes*: UNIQUE (install\_id), UNIque (user\_id), UNIQUE (push\_token) where push\_token is not null

### **OtpChallenge:**

* `id` (`bigint` \- PK & NOT NULL) \- Primary key, auto-generated.  
* `phone_e164` (`text` \- NOT NULL)  
* `code_hash` (`text` \- NOT NULL) \- OTP is hashed, never stored in clear.  
* Type (enum(OtpType) \- NOT NULL)  
  * REGISTRATION \- Account registration  
  * FORGOT\_PIN \- Reset PIN  
  * PHONE\_CHANGE \- Change the account phone number  
  * ACCOUNT\_DELETION \- Confirm account deletion  
  * EMAIL\_VERIFICATION \- confirm email address  
* `attempts` (`int` \- NOT NULL) \- default 0; Locked once it reaches the Config limit (for example 3).   
* `consumed_at` (`timestamptz` \- NULL)  
* send\_count (int \- NOT NULL) \- default 1\. Number of resends for this challenge, capped in Config.   
* `install_id` (`uuid` \- NOT NULL)  
* `ip` (`text` \- NOT NULL)  
* `created_at` (`timestamptz` \- NOT NULL) \- default now()  
* consumed\_at (timestamptz \- NULL) \- Set once when the code is verified correctly.   
* `expires_at` (`timestamptz` \- NOT NULL) \- Created \+ 5 minutes.  
* *Constraints / Notes: Creating a new challenge for the same phone and type invalidates the previous open one. A verified challenge must hand the next step (set PIN, reset PIN) a short-lived signed token, so the client never replays the OTP. Compare codes in constant time. Store only a keyed IP HMAC for rate limits, never the raw IP. Purged after 7 days, which also clears phone and IP HMAC.*  
* *Indexes: (phone\_e164, created\_at), (ip, created\_at), (install\_id, created\_at), UNIQUE (phone\_e164, type) where consumed\_at is null*

### **ConsentRecord:**

* `id` (`bigint` \- PK & NOT NULL) \- Primary key, auto-generated.  
* `user_id` (`bigint` \- FK to User & NOT NULL) \- FK to User.  
* `type` (`enum(ConsentType)` \- NOT NULL)  
  * TERMS \- Terms of service  
  * PRIVACY \- Privacy policy  
  * DONOR\_HEALTH\_DECLARATION \- Donor health declaration for donor mode  
  * DONOR\_LOCATION\_SHARING \- Storing and using donor location for matching, only if you store it server-side  
* `version` (`text` \- NOT NULL)  
* `accepted_at` (`timestamptz` \- NOT NULL)  
* `locale` (`text` \- NOT NULL)- Language the document was shown in (bn or en).   
* `app_version` (`text` \- NOT NULL)  
* `withdrawn_at` (`timestamptz` \- NULL) \- Set when the user withdraws. For TERMS and PRIVACY, withdrawal means account deletion.   
* *Constraints / Notes: UNIQUE (user\_id, type, version). Never update or delete a row except to set withdrawn\_at. Keep after account deletion only in pseudonymized form; confirm retention and anonymization details with legal. A new document version needs a new row, and the app blocks use until the user accepts it. Background-location consent is not supported.*  
* *Indexes: UNIQUE (user\_id, type, version), (user\_id, type, accepted\_at desc)*

### **FeatureFlag:**

* `key` (`text` \- PK & NOT NULL) \- Primary key.  
* `enabled` (`bool` \- NOT NULL)  
* `scope` (`enum(FlagScope)` \- NOT NULL) \- default 'all'  
  * all                           All platforms  
  * android                       Android only  
  * ios                           iOS only  
* `min_app_version` (`text` \- NULL)  
* `updated_by` (`bigint` \- FK to User & NOT NULL) \- FK to User.  
* `updated_at` (`timestamptz` \- NOT NULL) \- default now()  
* *Notes*: Turns features on or off per platform; drives the 'coming soon' snackbar.

### **Config**

* key (text \- PK & NOT NULL) \- Dotted names such as ‘donor.cooldown\_days.male’.  
* value (jsonb \- NOT NULL)  
* description (text \- NOT NULL) \- What it controls, its unit, and its valid range.  
* updated\_by (bigint \- FK AdminUser.user\_id & NULL) \- Null for seed values loaded by a migration.  
* updated\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: Non-secret values only. Never store API keys or HMAC peppers here. Validate type and range against a registry in code before every write, because jsonb accepts anything. Every change writes an AuditLog row with the old and new value in `meta`. Keys the app reads at startup, such as min\_supported\_app\_version, are cached with a TTL.  
* Indexes: PK (key)

## **\#\#\#\#\# GROUP B. Tier System\#\#\#\#\#**

### **Tier**

* id (bigint \- PK & NOT NULL) \- Primary key, auto-generated.  
* code (text \- UNIQUE & NOT NULL) \- Stable key used in code, for example ‘free’, ‘verified’.  
* name (text \- NOT NULL) \- Display name.  
* max\_open\_requests (int \- NOT NULL) \- How many unfulfilled requests a user can have at once. default 1\.  
* requires\_verification\_level (enum(VerificationLevel) \- NOT NULL) \- default ‘phone’. Minimum level to be on this tier.  
  * phone \- OTP verified  
  * nid \- NID verified through the KYC API  
* is\_active (boolean \- NOT NULL) \- default true. Never delete tiers; set false so existing users keep working.  
* created\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: ‘free’ is a real row, so every user always has a tier and code never checks for null. Paid or premium facilities are intentionally not modeled yet.  
* Indexes: UNIQUE (code)

### **TierLimit**

* id (bigint \- PK & NOT NULL) \- Primary key, auto-generated.  
* tier\_id (bigint \- FK Tier.id & NOT NULL)  
* component (enum(BloodComponent) \- NOT NULL)  
  * WHOLE\_BLOOD \- Whole blood  
  * RED\_CELLS \- Red blood cells  
  * PLATELETS \- Platelets (apheresis)  
  * PLASMA \- Plasma (plasmapheresis)  
  * WHITE\_CELLS \- White cells (confirm with medical contact)  
* max\_open\_bags (int \- NOT NULL) \- Maximum bags of this component across the user’s open requests. Free tier example: WHOLE\_BLOOD 2, RED\_CELLS 1, WHITE\_CELLS 1, PLASMA 1\.  
* max\_bags\_per\_window (int \- NULL) \- Optional second guard on bags requested in a rolling window. Null means no window limit.  
* window\_days (int \- NULL) \- Length of that window, for example 30\. Required when max\_bags\_per\_window is set.  
* Constraints / Notes: UNIQUE (tier\_id, component). CHECK that max\_bags\_per\_window and window\_days are both null or both set. Usage is counted live from BloodRequest, not stored as counters, so it can never drift. A request above the limit goes to a manual or hospital-confirmation path with a message in Bangla and English, never a plain refusal.  
* Indexes: UNIQUE (tier\_id, component)

### **Subscription**

* id (bigint \- PK & NOT NULL) \- Primary key, auto-generated.  
* organization\_id (bigint \- FK Organization.id & NOT NULL)  
* plan\_id (bigint \- FK Plan.id & NOT NULL)  
* status (enum(SubscriptionStatus) \- NOT NULL) \- default ‘active’  
  * trialing \- Free trial period  
  * active \- Current  
  * past\_due \- Payment failed, grace period  
  * canceled \- Ends at period end  
  * expired \- Ended, falls back to free plan  
* current\_period\_start (timestamptz \- NOT NULL)  
* current\_period\_end (timestamptz \- NOT NULL)  
* cancel\_at\_period\_end (boolean \- NOT NULL) \- default false  
* created\_at (timestamptz \- NOT NULL) \- default now()  
* updated\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: Design blocked: Organization and Plan are referenced but not defined in this draft. Do not implement subscriptions or paid behavior until those entity specifications and the billing scope are approved.  
* Indexes: (organization\_id, status), (current\_period\_end)

### **Payment**

* id (bigint \- PK & NOT NULL) \- Primary key, auto-generated.  
* subscription\_id (bigint \- FK Subscription.id & NOT NULL)  
* organization\_id (bigint \- FK Organization.id & NOT NULL)  
* amount (numeric(12,2) \- NOT NULL)  
* currency (text \- NOT NULL) \- default ‘BDT’  
* provider (enum(PaymentProvider) \- NOT NULL)  
  * BKASH \- bKash  
  * NAGAD \- Nagad  
  * SSLCOMMERZ \- SSLCommerz gateway  
  * MANUAL \- Bank transfer or cash, confirmed by staff  
* provider\_txn\_id (text \- UNIQUE & NULL) \- Provider’s transaction ID. The unique constraint makes webhook retries safe.  
* status (enum(PaymentStatus) \- NOT NULL) \- default ‘pending’  
  * pending \- Started  
  * succeeded \- Confirmed by provider webhook  
  * failed \- Declined or canceled  
  * refunded \- Returned  
* paid\_at (timestamptz \- NULL)  
* created\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: Mark a payment succeeded only from the provider’s server webhook, never from the app’s say-so. Never store card or wallet credentials. Every status change writes an AuditLog row.  
* Indexes: UNIQUE (provider\_txn\_id), (organization\_id, created\_at)

This entity is blocked with Subscription until Organization and Plan are defined and the billing scope is approved.

`User.tier_id` is the canonical entitlement reference. Do not duplicate it with a stored `verification_level`; derive verification state from KYC records when that feature is in scope.

## **\#\#\#\#\# GROUP C. DONOR \#\#\#\#\#**

### **AdminArea**

* id (int \- PK & NOT NULL) \- Primary key.  
* type (enum(AdminAreaType) \- NOT NULL)  
  * DISTRICT \- District  
  * UPAZILA \- Rural sub-district  
  * THANA \- Metropolitan police-station area  
* name\_bn (text \- NOT NULL)  
* name\_en (text \- NOT NULL)  
* centroid\_cell (bigint \- NOT NULL) \- H3 cell at resolution 7 for the area’s center.  
* Constraints / Notes: Static reference data, never edited by users.  
* Indexes: (parent\_id, type)

### **DonorProfile**

* user\_id (bigint \- PK, FK User.id & NOT NULL) \- Primary key.  
* date\_of\_birth (date \- NOT NULL) \- Minimum and maximum donor age are checked in the application from Config, not by a database CHECK.  
* sex (enum(Sex) \- NOT NULL) \- Used only for donation eligibility. Ask your medical contact how the screen should word this.  
  * MALE \- Cooldown from Config (default 90 days, medical contact confirms)  
  * FEMALE \- Cooldown from Config (default 120 days, medical contact confirms)  
* blood\_group (enum(BloodGroup) \- NOT NULL) \- All 8 values with Rh.  
* blood\_group\_source (enum(BloodGroupSource) \- NOT NULL) \- default ‘self’  
  * self \- Declared by the donor  
  * lab \- Confirmed by a lab or blood bank  
* apheresis\_willing (boolean \- NOT NULL) \- default false. Willing to donate platelets or plasma at an apheresis-capable facility.  
* weight\_kg (double precision \- NOT NULL) \- Last declared weight, updated from the latest passed ReadinessCheck.  
* weight\_declared\_at (timestamptz \- NOT NULL)  

* donor\_status (enum(DonorStatus) \- NOT NULL) \- default ‘setup\_incomplete’  
  * setup\_incomplete \- Opted in, setup not finished; not matchable  
  * active \- Setup complete  
  * disable \- disables donor mode; history kept  
* left\_donor\_at (timestamptz \- NULL) \- Set when donor\_status becomes ‘disable’, cleared if the donor rejoins.

* alert\_mode (enum(AlertMode) \- NOT NULL) \- default ‘off’. The system never switches this on by itself.  
  * off \- No alerts  
  * critical\_only \- Alerts for CRITICAL requests only  
  * all \- Alerts for all requests  
* available\_until (timestamptz \- NULL) \- Set from the chosen duration (1,7, 15, 30,60 90 days or unitl i change it). Matching checks it directly and does not rely on the expiry job.  
* eligibilty\_reminder (boolean \- NOT NULL) \- default true. “Tell me when I’m eligible again.”  
* last\_prompt\_at (timestamptz \- NULL)  
 

* last\_donated\_at (date \- NULL) \- Self-declared until a confirmed donation replaces it.  
* total\_donations (int \- NOT NULL) \- default 0\. Cached count only.  
* created\_at (timestamptz \- NOT NULL) \- default now()  
* updated\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: CHECK alert\_mode \= ‘off’ OR available\_until IS NOT NULL. CHECK (donor\_status \= ‘disable’) \= (left\_donor\_at IS NOT NULL). Weight comes from the latest passed ReadinessCheck, the confirmed donation count comes from Donation, and location lives in DonorArea and DonorLiveLocation, so none of those are stored here. Activation rule, enforced in the transaction that sets donor\_status to active: a HOME DonorArea row exists and the latest ReadinessCheck is PASSED and unexpired. Matching also excludes donors with an active Deferral. Deleted on account deletion (cascades to DonorArea, DonorLiveLocation, ReadinessCheck, and temporary Deferral rows).  
* Indexes: Matching: (blood\_group) where donor\_status \= ‘active’ and alert\_mode \<\> ‘off’; Expiry job: (available\_until) where alert\_mode \<\> ‘off’.

### **DonorArea**

* donor\_id (bigint \- FK DonorProfile.user\_id & NOT NULL)  
* kind (enum(DonorAreaKind) \- NOT NULL)  
  * HOME \- Home upazila or thana  
  * SECONDARY \- Optional work or study area  
  * TERTIARY \- Optional   
* area\_id (bigint \- FK AdminArea.id & NOT NULL) \- Chosen by dropdown.  
* gps\_cell (bigint \- NULL) \- H3 cell at resolution 7\. Set only when the donor allowed GPS, and raw coordinates are never stored. Null means “use the area’s centroid.”  
* confirmed\_at (timestamptz \- NOT NULL) \- default now(). Last time the donor confirmed this area.  
* Constraints / Notes: UNIQUE (donor\_id, kind). A donor must provide a HOME area during profile setup before readiness can pass. The effective cell is gps\_cell if present, otherwise AdminArea.centroid\_cell, and it is never stored. Deleted on account deletion. If legacy area rows exist, classify them as TERTIARY; do not archive them.  
* Indexes: (area\_id), (gps\_cell) where gps\_cell is not null

### **DonorLiveLocation**

* donor\_id (bigint \- PK, FK DonorProfile.user\_id & NOT NULL) \- One row per donor.  
* cell (bigint \- NOT NULL) \- H3 cell at resolution 7 from the latest coarse location.  
* permission (enum(LocationPermission) \- NOT NULL) \- Client-reported OS state.  
  * while\_in\_use \- Foreground location only; background updates are not allowed  
* confirmed\_at (timestamptz \- NOT NULL) \- Last time the device confirmed its cell, by cell change or heartbeat.  
* Constraints / Notes: The row exists only while DONOR\_LOCATION\_SHARING consent is active and a location is known. Withdrawing consent deletes the row in the same transaction that sets withdrawn\_at. No nullable columns and no cross-column CHECKs, because the row’s existence replaces them. Permission is really a per-device fact; keeping it here assumes one active device per donor, which is a deliberate v1 simplification. If you add a device table for push tokens, move it there.  
* Indexes: (cell)

### **ReadinessCheck**

* id (bigint \- PK & NOT NULL) \- Primary key, auto-generated.  
* donor\_id (bigint \- FK DonorProfile.user\_id & NOT NULL)  
* questionnaire\_version (text \- NOT NULL) \- Version of the Bangladesh questionnaire the donor saw.  
* outcome (enum(ReadinessOutcome) \- NOT NULL)  
  * PASSED \- Eligible by self-check  
  * DEFERRED \- Not eligible now; see the linked Deferral  
* weight\_kg (numeric(4,1) \- NOT NULL) \- Weight declared in this check.  
* valid\_until (timestamptz \- NULL) \- Only for PASSED. A passed check expires after a Config window.  
* locale (text \- NOT NULL)  
* app\_version (text \- NOT NULL)  
* checked\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: Raw answers are never stored, only the outcome. CHECK outcome \<\> ‘PASSED’ OR valid\_until IS NOT NULL. A passed check is not a medical clearance; the blood bank decides on site. Deleted on account deletion.  
* Indexes: (donor\_id, checked\_at desc)

### **Deferral(স্থগিতকরণ):**

* id (bigint \- PK & NOT NULL) \- Primary key, auto-generated.  
* user\_id (bigint \- FK User.id & NOT NULL)  
* type (enum(DeferralType) \- NOT NULL)  
  * TEMPORARY \- Ends on ends\_at  
  * PERMANENT \- Only staff can lift it  
* reason (enum(DeferralReason) \- NOT NULL) \- Deliberately coarse, so a leak reveals as little as possible.  
  * LOW\_WEIGHT \- Below minimum weight  
  * AGE\_LIMIT \- Outside the age range  
  * RECENT\_DONATION \- Within the cooldown  
  * TEMPORARY\_HEALTH \- Short-term health reason  
  * TRAVEL \- Travel-related deferral  
  * MEDICAL\_REVIEW \- Everything sensitive or unclear, shown to the donor as “please speak to blood bank staff”  
* source (enum(DeferralSource) \- NOT NULL)  
  * SELF\_CHECK \- From a ReadinessCheck  
  * BLOOD\_BANK \- Recorded by a blood bank  
  * STAFF \- Recorded by your admin  
* readiness\_check\_id (bigint \- FK ReadinessCheck.id & NULL)  
* starts\_at (timestamptz \- NOT NULL) \- default now()  
* ends\_at (timestamptz \- NULL) \- Null only for PERMANENT.  
* lifted\_at (timestamptz \- NULL)  
* lifted\_by (bigint \- FK AdminUser.id & NULL)  
* created\_at (timestamptz \- NOT NULL) \- default now()  
* Constraints / Notes: CHECK (type \= ‘PERMANENT’) \= (ends\_at IS NULL). A deferral is active when lifted\_at is null and (type is PERMANENT or ends\_at is in the future). Matching excludes donors with any active deferral. Donors cannot lift a deferral themselves. Do not retain phone HMACs for deferrals; D-025 permits retention only for suspended accounts. Sensitive reasons always use MEDICAL\_REVIEW.  
* Indexes: (user\_id) where lifted\_at is null