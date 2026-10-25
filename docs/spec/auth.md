# bloodX Auth — Implementation Spec

## Scope
Phone-based authentication, one account per phone, and one active install ID per account. OTP verification can transfer the binding; IP is an abuse-rate-limit signal, not an authentication factor.

## Data model
- `User` (`app_user`): `id`, `phoneE164`, `phoneHmac`, `displayName`, `authUserId?`, `boundInstallId?`, `pinHash?`, `pinSetAt?`, `pinFailedAttempts`, `pinLockedUntil?`, `language`, `status`, `createdAt`, `updatedAt`, `lastSeenAt?`, `deletedAt?`.
- `OtpChallenge` (`otp_challenge`): `id`, `phoneE164`, `codeHash`, `installId`, keyed `ip` hash, `type` (`newAccount|forgetPin|deviceTransfer`), `attempts`, `consumedAt?`, `createdAt`, `expiresAt`.
- `DeviceToken` (push notifications only): `user_id`, `platform`, `token` (unique), `last_seen_at`. Do not use push tokens as authentication or device identity.

Store PINs as Argon2id hashes; never store plaintext secrets. Serverpod JWT sessions are persisted using the Flutter auth-session manager and secure storage.

## Endpoints
- `authIdp.startLogin(phone, installId, isForgotPin)` — public; stores a challenge and returns its integer ID.
- `authIdp.finishLogin(challengeId, code, installId)` — public; verifies the code and originating install ID, creates/links an account when allowed, and returns `AuthSuccess`. OTP verification on a new install transfers the binding and revokes the account's existing tokens.
- `auth.setPin(pin)` — authenticated; stores the Argon2id PIN hash.
- `auth.loginWithPin(phone, pin, installId)` — public; verifies PIN and bound install ID, then returns `AuthSuccess`.
- `logout()` — revoke the current Serverpod auth session through the auth-session manager.
- `deleteAccount(confirm)` — require the user to type `DELETE`; delete/anonymize account data as specified below.
- `registerDeviceToken(token, platform)` / `unregisterDeviceToken(token)` — push notifications only.
- `becomeDonor(healthDetails)` — set role to `donor` and save the donor health/profile details after the user completes the donor form. A donor is not eligible/matchable until required details are complete and validated.

## Security rules
- Bangladesh phone numbers are normalized to `+880` E.164 and invalid prefixes are rejected.
- Rate-limit OTP starts by phone, secure install ID, and keyed client-IP hash using database transactions and PostgreSQL advisory locks. IP changes do not block OTP verification. Trust proxy headers only from the configured hosting ingress.
- OTP: cryptographically generated 6 digits, Argon2id hash at rest, 5-minute expiry, single use, max 5 attempts, 60-second resend cooldown, and per-phone/device/IP hourly limits. Challenges are bound to phone and secure install ID. Never log OTPs.
- PIN: exactly 5 numeric digits; Argon2id hash at rest. Reject `00000` in every build. Lock login for 15 minutes after 5 wrong PINs. Use a generic error for unknown accounts and incorrect PINs.
- Device policy: a UUIDv4 install ID is generated once and persisted in `flutter_secure_storage`. The first verified OTP binds it. OTP verification from a different install ID moves the account binding and revokes all existing tokens before issuing a new token. PIN login must come from the bound install; use the Forgot PIN OTP flow to transfer to a new install.
- Twilio is the initial SMS adapter. Inject `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, and `TWILIO_FROM_NUMBER` from a secret manager; never commit or log credential values. Trial accounts can send only to verified destination numbers. Inject `OTP_IP_RATE_LIMIT_HMAC_KEY` similarly. SMS delivery fails closed when Twilio is unconfigured or rejects the request.
- Use the socket peer IP for the keyed abuse-rate-limit signal; do not trust forwarded IP headers until a trusted ingress resolver is configured. A changing IP never invalidates a pending challenge.
- Store Serverpod auth sessions only through the secure auth-session manager; never persist tokens in Hive/SharedPreferences. Suspended/deleted users cannot authenticate.
- Suspended/deleted users cannot authenticate; deleted users cannot reset PIN. On deletion, revoke sessions and push tokens, remove profile/health data as required, and anonymize retained request/pledge references.
- If app version is below the supported minimum, return UPDATE_REQUIRED and block normal use. Keep minimum version in code/deployment configuration; no Config entity/API.
- Never log OTPs, PINs, tokens, or full phone numbers; mask phone numbers.

## Screens, dialogues & navigation

### Screens (S1–S9, S22)
- **S1: Splash (`SplashScreen`)**
  - BloodX animated emblem, bilingual branding, and initialization check.
  - If app version < minimum required: navigate to **S22** and halt.
  - If authenticated session exists: navigate to **App** (Home).
  - Else: navigate to **S2** (Onboarding).
- **S2: Onboarding (`OnboardingScreen`)**
  - Language toggle (Bangla / English), 2–3 horizontal slides highlighting Dhaka emergency waves, nonprofit zero fees, and consent protection.
  - **Can be skipped**: Skip button in header navigates directly to **S3** (Sign Up) or **S6** (Log In). "Get Started" button leads to **S3**.
- **S3: Phone Input / Sign Up (`PhoneInputScreen`)**
  - Bangladesh phone input (+880 prefix, 10 digits, validated E.164).
  - Donor opt-in checkbox (D-015: unchecked by default).
  - Tap on Terms & Privacy Policy opens **S7** dialog.
  - "Already have an account? Log In" link navigates to **S6**.
  - In Forgot PIN flow: invoked as `isForgotPin: true` (omits donor checkbox, title: "Reset PIN").
- **S4: OTP Verification (`OtpVerificationScreen`)**
  - 6-digit numeric OTP code input.
  - Masked phone display (`+880 17••• •••89`), 60-second cooldown resend timer.
  - Single use; test code `000000` permitted in dev mode only.
  - On verification success: carries forward context and navigates to **S5**.
- **S5: PIN Setup (`PinSetupScreen`)**
  - Exactly 5 numeric digits; hashed at rest.
  - Step 1: "Create 5-digit PIN"; Step 2: "Confirm your 5-digit PIN" (`verify_pin`).
  - Validation: rejects non-matching entries; `00000` test-only.
  - On success: saves PIN hash and navigates to **S6** (Phone + PIN Login).
- **S6: Phone + PIN Login (`LoginPinScreen`)**
  - Phone input (+880 prefix) + 5-digit PIN entry.
  - Only allowed from the currently bound device; lock account login for 15 minutes after 5 consecutive failed attempts.
  - "Forgot PIN?" link triggers reset flow: `S6 -> S3 (without checkbox) -> S4 -> S5 (new pin) -> S6 -> App`.
  - "Don't have an account? Sign Up" link navigates to **S3**.
  - On successful login:
    - If donor opt-in was checked in S3 (or profile is incomplete): navigates to **S8** (Donor Health Details) <-> **S9** -> App.
    - If donor unchecked / returning user with complete profile: navigates directly to **App** (Home).
- **S7: Terms & Privacy Policy Dialog (`TermsPrivacyDialog`)**
  - Small, scrollable dialog displaying nonprofit status (D-001), volunteer terms (D-016), privacy and data consent policies.
- **S8: Donor Health Details (`DonorHealthDetailsScreen`)**
  - Blood group selector (`A+`, `A-`, `B+`, `B-`, `O+`, `O-`, `AB+`, `AB-`).
  - Required donor eligibility checkboxes (18–60 age, weight ≥ 45/50kg, feel well today, no fever/illness, cooldown passed 90d M / 120d F).
  - Location field with a "Pick on Map" button that navigates to **S9** (or triggers **D1** for GPS).
  - Preferred hospitals multi-select chip list (major Dhaka medical centers).
  - Saves via `becomeDonor(healthDetails)`; incomplete profiles are not matchable.
- **S9: Google Map Location Picker (`LocationPickerScreen`)**
  - Interactive map view of Dhaka with marker pin, area selector / search, and "Use Current Location" (triggers **D1**).
  - Confirming location passes selected area and coordinates back to **S8**.
- **S22: Update Required Screen (`UpdateRequiredScreen`)**
  - Shown when backend/config indicates app version is below `min_supported_app_version`. Blocks normal app use with a clear update prompt and link.

### Dialogues & Permissions (D1–D4)
- **D1: Location Access Dialog (`LocationPermissionDialog`)**
  - Rationale: to find nearby emergency blood requests in Dhaka without continuous background tracking. Options: [Allow Location Access] / [Not Now].
- **D2: Notification Access Dialog (`NotificationPermissionDialog`)**
  - Rationale: to receive urgent wave-based alerts when a matching patient needs blood nearby. Options: [Enable Notifications] / [Later].
- **D3: Storage Access Dialog (`StoragePermissionDialog`)**
  - Rationale: to upload medical requisition slips and hospital donor verification cards. Options: [Allow Access] / [Cancel].
- **D4: Delete Account Dialog (`DeleteAccountDialog`)**
  - Accessible from Profile / Settings.
  - Requires the user to explicitly type `"DELETE"` in uppercase to activate the confirmation button.
  - Explains irreversible anonymization of transaction records and immediate revocation of sessions and push tokens.

### Navigation Flow
1. **New User (Non-Donor)**: `S1 -> S2 -> S3 -> S4 -> S5 -> S6 -> App`
2. **New User (Donor Opt-In Checked)**: `S1 -> S2 -> S3 -> S4 -> S5 -> S6 -> S8 <-> S9 -> App`
3. **Forgot PIN**: `S6 -> S3 (without checkbox) -> S4 -> S5 (new pin) -> S6 -> App`
4. **Terms & Privacy**: `S3 (tap on terms and privacy policy) -> S7`
5. **Sign Out**: `App -> S6 (logout)`
6. **Outdated App Version**: `S1 -> S22 (halt / block)`


## Required tests
- Bangladesh phone validation/normalization; App Check; OTP rate limits, resend delay, expiry, attempt limit, single use, and test OTP disabled in production.
- New-account creation and unique phone constraint; PIN hashing, lockout, and reset rules.
- Donor opt-in checked opens donor health form after authentication; unchecked skips it and follows normal login flow. Donor details persist, incomplete profiles are not matchable, and returning donors are not repeatedly prompted.
- Same-device login; new-device OTP transfer; old-session/refresh-token revocation; wrong-device session rejection; concurrent transfer safety.
- Suspended/deleted account access denied; deletion revokes sessions/tokens and anonymizes references.
- Old app version receives `UPDATE_REQUIRED`; no secrets or full phone numbers in logs.
