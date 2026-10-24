# Graph Report - blood_flutter  (2026-10-24)

## Corpus Check
- 90 files · ~38,713 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 113 file(s) not represented in the graph (top: .bin 26, .lock 15, .properties 10)

## Summary
- 1166 nodes · 1463 edges · 64 communities (53 shown, 11 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 17 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `db3d71f8`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- blood_strings.dart
- Win32Window
- blood_theme2.dart
- home_placeholder_screen.dart
- blood_text_field.dart
- my_application.cc
- auth_state.dart
- blood_theme.dart
- location_picker_screen.dart
- blood_colors.dart
- session_profile_validator_test.dart
- donor_health_details_screen.dart
- auth_controller.dart
- utils.cpp
- blood_button.dart
- app_routes.dart
- session_profile_guard.dart
- auth_session_revocation_outbox.dart
- app_session_startup.dart
- login_screen.dart
- State
- phone_input_screen.dart
- blood_drop_logo.dart
- onboarding_screen.dart
- theme_controller.dart
- pin_setup_screen.dart
- splash_screen.dart
- GeneratedPluginRegistrant.swift
- app_sentry_service.dart
- ../../../core/localization/blood_strings.dart
- delete_account_dialog.dart
- manifest.json
- ios/RunnerTests/RunnerTests.swift
- AppDelegate
- serverpod_client.dart
- FlutterMacOS
- AppDelegate
- package:flutter/material.dart
- phone_input_screen_test.dart
- RegisterGeneratedPlugins
- MainActivity.kt
- blood_flutter
- GeneratedPluginRegistrant.m
- LaunchImage.imageset/README.md
- widget_test.dart
- String?
- dart_plugin_registrant.dart
- otp_verification_screen.dart
- web_plugin_registrant.dart
- sign_in_screen.dart
- _
- device_identity.dart
- string
- GeneratedPluginRegistrant.java
- flutter_lldb_helper.py
- dart_build_result.json
- gradlew
- _BloodButtonState
- Flutter/flutter_export_environment.sh
- ephemeral/flutter_export_environment.sh
- c_users_user_documents_blood_blood_blood_flutter_ios_runner_generatedpluginregistrant_h

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 24 edges
2. `_` - 19 edges
3. `MessageHandler` - 12 edges
4. `FlutterWindow` - 10 edges
5. `Create` - 10 edges
6. `WndProc` - 10 edges
7. `MessageHandler` - 9 edges
8. `_MyApplication` - 7 edges
9. `OnCreate` - 7 edges
10. `WindowClassRegistrar` - 7 edges

## Surprising Connections (you probably didn't know these)
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  windows/runner/flutter_window.h → windows/flutter/generated_plugin_registrant.cc
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  windows/runner/main.cpp → windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  windows/runner/win32_window.cpp → windows/runner/win32_window.h
- `my_application_activate()` --calls--> `fl_register_plugins()`  [INFERRED]
  linux/runner/my_application.cc → linux/flutter/generated_plugin_registrant.cc
- `main()` --calls--> `my_application_new()`  [INFERRED]
  linux/runner/main.cc → linux/runner/my_application.cc

## Import Cycles
- None detected.

## Communities (64 total, 11 thin omitted)

### Community 0 - "blood_strings.dart"
Cohesion: 0.01
Nodes (151): app_language.dart, addressFieldHint, addressFieldLabel, agree, agreed, allowAccess, alreadyHaveAccount, and (+143 more)

### Community 1 - "Win32Window"
Cohesion: 0.05
Nodes (59): dwmapi, FlutterViewController, generated_plugin_registrant, optional, RECT, unique_ptr, DartProject, HWND (+51 more)

### Community 2 - "blood_theme2.dart"
Cohesion: 0.04
Nodes (49): AppTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight, containerSubtleDark (+41 more)

### Community 3 - "home_placeholder_screen.dart"
Cohesion: 0.07
Nodes (27): core/localization/app_language.dart, core/session/app_session_startup.dart, ../../../core/session/auth_session_revocation_outbox.dart, ../../../core/session/session_profile_guard.dart, core/theme/theme_controller.dart, DateTime?, features/splash/presentation/splash_screen.dart, features/splash/presentation/update_required_screen.dart (+19 more)

### Community 4 - "blood_text_field.dart"
Cohesion: 0.05
Nodes (44): blood_button.dart, IconData, int?, autofocus, BloodTextField, build, controller, errorText (+36 more)

### Community 5 - "my_application.cc"
Cohesion: 0.05
Nodes (38): connectivity_plus_windows_plugin, desktop_webview_window_plugin, FlPluginRegistry, flutter_linux, flutter_secure_storage_linux_plugin, flutter_secure_storage_windows_plugin, FlView, GApplication (+30 more)

### Community 6 - "auth_state.dart"
Cohesion: 0.07
Nodes (26): appVersionSupported, area, AuthState, AuthStatus, bloodGroup, challengeId, copyWith, displayName (+18 more)

### Community 7 - "blood_theme.dart"
Cohesion: 0.05
Nodes (38): blood_colors.dart, BloodTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight (+30 more)

### Community 8 - "location_picker_screen.dart"
Cohesion: 0.06
Nodes (36): ../../../core/location/foreground_location_service.dart, ../../../core/widgets/permission_dialogs.dart, CustomPainter, Exception, failure, ForegroundLocationException, ForegroundLocationFailure, ForegroundLocationService (+28 more)

### Community 9 - "blood_colors.dart"
Cohesion: 0.06
Nodes (30): accent, backgroundDark, backgroundLight, BloodColors, darkCardGradient, error, glassGradient, info (+22 more)

### Community 10 - "session_profile_validator_test.dart"
Cohesion: 0.14
Nodes (13): dart:io, Future, package:blood_flutter/core/session/app_session_startup.dart, package:blood_flutter/core/session/session_profile_validator.dart, package:serverpod_client/serverpod_client.dart, RefresherClientAuthKeyProvider, async, _authHeader (+5 more)

### Community 11 - "donor_health_details_screen.dart"
Cohesion: 0.08
Nodes (25): _addressController, _allEligibilityPassed, _bloodGroups, build, _buildEligibilityTile, _checkAge, _checkCooldown, _checkHealth (+17 more)

### Community 12 - "auth_controller.dart"
Cohesion: 0.05
Nodes (36): AuthState get, ../core/network/serverpod_client.dart, completeProfile, _countdownTimer, deleteAccount, dispose, instance, loginWithPin (+28 more)

### Community 13 - "utils.cpp"
Cohesion: 0.19
Nodes (12): flutter_windows, _In_, _In_opt_, io, iostream, stdio, wWinMain(), string (+4 more)

### Community 14 - "blood_button.dart"
Cohesion: 0.10
Nodes (20): double?, backgroundColor, BloodButtonStyle, borderRadius, build, createState, dispose, height (+12 more)

### Community 15 - "app_routes.dart"
Cohesion: 0.08
Nodes (23): ../../features/auth/presentation/donor_health_details_screen.dart, ../../features/auth/presentation/location_picker_screen.dart, ../../features/auth/presentation/login_screen.dart, ../../features/auth/presentation/otp_verification_screen.dart, ../../features/auth/presentation/phone_input_screen.dart, ../../features/auth/presentation/pin_setup_screen.dart, ../../features/home/presentation/home_placeholder_screen.dart, ../../features/onboarding/presentation/onboarding_screen.dart (+15 more)

### Community 16 - "session_profile_guard.dart"
Cohesion: 0.11
Nodes (18): auth_session_revocation_outbox.dart, ../../features/auth/controllers/auth_controller.dart, ../../features/auth/presentation/donor_opt_in_dialog.dart, _accountBlocked, _authSession, build, child, createState (+10 more)

### Community 17 - "auth_session_revocation_outbox.dart"
Cohesion: 0.11
Nodes (17): app_session_startup.dart, dart:convert, AuthSessionRevocationOutbox, clear, _enqueue, _isolatedSessionKey, _outboxKey, _pendingRetry (+9 more)

### Community 18 - "app_session_startup.dart"
Cohesion: 0.11
Nodes (17): dart:ui, _cachedDonorStatusKey, _cachedUserIdKey, cacheProfile, clearProfileCache, _clearSavedAuthentication, _firstInstallKey, hasRestoredSession (+9 more)

### Community 19 - "login_screen.dart"
Cohesion: 0.12
Nodes (17): donor_opt_in_dialog.dart, FocusNode, build, createState, dispose, donorOptInPending, _errorMessage, _handleForgotPin (+9 more)

### Community 20 - "State"
Cohesion: 0.17
Nodes (16): SessionProfileGuard, _SessionProfileGuardState, DeleteAccountDialog, _DeleteAccountDialogState, DonorHealthDetailsScreen, _DonorHealthDetailsScreenState, DonorOptInDialog, _DonorOptInDialogState (+8 more)

### Community 21 - "phone_input_screen.dart"
Cohesion: 0.11
Nodes (17): build, createState, dispose, _donorOptIn, _errorMessage, _handleSendOtp, initState, isForgotPin (+9 more)

### Community 22 - "blood_drop_logo.dart"
Cohesion: 0.12
Nodes (16): animated, BloodDropLogo, _BloodDropLogoState, build, _controller, createState, deepColor, dispose (+8 more)

### Community 23 - "onboarding_screen.dart"
Cohesion: 0.12
Nodes (16): badgeColor, badgeText, build, createState, _currentPage, description, dispose, icon (+8 more)

### Community 24 - "theme_controller.dart"
Cohesion: 0.06
Nodes (30): blood_theme2.dart, blood_theme.dart, BloodThemePreset get, bool get, ChangeNotifier, AppLanguage, instance, isBangla (+22 more)

### Community 25 - "pin_setup_screen.dart"
Cohesion: 0.13
Nodes (14): ../controllers/auth_controller.dart, build, _buildKeypadButton, _buildKeypadRow, createState, _currentInput, donorOptIn, _errorMessage (+6 more)

### Community 26 - "splash_screen.dart"
Cohesion: 0.14
Nodes (14): Animation, AnimationController, ../../auth/controllers/auth_controller.dart, Color, core/router/app_routes.dart, build, _checkNavigation, createState (+6 more)

### Community 27 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.14
Nodes (13): connectivity_plus, desktop_webview_window, flutter_secure_storage_darwin, flutter_web_auth_2, Foundation, geolocator_apple, google_sign_in_ios, package_info_plus (+5 more)

### Community 28 - "app_sentry_service.dart"
Cohesion: 0.15
Nodes (12): dart:async, AppSentryService, captureException, captureFlutterError, captureMessage, captureUnhandledError, _enabled, init (+4 more)

### Community 29 - "../../../core/localization/blood_strings.dart"
Cohesion: 0.18
Nodes (10): ../../../core/localization/blood_strings.dart, ../../../core/theme/blood_colors.dart, ../../../core/widgets/blood_button.dart, ../../../core/widgets/blood_drop_logo.dart, build, _buildPoint, show, TermsPrivacyDialog (+2 more)

### Community 30 - "delete_account_dialog.dart"
Cohesion: 0.17
Nodes (11): ../../../core/widgets/blood_text_field.dart, build, _canDelete, createState, dispose, _handleDelete, initState, _inputController (+3 more)

### Community 31 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 32 - "ios/RunnerTests/RunnerTests.swift"
Cohesion: 0.24
Nodes (6): Flutter, FlutterSceneDelegate, SceneDelegate, RunnerTests, UIKit, XCTestCase

### Community 34 - "AppDelegate"
Cohesion: 0.25
Nodes (6): Any, FlutterImplicitEngineBridge, FlutterImplicitEngineDelegate, AppDelegate, Bool, UIApplication

### Community 35 - "serverpod_client.dart"
Cohesion: 0.25
Nodes (7): Client, client, initializeClient, serverUrl, package:blood_client/blood_client.dart, package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart, package:serverpod_flutter/serverpod_flutter.dart

### Community 36 - "FlutterMacOS"
Cohesion: 0.32
Nodes (4): Cocoa, FlutterMacOS, RunnerTests, XCTest

### Community 37 - "AppDelegate"
Cohesion: 0.47
Nodes (4): FlutterAppDelegate, AppDelegate, Bool, NSApplication

### Community 38 - "package:flutter/material.dart"
Cohesion: 0.20
Nodes (8): build, createState, initialValue, _optedIn, show, package:blood_flutter/core/widgets/permission_dialogs.dart, package:flutter/material.dart, main

### Community 39 - "phone_input_screen_test.dart"
Cohesion: 0.13
Nodes (13): Checkbox, CheckboxListTile, package:blood_flutter/core/localization/app_language.dart, package:blood_flutter/core/localization/blood_strings.dart, package:blood_flutter/features/auth/controllers/auth_controller.dart, package:blood_flutter/features/auth/presentation/donor_opt_in_dialog.dart, package:blood_flutter/features/auth/presentation/phone_input_screen.dart, package:flutter_test/flutter_test.dart (+5 more)

### Community 41 - "RegisterGeneratedPlugins"
Cohesion: 0.40
Nodes (4): FlutterPluginRegistry, RegisterGeneratedPlugins(), MainFlutterWindow, NSWindow

### Community 45 - "GeneratedPluginRegistrant.m"
Cohesion: 0.11
Nodes (16): connectivityplusplugin, fluttersecurestoragedarwinplugin, flutterwebauth2plugin, fpppackageinfoplusplugin, geolocatorplugin, googlesigninplugin, GeneratedPluginRegistrant, +registerWithRegistry (+8 more)

### Community 52 - "dart_plugin_registrant.dart"
Cohesion: 0.08
Nodes (24): @pragma, _PluginRegistrant, register, package:connectivity_plus/connectivity_plus.dart, package:flutter_secure_storage_windows/flutter_secure_storage_windows.dart, package:flutter_web_auth_2/flutter_web_auth_2.dart, package:geolocator_android/geolocator_android.dart, package:geolocator_apple/geolocator_apple.dart (+16 more)

### Community 53 - "otp_verification_screen.dart"
Cohesion: 0.13
Nodes (15): build, createState, dispose, _enteredCode, _errorMessage, _focusNodes, _handleResend, _handleVerify (+7 more)

### Community 54 - "web_plugin_registrant.dart"
Cohesion: 0.12
Nodes (15): registerPlugins, registrar, package:connectivity_plus/src/connectivity_plus_web.dart, package:flutter_secure_storage_web/flutter_secure_storage_web.dart, package:flutter_web_auth_2/src/web.dart, package:flutter_web_plugins/flutter_web_plugins.dart, package:geolocator_web/geolocator_web.dart, package:google_sign_in_web/google_sign_in_web.dart (+7 more)

### Community 55 - "sign_in_screen.dart"
Cohesion: 0.15
Nodes (13): FlutterAuthSessionManager get, _authSession, build, child, createState, dispose, initState, _isSignedIn (+5 more)

### Community 56 - "_"
Cohesion: 0.17
Nodes (12): _, _clearSafely, isBlocked, isDonor, _pendingValidation, restore, SessionProfileSnapshot, SessionProfileValidator (+4 more)

### Community 57 - "device_identity.dart"
Cohesion: 0.18
Nodes (10): dart:math, DeviceIdentity, _generateUuidV4, getInstallId, _storage, _storageKey, _uuidPattern, package:flutter_secure_storage/flutter_secure_storage.dart (+2 more)

### Community 58 - "string"
Cohesion: 0.27
Nodes (7): dart_project, flutter_view_controller, functional, memory, string, vector, windows

### Community 59 - "GeneratedPluginRegistrant.java"
Cohesion: 0.38
Nodes (5): GeneratedPluginRegistrant, androidx.annotation.Keep, io.flutter.embedding.engine.FlutterEngine, log, nonnull

### Community 60 - "flutter_lldb_helper.py"
Cohesion: 0.29
Nodes (6): handle_new_rx_page(), __lldb_init_module(), Intercept NOTIFY_DEBUGGER_ABOUT_RX_PAGES and touch the pages., lldb, SBDebugger, SBFrame

### Community 61 - "dart_build_result.json"
Cohesion: 0.33
Nodes (5): build_end, build_start, code_assets, data_assets, dependencies

### Community 62 - "gradlew"
Cohesion: 0.60
Nodes (3): gradlew script, die(), warn()

### Community 63 - "_BloodButtonState"
Cohesion: 0.67
Nodes (3): BloodButton, _BloodButtonState, SingleTickerProviderStateMixin

## Knowledge Gaps
- **681 isolated node(s):** `registrar`, `registerPlugins`, `build_start`, `build_end`, `dependencies` (+676 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 875 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **11 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Win32Window` connect `Win32Window` to `string`?**
  _High betweenness centrality (0.069) - this node is a cross-community bridge._
- **Why does `OnCreate` connect `Win32Window` to `my_application.cc`?**
  _High betweenness centrality (0.031) - this node is a cross-community bridge._
- **Why does `RegisterPlugins()` connect `my_application.cc` to `Win32Window`?**
  _High betweenness centrality (0.030) - this node is a cross-community bridge._
- **What connects `registrar`, `registerPlugins`, `build_start` to the rest of the system?**
  _681 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `blood_strings.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.013157894736842105 - nodes in this community are weakly interconnected._
- **Should `Win32Window` be split into smaller, more focused modules?**
  _Cohesion score 0.05407925407925408 - nodes in this community are weakly interconnected._
- **Should `blood_theme2.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.04 - nodes in this community are weakly interconnected._