# Graph Report - blood_server  (2026-11-01)

## Corpus Check
- 65 files · ~91,637 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 6 file(s) not represented in the graph (top: (none) 3, .Ly9AZGFydD0zLjg= 1, .exe 1)

## Summary
- 1014 nodes · 1345 edges · 43 communities (37 shown, 6 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `0b8fd63b`
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
- hybrid_cloud_storage_test.dart
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
- package:blood_server/src/generated/protocol.dart
- static const
- _i1.IncludeList
- _i1.IncludeObject
- consent_type.dart
- ../generated/protocol.dart
- _
- _
- _
- main.dart
- _InternalTestEndpoints
- PhoneOtpIdpConfig
- PhoneOtpIdpGetter
- CHANGELOG.md
- PhoneOtpDeliveryException
- Protocol
- User
- package:serverpod/serverpod.dart
- README.md
- config_service.dart
- storage_sync_worker.dart
- email_idp_endpoint.dart

## God Nodes (most connected - your core abstractions)
1. `_` - 93 edges
2. `_` - 75 edges
3. `_` - 74 edges
4. `_` - 70 edges
5. `_` - 69 edges
6. `_` - 68 edges
7. `_` - 67 edges
8. `_` - 65 edges
9. `_` - 19 edges
10. `_` - 16 edges

## Surprising Connections (you probably didn't know these)
- `_` --references--> `User`  [EXTRACTED]
  lib/src/generated/audit_log.dart → lib/src/generated/user.dart
- `_` --references--> `UserInclude`  [EXTRACTED]
  lib/src/generated/audit_log.dart → lib/src/generated/user.dart
- `_` --references--> `UserTable`  [EXTRACTED]
  lib/src/generated/audit_log.dart → lib/src/generated/user.dart
- `_` --references--> `User`  [EXTRACTED]
  lib/src/generated/config.dart → lib/src/generated/user.dart
- `_` --references--> `UserInclude`  [EXTRACTED]
  lib/src/generated/config.dart → lib/src/generated/user.dart

## Import Cycles
- None detected.

## Communities (43 total, 6 thin omitted)

### Community 0 - "serverpod_test_tools.dart"
Cohesion: 0.03
Nodes (70): _AccountDeletionEndpoint, _AreaEndpoint, _AuthEndpoint, _AuthIdpEndpoint, class _InternalTestEndpoints extends, _DonorProfileEndpoint, _DonorPromptEndpoint, _EmailIdpEndpoint (+62 more)

### Community 1 - "phone_otp_idp.dart"
Cohesion: 0.04
Nodes (45): Argon2HashUtil, AuthUsers, Future, _authUsers, build, config, _consumeChallenge, _dummyPinHash (+37 more)

### Community 2 - "_"
Cohesion: 0.04
Nodes (49): Language, _, authUserId, boundInstallId, columns, count, createdAt, status (+41 more)

### Community 3 - "_"
Cohesion: 0.03
Nodes (64): availability_mode.dart, AvailabilityMode, blood_group.dart, blood_group_source.dart, BloodGroup, ColumnDouble, donor_status.dart, DonorStatus (+56 more)

### Community 4 - "_"
Cohesion: 0.04
Nodes (47): device_platform.dart, _, appCheckOkAt, appVersion, attachRow, columns, count, createdAt (+39 more)

### Community 5 - "_"
Cohesion: 0.05
Nodes (43): _, action, actor, actorId, attachRow, AuditLogAttachRowRepository, AuditLogRepository, columns (+35 more)

### Community 6 - "_"
Cohesion: 0.05
Nodes (44): ColumnInt, ColumnString, ColumnUuid, _, attempts, codeHash, columns, consumedAt (+36 more)

### Community 7 - "_"
Cohesion: 0.05
Nodes (43): ColumnDateTime, consent_type.dart, _, acceptedAt, appVersion, attachRow, columns, ConsentRecordAttachRowRepository (+35 more)

### Community 8 - "hybrid_cloud_storage_test.dart"
Cohesion: 0.05
Nodes (44): CloudStorage, dart:io, dart:typed_data, DatabaseCloudStorage, Directory, Directory get, cloud, deleteFile (+36 more)

### Community 9 - "_"
Cohesion: 0.05
Nodes (42): ColumnEnum, flag_scope.dart, _, attachRow, columns, count, db, delete (+34 more)

### Community 10 - "_"
Cohesion: 0.05
Nodes (43): ColumnBool, ColumnSerializable, _, attachRow, columns, ConfigAttachRowRepository, ConfigRepository, count (+35 more)

### Community 11 - "protocol.dart"
Cohesion: 0.03
Nodes (64): Area, area.dart, area_type.dart, AreaType, audit_log.dart, blood_component.dart, BloodComponent, BloodGroupSource (+56 more)

### Community 12 - "server.dart"
Cohesion: 0.04
Nodes (47): accountSid, appDir, authToken, cloudGenerated, cloudSlips, create, _createR2Storage, dotEnv (+39 more)

### Community 13 - "greeting.dart"
Cohesion: 0.09
Nodes (22): abstract class, @_i1, DateTime?, copyWith, copyWith, copyWith, copyWith, copyWith (+14 more)

### Community 14 - "r2_signed_url_service.dart"
Cohesion: 0.05
Nodes (42): _, freeTierCode, getOrCreateFreeTier, TierService, _authHeader, captureException, _dsn, _env (+34 more)

### Community 15 - "int?"
Cohesion: 0.19
Nodes (19): _i1.Table, _i1.UpdateTable, int?, AuditLogTable, AuditLogUpdateTable, ConfigTable, ConfigUpdateTable, ConsentRecordTable (+11 more)

### Community 16 - "account_deletion_endpoint.dart"
Cohesion: 0.12
Nodes (16): account_deletion_service.dart, bool get, Endpoint, AreaEndpoint, getAllLocations, getDistricts, getUpazilas, requireLogin (+8 more)

### Community 17 - "_"
Cohesion: 0.20
Nodes (10): _, AccountDeletionPolicy, anonymize, _authenticatedUserId, canSelfDelete, deleteCurrentUser, _deleteUser, deleteUserAfterAdminReview (+2 more)

### Community 18 - "endpoints.dart"
Cohesion: 0.11
Nodes (17): ../area/area_endpoint.dart, ../auth/account_deletion_endpoint.dart, ../auth/auth_endpoint.dart, ../auth/auth_idp_endpoint.dart, ../auth/email_idp_endpoint.dart, ../auth/jwt_refresh_endpoint.dart, ../config/aws_endpoint_config.dart, ../donor/donor_profile_endpoint.dart (+9 more)

### Community 19 - "auth_idp_endpoint.dart"
Cohesion: 0.11
Nodes (19): @unauthenticatedClientCall, ../donor/donor_prompt_service.dart, IdpBaseEndpoint, AuthEndpoint, loginWithPin, phoneOtpIdp, setPin, AuthIdpEndpoint (+11 more)

### Community 20 - "app_config_route.dart"
Cohesion: 0.15
Nodes (11): JsonWidget, apiUrl, AppConfigRoute, AppConfigWidget, build, widget, build, RootRoute (+3 more)

### Community 21 - "package:blood_server/src/generated/protocol.dart"
Cohesion: 0.10
Nodes (14): package:blood_server/src/auth/phone_otp_idp.dart, package:blood_server/src/donor/donor_profile_endpoint.dart, package:blood_server/src/donor/donor_prompt_service.dart, package:blood_server/src/generated/protocol.dart, package:blood_server/src/profile/profile_endpoint.dart, package:test/test.dart, main, test_tools/serverpod_test_tools.dart (+6 more)

### Community 22 - "static const"
Cohesion: 0.15
Nodes (11): donor_prompt_service.dart, claimDonorPrompt, DonorPromptEndpoint, requireLogin, _service, claimPrompt, cooldown, DonorPromptService (+3 more)

### Community 23 - "_i1.IncludeList"
Cohesion: 0.22
Nodes (9): _i1.IncludeList, AuditLogIncludeList, ConfigIncludeList, ConsentRecordIncludeList, DeviceIncludeList, DonorProfileIncludeList, FeatureFlagIncludeList, OtpChallengeIncludeList (+1 more)

### Community 24 - "_i1.IncludeObject"
Cohesion: 0.22
Nodes (9): _i1.IncludeObject, AuditLogInclude, ConfigInclude, ConsentRecordInclude, DeviceInclude, DonorProfileInclude, FeatureFlagInclude, OtpChallengeInclude (+1 more)

### Community 25 - "consent_type.dart"
Cohesion: 0.07
Nodes (25): active,
  suspended,, all,
  android,, _i1.SerializableModel, BackgroundTasks, ConsentType, fromJson, toJson, toString (+17 more)

### Community 26 - "../generated/protocol.dart"
Cohesion: 0.18
Nodes (10): ../auth/tier_service.dart, bangladesh_locations_data.dart, ../generated/protocol.dart, GreetingEndpoint, hello, _, DatabaseSeeder, seedAll (+2 more)

### Community 27 - "_"
Cohesion: 0.33
Nodes (6): _, BangladeshLocationsData, districts, districtUpazilas, static const List, static const Map

### Community 32 - "_"
Cohesion: 0.20
Nodes (10): _, _bloodGroupFromLabel, _dateOnlyUtc, DonorProfileValidation, isValid, isValidReadinessCheck, readinessOutcome, requireLogin (+2 more)

### Community 33 - "_"
Cohesion: 0.18
Nodes (11): dart:convert, dart:math, _, confirmMyProfileImage, createMyProfileImageUploadDescription, _findCurrentUser, getMyProfile, isOwnedImageKey (+3 more)

### Community 36 - "_InternalTestEndpoints"
Cohesion: 0.67
Nodes (3): _i1.InternalTestEndpoints, _InternalTestEndpoints, TestEndpoints

### Community 37 - "PhoneOtpIdpConfig"
Cohesion: 0.67
Nodes (3): IdentityProviderBuilder, PhoneOtpIdp, PhoneOtpIdpConfig

### Community 42 - "User"
Cohesion: 0.16
Nodes (18): _i1.ProtocolSerialization, _i1.TableRow, AuditLog, _AuditLogImpl, Config, _ConfigImpl, ConsentRecord, _ConsentRecordImpl (+10 more)

### Community 43 - "package:serverpod/serverpod.dart"
Cohesion: 0.22
Nodes (7): R2Endpoint, signedDownloadUrl, signedUploadUrl, BuiltWithServerpodPageWidget, package:serverpod/serverpod.dart, ../storage/r2_signed_url_service.dart, TemplateWidget

### Community 46 - "config_service.dart"
Cohesion: 0.33
Nodes (5): ConfigService, put, _sensitiveName, package:serverpod/protocol.dart, static final RegExp

### Community 48 - "storage_sync_worker.dart"
Cohesion: 0.10
Nodes (19): dart:async, Duration, hybrid_cloud_storage.dart, interval, _isSyncing, serverpod, start, stop (+11 more)

### Community 49 - "email_idp_endpoint.dart"
Cohesion: 0.50
Nodes (3): EmailIdpBaseEndpoint, EmailIdpEndpoint, package:serverpod_auth_idp_server/providers/email.dart

## Knowledge Gaps
- **646 isolated node(s):** `main`, `dotEnv`, `skipSentry`, `skipR2`, `pod` (+641 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 796 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **6 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_` connect `_` to `_`, `_`, `_`, `hybrid_cloud_storage_test.dart`, `_`, `_`, `User`, `package:serverpod/serverpod.dart`, `greeting.dart`, `r2_signed_url_service.dart`, `int?`, `storage_sync_worker.dart`, `endpoints.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`, `consent_type.dart`?**
  _High betweenness centrality (0.118) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `_`, `_`, `hybrid_cloud_storage_test.dart`, `_`, `User`, `package:serverpod/serverpod.dart`, `greeting.dart`, `r2_signed_url_service.dart`, `int?`, `storage_sync_worker.dart`, `package:blood_server/src/generated/protocol.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`?**
  _High betweenness centrality (0.115) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `_`, `_`, `_`, `hybrid_cloud_storage_test.dart`, `_`, `_`, `protocol.dart`, `User`, `greeting.dart`, `package:serverpod/serverpod.dart`, `int?`, `storage_sync_worker.dart`, `r2_signed_url_service.dart`, `package:blood_server/src/generated/protocol.dart`, `static const`, `_i1.IncludeList`, `_i1.IncludeObject`?**
  _High betweenness centrality (0.099) - this node is a cross-community bridge._
- **What connects `main`, `dotEnv`, `skipSentry` to the rest of the system?**
  _646 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `serverpod_test_tools.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.028169014084507043 - nodes in this community are weakly interconnected._
- **Should `phone_otp_idp.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.043478260869565216 - nodes in this community are weakly interconnected._
- **Should `_` be split into smaller, more focused modules?**
  _Cohesion score 0.04081632653061224 - nodes in this community are weakly interconnected._