# Graph Report - blood  (2026-10-18)

## Corpus Check
- 174 files · ~130,962 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 46 file(s) not represented in the graph (top: .xcconfig 8, .plist 7, .xml 5)

## Summary
- 1864 nodes · 2413 edges · 130 communities (89 shown, 41 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 18 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `57a6c851`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- win32_window.cpp
- blood_strings.dart
- client.dart
- my_application.cc
- GeneratedPluginRegistrant.swift
- generated/protocol.dart
- blood_button.dart
- memory.md — Shared project memory (all AI models)
- serverpod_test_tools.dart
- blood_colors.dart
- protocol/greetings/greeting.dart
- donor_health_details_screen.dart
- server.dart
- blood_text_field.dart
- auth_controller.dart
- auth_state.dart
- onboarding_screen.dart
- otp_verification_screen.dart
- session_profile_guard.dart
- phone_input_screen.dart
- location_picker_screen.dart
- session_profile_validator_test.dart
- app_session_startup.dart
- manifest.json
- app_language.dart
- core — shared definitions (read when a slice points here)
- sign_in_screen.dart
- STATE — single source of truth (keep small; edit only when something changes)
- blood_theme2.dart
- home_placeholder_screen.dart
- StatelessWidget
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
- Runner-Bridging-Header.h
- widget_test.dart
- blood_server/CHANGELOG.md
- blood_server/README.md
- LOG.md
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
- protocol/protocol.dart
- pin_setup_screen.dart
- package:flutter/material.dart
- delete_account_dialog.dart
- package:serverpod/serverpod.dart
- auth_session_revocation_outbox.dart
- endpoints.dart
- _
- Win32Window
- linux/flutter/generated_plugin_registrant.cc
- windows/flutter/generated_plugin_registrant.cc
- AGENTS.md — BloodX
- _MyApplication
- app_routes.dart
- lib/main.dart
- main
- utils.cpp
- _
- MessageHandler
- flutter_window.h
- MessageHandler
- serverpod_client.dart
- State
- _
- Point
- _
- _
- _
- _
- _
- blood_drop_logo.dart
- int?
- theme_controller.dart
- _
- protocol/user_status.dart
- protocol/flag_scope.dart
- protocol/platform.dart
- protocol/consent_type.dart
- protocol/language.dart
- protocol/otp_type.dart
- protocol/admin_role.dart
- @_i1
- generated/greetings/greeting.dart
- package:blood_server/src/generated/protocol.dart
- package:serverpod_auth_idp_server/core.dart
- UserInclude
- _i1.IncludeList
- auth_controller_test.dart
- _i1.SerializableModel
- Application entities
- account_deletion_endpoint.dart
- _InternalTestEndpoints
- OtpChallenge

## God Nodes (most connected - your core abstractions)
1. `_` - 75 edges
2. `_` - 70 edges
3. `_` - 69 edges
4. `_` - 68 edges
5. `_` - 67 edges
6. `_` - 66 edges
7. `_` - 65 edges
8. `_` - 64 edges
9. `Win32Window` - 24 edges
10. `_` - 19 edges

## Surprising Connections (you probably didn't know these)
- `Git (trunk-based)` --references--> `main()`  [INFERRED]
  AGENTS.md → blood_flutter/linux/runner/main.cc
- `my_application_activate()` --calls--> `fl_register_plugins()`  [INFERRED]
  blood_flutter/linux/runner/my_application.cc → blood_flutter/linux/flutter/generated_plugin_registrant.cc
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  blood_flutter/windows/runner/flutter_window.h → blood_flutter/windows/flutter/generated_plugin_registrant.cc
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  blood_flutter/windows/runner/main.cpp → blood_flutter/windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  blood_flutter/windows/runner/win32_window.cpp → blood_flutter/windows/runner/win32_window.h

## Import Cycles
- None detected.

## Communities (130 total, 41 thin omitted)

### Community 0 - "win32_window.cpp"
Cohesion: 0.17
Nodes (14): wchar_t, Scale(), Create, Destroy, SetQuitOnClose, Show, Win32Window::Win32Window(), WindowClassRegistrar (+6 more)

### Community 1 - "blood_strings.dart"
Cohesion: 0.01
Nodes (136): app_language.dart, agree, agreed, allowAccess, alreadyHaveAccount, and, appName, areaLabel (+128 more)

### Community 2 - "client.dart"
Cohesion: 0.05
Nodes (40): AuthSuccess, AuthUserModel, accountDeletion, Client, deleteAccountAfterReview, deleteMyAccount, emailIdp, EndpointAccountDeletion (+32 more)

### Community 3 - "my_application.cc"
Cohesion: 0.19
Nodes (12): my_application_activate(), my_application_class_init(), my_application_dispose(), my_application_local_command_line(), my_application_shutdown(), my_application_startup(), GApplication, gboolean (+4 more)

### Community 4 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.05
Nodes (35): Any, AppDelegate, Bool, SceneDelegate, RunnerTests, RegisterGeneratedPlugins(), AppDelegate, Bool (+27 more)

### Community 5 - "generated/protocol.dart"
Cohesion: 0.08
Nodes (23): admin_user.dart, audit_log.dart, deserializeByClassName, getClassNameForObject, getClassNameForType, getClassNameFromObjectJson, getModuleName, getTableForType (+15 more)

### Community 6 - "blood_button.dart"
Cohesion: 0.10
Nodes (20): backgroundColor, BloodButtonStyle, borderRadius, build, createState, dispose, height, icon (+12 more)

### Community 7 - "memory.md — Shared project memory (all AI models)"
Cohesion: 0.14
Nodes (14): 10. Session log (append only, newest at bottom), 1. Snapshot, 2. Owner context, 3. Decision log, 4. Facts and context (not decisions), 5. Current state, 6. Dependencies (record every package or service added), 7. Known gotchas (+6 more)

### Community 8 - "serverpod_test_tools.dart"
Cohesion: 0.05
Nodes (38): _AccountDeletionEndpoint, accountDeletion, _AccountDeletionEndpoint, deleteAccountAfterReview, deleteMyAccount, emailIdp, _EmailIdpEndpoint, _endpointDispatch (+30 more)

### Community 9 - "blood_colors.dart"
Cohesion: 0.06
Nodes (30): accent, backgroundDark, backgroundLight, BloodColors, darkCardGradient, error, glassGradient, info (+22 more)

### Community 10 - "protocol/greetings/greeting.dart"
Cohesion: 0.17
Nodes (11): author, copyWith, fromJson, _GreetingImpl, message, timestamp, toJson, toString (+3 more)

### Community 11 - "donor_health_details_screen.dart"
Cohesion: 0.11
Nodes (18): _allEligibilityPassed, _bloodGroups, build, _buildEligibilityTile, _checkAge, _checkCooldown, _checkHealth, _checkMedication (+10 more)

### Community 12 - "server.dart"
Cohesion: 0.12
Nodes (15): appDir, pod, root, run, _sendPasswordResetCode, _sendRegistrationCode, start, EmailIdpEndpoint (+7 more)

### Community 13 - "blood_text_field.dart"
Cohesion: 0.10
Nodes (20): autofocus, build, controller, errorText, focusNode, hintText, inputFormatters, keyboardType (+12 more)

### Community 14 - "auth_controller.dart"
Cohesion: 0.07
Nodes (26): AuthState get, completeProfile, _countdownTimer, deleteAccount, dispose, hashPin, instance, loginWithPin (+18 more)

### Community 15 - "auth_state.dart"
Cohesion: 0.07
Nodes (26): appVersionSupported, area, AuthState, AuthStatus, bloodGroup, challengeId, copyWith, displayName (+18 more)

### Community 16 - "onboarding_screen.dart"
Cohesion: 0.12
Nodes (17): badgeColor, badgeText, build, createState, _currentPage, description, dispose, icon (+9 more)

### Community 17 - "otp_verification_screen.dart"
Cohesion: 0.12
Nodes (16): build, createState, dispose, _enteredCode, _errorMessage, _focusNodes, _handleResend, _handleVerify (+8 more)

### Community 18 - "session_profile_guard.dart"
Cohesion: 0.11
Nodes (17): app_session_startup.dart, auth_session_revocation_outbox.dart, _accountBlocked, build, child, createState, _discardExpiredSession, _getProfile (+9 more)

### Community 19 - "phone_input_screen.dart"
Cohesion: 0.11
Nodes (19): build, createState, dispose, _donorOptIn, _errorMessage, _handleSendOtp, initState, isForgotPin (+11 more)

### Community 20 - "location_picker_screen.dart"
Cohesion: 0.11
Nodes (18): build, createState, _dhakaAreas, dispose, _handleConfirm, _handleGpsLocation, initialArea, initState (+10 more)

### Community 21 - "session_profile_validator_test.dart"
Cohesion: 0.12
Nodes (14): SessionProfileSnapshot, async, _authHeader, _DelayedRefreshProvider, _isExpired, main, refreshAuthKey, refreshCalls (+6 more)

### Community 22 - "app_session_startup.dart"
Cohesion: 0.11
Nodes (18): _cachedDonorStatusKey, _cachedUserIdKey, cacheProfile, clearProfileCache, _clearSavedAuthentication, _firstInstallKey, hasRestoredSession, initialize (+10 more)

### Community 23 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 24 - "app_language.dart"
Cohesion: 0.17
Nodes (11): instance, isBangla, _locale, _saveLocale, setLocale, toggleLanguage, dart:async, Locale (+3 more)

### Community 25 - "core — shared definitions (read when a slice points here)"
Cohesion: 0.20
Nodes (9): Config defaults (all tunable in config; **medical**/**legal** = confirm before launch; [G] = guess, tune from beta), core — shared definitions (read when a slice points here), Cross-cutting rules, Enums, Errors, Stack, State machines, Verify before relying [Likely] (+1 more)

### Community 26 - "sign_in_screen.dart"
Cohesion: 0.18
Nodes (11): build, child, createState, dispose, initState, _isSignedIn, showSnackBar, SignInScreen (+3 more)

### Community 27 - "STATE — single source of truth (keep small; edit only when something changes)"
Cohesion: 0.25
Nodes (7): DECIDED, Deps (one line each: name · why · task), Open questions, Product, PROPOSED, Spec map (read ONE per task), STATE — single source of truth (keep small; edit only when something changes)

### Community 28 - "blood_theme2.dart"
Cohesion: 0.04
Nodes (49): AppTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight, containerSubtleDark (+41 more)

### Community 29 - "home_placeholder_screen.dart"
Cohesion: 0.09
Nodes (24): Animation, ../../auth/controllers/auth_controller.dart, build, child, createState, _handleSignOut, _lastBackPress, _onBackInvoked (+16 more)

### Community 30 - "StatelessWidget"
Cohesion: 0.22
Nodes (9): BloodTextField, _BasePermissionDialog, LocationPermissionDialog, NotificationPermissionDialog, StoragePermissionDialog, TermsPrivacyDialog, HomePlaceholderScreen, BloodApp (+1 more)

### Community 31 - "login_screen.dart"
Cohesion: 0.12
Nodes (18): build, createState, dispose, donorOptInPending, _errorMessage, _handleForgotPin, _handleGoToSignUp, _handleLogin (+10 more)

### Community 32 - "_"
Cohesion: 0.04
Nodes (47): _, appCheckOkAt, appVersion, attachRow, columns, count, createdAt, db (+39 more)

### Community 33 - "gh_bootstrap.sh"
Cohesion: 1.00
Nodes (3): make_label(), run(), gh_bootstrap.sh script

### Community 35 - "blood_theme.dart"
Cohesion: 0.05
Nodes (38): blood_colors.dart, BloodTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight (+30 more)

### Community 58 - "bloodX Auth — Implementation Spec"
Cohesion: 0.18
Nodes (10): bloodX Auth — Implementation Spec, Data model, Dialogues & Permissions (D1–D4), Endpoints, Navigation Flow, Required tests, Scope, Screens, dialogues & navigation (+2 more)

### Community 76 - "permission_dialogs.dart"
Cohesion: 0.13
Nodes (14): blood_button.dart, build, description, icon, iconColor, negativeLabel, onCancel, onConfirm (+6 more)

### Community 77 - "protocol/protocol.dart"
Cohesion: 0.08
Nodes (24): admin_role.dart, AdminRole, deserializeByClassName, getClassNameForObject, getClassNameForType, getClassNameFromObjectJson, _instance, mapRecordToJson (+16 more)

### Community 78 - "pin_setup_screen.dart"
Cohesion: 0.12
Nodes (16): build, _buildKeypadButton, _buildKeypadRow, createState, _currentInput, donorOptIn, _errorMessage, _firstPin (+8 more)

### Community 79 - "package:flutter/material.dart"
Cohesion: 0.12
Nodes (16): build, _callHello, createState, _errorMessage, GreetingsScreen, _GreetingsScreenState, ResultDisplay, _resultMessage (+8 more)

### Community 80 - "delete_account_dialog.dart"
Cohesion: 0.11
Nodes (18): build, _canDelete, createState, DeleteAccountDialog, _DeleteAccountDialogState, dispose, _handleDelete, initState (+10 more)

### Community 81 - "package:serverpod/serverpod.dart"
Cohesion: 0.12
Nodes (14): apiUrl, AppConfigRoute, AppConfigWidget, build, widget, build, RootRoute, BuiltWithServerpodPageWidget (+6 more)

### Community 82 - "auth_session_revocation_outbox.dart"
Cohesion: 0.11
Nodes (17): AuthSessionRevocationOutbox, clear, _enqueue, _isolatedSessionKey, _outboxKey, _pendingRetry, _removeQueued, retryPending (+9 more)

### Community 83 - "endpoints.dart"
Cohesion: 0.17
Nodes (11): ../auth/account_deletion_endpoint.dart, ../auth/email_idp_endpoint.dart, ../auth/jwt_refresh_endpoint.dart, Endpoints, initializeEndpoints, ../greetings/greeting_endpoint.dart, _i1.EndpointDispatch, package:serverpod_auth_core_server/serverpod_auth_core_server.dart (+3 more)

### Community 84 - "_"
Cohesion: 0.05
Nodes (43): _, AdminUser, AdminUserAttachRowRepository, _AdminUserImpl, AdminUserRepository, attachRow, columns, count (+35 more)

### Community 85 - "Win32Window"
Cohesion: 0.15
Nodes (19): FlutterWindow, flutter_controller_, OnCreate, OnDestroy, project_, DartProject, HWND, Win32Window (+11 more)

### Community 86 - "linux/flutter/generated_plugin_registrant.cc"
Cohesion: 0.22
Nodes (7): fl_register_plugins(), desktop_webview_window_plugin, FlPluginRegistry, flutter_linux, flutter_secure_storage_linux_plugin, url_launcher_plugin, window_to_front_plugin

### Community 87 - "windows/flutter/generated_plugin_registrant.cc"
Cohesion: 0.25
Nodes (6): RegisterPlugins(), connectivity_plus_windows_plugin, flutter_secure_storage_windows_plugin, plugin_registry, PluginRegistry, url_launcher_windows

### Community 88 - "AGENTS.md — BloodX"
Cohesion: 0.29
Nodes (6): AGENTS.md — BloodX, Graph (graphify, `graphify-out/`), Non-negotiables, Questions: ask in parallel, never wait, Read (this order; nothing else unless told), Token rules

### Community 89 - "_MyApplication"
Cohesion: 0.29
Nodes (7): first_frame_cb(), my_application_init(), _MyApplication, dart_entrypoint_arguments, parent_instance, FlView, GtkApplication

### Community 90 - "app_routes.dart"
Cohesion: 0.08
Nodes (23): AppRoutes, _arguments, donorHealthDetails, home, locationPicker, login, onboarding, otpVerification (+15 more)

### Community 91 - "lib/main.dart"
Cohesion: 0.14
Nodes (13): AppSessionStartup, build, false, isDark, main, setEnabledSystemUIMode, startup, _systemUiOverlayStyle (+5 more)

### Community 92 - "main"
Cohesion: 0.33
Nodes (4): Git (trunk-based), main(), my_application_new(), gtk

### Community 93 - "utils.cpp"
Cohesion: 0.18
Nodes (13): wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), flutter_windows, _In_ (+5 more)

### Community 94 - "_"
Cohesion: 0.13
Nodes (14): _, _clearSafely, isBlocked, isDonor, _pendingValidation, restore, SessionProfileValidator, SessionRestorePolicy (+6 more)

### Community 95 - "MessageHandler"
Cohesion: 0.18
Nodes (10): DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM, FlutterWindow::FlutterWindow(), MessageHandler (+2 more)

### Community 96 - "flutter_window.h"
Cohesion: 0.39
Nodes (4): dart_project, flutter_view_controller, functional, windows

### Community 97 - "MessageHandler"
Cohesion: 0.38
Nodes (10): HWND, LPARAM, LRESULT, UINT, WPARAM, EnableFullDpiSupportIfAvailable(), GetThisFromHandle, MessageHandler (+2 more)

### Community 98 - "serverpod_client.dart"
Cohesion: 0.29
Nodes (6): client, initializeClient, serverUrl, package:blood_client/blood_client.dart, package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart, package:serverpod_flutter/serverpod_flutter.dart

### Community 99 - "State"
Cohesion: 0.20
Nodes (15): SessionProfileGuard, _SessionProfileGuardState, BloodButton, _BloodButtonState, BloodDropLogo, _BloodDropLogoState, DonorHealthDetailsScreen, _DonorHealthDetailsScreenState (+7 more)

### Community 100 - "_"
Cohesion: 0.05
Nodes (41): _, attempts, codeHash, columns, consumedAt, count, createdAt, db (+33 more)

### Community 101 - "Point"
Cohesion: 0.21
Nodes (6): Point, x, y, Size, height, width

### Community 102 - "_"
Cohesion: 0.05
Nodes (44): _, acceptedAt, appVersion, attachRow, columns, ConsentRecord, ConsentRecordAttachRowRepository, _ConsentRecordImpl (+36 more)

### Community 103 - "_"
Cohesion: 0.05
Nodes (43): _, attachRow, columns, count, db, delete, deleteRow, deleteWhere (+35 more)

### Community 104 - "_"
Cohesion: 0.05
Nodes (42): _, attachRow, columns, Config, ConfigAttachRowRepository, _ConfigImpl, ConfigRepository, count (+34 more)

### Community 105 - "_"
Cohesion: 0.05
Nodes (44): _, authUserId, columns, count, createdAt, status, db, delete (+36 more)

### Community 106 - "_"
Cohesion: 0.05
Nodes (44): _, action, actor, actorId, attachRow, AuditLog, AuditLogAttachRowRepository, _AuditLogImpl (+36 more)

### Community 107 - "blood_drop_logo.dart"
Cohesion: 0.11
Nodes (18): AnimationController, animated, _BloodDropPainter, build, _controller, createState, deepColor, dispose (+10 more)

### Community 108 - "int?"
Cohesion: 0.19
Nodes (19): AdminUserTable, AdminUserUpdateTable, AuditLogTable, AuditLogUpdateTable, ConfigTable, ConfigUpdateTable, ConsentRecordTable, ConsentRecordUpdateTable (+11 more)

### Community 109 - "theme_controller.dart"
Cohesion: 0.10
Nodes (19): AppLanguage, AppThemeController, BloodThemePreset, instance, isModern, _preset, setPreset, setThemeMode (+11 more)

### Community 110 - "_"
Cohesion: 0.10
Nodes (19): _, AccountDeletionPolicy, anonymize, _authenticatedUserId, canAdminDelete, canSelfDelete, deleteCurrentUser, _deleteUser (+11 more)

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
Cohesion: 0.20
Nodes (10): @_i1, copyWith, copyWith, copyWith, copyWith, copyWith, copyWith, copyWith (+2 more)

### Community 119 - "generated/greetings/greeting.dart"
Cohesion: 0.20
Nodes (9): abstract class, author, copyWith, fromJson, message, timestamp, toJson, toJsonForProtocol (+1 more)

### Community 120 - "package:blood_server/src/generated/protocol.dart"
Cohesion: 0.20
Nodes (8): main, main, main, tables, package:blood_server/src/auth/account_deletion_service.dart, package:blood_server/src/generated/protocol.dart, package:test/test.dart, test_tools/serverpod_test_tools.dart

### Community 121 - "package:serverpod_auth_idp_server/core.dart"
Cohesion: 0.50
Nodes (3): JwtRefreshEndpoint, package:serverpod_auth_idp_server/core.dart, RefreshJwtTokensEndpoint

### Community 122 - "UserInclude"
Cohesion: 0.22
Nodes (9): AdminUserInclude, AuditLogInclude, ConfigInclude, ConsentRecordInclude, DeviceInclude, FeatureFlagInclude, OtpChallengeInclude, UserInclude (+1 more)

### Community 123 - "_i1.IncludeList"
Cohesion: 0.22
Nodes (9): AdminUserIncludeList, AuditLogIncludeList, ConfigIncludeList, ConsentRecordIncludeList, DeviceIncludeList, FeatureFlagIncludeList, OtpChallengeIncludeList, UserIncludeList (+1 more)

### Community 124 - "auth_controller_test.dart"
Cohesion: 0.33
Nodes (5): main, package:blood_flutter/core/localization/app_language.dart, package:blood_flutter/features/auth/controllers/auth_controller.dart, package:flutter_test/flutter_test.dart, package:shared_preferences/shared_preferences.dart

### Community 126 - "_i1.SerializableModel"
Cohesion: 0.50
Nodes (4): Greeting, Greeting, _i1.ProtocolSerialization, _i1.SerializableModel

### Community 128 - "Application entities"
Cohesion: 0.20
Nodes (9): Application entities, AuditLog, Config, ConsentRecord, Device, FeatureFlag, OtpChallenge, Serverpod mappings (+1 more)

### Community 129 - "account_deletion_endpoint.dart"
Cohesion: 0.14
Nodes (13): account_deletion_service.dart, AccountDeletionEndpoint, deleteAccountAfterReview, deleteMyAccount, requireLogin, _service, AccountDeletionService, GreetingEndpoint (+5 more)

### Community 131 - "_InternalTestEndpoints"
Cohesion: 0.67
Nodes (3): _InternalTestEndpoints, TestEndpoints, _i1.InternalTestEndpoints

## Knowledge Gaps
- **1179 isolated node(s):** `superAdmin`, `fromJson`, `toJson`, `toString`, `Modules` (+1174 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 1392 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **41 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_bn` connect `protocol/language.dart` to `blood_strings.dart`?**
  _High betweenness centrality (0.135) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `client.dart`, `_`, `generated/protocol.dart`, `_`, `_`, `_`, `protocol/greetings/greeting.dart`, `int?`, `protocol/protocol.dart`, `otp_verification_screen.dart`, `package:serverpod/serverpod.dart`, `auth_session_revocation_outbox.dart`, `_`, `@_i1`, `generated/greetings/greeting.dart`, `package:blood_server/src/generated/protocol.dart`, `UserInclude`, `_i1.IncludeList`?**
  _High betweenness centrality (0.088) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `client.dart`, `generated/protocol.dart`, `protocol/greetings/greeting.dart`, `otp_verification_screen.dart`, `protocol/protocol.dart`, `package:serverpod/serverpod.dart`, `auth_session_revocation_outbox.dart`, `endpoints.dart`, `_`, `_`, `_`, `_`, `_`, `_`, `int?`, `@_i1`, `package:blood_server/src/generated/protocol.dart`, `UserInclude`, `_i1.IncludeList`?**
  _High betweenness centrality (0.082) - this node is a cross-community bridge._
- **What connects `superAdmin`, `fromJson`, `toJson` to the rest of the system?**
  _1179 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `blood_strings.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.014598540145985401 - nodes in this community are weakly interconnected._
- **Should `client.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.05121951219512195 - nodes in this community are weakly interconnected._
- **Should `GeneratedPluginRegistrant.swift` be split into smaller, more focused modules?**
  _Cohesion score 0.04846938775510204 - nodes in this community are weakly interconnected._