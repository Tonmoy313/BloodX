# Graph Report - blood  (2026-10-20)

## Corpus Check
- 270 files · ~207,066 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 133 file(s) not represented in the graph (top: .bin 26, .lock 16, (none) 11)

## Summary
- 2585 nodes · 3214 edges · 184 communities (129 shown, 55 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 20 edges (avg confidence: 0.86)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `585ac377`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- _
- blood_strings.dart
- client.dart
- my_application_local_command_line
- GeneratedPluginRegistrant.swift
- protocol/protocol.dart
- blood_button.dart
- memory.md — Shared project memory (all AI models)
- serverpod_test_tools.dart
- blood_theme2.dart
- DateTime?
- phone_otp_idp.dart
- server.dart
- theme_controller.dart
- auth_controller.dart
- auth_state.dart
- onboarding_screen.dart
- otp_verification_screen.dart
- session_profile_guard.dart
- phone_input_screen.dart
- location_picker_screen.dart
- _
- app_session_startup.dart
- manifest.json
- app_language.dart
- core — shared definitions (read when a slice points here)
- sign_in_screen.dart
- STATE — single source of truth (keep small; edit only when something changes)
- session_profile_validator_test.dart
- ../../../core/localization/blood_strings.dart
- splash_screen.dart
- login_screen.dart
- _
- gh_bootstrap.sh
- MainActivity.kt
- blood_theme.dart
- blood_flutter
- bin/main.dart
- check.sh
- blood_client/CHANGELOG.md
- endpoint.md
- blood_client/README.md
- LaunchImage.imageset/README.md
- GeneratedPluginRegistrant.m
- widget_test.dart
- blood_server/CHANGELOG.md
- blood_server/README.md
- GeneratedPluginRegistrant.java
- FUTURE.md
- P0.md
- P1.md
- P2.md
- P3.md
- P4.md
- P5.md
- P6.md
- P7.md
- admin.md
- bloodX Auth — Implementation Spec
- closeout.md
- donor.md
- location.md
- ops.md
- pledge.md
- request.md
- safety.md
- README.md
- gh_protect_main.sh
- guard_sql.sh
- setup_hooks.sh
- test.sh
- @Deprecated
- String?
- permission_dialogs.dart
- blood_text_field.dart
- pin_setup_screen.dart
- State
- delete_account_dialog.dart
- package:serverpod/serverpod.dart
- auth_session_revocation_outbox.dart
- endpoints.dart
- _
- Win32Window
- file_selector_plugin
- windows/flutter/generated_plugin_registrant.cc
- AGENTS.md — BloodX
- my_application.cc
- app_routes.dart
- home_placeholder_screen.dart
- main
- utils.cpp
- string
- _
- flutter_window.h
- ios/RunnerTests/RunnerTests.swift
- Key Syntax Differences and Pitfalls
- _i1.EndpointRef
- _
- package:test/test.dart
- _
- _
- _
- _
- _
- blood_drop_logo.dart
- int?
- package:flutter/material.dart
- _
- protocol/user_status.dart
- protocol/flag_scope.dart
- protocol/platform.dart
- protocol/consent_type.dart
- protocol/language.dart
- protocol/otp_type.dart
- protocol/admin_role.dart
- @_i1
- Point
- Client
- auth_idp_endpoint.dart
- UserInclude
- _i1.IncludeList
- Building Dart CLI Applications
- EndpointAuthIdp
- User
- AppDelegate
- Application entities
- donor_prompt_endpoint.dart
- macos/RunnerTests/RunnerTests.swift
- _InternalTestEndpoints
- EndpointEmailIdp
- AppDelegate
- static const
- RegisterGeneratedPlugins
- serverpod_client.dart
- blood_colors.dart
- win32_window.cpp
- Compiling C Code into Code Assets with Native Assets Hooks
- MessageHandler
- MessageHandler
- EndpointJwtRefresh
- donor_health_details_screen.dart
- Size
- generated/protocol.dart
- 2. Recommended package:path Idioms vs. String Anti-Patterns
- Implementing Dart Patterns
- 2. Syntax Reference
- Generating FFI Bindings using package:ffigen
- dart_plugin_registrant.dart
- Implementing Dart and Flutter Test Coverage
- Writing Dart API Documentation
- web_plugin_registrant.dart
- cross_platform_paths.dart
- Resolving Dart Static Analysis Errors
- json_patterns.dart
- multi_command_runner.dart
- Testing and Mocking Dart Applications
- Testing Dart and Flutter Applications
- Managing Dart Dependencies
- generated/greetings/greeting.dart
- Analyzing and Fixing Dart Code
- Using Examples in Dartdoc
- single_command_tool.dart
- account_deletion_endpoint.dart
- flutter_lldb_helper.py
- dart_build_result.json
- gradlew
- package:blood_server/src/generated/protocol.dart
- @pragma
- PhoneOtpIdpConfig
- dart:io
- rules/graphify.md
- workflows/graphify.md
- PhoneOtpIdpGetter
- _i1.SerializableModel
- Flutter/flutter_export_environment.sh
- ephemeral/flutter_export_environment.sh
- commit-msg
- pre-commit
- pre-push
- c_users_user_documents_blood_blood_blood_flutter_ios_runner_generatedpluginregistrant_h
- file_selector_windows

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
10. `Win32Window` - 24 edges

## Surprising Connections (you probably didn't know these)
- `Task Progress` --references--> `main()`  [INFERRED]
  .agents/skills/dart-add-unit-test/SKILL.md → blood_flutter/linux/runner/main.cc
- `Git (trunk-based)` --references--> `main()`  [INFERRED]
  AGENTS.md → blood_flutter/linux/runner/main.cc
- `Avoid Destructive Exits (`exit(N)`)` --references--> `main()`  [INFERRED]
  .agents/skills/dart-build-cli-app/SKILL.md → blood_flutter/linux/runner/main.cc
- `main()` --calls--> `my_application_new()`  [INFERRED]
  blood_flutter/linux/runner/main.cc → blood_flutter/linux/runner/my_application.cc
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  blood_flutter/windows/runner/main.cpp → blood_flutter/windows/runner/utils.cpp

## Import Cycles
- None detected.

## Communities (184 total, 55 thin omitted)

### Community 0 - "_"
Cohesion: 0.04
Nodes (46): _, address, area, attachRow, bloodGroup, columns, count, createdAt (+38 more)

### Community 1 - "blood_strings.dart"
Cohesion: 0.01
Nodes (150): app_language.dart, addressFieldHint, addressFieldLabel, agree, agreed, allowAccess, alreadyHaveAccount, and (+142 more)

### Community 2 - "client.dart"
Cohesion: 0.05
Nodes (39): AuthSuccess, AuthUserModel, accountDeletion, auth, authIdp, claimDonorPrompt, deleteAccountAfterReview, deleteMyAccount (+31 more)

### Community 3 - "my_application_local_command_line"
Cohesion: 0.22
Nodes (9): fl_register_plugins(), my_application_activate(), my_application_local_command_line(), my_application_shutdown(), my_application_startup(), FlPluginRegistry, GApplication, gboolean (+1 more)

### Community 4 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.15
Nodes (12): connectivity_plus, desktop_webview_window, flutter_secure_storage_darwin, flutter_web_auth_2, Foundation, geolocator_apple, google_sign_in_ios, package_info_plus (+4 more)

### Community 5 - "protocol/protocol.dart"
Cohesion: 0.08
Nodes (25): AdminRole, deserializeByClassName, getClassNameForObject, getClassNameForType, getClassNameFromObjectJson, _instance, mapRecordToJson, Protocol (+17 more)

### Community 6 - "blood_button.dart"
Cohesion: 0.09
Nodes (23): backgroundColor, BloodButton, _BloodButtonState, BloodButtonStyle, borderRadius, build, createState, dispose (+15 more)

### Community 7 - "memory.md — Shared project memory (all AI models)"
Cohesion: 0.14
Nodes (14): 10. Session log (append only, newest at bottom), 1. Snapshot, 2. Owner context, 3. Decision log, 4. Facts and context (not decisions), 5. Current state, 6. Dependencies (record every package or service added), 7. Known gotchas (+6 more)

### Community 8 - "serverpod_test_tools.dart"
Cohesion: 0.04
Nodes (56): _AccountDeletionEndpoint, _AuthEndpoint, _AuthIdpEndpoint, accountDeletion, _AccountDeletionEndpoint, auth, _AuthEndpoint, authIdp (+48 more)

### Community 9 - "blood_theme2.dart"
Cohesion: 0.04
Nodes (49): AppTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight, containerSubtleDark (+41 more)

### Community 10 - "DateTime?"
Cohesion: 0.17
Nodes (11): author, copyWith, fromJson, _GreetingImpl, message, timestamp, toJson, toString (+3 more)

### Community 11 - "phone_otp_idp.dart"
Cohesion: 0.04
Nodes (44): Argon2HashUtil, AuthUsers, _authUsers, build, config, _consumeChallenge, _dummyPinHash, finishLogin (+36 more)

### Community 12 - "server.dart"
Cohesion: 0.05
Nodes (35): dir, fs, listSubdirectoryNames, main, pathContext, projectDir, subdirs, accountSid (+27 more)

### Community 13 - "theme_controller.dart"
Cohesion: 0.10
Nodes (19): AppLanguage, AppThemeController, BloodThemePreset, instance, isModern, _preset, setPreset, setThemeMode (+11 more)

### Community 14 - "auth_controller.dart"
Cohesion: 0.07
Nodes (26): AuthState get, completeProfile, _countdownTimer, deleteAccount, dispose, instance, loginWithPin, maskPhone (+18 more)

### Community 15 - "auth_state.dart"
Cohesion: 0.07
Nodes (26): appVersionSupported, area, AuthState, AuthStatus, bloodGroup, challengeId, copyWith, displayName (+18 more)

### Community 16 - "onboarding_screen.dart"
Cohesion: 0.11
Nodes (18): badgeColor, badgeText, build, createState, _currentPage, description, dispose, icon (+10 more)

### Community 17 - "otp_verification_screen.dart"
Cohesion: 0.13
Nodes (15): build, createState, dispose, _enteredCode, _errorMessage, _focusNodes, _handleResend, _handleVerify (+7 more)

### Community 18 - "session_profile_guard.dart"
Cohesion: 0.12
Nodes (16): auth_session_revocation_outbox.dart, _accountBlocked, _authSession, build, child, createState, _discardExpiredSession, _donorPromptDue (+8 more)

### Community 19 - "phone_input_screen.dart"
Cohesion: 0.11
Nodes (19): build, createState, dispose, _donorOptIn, _errorMessage, _handleSendOtp, initState, isForgotPin (+11 more)

### Community 20 - "location_picker_screen.dart"
Cohesion: 0.05
Nodes (37): failure, ForegroundLocationException, ForegroundLocationFailure, ForegroundLocationService, getPrecisePosition, openRelevantSettings, _BloodDropPainter, build (+29 more)

### Community 21 - "_"
Cohesion: 0.13
Nodes (14): _, _clearSafely, isBlocked, isDonor, _pendingValidation, restore, SessionProfileValidator, SessionRestorePolicy (+6 more)

### Community 22 - "app_session_startup.dart"
Cohesion: 0.11
Nodes (18): _cachedDonorStatusKey, _cachedUserIdKey, cacheProfile, clearProfileCache, _clearSavedAuthentication, _firstInstallKey, hasRestoredSession, initialize (+10 more)

### Community 23 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 24 - "app_language.dart"
Cohesion: 0.18
Nodes (10): instance, isBangla, _locale, _saveLocale, setLocale, toggleLanguage, Locale, Locale get (+2 more)

### Community 25 - "core — shared definitions (read when a slice points here)"
Cohesion: 0.20
Nodes (9): Config defaults (all tunable in config; **medical**/**legal** = confirm before launch; [G] = guess, tune from beta), core — shared definitions (read when a slice points here), Cross-cutting rules, Enums, Errors, Stack, State machines, Verify before relying [Likely] (+1 more)

### Community 26 - "sign_in_screen.dart"
Cohesion: 0.17
Nodes (11): _authSession, build, child, createState, dispose, initState, _isSignedIn, showSnackBar (+3 more)

### Community 27 - "STATE — single source of truth (keep small; edit only when something changes)"
Cohesion: 0.22
Nodes (8): DECIDED, Deps (one line each: name · why · task), Open questions, Product, PROPOSED, Spec map (read ONE per task), Staging verification gate, STATE — single source of truth (keep small; edit only when something changes)

### Community 28 - "session_profile_validator_test.dart"
Cohesion: 0.14
Nodes (13): SessionProfileSnapshot, async, _authHeader, _DelayedRefreshProvider, _isExpired, main, refreshAuthKey, refreshCalls (+5 more)

### Community 29 - "../../../core/localization/blood_strings.dart"
Cohesion: 0.14
Nodes (13): build, createState, DonorOptInDialog, _DonorOptInDialogState, initialValue, _optedIn, show, build (+5 more)

### Community 30 - "splash_screen.dart"
Cohesion: 0.15
Nodes (13): Animation, AnimationController, ../../auth/controllers/auth_controller.dart, build, _checkNavigation, createState, dispose, _fadeAnimation (+5 more)

### Community 31 - "login_screen.dart"
Cohesion: 0.12
Nodes (17): build, createState, dispose, donorOptInPending, _errorMessage, _handleForgotPin, _handleGoToSignUp, _handleLogin (+9 more)

### Community 32 - "_"
Cohesion: 0.04
Nodes (45): _, appCheckOkAt, appVersion, attachRow, columns, count, createdAt, db (+37 more)

### Community 33 - "gh_bootstrap.sh"
Cohesion: 1.00
Nodes (3): make_label(), run(), gh_bootstrap.sh script

### Community 35 - "blood_theme.dart"
Cohesion: 0.05
Nodes (38): blood_colors.dart, BloodTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight (+30 more)

### Community 43 - "GeneratedPluginRegistrant.m"
Cohesion: 0.12
Nodes (15): GeneratedPluginRegistrant, +registerWithRegistry, connectivityplusplugin, fluttersecurestoragedarwinplugin, flutterwebauth2plugin, fpppackageinfoplusplugin, geolocatorplugin, googlesigninplugin (+7 more)

### Community 47 - "GeneratedPluginRegistrant.java"
Cohesion: 0.32
Nodes (5): androidx.annotation.Keep, GeneratedPluginRegistrant, LOG — one row per session, ≤3 lines, append only, io.flutter.embedding.engine.FlutterEngine, nonnull

### Community 58 - "bloodX Auth — Implementation Spec"
Cohesion: 0.18
Nodes (10): bloodX Auth — Implementation Spec, Data model, Dialogues & Permissions (D1–D4), Endpoints, Navigation Flow, Required tests, Scope, Screens, dialogues & navigation (+2 more)

### Community 76 - "permission_dialogs.dart"
Cohesion: 0.10
Nodes (23): blood_button.dart, BloodTextField, _BasePermissionDialog, build, description, icon, iconColor, LocationPermissionDialog (+15 more)

### Community 77 - "blood_text_field.dart"
Cohesion: 0.10
Nodes (20): autofocus, build, controller, errorText, focusNode, hintText, inputFormatters, keyboardType (+12 more)

### Community 78 - "pin_setup_screen.dart"
Cohesion: 0.12
Nodes (16): build, _buildKeypadButton, _buildKeypadRow, createState, _currentInput, donorOptIn, _errorMessage, _firstPin (+8 more)

### Community 79 - "State"
Cohesion: 0.20
Nodes (14): SessionProfileGuard, _SessionProfileGuardState, DonorHealthDetailsScreen, _DonorHealthDetailsScreenState, LoginPinScreen, _LoginPinScreenState, _DoubleBackToExit, _DoubleBackToExitState (+6 more)

### Community 80 - "delete_account_dialog.dart"
Cohesion: 0.15
Nodes (13): build, _canDelete, createState, DeleteAccountDialog, _DeleteAccountDialogState, dispose, _handleDelete, initState (+5 more)

### Community 81 - "package:serverpod/serverpod.dart"
Cohesion: 0.12
Nodes (14): apiUrl, AppConfigRoute, AppConfigWidget, build, widget, build, RootRoute, BuiltWithServerpodPageWidget (+6 more)

### Community 82 - "auth_session_revocation_outbox.dart"
Cohesion: 0.11
Nodes (17): app_session_startup.dart, AuthSessionRevocationOutbox, clear, _enqueue, _isolatedSessionKey, _outboxKey, _pendingRetry, _removeQueued (+9 more)

### Community 83 - "endpoints.dart"
Cohesion: 0.12
Nodes (15): ../auth/account_deletion_endpoint.dart, ../auth/auth_endpoint.dart, ../auth/auth_idp_endpoint.dart, ../auth/email_idp_endpoint.dart, ../auth/jwt_refresh_endpoint.dart, Endpoints, initializeEndpoints, ../donor/donor_profile_endpoint.dart (+7 more)

### Community 84 - "_"
Cohesion: 0.05
Nodes (39): _, AdminUserAttachRowRepository, AdminUserRepository, attachRow, columns, count, createdAt, db (+31 more)

### Community 85 - "Win32Window"
Cohesion: 0.14
Nodes (20): RegisterPlugins(), FlutterWindow, flutter_controller_, OnCreate, OnDestroy, project_, DartProject, HWND (+12 more)

### Community 87 - "windows/flutter/generated_plugin_registrant.cc"
Cohesion: 0.14
Nodes (11): connectivity_plus_windows_plugin, desktop_webview_window_plugin, flutter_linux, flutter_secure_storage_linux_plugin, flutter_secure_storage_windows_plugin, geolocator_windows, permission_handler_windows_plugin, plugin_registry (+3 more)

### Community 88 - "AGENTS.md — BloodX"
Cohesion: 0.29
Nodes (6): AGENTS.md — BloodX, Graph (graphify, `graphify-out/`), Non-negotiables, Questions: ask in parallel, never wait, Read (this order; nothing else unless told), Token rules

### Community 89 - "my_application.cc"
Cohesion: 0.18
Nodes (13): first_frame_cb(), my_application_class_init(), my_application_dispose(), my_application_init(), my_application_new(), _MyApplication, dart_entrypoint_arguments, parent_instance (+5 more)

### Community 90 - "app_routes.dart"
Cohesion: 0.08
Nodes (23): AppRoutes, _arguments, donorHealthDetails, home, locationPicker, login, onboarding, otpVerification (+15 more)

### Community 91 - "home_placeholder_screen.dart"
Cohesion: 0.08
Nodes (24): AppSessionStartup, build, child, createState, _handleSignOut, _lastBackPress, _onBackInvoked, _showComingSoonSnackBar (+16 more)

### Community 92 - "main"
Cohesion: 0.25
Nodes (6): Git (trunk-based), 1. Core Architecture & Process Lifecycle, Avoid Destructive Exits (`exit(N)`), The Thin Entrypoint Pattern (`bin/` vs. `lib/src/`), main(), gtk

### Community 93 - "utils.cpp"
Cohesion: 0.18
Nodes (13): wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), flutter_windows, _In_ (+5 more)

### Community 94 - "string"
Cohesion: 0.17
Nodes (11): build, _callHello, createState, _errorMessage, GreetingsScreen, _GreetingsScreenState, ResultDisplay, _resultMessage (+3 more)

### Community 95 - "_"
Cohesion: 0.15
Nodes (13): AccountDeletionEndpoint, AuthEndpoint, _, DonorProfileEndpoint, DonorProfileValidation, isValid, requireLogin, saveMyProfile (+5 more)

### Community 96 - "flutter_window.h"
Cohesion: 0.39
Nodes (4): dart_project, flutter_view_controller, functional, windows

### Community 97 - "ios/RunnerTests/RunnerTests.swift"
Cohesion: 0.24
Nodes (6): SceneDelegate, RunnerTests, Flutter, FlutterSceneDelegate, UIKit, XCTest

### Community 98 - "Key Syntax Differences and Pitfalls"
Cohesion: 0.05
Nodes (37): 10. Dynamic Map / JSON Lookup Casting, 1. Collection Equality Pitfall (`equals` vs `deepEquals`), 1. Dependency Setup, 1. Simple Custom Expectations (using `expect`), 1. Specific Error Matchers, 2. Identify and Plan Target Files, 2. Nested Property Extraction (using `nest` or `has`), 2. The `anything` Matcher (+29 more)

### Community 99 - "_i1.EndpointRef"
Cohesion: 0.29
Nodes (7): EndpointAccountDeletion, EndpointAuth, EndpointDonorProfile, EndpointDonorPrompt, EndpointGreeting, EndpointProfile, _i1.EndpointRef

### Community 100 - "_"
Cohesion: 0.05
Nodes (42): _, attempts, codeHash, columns, consumedAt, count, createdAt, db (+34 more)

### Community 101 - "package:test/test.dart"
Cohesion: 0.12
Nodes (11): main, main, main, main, main, package:blood_server/src/auth/account_deletion_service.dart, package:blood_server/src/auth/phone_otp_idp.dart, package:blood_server/src/donor/donor_profile_endpoint.dart (+3 more)

### Community 102 - "_"
Cohesion: 0.05
Nodes (42): _, acceptedAt, appVersion, attachRow, columns, ConsentRecordAttachRowRepository, ConsentRecordRepository, count (+34 more)

### Community 103 - "_"
Cohesion: 0.05
Nodes (41): _, attachRow, columns, count, db, delete, deleteRow, deleteWhere (+33 more)

### Community 104 - "_"
Cohesion: 0.05
Nodes (40): _, attachRow, columns, ConfigAttachRowRepository, ConfigRepository, count, db, delete (+32 more)

### Community 105 - "_"
Cohesion: 0.04
Nodes (48): _, authUserId, boundInstallId, columns, count, createdAt, status, db (+40 more)

### Community 106 - "_"
Cohesion: 0.05
Nodes (42): _, action, actor, actorId, attachRow, AuditLogAttachRowRepository, AuditLogRepository, columns (+34 more)

### Community 107 - "blood_drop_logo.dart"
Cohesion: 0.12
Nodes (16): animated, BloodDropLogo, _BloodDropLogoState, build, _controller, createState, deepColor, dispose (+8 more)

### Community 108 - "int?"
Cohesion: 0.17
Nodes (21): AdminUserTable, AdminUserUpdateTable, AuditLogTable, AuditLogUpdateTable, ConfigTable, ConfigUpdateTable, ConsentRecordTable, ConsentRecordUpdateTable (+13 more)

### Community 109 - "package:flutter/material.dart"
Cohesion: 0.12
Nodes (16): main, main, main, main, Checkbox, CheckboxListTile, package:blood_flutter/core/localization/app_language.dart, package:blood_flutter/core/localization/blood_strings.dart (+8 more)

### Community 110 - "_"
Cohesion: 0.12
Nodes (17): _, AccountDeletionPolicy, anonymize, _authenticatedUserId, canAdminDelete, canSelfDelete, deleteCurrentUser, _deleteUser (+9 more)

### Community 111 - "protocol/user_status.dart"
Cohesion: 0.15
Nodes (11): active,
  suspended,, deleted, fromJson, toJson, toString, UserStatus, deleted, fromJson (+3 more)

### Community 112 - "protocol/flag_scope.dart"
Cohesion: 0.15
Nodes (11): all,
  android,, FlagScope, fromJson, ios, toJson, toString, FlagScope, fromJson (+3 more)

### Community 113 - "protocol/platform.dart"
Cohesion: 0.15
Nodes (11): android,, fromJson, ios, Platform, toJson, toString, fromJson, ios (+3 more)

### Community 114 - "protocol/consent_type.dart"
Cohesion: 0.15
Nodes (11): ConsentType, donorOptIn, fromJson, toJson, toString, ConsentType, donorOptIn, fromJson (+3 more)

### Community 115 - "protocol/language.dart"
Cohesion: 0.15
Nodes (11): en, fromJson, Language, toJson, toString, _bn, en, fromJson (+3 more)

### Community 116 - "protocol/otp_type.dart"
Cohesion: 0.15
Nodes (11): deviceTransfer, fromJson, OtpType, toJson, toString, deviceTransfer, fromJson, OtpType (+3 more)

### Community 117 - "protocol/admin_role.dart"
Cohesion: 0.15
Nodes (11): AdminRole, fromJson, superAdmin, toJson, toString, AdminRole, fromJson, superAdmin (+3 more)

### Community 118 - "@_i1"
Cohesion: 0.18
Nodes (11): @_i1, copyWith, copyWith, copyWith, copyWith, copyWith, copyWith, copyWith (+3 more)

### Community 119 - "Point"
Cohesion: 0.50
Nodes (3): Point, x, y

### Community 121 - "auth_idp_endpoint.dart"
Cohesion: 0.12
Nodes (18): @unauthenticatedClientCall, loginWithPin, phoneOtpIdp, setPin, AuthIdpEndpoint, finishLogin, hasAccount, phoneOtpIdp (+10 more)

### Community 122 - "UserInclude"
Cohesion: 0.20
Nodes (10): AdminUserInclude, AuditLogInclude, ConfigInclude, ConsentRecordInclude, DeviceInclude, DonorProfileInclude, FeatureFlagInclude, OtpChallengeInclude (+2 more)

### Community 123 - "_i1.IncludeList"
Cohesion: 0.20
Nodes (10): AdminUserIncludeList, AuditLogIncludeList, ConfigIncludeList, ConsentRecordIncludeList, DeviceIncludeList, DonorProfileIncludeList, FeatureFlagIncludeList, OtpChallengeIncludeList (+2 more)

### Community 124 - "Building Dart CLI Applications"
Cohesion: 0.06
Nodes (31): 1. The AOT SDK Discovery Trap, 2. The Solution: `package:cli_util` (`^0.6.0`), 3. Subprocess Spawning Invariants, Consequences of Naive Resolution:, Dart SDK Discovery and Subprocess Spawning in AOT & JIT, Potential Dart SDK Locations:, Why This Fails in Standalone AOT:, 1. Cross-Platform Signal Handling (+23 more)

### Community 126 - "User"
Cohesion: 0.15
Nodes (19): AdminUser, _AdminUserImpl, AuditLog, _AuditLogImpl, Config, _ConfigImpl, ConsentRecord, _ConsentRecordImpl (+11 more)

### Community 127 - "AppDelegate"
Cohesion: 0.25
Nodes (6): Any, AppDelegate, Bool, FlutterImplicitEngineBridge, FlutterImplicitEngineDelegate, UIApplication

### Community 128 - "Application entities"
Cohesion: 0.18
Nodes (10): Application entities, AuditLog, Config, ConsentRecord, Device, DonorProfile, FeatureFlag, OtpChallenge (+2 more)

### Community 129 - "donor_prompt_endpoint.dart"
Cohesion: 0.18
Nodes (9): claimDonorPrompt, requireLogin, _service, DonorPromptService, getMyProfile, ProfileEndpoint, requireLogin, bool get (+1 more)

### Community 130 - "macos/RunnerTests/RunnerTests.swift"
Cohesion: 0.32
Nodes (4): RunnerTests, Cocoa, FlutterMacOS, XCTestCase

### Community 131 - "_InternalTestEndpoints"
Cohesion: 0.67
Nodes (3): _InternalTestEndpoints, TestEndpoints, _i1.InternalTestEndpoints

### Community 133 - "AppDelegate"
Cohesion: 0.47
Nodes (4): AppDelegate, Bool, FlutterAppDelegate, NSApplication

### Community 134 - "static const"
Cohesion: 0.12
Nodes (14): DeviceIdentity, _generateUuidV4, getInstallId, _storage, _storageKey, _uuidPattern, claimPrompt, cooldown (+6 more)

### Community 135 - "RegisterGeneratedPlugins"
Cohesion: 0.40
Nodes (4): RegisterGeneratedPlugins(), MainFlutterWindow, FlutterPluginRegistry, NSWindow

### Community 136 - "serverpod_client.dart"
Cohesion: 0.29
Nodes (6): client, initializeClient, serverUrl, package:blood_client/blood_client.dart, package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart, package:serverpod_flutter/serverpod_flutter.dart

### Community 137 - "blood_colors.dart"
Cohesion: 0.06
Nodes (30): accent, backgroundDark, backgroundLight, BloodColors, darkCardGradient, error, glassGradient, info (+22 more)

### Community 138 - "win32_window.cpp"
Cohesion: 0.16
Nodes (15): wchar_t, Scale(), Create, Destroy, SetQuitOnClose, Show, UpdateTheme, Win32Window::Win32Window() (+7 more)

### Community 139 - "Compiling C Code into Code Assets with Native Assets Hooks"
Cohesion: 0.07
Nodes (28): 1. Defining Target Hashes (`lib/src/hook_helpers/hashes.dart`), 1. Local Execution Sandbox, 2. Hook Downloader Helper (`lib/src/hook_helpers/download.dart`), 2. Verify Target Outputs, 3. Implementing `hook/build.dart`, 3. Verify Tree-Shaking Stripping, 4. Verify Offline Compliance (User Defines), C Source and Bindings Setup (+20 more)

### Community 140 - "MessageHandler"
Cohesion: 0.18
Nodes (10): DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM, FlutterWindow::FlutterWindow(), MessageHandler (+2 more)

### Community 141 - "MessageHandler"
Cohesion: 0.36
Nodes (10): HWND, LPARAM, LRESULT, UINT, WPARAM, EnableFullDpiSupportIfAvailable(), GetHandle, GetThisFromHandle (+2 more)

### Community 143 - "donor_health_details_screen.dart"
Cohesion: 0.08
Nodes (25): _addressController, _allEligibilityPassed, _bloodGroups, build, _buildEligibilityTile, _checkAge, _checkCooldown, _checkHealth (+17 more)

### Community 144 - "Size"
Cohesion: 0.50
Nodes (3): Size, height, width

### Community 145 - "generated/protocol.dart"
Cohesion: 0.08
Nodes (23): admin_role.dart, admin_user.dart, audit_log.dart, deserializeByClassName, getClassNameForObject, getClassNameForType, getClassNameFromObjectJson, getModuleName (+15 more)

### Community 146 - "2. Recommended package:path Idioms vs. String Anti-Patterns"
Cohesion: 0.08
Nodes (23): 1. Core Principles & Cross-Platform Rules, 2. Recommended package:path Idioms vs. String Anti-Patterns, 3. Bridging Native Paths to POSIX, Git, & URL Contexts, 4. Mockable File Systems (`package:file` vs. Global `p.*`), 5. Extensions, Compound Extensions & Stem Extraction, 6. Workflows & Audit Checklist, Avoid Treating File Paths as Raw Strings, Contents (+15 more)

### Community 147 - "Implementing Dart Patterns"
Cohesion: 0.08
Nodes (23): 1. Prefer `is` Type Promotion over `if-case` for Single Promotable Variables, 2. Consolidate Nullable Types in Switch Arms, 3. Preserve Fast-Fail Validation (Do Not Silently Drop Data), 4. Avoid Single-Case or Boolean Switches, 5. Avoid Gratuitous Object Destructuring, 6. Avoid `if-case` for Standalone Scalar Comparisons, Algebraic Data Types (Sealed Classes), Contents (+15 more)

### Community 148 - "2. Syntax Reference"
Cohesion: 0.08
Nodes (23): 1. Overview, 2.1 Basic Class Header Syntax, 2.2 Declaring, Initializing, and Plain Parameters, 2.3 Constant Primary Constructors, 2.4 Extension Types, 2.5 Empty Body Semicolon Shorthand (`;`), 2.6 The In-Body Part of a Primary Constructor (`this ...`), 2.7 Abbreviated Concise Constructor Syntax (+15 more)

### Community 149 - "Generating FFI Bindings using package:ffigen"
Cohesion: 0.09
Nodes (21): 1. `FfiGenerator`, 2. `Headers`, 3. `Functions`, 4. `Output`, AFTER: Generating via FFIgen (The Correct Pattern), BEFORE: Manual FFI Binding (The Anti-Pattern), Concrete Example: Binding a C Library, Constraints (+13 more)

### Community 150 - "dart_plugin_registrant.dart"
Cohesion: 0.09
Nodes (21): package:connectivity_plus/connectivity_plus.dart, package:flutter_secure_storage_windows/flutter_secure_storage_windows.dart, package:flutter_web_auth_2/flutter_web_auth_2.dart, package:geolocator_android/geolocator_android.dart, package:geolocator_apple/geolocator_apple.dart, package:google_sign_in_android/google_sign_in_android.dart, package:google_sign_in_ios/google_sign_in_ios.dart, package:package_info_plus/package_info_plus.dart (+13 more)

### Community 151 - "Implementing Dart and Flutter Test Coverage"
Cohesion: 0.12
Nodes (15): 1. Add Dependencies, 1. Run Tests with VM Service, 2. Collect Coverage and Generate LCOV, 2. Collect Raw Coverage, 3. Feedback Loop: Validate Output, 3. Format to LCOV, Contents, Coverage Directives (+7 more)

### Community 152 - "Writing Dart API Documentation"
Cohesion: 0.13
Nodes (14): 1. Banned Tags vs. Prose, 1. Scope and Structure, 2. The Annotation Placement Trap, 2. Tone and Openers, 3. Openers and Tone, 3. Strict Anti-Patterns (Banned), 4. Constructor Linking, 4. Technical Placement & Resolution (+6 more)

### Community 153 - "web_plugin_registrant.dart"
Cohesion: 0.13
Nodes (14): registerPlugins, registrar, package:connectivity_plus/src/connectivity_plus_web.dart, package:flutter_secure_storage_web/flutter_secure_storage_web.dart, package:flutter_web_auth_2/src/web.dart, package:flutter_web_plugins/flutter_web_plugins.dart, package:geolocator_web/geolocator_web.dart, package:google_sign_in_web/google_sign_in_web.dart (+6 more)

### Community 154 - "cross_platform_paths.dart"
Cohesion: 0.14
Nodes (13): compoundExt, computeWebAssetKey, contains, ext, insertContentHash, isCanvasKitWasmAsset, main, nativeSamplePath (+5 more)

### Community 155 - "Resolving Dart Static Analysis Errors"
Cohesion: 0.15
Nodes (12): Contents, Core Concepts & Guidelines, Error Handling, Example: Fixing Dynamic List Assignments, Example: Fixing Method Overrides (Contravariance), Example: Fixing Null Safety with `late`, Examples, Null Safety (+4 more)

### Community 156 - "json_patterns.dart"
Cohesion: 0.18
Nodes (12): ApiResponse, code, data, error, ErrorResponse, main, message, parseApiResponse (+4 more)

### Community 157 - "multi_command_runner.dart"
Cohesion: 0.17
Nodes (11): description, main, name, ProcessCommand, run, runCommand, runner, ToolCommandRunner (+3 more)

### Community 158 - "Testing and Mocking Dart Applications"
Cohesion: 0.17
Nodes (11): Contents, Examples, Feedback Loop: Test Failures, Generating Mocks, High-Fidelity Mocking and Testing Example, Implementing Unit Tests, Managing Dependencies, Structuring Code for Testability (+3 more)

### Community 159 - "Testing Dart and Flutter Applications"
Cohesion: 0.18
Nodes (10): Contents, Examples, Executing Tests, Mocking with Mockito, Standard Unit Test Suite, Structuring Test Files, Task Progress, Test Implementation Workflow (+2 more)

### Community 160 - "Managing Dart Dependencies"
Cohesion: 0.18
Nodes (10): Contents, Core Concepts, Examples, Managing Dart Dependencies, Surgical Lockfile Removal, Tightening Constraints, Version Constraints, Workflow: Auditing Dependencies (+2 more)

### Community 161 - "generated/greetings/greeting.dart"
Cohesion: 0.20
Nodes (9): abstract class, author, copyWith, fromJson, message, timestamp, toJson, toJsonForProtocol (+1 more)

### Community 162 - "Analyzing and Fixing Dart Code"
Cohesion: 0.20
Nodes (9): Analysis Configuration, Analyzing and Fixing Dart Code, Comprehensive `analysis_options.yaml`, Contents, Diagnostic Suppression, Examples, Inline Diagnostic Suppression, Workflow: Applying Automated Fixes (+1 more)

### Community 163 - "Using Examples in Dartdoc"
Cohesion: 0.22
Nodes (8): 1. The `{@example}` Directive, 2. Using Regions, 3. Hiding Setup Code, 4. Marker Filtering Rules, 5. Placement and Path Resolution, 6. Verification, Contents, Using Examples in Dartdoc

### Community 164 - "single_command_tool.dart"
Cohesion: 0.25
Nodes (7): inputPath, main, parser, _runTool, package:args/args.dart, package:io/io.dart, package:stack_trace/stack_trace.dart

### Community 165 - "account_deletion_endpoint.dart"
Cohesion: 0.29
Nodes (6): account_deletion_service.dart, deleteAccountAfterReview, deleteMyAccount, requireLogin, _service, AccountDeletionService

### Community 166 - "flutter_lldb_helper.py"
Cohesion: 0.29
Nodes (6): handle_new_rx_page(), __lldb_init_module(), Intercept NOTIFY_DEBUGGER_ABOUT_RX_PAGES and touch the pages., lldb, SBDebugger, SBFrame

### Community 167 - "dart_build_result.json"
Cohesion: 0.33
Nodes (5): build_end, build_start, code_assets, data_assets, dependencies

### Community 168 - "gradlew"
Cohesion: 0.60
Nodes (3): gradlew script, die(), warn()

### Community 169 - "package:blood_server/src/generated/protocol.dart"
Cohesion: 0.50
Nodes (3): main, tables, package:blood_server/src/generated/protocol.dart

### Community 170 - "@pragma"
Cohesion: 0.67
Nodes (3): @pragma, _PluginRegistrant, register

### Community 171 - "PhoneOtpIdpConfig"
Cohesion: 0.67
Nodes (3): PhoneOtpIdp, PhoneOtpIdpConfig, IdentityProviderBuilder

## Knowledge Gaps
- **1628 isolated node(s):** `runner`, `name`, `description`, `main`, `runCommand` (+1623 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 1954 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **55 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_bn` connect `protocol/language.dart` to `blood_strings.dart`?**
  _High betweenness centrality (0.101) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `generated/greetings/greeting.dart`, `_`, `static const`, `_`, `package:blood_server/src/generated/protocol.dart`, `DateTime?`, `int?`, `otp_verification_screen.dart`, `package:serverpod/serverpod.dart`, `generated/protocol.dart`, `_`, `@_i1`, `string`, `UserInclude`, `_i1.IncludeList`, `json_patterns.dart`, `User`?**
  _High betweenness centrality (0.055) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `protocol/protocol.dart`, `static const`, `DateTime?`, `otp_verification_screen.dart`, `generated/protocol.dart`, `json_patterns.dart`, `package:blood_server/src/generated/protocol.dart`, `package:serverpod/serverpod.dart`, `endpoints.dart`, `_`, `string`, `_`, `_`, `_`, `int?`, `@_i1`, `UserInclude`, `_i1.IncludeList`, `User`?**
  _High betweenness centrality (0.043) - this node is a cross-community bridge._
- **What connects `runner`, `name`, `description` to the rest of the system?**
  _1628 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `_` be split into smaller, more focused modules?**
  _Cohesion score 0.044444444444444446 - nodes in this community are weakly interconnected._
- **Should `blood_strings.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.013245033112582781 - nodes in this community are weakly interconnected._
- **Should `client.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.05 - nodes in this community are weakly interconnected._