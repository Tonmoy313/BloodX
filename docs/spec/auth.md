# bloodX Auth — Implementation Spec

## Scope
Phone-based authentication, one account per phone, one active device per account. Keep implementation minimal;

## Data model
- `User`: `id`, `phone` (unique, E.164), `name`, `pin_hash`, `language` (`bn|en`), `role` (`not_donor|donor`), `status` (`active|suspended|deleted`), `bound_device_id`, `created_at`, `last_seen_at`, `deleted_at`.
- `OtpChallenge`: `id`, `phone`, `code_hash`, `device_id`, `expires_at`, `attempts`, `created_at`, `consumed_at`, `type` (new_account|forget_pin|device_transfer).
- `AuthSession`: `id`, `user_id`, `device_id`, `refresh_token_hash`, `expires_at`, `revoked_at`, `created_at`, `last_seen_at`.
- `DeviceToken` (push notifications only): `user_id`, `platform`, `token` (unique), `last_seen_at`. Do not use push tokens as authentication or device identity.

Store PINs and refresh tokens as secure hashes; never store plaintext secrets.

## Endpoints
- `requestOtp(phone, deviceId)` — public; returns challenge and resend delay.
- `verifyOtp(challengeId, code, deviceId)` — public; validates OTP, creates account if new, or transfers an existing account to the verified new device; returns session and `isNewUser`.
- `login(phone, pin, deviceId)` — login only from the currently bound device. A different device must complete OTP verification first.
- `refreshSession(refreshToken, deviceId)` — rotate refresh token; reject revoked, expired, or device-mismatched sessions.
- `logout()` — revoke current session.
- `resetPin(phone, otp, newPin, deviceId)` — OTP-verified reset; reject suspended/deleted accounts.
- `deleteAccount(confirm)` — require the user to type `DELETE`; delete/anonymize account data as specified below.
- `registerDeviceToken(token, platform)` / `unregisterDeviceToken(token)` — push notifications only.
- `becomeDonor(healthDetails)` — set role to `donor` and save the donor health/profile details after the user completes the donor form. A donor is not eligible/matchable until required details are complete and validated.

## Security rules
- Bangladesh phone input: exactly 10 numeric digits; backend adds +880, stores E.164, rejects invalid numbers.
- Require Firebase App Check before OTP requests. Rate-limit by phone, device, and IP; keep limits in code/deployment settings, not a database config entity.
- OTP: 6 digits, hash at rest, 5-minute expiry, one use, max 5 attempts, enforced resend delay. Bind every challenge to phone, category, and device. Reject category/purpose mismatch. 000000 only in local/test builds; production uses a real SMS provider.
- PIN: exactly 5 numeric digits; hash at rest. 00000 test-only, rejected in production. Lock login for 15 minutes after 5 wrong PINs. Do not disclose whether a phone has an account.
- Device policy: one bound device per user. First successful OTP verification binds it. OTP verified as device_transfer on a new device atomically changes bound_device_id and revokes all old sessions/refresh tokens before issuing the new session. PIN alone cannot transfer a device.
- Use short-lived access tokens + rotating refresh tokens in platform secure storage (flutter_secure_storage); never Hive/SharedPreferences. Check session, device binding, and user status on protected requests. Verify behavior against the project's Serverpod auth/session implementation.
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
