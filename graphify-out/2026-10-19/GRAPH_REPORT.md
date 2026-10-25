# Graph Report - blood  (2026-10-19)

## Corpus Check
- 203 files · ~180,841 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 46 file(s) not represented in the graph (top: .xcconfig 8, .plist 7, .xml 5)

## Summary
- 2126 nodes · 2776 edges · 146 communities (103 shown, 43 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 18 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `585ac377`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- _
- blood_strings.dart
- client.dart
- my_application.cc
- GeneratedPluginRegistrant.swift
- generated/protocol.dart
- blood_button.dart
- memory.md — Shared project memory (all AI models)
- serverpod_test_tools.dart
- blood_colors.dart
- DateTime?
- donor_health_details_screen.dart
- server.dart
- theme_controller.dart
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
- Protocol
- pin_setup_screen.dart
- greetings_screen.dart
- delete_account_dialog.dart
- app_config_route.dart
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
- _
- string
- ios/RunnerTests/RunnerTests.swift
- package:blood_client/blood_client.dart
- State
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
- generated/greetings/greeting.dart
- package:blood_server/src/generated/protocol.dart
- jwt_refresh_endpoint.dart
- UserInclude
- _i1.IncludeList
- profile_setup_screen.dart
- _i1.SerializableModel
- User
- AppDelegate
- **\#\#\#\#\# GROUP A. IDENTITY AND ACCESS \#\#\#\#\#**
- account_deletion_endpoint.dart
- macos/RunnerTests/RunnerTests.swift
- _InternalTestEndpoints
- package:serverpod/serverpod.dart
- AppDelegate
- static const
- RegisterGeneratedPlugins
- blood_text_field.dart
- home_placeholder_screen.dart
- win32_window.cpp
- protocol/sex.dart
- MessageHandler
- MessageHandler
- ChangeNotifier
- Point
- Size
- Protocol

## God Nodes (most connected - your core abstractions)
1. `_` - 75 edges
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

## Communities (146 total, 43 thin omitted)

### Community 0 - "_"
Cohesion: 0.05
Nodes (44): _, address, area, attachRow, bloodGroup, columns, count, createdAt (+36 more)

### Community 1 - "blood_strings.dart"
Cohesion: 0.01
Nodes (168): app_language.dart, addressFieldHint, addressFieldLabel, agree, agreed, allowAccess, alreadyHaveAccount, and (+160 more)

### Community 2 - "client.dart"
Cohesion: 0.05
Nodes (47): AuthSuccess, AuthUserModel, accountDeletion, claimDonorPrompt, Client, deleteAccountAfterReview, deleteMyAccount, donorProfile (+39 more)

### Community 3 - "my_application.cc"
Cohesion: 0.19
Nodes (12): my_application_activate(), my_application_class_init(), my_application_dispose(), my_application_local_command_line(), my_application_shutdown(), my_application_startup(), GApplication, gboolean (+4 more)

### Community 4 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.14
Nodes (13): connectivity_plus, desktop_webview_window, file_selector_macos, flutter_secure_storage_darwin, flutter_web_auth_2, Foundation, geolocator_apple, google_sign_in_ios (+5 more)

### Community 5 - "generated/protocol.dart"
Cohesion: 0.06
Nodes (46): admin_role.dart, admin_user.dart, AdminRole, audit_log.dart, deserializeByClassName, getClassNameForObject, getClassNameForType, getClassNameFromObjectJson (+38 more)

### Community 6 - "blood_button.dart"
Cohesion: 0.10
Nodes (20): backgroundColor, BloodButtonStyle, borderRadius, build, createState, dispose, height, icon (+12 more)

### Community 7 - "memory.md — Shared project memory (all AI models)"
Cohesion: 0.14
Nodes (14): 10. Session log (append only, newest at bottom), 1. Snapshot, 2. Owner context, 3. Decision log, 4. Facts and context (not decisions), 5. Current state, 6. Dependencies (record every package or service added), 7. Known gotchas (+6 more)

### Community 8 - "serverpod_test_tools.dart"
Cohesion: 0.04
Nodes (46): _AccountDeletionEndpoint, accountDeletion, _AccountDeletionEndpoint, claimDonorPrompt, deleteAccountAfterReview, deleteMyAccount, donorProfile, _DonorProfileEndpoint (+38 more)

### Community 9 - "blood_colors.dart"
Cohesion: 0.06
Nodes (30): accent, backgroundDark, backgroundLight, BloodColors, darkCardGradient, error, glassGradient, info (+22 more)

### Community 10 - "DateTime?"
Cohesion: 0.20
Nodes (9): author, copyWith, fromJson, _GreetingImpl, message, timestamp, toJson, toString (+1 more)

### Community 11 - "donor_health_details_screen.dart"
Cohesion: 0.08
Nodes (25): _addressController, _allEligibilityPassed, _bloodGroups, build, _buildEligibilityTile, _checkAge, _checkCooldown, _checkHealth (+17 more)

### Community 12 - "server.dart"
Cohesion: 0.12
Nodes (15): appDir, pod, root, run, _sendPasswordResetCode, _sendRegistrationCode, start, EmailIdpEndpoint (+7 more)

### Community 13 - "theme_controller.dart"
Cohesion: 0.12
Nodes (15): BloodThemePreset, instance, isModern, _preset, setPreset, setThemeMode, _themeMode, togglePreset (+7 more)

### Community 14 - "auth_controller.dart"
Cohesion: 0.06
Nodes (32): AuthState get, _clearPinState, _countdownTimer, deleteAccount, dispose, _failedPinAttempts, hashPin, instance (+24 more)

### Community 15 - "auth_state.dart"
Cohesion: 0.06
Nodes (32): accountStatus, address, appUserId, appVersionSupported, area, AuthState, AuthStatus, authUserId (+24 more)

### Community 16 - "onboarding_screen.dart"
Cohesion: 0.10
Nodes (20): badgeColor, badgeText, build, createState, _currentPage, description, dispose, icon (+12 more)

### Community 17 - "otp_verification_screen.dart"
Cohesion: 0.13
Nodes (15): build, createState, dispose, _enteredCode, _errorMessage, _focusNodes, _handleResend, _handleVerify (+7 more)

### Community 18 - "session_profile_guard.dart"
Cohesion: 0.12
Nodes (16): app_session_startup.dart, auth_session_revocation_outbox.dart, _accountBlocked, build, child, createState, _discardExpiredSession, _getProfile (+8 more)

### Community 19 - "phone_input_screen.dart"
Cohesion: 0.11
Nodes (19): build, createState, dispose, _donorOptIn, _errorMessage, _handleSendOtp, initState, isForgotPin (+11 more)

### Community 20 - "location_picker_screen.dart"
Cohesion: 0.06
Nodes (36): failure, ForegroundLocationException, ForegroundLocationFailure, ForegroundLocationService, getPrecisePosition, openRelevantSettings, _BloodDropPainter, build (+28 more)

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
Cohesion: 0.22
Nodes (8): DECIDED, Deps (one line each: name · why · task), Open questions, Product, PROPOSED, Spec map (read ONE per task), Staging verification gate, STATE — single source of truth (keep small; edit only when something changes)

### Community 28 - "blood_theme2.dart"
Cohesion: 0.04
Nodes (49): AppTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight, containerSubtleDark (+41 more)

### Community 29 - "../../../core/localization/blood_strings.dart"
Cohesion: 0.15
Nodes (12): build, createState, DonorOptInDialog, _DonorOptInDialogState, initialValue, _optedIn, show, build (+4 more)

### Community 30 - "splash_screen.dart"
Cohesion: 0.17
Nodes (11): Animation, AnimationController, ../../auth/controllers/auth_controller.dart, build, _checkNavigation, createState, dispose, _fadeAnimation (+3 more)

### Community 31 - "login_screen.dart"
Cohesion: 0.12
Nodes (18): build, createState, dispose, _errorMessage, _handleForgotPin, _handleGoToSignUp, _handleLogin, initialPhone (+10 more)

### Community 32 - "_"
Cohesion: 0.04
Nodes (45): _, appCheckOkAt, appVersion, attachRow, columns, count, createdAt, db (+37 more)

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
Cohesion: 0.09
Nodes (24): blood_button.dart, BloodTextField, _BasePermissionDialog, build, description, icon, iconColor, LocationPermissionDialog (+16 more)

### Community 78 - "pin_setup_screen.dart"
Cohesion: 0.13
Nodes (15): build, _buildKeypadButton, _buildKeypadRow, createState, _currentInput, _errorMessage, _firstPin, _isConfirming (+7 more)

### Community 79 - "greetings_screen.dart"
Cohesion: 0.22
Nodes (9): build, _callHello, createState, _errorMessage, GreetingsScreen, _GreetingsScreenState, _resultMessage, _textEditingController (+1 more)

### Community 80 - "delete_account_dialog.dart"
Cohesion: 0.15
Nodes (13): build, _canDelete, createState, DeleteAccountDialog, _DeleteAccountDialogState, dispose, _handleDelete, initState (+5 more)

### Community 81 - "app_config_route.dart"
Cohesion: 0.20
Nodes (9): apiUrl, AppConfigRoute, AppConfigWidget, build, widget, RootRoute, JsonWidget, Uri get (+1 more)

### Community 82 - "auth_session_revocation_outbox.dart"
Cohesion: 0.11
Nodes (17): AuthSessionRevocationOutbox, clear, _enqueue, _isolatedSessionKey, _outboxKey, _pendingRetry, _removeQueued, retryPending (+9 more)

### Community 83 - "endpoints.dart"
Cohesion: 0.14
Nodes (13): ../auth/account_deletion_endpoint.dart, ../auth/email_idp_endpoint.dart, ../auth/jwt_refresh_endpoint.dart, Endpoints, initializeEndpoints, ../donor/donor_profile_endpoint.dart, ../donor/donor_prompt_endpoint.dart, ../greetings/greeting_endpoint.dart (+5 more)

### Community 84 - "_"
Cohesion: 0.05
Nodes (40): _, AdminUserAttachRowRepository, AdminUserRepository, attachRow, columns, count, createdAt, db (+32 more)

### Community 85 - "Win32Window"
Cohesion: 0.16
Nodes (18): FlutterWindow, flutter_controller_, OnCreate, OnDestroy, project_, DartProject, HWND, Win32Window (+10 more)

### Community 86 - "linux/flutter/generated_plugin_registrant.cc"
Cohesion: 0.20
Nodes (8): fl_register_plugins(), desktop_webview_window_plugin, file_selector_plugin, FlPluginRegistry, flutter_linux, flutter_secure_storage_linux_plugin, url_launcher_plugin, window_to_front_plugin

### Community 87 - "windows/flutter/generated_plugin_registrant.cc"
Cohesion: 0.18
Nodes (9): RegisterPlugins(), connectivity_plus_windows_plugin, file_selector_windows, flutter_secure_storage_windows_plugin, geolocator_windows, permission_handler_windows_plugin, plugin_registry, PluginRegistry (+1 more)

### Community 88 - "AGENTS.md — BloodX"
Cohesion: 0.29
Nodes (6): AGENTS.md — BloodX, Graph (graphify, `graphify-out/`), Non-negotiables, Questions: ask in parallel, never wait, Read (this order; nothing else unless told), Token rules

### Community 89 - "_MyApplication"
Cohesion: 0.29
Nodes (7): first_frame_cb(), my_application_init(), _MyApplication, dart_entrypoint_arguments, parent_instance, FlView, GtkApplication

### Community 90 - "app_routes.dart"
Cohesion: 0.08
Nodes (24): AppRoutes, _arguments, donorHealthDetails, home, locationPicker, login, onboarding, otpVerification (+16 more)

### Community 91 - "lib/main.dart"
Cohesion: 0.13
Nodes (14): AppSessionStartup, build, false, isDark, main, setEnabledSystemUIMode, startup, _systemUiOverlayStyle (+6 more)

### Community 92 - "main"
Cohesion: 0.33
Nodes (4): Git (trunk-based), main(), my_application_new(), gtk

### Community 93 - "utils.cpp"
Cohesion: 0.19
Nodes (12): wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), flutter_windows, _In_ (+4 more)

### Community 94 - "_"
Cohesion: 0.13
Nodes (14): _, _clearSafely, isBlocked, isDonor, _pendingValidation, restore, SessionProfileValidator, SessionRestorePolicy (+6 more)

### Community 95 - "_"
Cohesion: 0.14
Nodes (13): ConfigService, put, _sensitiveName, _, DonorProfileValidation, isValid, requireLogin, saveMyProfile (+5 more)

### Community 96 - "string"
Cohesion: 0.27
Nodes (6): dart_project, flutter_view_controller, functional, string, vector, windows

### Community 97 - "ios/RunnerTests/RunnerTests.swift"
Cohesion: 0.24
Nodes (6): SceneDelegate, RunnerTests, Flutter, FlutterSceneDelegate, UIKit, XCTest

### Community 98 - "package:blood_client/blood_client.dart"
Cohesion: 0.17
Nodes (10): client, initializeClient, serverUrl, main, package:blood_client/blood_client.dart, package:blood_flutter/core/localization/app_language.dart, package:blood_flutter/features/auth/controllers/auth_controller.dart, package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart (+2 more)

### Community 99 - "State"
Cohesion: 0.23
Nodes (13): SessionProfileGuard, _SessionProfileGuardState, BloodButton, _BloodButtonState, BloodDropLogo, _BloodDropLogoState, DonorHealthDetailsScreen, _DonorHealthDetailsScreenState (+5 more)

### Community 100 - "_"
Cohesion: 0.05
Nodes (42): _, attempts, codeHash, columns, consumedAt, count, createdAt, db (+34 more)

### Community 101 - "package:test/test.dart"
Cohesion: 0.15
Nodes (9): main, main, main, main, package:blood_server/src/auth/account_deletion_service.dart, package:blood_server/src/donor/donor_profile_endpoint.dart, package:blood_server/src/donor/donor_prompt_service.dart, package:test/test.dart (+1 more)

### Community 102 - "_"
Cohesion: 0.05
Nodes (42): _, acceptedAt, appVersion, attachRow, columns, ConsentRecordAttachRowRepository, ConsentRecordRepository, count (+34 more)

### Community 103 - "_"
Cohesion: 0.05
Nodes (41): _, attachRow, columns, count, db, delete, deleteRow, deleteWhere (+33 more)

### Community 104 - "_"
Cohesion: 0.05
Nodes (41): _, attachRow, columns, ConfigAttachRowRepository, ConfigRepository, count, db, delete (+33 more)

### Community 105 - "_"
Cohesion: 0.04
Nodes (46): _, authUserId, columns, count, createdAt, status, dateOfBirth, db (+38 more)

### Community 106 - "_"
Cohesion: 0.05
Nodes (42): _, action, actor, actorId, attachRow, AuditLogAttachRowRepository, AuditLogRepository, columns (+34 more)

### Community 107 - "blood_drop_logo.dart"
Cohesion: 0.13
Nodes (14): animated, build, _controller, createState, deepColor, dispose, _glowAnimation, initState (+6 more)

### Community 108 - "int?"
Cohesion: 0.17
Nodes (21): AdminUserTable, AdminUserUpdateTable, AuditLogTable, AuditLogUpdateTable, ConfigTable, ConfigUpdateTable, ConsentRecordTable, ConsentRecordUpdateTable (+13 more)

### Community 109 - "package:flutter/material.dart"
Cohesion: 0.15
Nodes (14): main, main, main, main, Checkbox, CheckboxListTile, package:blood_flutter/core/localization/blood_strings.dart, package:blood_flutter/core/widgets/permission_dialogs.dart (+6 more)

### Community 110 - "_"
Cohesion: 0.17
Nodes (12): _, AccountDeletionPolicy, anonymize, _authenticatedUserId, canAdminDelete, canSelfDelete, deleteCurrentUser, _deleteUser (+4 more)

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

### Community 119 - "generated/greetings/greeting.dart"
Cohesion: 0.18
Nodes (10): abstract class, author, copyWith, fromJson, _GreetingImpl, message, timestamp, toJson (+2 more)

### Community 120 - "package:blood_server/src/generated/protocol.dart"
Cohesion: 0.50
Nodes (3): main, tables, package:blood_server/src/generated/protocol.dart

### Community 121 - "jwt_refresh_endpoint.dart"
Cohesion: 0.17
Nodes (10): @unauthenticatedClientCall, _donorPromptService, JwtRefreshEndpoint, refreshAccessToken, DonorPromptService, getMyProfile, requireLogin, ../donor/donor_prompt_service.dart (+2 more)

### Community 122 - "UserInclude"
Cohesion: 0.20
Nodes (10): AdminUserInclude, AuditLogInclude, ConfigInclude, ConsentRecordInclude, DeviceInclude, DonorProfileInclude, FeatureFlagInclude, OtpChallengeInclude (+2 more)

### Community 123 - "_i1.IncludeList"
Cohesion: 0.20
Nodes (10): AdminUserIncludeList, AuditLogIncludeList, ConfigIncludeList, ConsentRecordIncludeList, DeviceIncludeList, DonorProfileIncludeList, FeatureFlagIncludeList, OtpChallengeIncludeList (+2 more)

### Community 124 - "profile_setup_screen.dart"
Cohesion: 0.10
Nodes (21): build, _chooseDateOfBirth, _chooseImage, _continue, createState, _dateOfBirth, dispose, _errorMessage (+13 more)

### Community 126 - "User"
Cohesion: 0.13
Nodes (21): AdminUser, _AdminUserImpl, AuditLog, _AuditLogImpl, Config, _ConfigImpl, ConsentRecord, _ConsentRecordImpl (+13 more)

### Community 127 - "AppDelegate"
Cohesion: 0.25
Nodes (6): Any, AppDelegate, Bool, FlutterImplicitEngineBridge, FlutterImplicitEngineDelegate, UIApplication

### Community 128 - "**\#\#\#\#\# GROUP A. IDENTITY AND ACCESS \#\#\#\#\#**"
Cohesion: 0.06
Nodes (34): **AdminUser:**, **Area:**, **AreaAdjacency:**, **AuditLog:**, **BadgeDefinition:**, **BloodRequest:**, **Config:**, **ConsentRecord:** (+26 more)

### Community 129 - "account_deletion_endpoint.dart"
Cohesion: 0.12
Nodes (16): account_deletion_service.dart, AccountDeletionEndpoint, deleteAccountAfterReview, deleteMyAccount, requireLogin, _service, AccountDeletionService, DonorProfileEndpoint (+8 more)

### Community 130 - "macos/RunnerTests/RunnerTests.swift"
Cohesion: 0.32
Nodes (4): RunnerTests, Cocoa, FlutterMacOS, XCTestCase

### Community 131 - "_InternalTestEndpoints"
Cohesion: 0.67
Nodes (3): _InternalTestEndpoints, TestEndpoints, _i1.InternalTestEndpoints

### Community 132 - "package:serverpod/serverpod.dart"
Cohesion: 0.29
Nodes (5): build, BuiltWithServerpodPageWidget, package:blood_server/src/web/widgets/built_with_serverpod_page.dart, package:serverpod/serverpod.dart, TemplateWidget

### Community 133 - "AppDelegate"
Cohesion: 0.47
Nodes (4): AppDelegate, Bool, FlutterAppDelegate, NSApplication

### Community 134 - "static const"
Cohesion: 0.33
Nodes (5): claimPrompt, cooldown, isCooldownComplete, scheduleAfterTokenRefresh, static const

### Community 135 - "RegisterGeneratedPlugins"
Cohesion: 0.40
Nodes (4): RegisterGeneratedPlugins(), MainFlutterWindow, FlutterPluginRegistry, NSWindow

### Community 136 - "blood_text_field.dart"
Cohesion: 0.10
Nodes (20): autofocus, build, controller, errorText, focusNode, hintText, inputFormatters, keyboardType (+12 more)

### Community 137 - "home_placeholder_screen.dart"
Cohesion: 0.12
Nodes (18): ../../auth/presentation/donor_opt_in_dialog.dart, build, child, createState, _displayDonorPrompt, _donorPromptHandled, _DoubleBackToExit, _DoubleBackToExitState (+10 more)

### Community 138 - "win32_window.cpp"
Cohesion: 0.17
Nodes (14): wchar_t, Scale(), Create, Destroy, SetQuitOnClose, Show, Win32Window::Win32Window(), WindowClassRegistrar (+6 more)

### Community 139 - "protocol/sex.dart"
Cohesion: 0.15
Nodes (11): female, fromJson, Sex, toJson, toString, female, fromJson, Sex (+3 more)

### Community 140 - "MessageHandler"
Cohesion: 0.18
Nodes (10): DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM, FlutterWindow::FlutterWindow(), MessageHandler (+2 more)

### Community 141 - "MessageHandler"
Cohesion: 0.33
Nodes (11): HWND, LPARAM, LRESULT, UINT, WPARAM, EnableFullDpiSupportIfAvailable(), GetHandle, GetThisFromHandle (+3 more)

### Community 142 - "ChangeNotifier"
Cohesion: 0.50
Nodes (4): AppLanguage, AppThemeController, AuthController, ChangeNotifier

### Community 143 - "Point"
Cohesion: 0.50
Nodes (3): Point, x, y

### Community 144 - "Size"
Cohesion: 0.50
Nodes (3): Size, height, width

## Knowledge Gaps
- **1368 isolated node(s):** `superAdmin`, `fromJson`, `toJson`, `toString`, `Modules` (+1363 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 1605 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **43 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_bn` connect `protocol/language.dart` to `blood_strings.dart`?**
  _High betweenness centrality (0.130) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `client.dart`, `package:serverpod/serverpod.dart`, `generated/protocol.dart`, `static const`, `DateTime?`, `otp_verification_screen.dart`, `endpoints.dart`, `_`, `string`, `_`, `_`, `_`, `_`, `_`, `int?`, `@_i1`, `package:blood_server/src/generated/protocol.dart`, `UserInclude`, `_i1.IncludeList`, `User`?**
  _High betweenness centrality (0.075) - this node is a cross-community bridge._
- **Why does `_` connect `_` to `string`, `client.dart`, `package:serverpod/serverpod.dart`, `_`, `_`, `static const`, `_`, `_`, `DateTime?`, `int?`, `otp_verification_screen.dart`, `_`, `@_i1`, `generated/greetings/greeting.dart`, `package:blood_server/src/generated/protocol.dart`, `UserInclude`, `_i1.IncludeList`, `User`?**
  _High betweenness centrality (0.063) - this node is a cross-community bridge._
- **What connects `superAdmin`, `fromJson`, `toJson` to the rest of the system?**
  _1368 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `_` be split into smaller, more focused modules?**
  _Cohesion score 0.045454545454545456 - nodes in this community are weakly interconnected._
- **Should `blood_strings.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.011834319526627219 - nodes in this community are weakly interconnected._
- **Should `client.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.04521276595744681 - nodes in this community are weakly interconnected._