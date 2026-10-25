# Graph Report - blood_server  (2026-10-21)

## Corpus Check
- 83 files · ~126,566 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 3 file(s) not represented in the graph (top: .Ly9AZGFydD0zLjg= 1, (none) 1, .css 1)

## Summary
- 838 nodes · 1159 edges · 45 communities (37 shown, 8 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `2c746e54`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- serverpod_test_tools.dart
- phone_otp_idp.dart
- _
- _
- _
- _
- _
- _
- _
- _
- _
- protocol.dart
- server.dart
- greeting.dart
- package:blood_server/src/generated/protocol.dart
- int?
- account_deletion_endpoint.dart
- _
- endpoints.dart
- auth_idp_endpoint.dart
- app_config_route.dart
- package:serverpod/serverpod.dart
- static const
- _i1.IncludeList
- _i1.IncludeObject
- user_status.dart
- platform.dart
- jwt_refresh_endpoint.dart
- admin_role.dart
- otp_type.dart
- language.dart
- consent_type.dart
- _
- package:serverpod_auth_idp_server/core.dart
- _i1.SerializableModel
- main.dart
- _InternalTestEndpoints
- PhoneOtpIdpConfig
- PhoneOtpIdpGetter
- CHANGELOG.md
- PhoneOtpDeliveryException
- Protocol
- Config
- User
- README.md

## God Nodes (most connected - your core abstractions)
1. `_` - 76 edges
2. `_` - 75 edges
3. `_` - 70 edges
4. `_` - 70 edges
5. `_` - 69 edges
6. `_` - 68 edges
7. `_` - 66 edges
8. `_` - 65 edges
9. `_` - 64 edges
10. `_` - 19 edges

## Surprising Connections (you probably didn't know these)
- `_` --references--> `AdminRole`  [EXTRACTED]
  lib/src/generated/admin_user.dart → lib/src/generated/admin_role.dart
- `_` --references--> `User`  [EXTRACTED]
  lib/src/generated/admin_user.dart → lib/src/generated/user.dart
- `_` --references--> `UserInclude`  [EXTRACTED]
  lib/src/generated/admin_user.dart → lib/src/generated/user.dart
- `_` --references--> `UserTable`  [EXTRACTED]
  lib/src/generated/admin_user.dart → lib/src/generated/user.dart
- `_` --references--> `User`  [EXTRACTED]
  lib/src/generated/audit_log.dart → lib/src/generated/user.dart

## Import Cycles
- None detected.

## Communities (45 total, 8 thin omitted)

### Community 0 - "serverpod_test_tools.dart"
Cohesion: 0.04
Nodes (56): _AccountDeletionEndpoint, _AuthEndpoint, _AuthIdpEndpoint, class _InternalTestEndpoints extends, _DonorProfileEndpoint, _DonorPromptEndpoint, _EmailIdpEndpoint, EndpointDispatch (+48 more)

### Community 1 - "phone_otp_idp.dart"
Cohesion: 0.04
Nodes (47): Argon2HashUtil, AuthUsers, dart:math, Duration, Future, _authUsers, build, config (+39 more)

### Community 2 - "_"
Cohesion: 0.04
Nodes (48): _, authUserId, boundInstallId, columns, count, createdAt, status, db (+40 more)

### Community 3 - "_"
Cohesion: 0.04
Nodes (47): ColumnDouble, _, address, area, attachRow, bloodGroup, columns, count (+39 more)

### Community 4 - "_"
Cohesion: 0.04
Nodes (47): _, appCheckOkAt, appVersion, attachRow, columns, count, createdAt, db (+39 more)

### Community 5 - "_"
Cohesion: 0.04
Nodes (46): ColumnString, _i1.ProtocolSerialization, _, action, actor, actorId, attachRow, AuditLog (+38 more)

### Community 6 - "_"
Cohesion: 0.05
Nodes (44): ColumnDateTime, ColumnEnum, ColumnUuid, _, attempts, codeHash, columns, consumedAt (+36 more)

### Community 7 - "_"
Cohesion: 0.05
Nodes (44): _, acceptedAt, appVersion, attachRow, columns, ConsentRecord, ConsentRecordAttachRowRepository, _ConsentRecordImpl (+36 more)

### Community 8 - "_"
Cohesion: 0.05
Nodes (43): ColumnBool, _i1.TableRow, _, AdminUser, AdminUserAttachRowRepository, _AdminUserImpl, AdminUserRepository, attachRow (+35 more)

### Community 9 - "_"
Cohesion: 0.05
Nodes (43): ColumnInt, _, attachRow, columns, count, db, delete, deleteRow (+35 more)

### Community 10 - "_"
Cohesion: 0.05
Nodes (41): ColumnSerializable, _, attachRow, columns, ConfigAttachRowRepository, ConfigRepository, count, db (+33 more)

### Community 11 - "protocol.dart"
Cohesion: 0.06
Nodes (30): admin_role.dart, admin_user.dart, audit_log.dart, config.dart, consent_record.dart, consent_type.dart, device.dart, donor_profile.dart (+22 more)

### Community 12 - "server.dart"
Cohesion: 0.07
Nodes (26): dart:async, dart:convert, EmailIdpBaseEndpoint, accountSid, appDir, authToken, fromNumber, httpClient (+18 more)

### Community 13 - "greeting.dart"
Cohesion: 0.09
Nodes (23): abstract class, @_i1, DateTime?, copyWith, copyWith, copyWith, copyWith, copyWith (+15 more)

### Community 14 - "package:blood_server/src/generated/protocol.dart"
Cohesion: 0.09
Nodes (16): dart:io, package:blood_server/src/auth/account_deletion_service.dart, package:blood_server/src/auth/phone_otp_idp.dart, package:blood_server/src/donor/donor_profile_endpoint.dart, package:blood_server/src/donor/donor_prompt_service.dart, package:blood_server/src/generated/protocol.dart, package:test/test.dart, main (+8 more)

### Community 15 - "int?"
Cohesion: 0.17
Nodes (21): _i1.Table, _i1.UpdateTable, int?, AdminUserTable, AdminUserUpdateTable, AuditLogTable, AuditLogUpdateTable, ConfigTable (+13 more)

### Community 16 - "account_deletion_endpoint.dart"
Cohesion: 0.12
Nodes (16): account_deletion_service.dart, bool get, donor_prompt_service.dart, Endpoint, AccountDeletionEndpoint, deleteAccountAfterReview, deleteMyAccount, requireLogin (+8 more)

### Community 17 - "_"
Cohesion: 0.12
Nodes (17): _, AccountDeletionPolicy, anonymize, _authenticatedUserId, canAdminDelete, canSelfDelete, deleteCurrentUser, _deleteUser (+9 more)

### Community 18 - "endpoints.dart"
Cohesion: 0.12
Nodes (15): ../auth/account_deletion_endpoint.dart, ../auth/auth_endpoint.dart, ../auth/auth_idp_endpoint.dart, ../auth/email_idp_endpoint.dart, ../auth/jwt_refresh_endpoint.dart, ../donor/donor_profile_endpoint.dart, ../donor/donor_prompt_endpoint.dart, ../greetings/greeting_endpoint.dart (+7 more)

### Community 19 - "auth_idp_endpoint.dart"
Cohesion: 0.18
Nodes (12): @unauthenticatedClientCall, IdpBaseEndpoint, loginWithPin, phoneOtpIdp, setPin, AuthIdpEndpoint, finishLogin, hasAccount (+4 more)

### Community 20 - "app_config_route.dart"
Cohesion: 0.15
Nodes (11): JsonWidget, apiUrl, AppConfigRoute, AppConfigWidget, build, widget, build, RootRoute (+3 more)

### Community 21 - "package:serverpod/serverpod.dart"
Cohesion: 0.20
Nodes (8): all,
  android,, fromJson, ios, toJson, toString, BuiltWithServerpodPageWidget, package:serverpod/serverpod.dart, TemplateWidget

### Community 22 - "static const"
Cohesion: 0.20
Nodes (8): ../generated/protocol.dart, claimPrompt, cooldown, isCooldownComplete, scheduleAfterTokenRefresh, GreetingEndpoint, hello, static const

### Community 23 - "_i1.IncludeList"
Cohesion: 0.20
Nodes (10): _i1.IncludeList, AdminUserIncludeList, AuditLogIncludeList, ConfigIncludeList, ConsentRecordIncludeList, DeviceIncludeList, DonorProfileIncludeList, FeatureFlagIncludeList (+2 more)

### Community 24 - "_i1.IncludeObject"
Cohesion: 0.20
Nodes (10): _i1.IncludeObject, AdminUserInclude, AuditLogInclude, ConfigInclude, ConsentRecordInclude, DeviceInclude, DonorProfileInclude, FeatureFlagInclude (+2 more)

### Community 25 - "user_status.dart"
Cohesion: 0.29
Nodes (6): active,
  suspended,, deleted, fromJson, toJson, toString, UserStatus

### Community 26 - "platform.dart"
Cohesion: 0.29
Nodes (6): android,, fromJson, ios, Platform, toJson, toString

### Community 27 - "jwt_refresh_endpoint.dart"
Cohesion: 0.29
Nodes (6): ../donor/donor_prompt_service.dart, _donorPromptService, JwtRefreshEndpoint, refreshAccessToken, DonorPromptService, RefreshJwtTokensEndpoint

### Community 28 - "admin_role.dart"
Cohesion: 0.29
Nodes (6): AdminRole, fromJson, superAdmin, toJson, toString, ops,
  medicalReviewer,

### Community 29 - "otp_type.dart"
Cohesion: 0.29
Nodes (6): deviceTransfer, fromJson, OtpType, toJson, toString, newAccount,
  forgetPin,

### Community 30 - "language.dart"
Cohesion: 0.33
Nodes (5): bn,, en, fromJson, toJson, toString

### Community 31 - "consent_type.dart"
Cohesion: 0.33
Nodes (5): donorOptIn, fromJson, toJson, toString, termsOfService,
  privacyPolicy,

### Community 32 - "_"
Cohesion: 0.40
Nodes (5): _, DonorProfileValidation, isValid, requireLogin, saveMyProfile

### Community 33 - "package:serverpod_auth_idp_server/core.dart"
Cohesion: 0.40
Nodes (4): getMyProfile, ProfileEndpoint, requireLogin, package:serverpod_auth_idp_server/core.dart

### Community 34 - "_i1.SerializableModel"
Cohesion: 0.50
Nodes (4): _i1.SerializableModel, ConsentType, FlagScope, Language

### Community 36 - "_InternalTestEndpoints"
Cohesion: 0.67
Nodes (3): _i1.InternalTestEndpoints, _InternalTestEndpoints, TestEndpoints

### Community 37 - "PhoneOtpIdpConfig"
Cohesion: 0.67
Nodes (3): IdentityProviderBuilder, PhoneOtpIdp, PhoneOtpIdpConfig

## Knowledge Gaps
- **556 isolated node(s):** `main`, `pod`, `runMode`, `root`, `appDir` (+551 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 641 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_` connect `_` to `_i1.SerializableModel`, `_`, `_`, `_`, `_`, `_`, `_`, `_`, `protocol.dart`, `User`, `greeting.dart`, `int?`, `endpoints.dart`, `package:serverpod/serverpod.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`, `user_status.dart`?**
  _High betweenness centrality (0.124) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `_`, `_`, `_`, `_`, `_`, `_`, `_`, `User`, `protocol.dart`, `greeting.dart`, `package:blood_server/src/generated/protocol.dart`, `int?`, `endpoints.dart`, `package:serverpod/serverpod.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`, `platform.dart`?**
  _High betweenness centrality (0.122) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `_`, `_`, `_`, `_`, `_`, `_`, `User`, `protocol.dart`, `greeting.dart`, `package:blood_server/src/generated/protocol.dart`, `int?`, `package:serverpod/serverpod.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`?**
  _High betweenness centrality (0.116) - this node is a cross-community bridge._
- **What connects `main`, `pod`, `runMode` to the rest of the system?**
  _556 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `serverpod_test_tools.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.03508771929824561 - nodes in this community are weakly interconnected._
- **Should `phone_otp_idp.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.041666666666666664 - nodes in this community are weakly interconnected._
- **Should `_` be split into smaller, more focused modules?**
  _Cohesion score 0.041666666666666664 - nodes in this community are weakly interconnected._