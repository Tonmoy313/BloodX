BLOODX \- DATABASE SCHEMA (reading copy)  
Generated 2026-10-18 from docs/spec/entities.md and docs/spec/core.md. If they differ, the .md files win.

HOW TO READ  
  NULL \= optional column. NOT NULL \= required. 'default' \= value used when none is given.  
  Tags: \[R\] restricted (health or location) \- \[S\] sensitive (personal data) \- \[I\] internal.  
  FK \= foreign key. Unless a row says CASCADE, foreign keys use ON DELETE RESTRICT.  
  Users are never deleted. Account deletion anonymizes the User row, so history stays intact.  
  All times are timestamptz in UTC. The app shows them in Asia/Dhaka.

\================================================================================================  
PART 1 \- ENUMS (31)  
\================================================================================================

1\. BloodGroup  
   Used by: DonorProfile.blood\_group, BloodRequest.blood\_group,  
   WebDonorImport.blood\_group\_declared  
   A\_POS                         A positive  
   A\_NEG                         A negative  
   B\_POS                         B positive  
   B\_NEG                         B negative  
   O\_POS                         O positive  
   O\_NEG                         O negative (universal donor)  
   AB\_POS                        AB positive (universal recipient)  
   AB\_NEG                        AB negative  
   Note: Docs shorthand A+ means A\_POS, A- means A\_NEG.

2\. Component  
   Used by: BloodRequest.component  
   WHOLE\_BLOOD                   Whole blood. The only component with a flow in v1  
   PLATELETS                     Later (shows 'coming soon')  
   PLASMA                        Later (shows 'coming soon')

3\. Urgency  
   Used by: BloodRequest.urgency  
   CRITICAL                      Needed within 6 hours  
   SAME\_DAY                      Needed later today  
   SCHEDULED                     Needed tomorrow or later  
   Note: Derived from needed\_by\_at; the requester may raise it.

4\. RequestStatus  
   Used by: BloodRequest.status  
   open                          No bags pledged yet  
   partially\_pledged             Some bags pledged, not all  
   fully\_pledged                 All bags pledged  
   partially\_fulfilled           Some donations confirmed  
   fulfilled                     All donations confirmed (terminal)  
   cancelled                     Cancelled by requester or admin (terminal)  
   expired                       needed\_by\_at passed (terminal)  
   closed\_fake                   Closed by admin as fake (terminal)

5\. PledgeStatus  
   Used by: Pledge.status  
   pledged                       Donor committed to one bag  
   en\_route                      Donor tapped 'On my way'  
   arrived                       Donor reached the hospital  
   donated                       Both sides confirmed the donation  
   withdrawn\_free                Cancelled inside the free window (no mark)  
   cancelled                     Cancelled after the free window (counts toward the break rule)  
   released                      System removed it after arrival time \+ grace (counts toward the break rule)  
   not\_eligible                  Hospital could not take the donation (no penalty)  
   unconfirmed                   No confirmation arrived in time (no penalty)  
   Note: Active \= pledged, en\_route, arrived.

6\. Sex  
   Used by: DonorProfile.sex  
   MALE                          Cooldown default 90 days (medical contact confirms)  
   FEMALE                        Cooldown default 120 days (medical contact confirms)

7\. DonorStatus  
   Used by: DonorProfile.donor\_status  
   none                          Never opted in (normally no profile row exists)  
   setup\_incomplete              Opted in, setup not finished; not matchable  
   active                        Setup complete  
   left                          Left donor mode; history kept

8\. AvailabilityMode  
   Used by: DonorProfile.availability\_mode  
   off                           No alerts. Always the starting value  
   critical\_only                 Alerts for CRITICAL requests only  
   all                           Alerts for all requests  
   Note: The system never switches this on by itself.

9\. DeferralCategory  
   Used by: Deferral.category  
   LOW\_HEMOGLOBIN                Hospital reported low hemoglobin  
   LOW\_WEIGHT                    Below the weight limit  
   BLOOD\_PRESSURE                Blood pressure issue  
   RECENT\_ILLNESS\_OR\_MEDICATION  Recent illness, medication, or procedure  
   OTHER\_OR\_NOT\_TOLD             Other reason or not told (goes to admin review)  
   Note: Category only. No free-text reason is stored.

10\. DeferralSource  
   Used by: Deferral.source  
   SELF\_DECLARED                 Donor failed the readiness check  
   HOSPITAL\_REPORTED             Donor reported a hospital rejection  
   ADMIN                         Created by a medical reviewer

11\. Channel  
   Used by: NotificationAttempt.channel  
   PUSH                          FCM/APNs push  
   SMS                           SMS fallback

12\. AdminRole  
   Used by: AdminUser.role  
   ops                           Queue, reports, hospitals, delivery health  
   medical\_reviewer              Sees category-only health summaries, edits deferrals  
   super\_admin                   Everything, including config, flags, broadcast, audit log

13\. UploadStatus  
   Used by: UploadSlot.status  
   issued                        Upload URL given out  
   confirmed                     Server checked the stored object  
   attached                      Used by a request  
   expired                       Not used in time; object deleted

14\. HospitalType  
   Used by: Hospital.type  
   HOSPITAL                      Hospital  
   CLINIC                        Clinic  
   BLOOD\_BANK                    Blood bank (feeds the 'nearest blood banks' list)  
   DIAGNOSTIC                    Diagnostic center

15\. ConsentType  
   Used by: ConsentRecord.type  
   TERMS                         Terms of service  
   PRIVACY                       Privacy policy  
   DONOR\_HEALTH\_DECLARATION      Donor health declaration for donor mode  
   NOTIFICATIONS                 Permission to send notifications

16\. Language  
   Used by: User.language  
   bn                            Bangla (default)  
   en                            English

17\. FlagScope  
   Used by: FeatureFlag.scope  
   all                           All platforms  
   android                       Android only  
   ios                           iOS only  
   web                           Admin web only

18\. Platform  
   Used by: Device.platform  
   android                       Android  
   ios                           iOS  
   web                           Admin web

19\. UserStatus  
   Used by: User.status  
   active                        Normal  
   suspended                     Blocked at the session check  
   deleted                       Anonymized after account deletion

20\. CloseReason  
   Used by: BloodRequest.close\_reason  
   fulfilled                     All bags donated  
   cancelled\_by\_requester        Requester cancelled  
   expired                       Needed-by time passed  
   admin\_closed                  Closed by an admin  
   fake                          Marked fake by an admin

21\. CancelReason  
   Used by: Pledge.cancel\_reason (chips, no free text)  
   traffic                       Stuck in traffic  
   unwell                        Not feeling well  
   plans\_changed                 Plans changed  
   other                         Other

22\. Confirmation  
   Used by: Pledge.donor\_confirmation, Pledge.requester\_confirmation  
   none                          Not answered yet  
   donated                       Says the donation happened  
   did\_not\_arrive                Requester says the donor did not arrive  
   not\_eligible                  Hospital could not take the donation  
   Note: A donation counts only when both sides say 'donated'.

23\. AttemptStatus  
   Used by: NotificationAttempt.status  
   queued                        Created, not sent  
   sent                          Handed to the provider  
   delivered                     Provider confirmed delivery  
   opened                        User opened it  
   failed                        Provider error; the sweeper retries

24\. InboxType  
   Used by: InboxMessage.type (text is rendered on the client in bn/en)  
   NEW\_REQUEST                   A compatible request exists  
   PLEDGE\_RECEIVED               First pledge on your request  
   PLEDGE\_CHANGED                A pledge changed  
   RELEASED                      A donor was released; searching again  
   CHECK\_IN                      'Still coming?' reminder  
   REQUEST\_CANCELLED             Requester cancelled  
   REQUEST\_EXPIRING              Request is about to expire  
   ALL\_BAGS\_FILLED               All bags pledged  
   THANK\_YOU                     Thank-you after a confirmed donation  
   AVAILABILITY\_PROMPT           The single availability-expiry prompt  
   BREAK\_NOTICE                  Friendly break after repeated releases  
   ELIGIBLE\_AGAIN                Only if the donor turned reminders on

25\. LedgerEvent  
   Used by: PointsLedger.event  
   DONATION                      Confirmed donation (+10)  
   CRITICAL\_BONUS                Critical request completed (+5)  
   HONEST\_REJECTION              Both sides confirmed a rejection (+2)  
   CORRECTION                    Negative or positive fix with a reason  
   EXPIRY                        Points expired after 12 months

26\. AssetKind  
   Used by: GeneratedAsset.kind  
   SHARE\_CARD                    Shareable donor image  
   CERTIFICATE                   Donation certificate PDF

27\. ReportTarget  
   Used by: Report.target\_type  
   REQUEST                       A blood request  
   USER                          A user

28\. ReportReason  
   Used by: Report.reason  
   FAKE\_REQUEST                  Looks fake  
   ABUSIVE                       Abusive behavior  
   SPAM                          Spam  
   OTHER                         Other

29\. ReportStatus  
   Used by: Report.status  
   open                          New  
   reviewed                      Seen by an admin  
   actioned                      Action taken  
   dismissed                     No action needed

30\. ShareStatus  
   Used by: LocationShare.status (phase P6)  
   asked                         Waiting for the other person  
   accepted                      Sharing is on  
   declined                      Declined  
   expired                       Time ran out  
   stopped                       Stopped by the sharer or by arrival/cancel/completion

31\. OutcomeEventType  
   Used by: OutcomeEvent.type  
   request\_created  
   wave\_sent  
   pledged  
   withdrawn\_free  
   checked\_in  
   extended  
   arrived  
   donated\_confirmed  
   cancelled  
   released  
   not\_eligible  
   unconfirmed  
   request\_cancelled  
   request\_expired  
   request\_fulfilled  
   contact\_revealed  
   readiness\_passed  
   readiness\_failed  
   deferral\_created

\================================================================================================

# **PART 2 \- ENTITIES (31)**

\================================================================================================

## **\#\#\#\#\# GROUP A. IDENTITY AND ACCESS \#\#\#\#\#**

### **AdminUser:**

* `user_id` (`bigint` \- PK, FK to User & NOT NULL) \- Primary key. FK to User.  
* `role` (`enum(AdminRole)` \- NOT NULL)  
* `created_by` (`bigint` \- FK to User & NOT NULL) \- FK to User.  
* `created_at` (`timestamptz` \- NOT NULL) \- default now()  
* `updated_at` (`timestamptz` \- NOT NULL) \- default now()  
* `disabled_at` (`timestamptz` \- NULL)  
* *Notes*: Purpose: Staff accounts and their single role.

### **User:**

* `id` (`bigint` \- PK & NOT NULL) \- Primary key, auto-generated.  
* Image	  
* full\_name (text & NOT NULL)  
* date\_of\_birth (date & NOT NULL)  
* sex (enum(Sex) & NOT NULL)  
* `phone_e164` (`text` \- UNIQUE & NOT NULL) \- E.164 (+880...). Set to null on account deletion.  
* `phone_hmac` (`text` \- NULL) \- HMAC of the phone, kept only for suspended users to block re-registration. Confirm with legal.  
* `display_name` (`text` \- NOT NULL)  
* `language` (`enum(Language)` \- NOT NULL) \- default 'bn'  
* `status` (`enum(UserStatus)` \- NOT NULL) \- default 'active'  
* `suspended_reason` (`text` \- NULL)  
* `created_at` (`timestamptz` \- NOT NULL) \- default now()  
* `updated_at` (`timestamptz` \- NOT NULL) \- default now()  
* `last_seen_at` (`timestamptz` \- NULL)  
* `deleted_at` (`timestamptz` \- NULL)  
* *Constraints / Notes*: No role column (Donor mode lives on DonorProfile; staff roles live in AdminUser). On account deletion: status \= deleted, phone \= null, display\_name \= 'Deleted user'.  
* *Indexes*: UNIQUE (phone\_e164), (status)  
* 

### **Device:**

* `id` (`bigint` \- PK & NOT NULL) \- Primary key, auto-generated.  
* `install_id` (`uuid` \- UNIQUE & NOT NULL) \- UNIQUE. Created by the app on first launch.  
* `user_id` (`bigint` \- FK to User & NOT NULL) \- FK to User.  
* `platform` (`enum(Platform)` \- NOT NULL)  
* `push_token` (`text` \- NULL)  
* `push_token_updated_at` (`timestamptz` \- NULL)  
* `app_version` (`text` \- NOT NULL)  
* `os_version` (`text` \- NOT NULL)  
* `app_check_ok_at` (`timestamptz` \- NULL) \- Last time Firebase App Check passed.  
* `created_at` (`timestamptz` \- NOT NULL) \- default now()  
* `last_seen_at` (`timestamptz` \- NOT NULL)  
* `revoked_at` (`timestamptz` \- NULL)  
* *Notes*: Revoked on logout, refresh-token reuse, or account deletion. Deleted with the account.  
* *Indexes*: UNIQUE (install\_id), (user\_id), UNIQUE (push\_token) where push\_token is not null

### **OtpChallenge:**

* `id` (`bigint` \- PK & NOT NULL) \- Primary key, auto-generated.  
* `phone_e164` (`text` \- NOT NULL)  
* `code_hash` (`text` \- NOT NULL) \- OTP is hashed, never stored in clear.  
* Type (enum(OtpType) \- NOT NULL)  
* `attempts` (`int` \- NOT NULL) \- default 0  
* `consumed_at` (`timestamptz` \- NULL)  
* `install_id` (`uuid` \- NOT NULL)  
* `ip` (`text` \- NOT NULL)  
* `created_at` (`timestamptz` \- NOT NULL) \- default now()  
* `expires_at` (`timestamptz` \- NOT NULL) \- Created \+ 5 minutes.  
* *Notes*: Purged after 7 days.  
* *Indexes*: (phone\_e164, created\_at), (ip, created\_at), (install\_id, created\_at)

### **ConsentRecord:**

* `id` (`bigint` \- PK & NOT NULL) \- Primary key, auto-generated.  
* `user_id` (`bigint` \- FK to User & NOT NULL) \- FK to User.  
* `type` (`enum(ConsentType)` \- NOT NULL)  
* `version` (`text` \- NOT NULL)  
* `accepted_at` (`timestamptz` \- NOT NULL)  
* `locale` (`text` \- NOT NULL)  
* `app_version` (`text` \- NOT NULL)  
* `withdrawn_at` (`timestamptz` \- NULL)  
* *Notes*: Kept after account deletion, pseudonymized. Confirm with legal.  
* *Indexes*: (user\_id, type, accepted\_at desc)

### **FeatureFlag:**

* `key` (`text` \- PK & NOT NULL) \- Primary key.  
* `enabled` (`bool` \- NOT NULL)  
* `scope` (`enum(FlagScope)` \- NOT NULL) \- default 'all'  
* `min_app_version` (`text` \- NULL)  
* `updated_by` (`bigint` \- FK to User & NOT NULL) \- FK to User.  
* `updated_at` (`timestamptz` \- NOT NULL) \- default now()  
* *Notes*: Turns features on or off per platform; drives the 'coming soon' snackbar.

### **Config:**

* `key` (`text` \- PK & NOT NULL) \- Primary key.  
* `value` (`jsonb` \- NOT NULL)  
* `updated_by` (`bigint` \- FK to User & NOT NULL) \- FK to User.  
* `updated_at` (`timestamptz` \- NOT NULL) \- default now()  
* *Notes*: Tunable values, including min\_supported\_app\_version. Every change writes an AuditLog row.

## **\#\#\#\#\# GROUP B. REFERENCE DATA \#\#\#\#\#**

Here is the schema representation for the **Group B. Reference Data** tables, formatted consistently:

### **Area:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* name\_en (text & NOT NULL)  
* name\_bn (text & NOT NULL)  
* city (text & NOT NULL) \- default 'Dhaka'  
* active (bool & NOT NULL) \- default true  
* created\_at (timestamptz & NOT NULL) \- default now()  
* updated\_at (timestamptz & NOT NULL) \- default now()  
* Constraints: UNIQUE (city, name\_en).

### **AreaAdjacency:**

* area\_id (bigint & NOT NULL) \- FK to Area.  
* neighbor\_area\_id (bigint & NOT NULL) \- FK to Area.  
* Constraints: Primary key (area\_id, neighbor\_area\_id); CHECK area\_id \<\> neighbor\_area\_id.  
* Notes: Store both directions of each pair.

### **Hospital:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* name\_en (text & NOT NULL)  
* name\_bn (text & NOT NULL)  
* area\_id (bigint & NOT NULL) \- FK to Area.  
* address (text & NOT NULL)  
* lat (double precision & NOT NULL)  
* lng (double precision & NOT NULL)  
* type (enum(HospitalType) & NOT NULL)  
* public\_phone (text & NULL)  
* is\_verified (bool & NOT NULL) \- default false  
* active (bool & NOT NULL) \- default true  
* created\_at (timestamptz & NOT NULL) \- default now()  
* updated\_at (timestamptz & NOT NULL) \- default now()  
* Indexes: (area\_id, active); (type); Trigram index on lower(name\_en) and name\_bn for search (needs pg\_trgm; verify on Neon).  
* Notes: BLOOD\_BANK rows feed the 'nearest blood banks' list.

### **BadgeDefinition:**

* key (text PK & NOT NULL) \- Primary key.  
* name\_en (text & NOT NULL)  
* name\_bn (text & NOT NULL)  
* rule (jsonb & NOT NULL) \- For example {"donations": 5}.  
* icon (text & NOT NULL)  
* active (bool & NOT NULL) \- default true

### **ReadinessQuestionnaire:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* version (text & NOT NULL) \- UNIQUE.  
* questions (jsonb & NOT NULL) \- Per item: id, text\_bn, text\_en, blocking, expected answer.  
* active\_from (timestamptz & NOT NULL)  
* created\_at (timestamptz & NOT NULL) \- default now()  
* Notes: The active one is the latest with active\_from \<= now. Final wording comes from the owner (D-014).

## **\#\#\#\#\# GROUP C. DONOR \#\#\#\#\#**

### **DonorProfile:**

* user\_id (bigint PK & NOT NULL) \- Primary key. FK to User.  
* blood\_group (enum(BloodGroup) & NOT NULL)  
* last\_donated\_at (date & NULL) \- Self-declared until a confirmed donation replaces it.  
* donor\_status (enum(DonorStatus) & NOT NULL) \- default 'none'  
* availability\_mode (enum(AvailabilityMode) & NOT NULL) \- default 'off', Always starts off. The system never turns it on.  
* available\_until (timestamptz & NULL) \- Set from the chosen duration (7, 30, or 90 days); expires by itself.  
* quiet\_hours\_enabled (bool & NOT NULL) \- default true  
* quiet\_hours\_start (time & NOT NULL) \- default '22:00', Asia/Dhaka local time.  
* quiet\_hours\_end (time & NOT NULL) \- default '07:00'  
* critical\_override (bool & NOT NULL) \- default false, Allows critical alerts during quiet hours.  
* reminders\_opt\_in (bool & NOT NULL) \- default false, 'Tell me when I'm eligible again.'  
* last\_prompt\_at (timestamptz & NULL)  
* prompt\_snooze\_until (timestamptz & NULL) \- 90 days after 'Not now' or silence.  
* notification\_paused\_until (timestamptz & NULL) \- Set by the break rule.  
* total\_confirmed\_donations (int & NOT NULL) \- default 0  
* joined\_donor\_at (timestamptz & NULL)  
* left\_donor\_at (timestamptz & NULL)  
* created\_at (timestamptz & NOT NULL) \- default now()  
* updated\_at (timestamptz & NOT NULL) \- default now()  
* Constraints: CHECK availability\_mode \= 'off' OR available\_until IS NOT NULL; CHECK total\_confirmed\_donations \>= 0\.  
* Indexes: Matching: (blood\_group, available\_until) where donor\_status \= 'active' and availability\_mode \<\> 'off'; Expiry job: (available\_until) where availability\_mode \<\> 'off'.  
* Notes: Deleted on account deletion (cascades to DonorArea, ReadinessCheck, Deferral).

### **DonorArea:**

* donor\_id (bigint & NOT NULL) \- FK to DonorProfile.user\_id, ON DELETE CASCADE.  
* area\_id (bigint & NOT NULL) \- FK to Area.  
* Constraints: Primary key (donor\_id, area\_id); Maximum 3 per donor (enforced in the service).  
* Indexes: (area\_id, donor\_id).

### **ReadinessCheck:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* donor\_id (bigint & NOT NULL) \- FK to DonorProfile.user\_id, ON DELETE CASCADE.  
* questionnaire\_version (text & NOT NULL)  
* answers (jsonb & NULL) \- Set to null after 12 months.  
* passed (bool & NOT NULL)  
* created\_at (timestamptz & NOT NULL) \- default now()  
* valid\_until (timestamptz & NOT NULL)  
* Indexes: (donor\_id, valid\_until desc).  
* Notes: Answers are never logged.

### **Deferral:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* donor\_id (bigint & NOT NULL) \- FK to DonorProfile.user\_id, ON DELETE CASCADE.  
* category (enum(DeferralCategory) & NOT NULL)  
* source (enum(DeferralSource) & NOT NULL)  
* starts\_at (timestamptz & NOT NULL)  
* ends\_at (timestamptz & NULL)  
* needs\_admin\_review (bool & NOT NULL) \- default false  
* pledge\_id (bigint & NULL) \- FK to Pledge.  
* created\_by\_user\_id (bigint & NULL) \- FK to User.  
* resolved\_at (timestamptz & NULL)  
* resolved\_by (bigint & NULL) \- FK to User.  
* created\_at (timestamptz & NOT NULL) \- default now()  
* Constraints: CHECK ends\_at IS NOT NULL OR needs\_admin\_review.  
* Indexes: (donor\_id, ends\_at); (needs\_admin\_review) where resolved\_at is null.  
* Notes: Visible only to the donor and to medical\_reviewer / super\_admin (every admin read is audited).

## **\#\#\#\#\# GROUP D. REQUESTS AND PLEDGES \#\#\#\#\#**

Here is the schema representation for **Group D (Requests and pledges)** and **Group E (Notifications)**, formatted consistently:

### **BloodRequest:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* public\_code (text & NOT NULL) \- UNIQUE. Human-readable, for example A-1042, from a sequence.  
* requester\_user\_id (bigint & NOT NULL) \- FK to User.  
* client\_request\_id (uuid & NOT NULL) \- Created by the app; makes createRequest idempotent.  
* hospital\_id (bigint & NOT NULL) \- FK to Hospital.  
* ward\_bed\_note (text & NULL) \- Up to 120 characters.  
* component (enum(Component) & NOT NULL) \- default 'WHOLE\_BLOOD'  
* blood\_group (enum(BloodGroup) & NOT NULL)  
* urgency (enum(Urgency) & NOT NULL)  
* bags\_needed (smallint & NOT NULL)  
* needed\_by\_at (timestamptz & NOT NULL)  
* patient\_name (text & NULL)  
* contact\_phone (text & NULL) \- Copy of the requester's verified phone. Required at creation; nulled on account deletion.  
* requisition\_slip\_key (text & NULL) \- R2 object key only, never a URL.  
* status (enum(RequestStatus) & NOT NULL) \- default 'open'  
* bags\_pledged (smallint & NOT NULL) \- default 0  
* bags\_donated (smallint & NOT NULL) \- default 0  
* current\_wave (smallint & NOT NULL) \- default 0  
* boosted\_until (timestamptz & NULL)  
* version (int & NOT NULL) \- default 0, Optimistic locking.  
* created\_at (timestamptz & NOT NULL) \- default now()  
* updated\_at (timestamptz & NOT NULL) \- default now()  
* closed\_at (timestamptz & NULL)  
* close\_reason (enum(CloseReason) & NULL)  
* Constraints: CHECK bags\_needed BETWEEN 1 AND 20 (the configurable cap is lower, default 6); CHECK 0 \<= bags\_pledged \<= bags\_needed; CHECK 0 \<= bags\_donated \<= bags\_needed; CHECK needed\_by\_at \> created\_at.  
* Indexes: UNIQUE (public\_code); UNIQUE (requester\_user\_id, client\_request\_id); (status, urgency, needed\_by\_at) where status is not terminal; (needed\_by\_at) where status is not terminal (expiry job); (hospital\_id, status); (requester\_user\_id, created\_at desc).  
* Notes: On account deletion: null patient\_name, contact\_phone, ward\_bed\_note; delete the slip object; keep the row.

### **UploadSlot:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* user\_id (bigint & NOT NULL) \- FK to User.  
* object\_key (text & NOT NULL) \- UNIQUE.  
* declared\_content\_type (text & NOT NULL)  
* declared\_length (int & NOT NULL)  
* status (enum(UploadStatus) & NOT NULL) \- default 'issued'  
* expires\_at (timestamptz & NOT NULL)  
* confirmed\_at (timestamptz & NULL)  
* request\_id (bigint & NULL) \- FK to BloodRequest.  
* created\_at (timestamptz & NOT NULL) \- default now()  
* Indexes: (status, expires\_at) where status in ('issued', 'confirmed').  
* Notes: Unconfirmed uploads under pending/ are deleted after 24 hours.

### **Pledge:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* request\_id (bigint & NOT NULL) \- FK to BloodRequest.  
* donor\_id (bigint & NOT NULL) \- FK to User.  
* client\_request\_id (uuid & NOT NULL) \- Makes pledge idempotent.  
* status (enum(PledgeStatus) & NOT NULL) \- default 'pledged'  
* committed\_arrival\_at (timestamptz & NOT NULL) \- Must be \<= the request's needed\_by\_at (checked in the pledge transaction).  
* contact\_share\_consented (bool & NOT NULL) \- Must be true.  
* free\_cancel\_until (timestamptz & NOT NULL) \- Created \+ 10 minutes.  
* en\_route\_at (timestamptz & NULL)  
* arrived\_at (timestamptz & NULL)  
* donated\_at (timestamptz & NULL)  
* released\_at (timestamptz & NULL)  
* extensions\_used (smallint & NOT NULL) \- default 0, Maximum 2\.  
* cancel\_reason (enum(CancelReason) & NULL)  
* donor\_confirmation (enum(Confirmation) & NOT NULL) \- default 'none'  
* requester\_confirmation (enum(Confirmation) & NOT NULL) \- default 'none'  
* version (int & NOT NULL) \- default 0  
* created\_at (timestamptz & NOT NULL) \- default now()  
* updated\_at (timestamptz & NOT NULL) \- default now()  
* Constraints: CHECK contact\_share\_consented \= true.  
* Indexes: Partial UNIQUE (request\_id, donor\_id) where status in ('pledged', 'en\_route', 'arrived'); UNIQUE (donor\_id, client\_request\_id); (request\_id, status); (donor\_id, status); (status, committed\_arrival\_at) where status in ('pledged', 'en\_route') (release job).

### **OutcomeEvent:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* type (enum(OutcomeEventType) & NOT NULL)  
* actor\_user\_id (bigint & NULL) \- FK to User.  
* request\_id (bigint & NULL) \- FK to BloodRequest.  
* pledge\_id (bigint & NULL) \- FK to Pledge.  
* meta (jsonb & NULL)  
* created\_at (timestamptz & NOT NULL) \- default now()  
* Indexes: (request\_id, created\_at); (pledge\_id); (type, created\_at).  
* Notes: Keep 24 months; partition by month when it grows.

### **NotificationAttempt:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* request\_id (bigint & NOT NULL) \- FK to BloodRequest.  
* donor\_id (bigint & NOT NULL) \- FK to User.  
* wave (smallint & NOT NULL)  
* channel (enum(Channel) & NOT NULL)  
* idempotency\_key (text & NOT NULL) \- UNIQUE. Format request\_id:donor\_id:wave:channel.  
* status (enum(AttemptStatus) & NOT NULL) \- default 'queued'  
* error\_code (text & NULL)  
* provider\_message\_id (text & NULL)  
* responded\_at (timestamptz & NULL)  
* created\_at (timestamptz & NOT NULL) \- default now()  
* updated\_at (timestamptz & NOT NULL) \- default now()  
* Indexes: UNIQUE (idempotency\_key); (request\_id, wave); (donor\_id, created\_at desc) for the notification-cap check; (status, created\_at) where status in ('queued', 'failed') for the sweeper.  
* Notes: Keep 12 months, then aggregate.

### **InboxMessage:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* user\_id (bigint & NOT NULL) \- FK to User.  
* type (enum(InboxType) & NOT NULL)  
* params (jsonb & NOT NULL) \- Ids and counts only; never phones or health data.  
* request\_id (bigint & NULL) \- FK to BloodRequest.  
* pledge\_id (bigint & NULL) \- FK to Pledge.  
* created\_at (timestamptz & NOT NULL) \- default now()  
* read\_at (timestamptz & NULL)  
* Indexes: (user\_id, created\_at desc); (user\_id) where read\_at is null.  
* Notes: Rendered on the client in Bangla or English. Purged after 90 days.

\------------------------------------------------------------------------------------------------  
23\. BroadcastMessage   \[I\]   (Group E. Notifications)  
\------------------------------------------------------------------------------------------------  
Purpose: Log of admin broadcasts.

Columns:  
  id                         bigint              NOT NULL  
      Primary key, auto-generated.  
  sent\_by\_admin\_id           bigint              NOT NULL  
      FK to User.  
  audience                   jsonb               NOT NULL  
  template\_key               text                NOT NULL  
  params                     jsonb               NULL  
  recipients\_count           int                 NOT NULL  default 0  
  created\_at                 timestamptz         NOT NULL  default now()

## **\#\#\#\#\# GROUP F. REWARDS \#\#\#\#\#**

\------------------------------------------------------------------------------------------------

Here is the schema representation for **Group F (Rewards)**, formatted consistently:

### **PointsLedger:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* donor\_id (bigint & NOT NULL) \- FK to User.  
* event (enum(LedgerEvent) & NOT NULL)  
* points (int & NOT NULL) \- Never zero. Corrections are new rows.  
* pledge\_id (bigint & NULL) \- FK to Pledge.  
* reason (text & NULL) \- Used for corrections only.  
* expires\_at (timestamptz & NULL)  
* created\_at (timestamptz & NOT NULL) \- default now()  
* Constraints: CHECK points \<\> 0; Partial UNIQUE (pledge\_id, event) where pledge\_id is not null (no double awards).  
* Indexes: (donor\_id, created\_at).  
* Notes: No UPDATE or DELETE path. Balance \= sum of points on non-expired rows.

### **DonorBadge:**

* donor\_id (bigint & NOT NULL) \- FK to User.  
* badge\_key (text & NOT NULL) \- FK to BadgeDefinition.key.  
* awarded\_at (timestamptz & NOT NULL) \- default now()  
* Constraints: Primary key (donor\_id, badge\_key).

### **GeneratedAsset:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* donor\_id (bigint & NOT NULL) \- FK to User.  
* kind (enum(AssetKind) & NOT NULL)  
* object\_key (text & NOT NULL) \- UNIQUE.  
* created\_at (timestamptz & NOT NULL) \- default now()  
* Notes: Share cards and certificates stored in R2, tracked so account deletion can remove them.

## **\#\#\#\#\# GROUP G. SAFETY AND AUDIT \#\#\#\#\#**

### **Report:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* reporter\_user\_id (bigint & NOT NULL) \- FK to User.  
* target\_type (enum(ReportTarget) & NOT NULL)  
* target\_id (bigint & NOT NULL)  
* reason (enum(ReportReason) & NOT NULL)  
* note (text & NULL) \- Up to 300 characters, sanitized.  
* status (enum(ReportStatus) & NOT NULL) \- default 'open'  
* reviewer\_admin\_id (bigint & NULL) \- FK to User.  
* outcome (text & NULL)  
* created\_at (timestamptz & NOT NULL) \- default now()  
* reviewed\_at (timestamptz & NULL)  
* Constraints: UNIQUE (reporter\_user\_id, target\_type, target\_id).  
* Indexes: (status, created\_at).

### **AuditLog:**

* id (bigint PK & NOT NULL) \- Primary key, auto-generated.  
* actor\_user\_id (bigint & NULL) \- FK to User.  
* actor\_role (text & NOT NULL)  
* action (text & NOT NULL)  
* target\_type (text & NOT NULL)  
* target\_id (bigint & NULL)  
* install\_id (uuid & NULL)  
* meta (jsonb & NULL) \- Never health data.  
* created\_at (timestamptz & NOT NULL) \- default now()  
* Indexes: (actor\_user\_id, created\_at); (target\_type, target\_id); (action, created\_at).  
* Notes: No UPDATE or DELETE path. Keep at least 24 months; partition by month when large.

\#\#\#\#\# GROUP H. LATER \#\#\#\#\#

\------------------------------------------------------------------------------------------------  
29\. LocationShare   \[R\]   (Group H. Later)  
\------------------------------------------------------------------------------------------------  
Purpose: Phase P6. A time-boxed live-location share between a donor and a requester on an active  
pledge.

Columns:  
  id                         bigint              NOT NULL  
      Primary key, auto-generated.  
  pledge\_id                  bigint              NOT NULL  
      FK to Pledge.  
  asked\_by                   bigint              NOT NULL  
      FK to User.  
  responder                  bigint              NOT NULL  
      FK to User.  
  status                     enum(ShareStatus)   NOT NULL  default 'asked'  
  duration\_minutes           int                 NOT NULL  
      15, 30, or 60\.  
  starts\_at                  timestamptz         NULL  
  expires\_at                 timestamptz         NULL  
  stopped\_at                 timestamptz         NULL  
  created\_at                 timestamptz         NOT NULL  default now()

Indexes:  
  \- Partial UNIQUE (pledge\_id) where status in ('asked', 'accepted') (one active ask per pair)

\------------------------------------------------------------------------------------------------  
30\. LocationPoint   \[R\]   (Group H. Later)  
\------------------------------------------------------------------------------------------------  
Purpose: Phase P6. A single position update inside a share.

Columns:  
  id                         bigint              NOT NULL  
      Primary key, auto-generated.  
  share\_id                   bigint              NOT NULL  
      FK to LocationShare.  
  lat                        double precision    NOT NULL  
  lng                        double precision    NOT NULL  
  recorded\_at                timestamptz         NOT NULL

Indexes:  
  \- (share\_id, recorded\_at)

Notes:  
  \- Deleted when the request closes.

\------------------------------------------------------------------------------------------------  
31\. WebDonorImport   \[S\]   (Group H. Later)  
\------------------------------------------------------------------------------------------------  
Purpose: Blocked on Q-004. Staging table for the website donor claim flow. Never matched until  
the donor claims their profile.

Columns:  
  id                         bigint              NOT NULL  
      Primary key, auto-generated.  
  phone\_e164                 text                NOT NULL  
  name                       text                NOT NULL  
  blood\_group\_declared       enum(BloodGroup)    NULL  
  last\_donated\_declared      date                NULL  
  source\_id                  text                NOT NULL  
  claimed\_user\_id            bigint              NULL  
      FK to User.  
  created\_at                 timestamptz         NOT NULL  default now()

\================================================================================================  
PART 3 \- RELATIONSHIPS AND ACCOUNT DELETION  
\================================================================================================

Relationships  
  \- User 1 to 0..1 DonorProfile  
  \- DonorProfile 1 to many DonorArea, ReadinessCheck, Deferral  
  \- User 1 to many BloodRequest (as requester) and Pledge (as donor)  
  \- BloodRequest 1 to many Pledge, NotificationAttempt, UploadSlot  
  \- Hospital 1 to many BloodRequest  
  \- Area 1 to many Hospital; Area many to many Area (AreaAdjacency)  
  \- Pledge 1 to many OutcomeEvent, PointsLedger rows; Pledge 1 to many LocationShare (P6)  
  \- User 1 to many Device, ConsentRecord, InboxMessage, GeneratedAsset

Account deletion  
  Anonymize: User.  
  Delete: DonorProfile (cascades to DonorArea, ReadinessCheck, Deferral), Device, OtpChallenge,  
  InboxMessage, GeneratedAsset (and the R2 files), LocationPoint.  
  Scrub personal fields: BloodRequest (patient\_name, contact\_phone, ward\_bed\_note) and delete  
  the slip object.  
  Keep (pseudonymous): Pledge, OutcomeEvent, PointsLedger, DonorBadge, Report, AuditLog,  
  ConsentRecord (confirm retention with legal).

Database features to verify before building (Serverpod/Neon may need hand-written SQL migrations)  
  \- Partial indexes and CHECK constraints  
  \- Append-only tables (no UPDATE/DELETE) for PointsLedger and AuditLog  
  \- pg\_trgm extension for hospital name search  
