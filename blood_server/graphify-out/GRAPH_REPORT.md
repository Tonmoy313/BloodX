# Graph Report - blood_server  (2026-10-24)

## Corpus Check
- 87 files · ~128,421 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 3 file(s) not represented in the graph (top: .Ly9AZGFydD0zLjg= 1, (none) 1, .css 1)

## Summary
- 900 nodes · 1234 edges · 52 communities (45 shown, 7 thin omitted)
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
- r2_signed_url_service.dart
- int?
- account_deletion_endpoint.dart
- _
- endpoints.dart
- auth_idp_endpoint.dart
- app_config_route.dart
- flag_scope.dart
- static const
- _i1.IncludeList
- _i1.IncludeObject
- user_status.dart
- platform.dart
- package:serverpod_auth_idp_server/core.dart
- admin_role.dart
- otp_type.dart
- language.dart
- consent_type.dart
- _
- sentry_service.dart
- _i1.SerializableModel
- main.dart
- _InternalTestEndpoints
- PhoneOtpIdpConfig
- PhoneOtpIdpGetter
- CHANGELOG.md
- PhoneOtpDeliveryException
- Protocol
- User
- Endpoint
- README.md
- donor_prompt_endpoint.dart
- config_service.dart
- root.dart
- dart:async
- email_idp_endpoint.dart
- package:serverpod/serverpod.dart
- FeatureFlag

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

## Communities (52 total, 7 thin omitted)

### Community 0 - "serverpod_test_tools.dart"
Cohesion: 0.03
Nodes (61): _AccountDeletionEndpoint, _AuthEndpoint, _AuthIdpEndpoint, class _InternalTestEndpoints extends, _DonorProfileEndpoint, _DonorPromptEndpoint, _EmailIdpEndpoint, EndpointDispatch (+53 more)

### Community 1 - "phone_otp_idp.dart"
Cohesion: 0.04
Nodes (45): Argon2HashUtil, AuthUsers, Duration, Future, _authUsers, build, config, _consumeChallenge (+37 more)

### Community 2 - "_"
Cohesion: 0.04
Nodes (48): _, authUserId, boundInstallId, columns, count, createdAt, status, db (+40 more)

### Community 3 - "_"
Cohesion: 0.04
Nodes (45): ColumnDouble, ColumnSerializable, _, address, area, attachRow, bloodGroup, columns (+37 more)

### Community 4 - "_"
Cohesion: 0.04
Nodes (45): _, appCheckOkAt, appVersion, attachRow, columns, count, createdAt, db (+37 more)

### Community 5 - "_"
Cohesion: 0.05
Nodes (42): _, action, actor, actorId, attachRow, AuditLogAttachRowRepository, AuditLogRepository, columns (+34 more)

### Community 6 - "_"
Cohesion: 0.05
Nodes (41): ColumnInt, ColumnUuid, _, attempts, codeHash, columns, consumedAt, count (+33 more)

### Community 7 - "_"
Cohesion: 0.05
Nodes (42): _, acceptedAt, appVersion, attachRow, columns, ConsentRecordAttachRowRepository, ConsentRecordRepository, count (+34 more)

### Community 8 - "_"
Cohesion: 0.05
Nodes (40): ColumnDateTime, _, AdminUserAttachRowRepository, AdminUserRepository, attachRow, columns, count, createdAt (+32 more)

### Community 9 - "_"
Cohesion: 0.05
Nodes (42): ColumnEnum, _, attachRow, columns, count, db, delete, deleteRow (+34 more)

### Community 10 - "_"
Cohesion: 0.05
Nodes (41): ColumnBool, ColumnString, _, attachRow, columns, ConfigAttachRowRepository, ConfigRepository, count (+33 more)

### Community 11 - "protocol.dart"
Cohesion: 0.06
Nodes (30): admin_role.dart, admin_user.dart, audit_log.dart, config.dart, consent_record.dart, consent_type.dart, device.dart, donor_profile.dart (+22 more)

### Community 12 - "server.dart"
Cohesion: 0.06
Nodes (30): accountSid, appDir, authToken, fromNumber, _generateOtp, httpClient, init, missing (+22 more)

### Community 13 - "greeting.dart"
Cohesion: 0.09
Nodes (23): abstract class, @_i1, DateTime?, copyWith, copyWith, copyWith, copyWith, copyWith (+15 more)

### Community 14 - "r2_signed_url_service.dart"
Cohesion: 0.05
Nodes (36): dart:io, _allowedStorageIds, defaultTtl, _keyPattern, maxTtl, missing, R2SignedUrlService, required (+28 more)

### Community 15 - "int?"
Cohesion: 0.17
Nodes (21): _i1.Table, _i1.UpdateTable, int?, AdminUserTable, AdminUserUpdateTable, AuditLogTable, AuditLogUpdateTable, ConfigTable (+13 more)

### Community 16 - "account_deletion_endpoint.dart"
Cohesion: 0.29
Nodes (6): account_deletion_service.dart, deleteAccountAfterReview, deleteMyAccount, requireLogin, _service, AccountDeletionService

### Community 17 - "_"
Cohesion: 0.17
Nodes (12): _, AccountDeletionPolicy, anonymize, _authenticatedUserId, canAdminDelete, canSelfDelete, deleteCurrentUser, _deleteUser (+4 more)

### Community 18 - "endpoints.dart"
Cohesion: 0.12
Nodes (16): ../auth/account_deletion_endpoint.dart, ../auth/auth_endpoint.dart, ../auth/auth_idp_endpoint.dart, ../auth/email_idp_endpoint.dart, ../auth/jwt_refresh_endpoint.dart, ../config/aws_endpoint_config.dart, ../donor/donor_profile_endpoint.dart, ../donor/donor_prompt_endpoint.dart (+8 more)

### Community 19 - "auth_idp_endpoint.dart"
Cohesion: 0.15
Nodes (14): @unauthenticatedClientCall, IdpBaseEndpoint, AuthEndpoint, loginWithPin, phoneOtpIdp, setPin, AuthIdpEndpoint, finishLogin (+6 more)

### Community 20 - "app_config_route.dart"
Cohesion: 0.29
Nodes (6): JsonWidget, apiUrl, AppConfigWidget, build, widget, Uri get

### Community 21 - "flag_scope.dart"
Cohesion: 0.33
Nodes (5): all,
  android,, fromJson, ios, toJson, toString

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

### Community 27 - "package:serverpod_auth_idp_server/core.dart"
Cohesion: 0.33
Nodes (5): ../donor/donor_prompt_service.dart, _donorPromptService, JwtRefreshEndpoint, package:serverpod_auth_idp_server/core.dart, RefreshJwtTokensEndpoint

### Community 28 - "admin_role.dart"
Cohesion: 0.33
Nodes (5): fromJson, superAdmin, toJson, toString, ops,
  medicalReviewer,

### Community 29 - "otp_type.dart"
Cohesion: 0.29
Nodes (6): deviceTransfer, fromJson, OtpType, toJson, toString, newAccount,
  forgetPin,

### Community 30 - "language.dart"
Cohesion: 0.29
Nodes (6): bn,, en, fromJson, Language, toJson, toString

### Community 31 - "consent_type.dart"
Cohesion: 0.33
Nodes (5): donorOptIn, fromJson, toJson, toString, termsOfService,
  privacyPolicy,

### Community 32 - "_"
Cohesion: 0.20
Nodes (9): bool get, _, DonorProfileValidation, isValid, requireLogin, saveMyProfile, getMyProfile, ProfileEndpoint (+1 more)

### Community 33 - "sentry_service.dart"
Cohesion: 0.10
Nodes (20): dart:convert, dart:math, _authHeader, captureException, _dsn, _env, _envelopeUri, _generateEventId (+12 more)

### Community 34 - "_i1.SerializableModel"
Cohesion: 0.50
Nodes (4): _i1.SerializableModel, AdminRole, ConsentType, FlagScope

### Community 36 - "_InternalTestEndpoints"
Cohesion: 0.67
Nodes (3): _i1.InternalTestEndpoints, _InternalTestEndpoints, TestEndpoints

### Community 37 - "PhoneOtpIdpConfig"
Cohesion: 0.67
Nodes (3): IdentityProviderBuilder, PhoneOtpIdp, PhoneOtpIdpConfig

### Community 42 - "User"
Cohesion: 0.16
Nodes (18): _i1.ProtocolSerialization, _i1.TableRow, AdminUser, _AdminUserImpl, AuditLog, _AuditLogImpl, Config, _ConfigImpl (+10 more)

### Community 43 - "Endpoint"
Cohesion: 0.22
Nodes (8): Endpoint, AccountDeletionEndpoint, R2Endpoint, signedDownloadUrl, signedUploadUrl, DonorProfileEndpoint, DonorPromptEndpoint, ../storage/r2_signed_url_service.dart

### Community 45 - "donor_prompt_endpoint.dart"
Cohesion: 0.33
Nodes (5): donor_prompt_service.dart, claimDonorPrompt, requireLogin, _service, DonorPromptService

### Community 46 - "config_service.dart"
Cohesion: 0.33
Nodes (5): ConfigService, put, _sensitiveName, package:serverpod/protocol.dart, static final RegExp

### Community 47 - "root.dart"
Cohesion: 0.33
Nodes (5): AppConfigRoute, build, RootRoute, package:blood_server/src/web/widgets/built_with_serverpod_page.dart, WidgetRoute

### Community 48 - "dart:async"
Cohesion: 0.40
Nodes (4): dart:async, handleCall, HealthRoute, Route

### Community 49 - "email_idp_endpoint.dart"
Cohesion: 0.50
Nodes (3): EmailIdpBaseEndpoint, EmailIdpEndpoint, package:serverpod_auth_idp_server/providers/email.dart

### Community 50 - "package:serverpod/serverpod.dart"
Cohesion: 0.50
Nodes (3): BuiltWithServerpodPageWidget, package:serverpod/serverpod.dart, TemplateWidget

## Knowledge Gaps
- **601 isolated node(s):** `main`, `pod`, `useDevelopmentOtp`, `runMode`, `root` (+596 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 693 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **7 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_` connect `_` to `sentry_service.dart`, `_`, `_`, `_`, `_`, `_`, `_`, `protocol.dart`, `User`, `greeting.dart`, `int?`, `package:serverpod/serverpod.dart`, `endpoints.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`, `user_status.dart`, `language.dart`?**
  _High betweenness centrality (0.116) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `sentry_service.dart`, `_`, `_`, `_`, `_`, `_`, `_`, `User`, `protocol.dart`, `greeting.dart`, `r2_signed_url_service.dart`, `int?`, `package:serverpod/serverpod.dart`, `endpoints.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`, `platform.dart`?**
  _High betweenness centrality (0.114) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `sentry_service.dart`, `_`, `_`, `_`, `_`, `_`, `User`, `protocol.dart`, `greeting.dart`, `r2_signed_url_service.dart`, `int?`, `package:serverpod/serverpod.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`?**
  _High betweenness centrality (0.108) - this node is a cross-community bridge._
- **What connects `main`, `pod`, `useDevelopmentOtp` to the rest of the system?**
  _601 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `serverpod_test_tools.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.03225806451612903 - nodes in this community are weakly interconnected._
- **Should `phone_otp_idp.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.043478260869565216 - nodes in this community are weakly interconnected._
- **Should `_` be split into smaller, more focused modules?**
  _Cohesion score 0.041666666666666664 - nodes in this community are weakly interconnected._