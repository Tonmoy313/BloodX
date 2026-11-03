# Graph Report - blood_flutter  (2026-11-03)

## Corpus Check
- 86 files · ~41,321 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 69 file(s) not represented in the graph (top: .xcconfig 10, .bin 8, .xml 7)

## Summary
- 1221 nodes · 1525 edges · 62 communities (50 shown, 12 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 17 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `b35ddde4`
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
- _
- donor_health_details_screen.dart
- auth_controller.dart
- utils.cpp
- blood_button.dart
- app_routes.dart
- session_profile_guard.dart
- auth_session_revocation_outbox.dart
- app_session_startup.dart
- login_screen.dart
- sign_in_screen.dart
- phone_input_screen.dart
- blood_drop_logo.dart
- onboarding_screen.dart
- theme_controller.dart
- pin_setup_screen.dart
- splash_screen.dart
- GeneratedPluginRegistrant.swift
- app_sentry_service.dart
- package:flutter/material.dart
- delete_account_dialog.dart
- manifest.json
- ios/RunnerTests/RunnerTests.swift
- app_language.dart
- AppDelegate
- serverpod_client.dart
- FlutterMacOS
- AppDelegate
- _
- phone_input_screen_test.dart
- RunnerTests
- RegisterGeneratedPlugins
- ChangeNotifier
- MainActivity.kt
- blood_flutter
- GeneratedPluginRegistrant.m
- LaunchImage.imageset/README.md
- widget_test.dart
- String?
- otp_verification_screen.dart
- device_identity.dart
- string
- GeneratedPluginRegistrant.java
- flutter_lldb_helper.py
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
8. `_` - 8 edges
9. `_MyApplication` - 7 edges
10. `OnCreate` - 7 edges

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

## Communities (62 total, 12 thin omitted)

### Community 0 - "blood_strings.dart"
Cohesion: 0.01
Nodes (202): app_language.dart, accountAlreadyRegistered, addressFieldHint, addressFieldLabel, addressHint, addressLabel, agree, agreed (+194 more)

### Community 1 - "Win32Window"
Cohesion: 0.05
Nodes (59): dwmapi, FlutterViewController, generated_plugin_registrant, optional, RECT, unique_ptr, DartProject, HWND (+51 more)

### Community 2 - "blood_theme2.dart"
Cohesion: 0.04
Nodes (49): AppTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight, containerSubtleDark (+41 more)

### Community 3 - "home_placeholder_screen.dart"
Cohesion: 0.17
Nodes (11): core/localization/app_language.dart, ../../../core/session/auth_session_revocation_outbox.dart, ../../../core/session/session_profile_guard.dart, DateTime?, build, child, createState, _handleSignOut (+3 more)

### Community 4 - "blood_text_field.dart"
Cohesion: 0.05
Nodes (46): blood_button.dart, IconData, int?, autofocus, BloodTextField, build, controller, errorText (+38 more)

### Community 5 - "my_application.cc"
Cohesion: 0.05
Nodes (40): connectivity_plus_windows_plugin, desktop_webview_window_plugin, file_selector_plugin, file_selector_windows, FlPluginRegistry, flutter_linux, flutter_secure_storage_linux_plugin, flutter_secure_storage_windows_plugin (+32 more)

### Community 6 - "auth_state.dart"
Cohesion: 0.07
Nodes (27): appVersionSupported, area, AuthState, AuthStatus, bloodGroup, challengeId, copyWith, displayName (+19 more)

### Community 7 - "blood_theme.dart"
Cohesion: 0.05
Nodes (38): blood_colors.dart, BloodTheme, borderDark, borderLight, containerDark, containerLight, containerMutedDark, containerMutedLight (+30 more)

### Community 8 - "location_picker_screen.dart"
Cohesion: 0.06
Nodes (36): ../../../core/location/foreground_location_service.dart, ../../../core/widgets/permission_dialogs.dart, CustomPainter, Exception, failure, ForegroundLocationException, ForegroundLocationFailure, ForegroundLocationService (+28 more)

### Community 9 - "blood_colors.dart"
Cohesion: 0.06
Nodes (30): accent, backgroundDark, backgroundLight, BloodColors, darkCardGradient, error, glassGradient, info (+22 more)

### Community 10 - "_"
Cohesion: 0.09
Nodes (25): dart:io, Future, _, _clearSafely, isBlocked, isDonor, _pendingValidation, restore (+17 more)

### Community 11 - "donor_health_details_screen.dart"
Cohesion: 0.04
Nodes (52): ../../../core/data/bangladesh_locations.dart, _addressController, _answers, _apheresisWilling, _bloodGroups, _bloodGroupSource, build, _buildCascadingLocationSelector (+44 more)

### Community 12 - "auth_controller.dart"
Cohesion: 0.07
Nodes (28): AuthState get, completeProfile, _countdownTimer, deleteAccount, dispose, _existingAccountErrorCode, instance, loginWithPin (+20 more)

### Community 13 - "utils.cpp"
Cohesion: 0.19
Nodes (12): flutter_windows, _In_, _In_opt_, io, iostream, stdio, wWinMain(), string (+4 more)

### Community 14 - "blood_button.dart"
Cohesion: 0.10
Nodes (20): double?, backgroundColor, BloodButtonStyle, borderRadius, build, createState, dispose, height (+12 more)

### Community 15 - "app_routes.dart"
Cohesion: 0.05
Nodes (40): core/monitoring/app_sentry_service.dart, core/session/app_session_startup.dart, core/theme/theme_controller.dart, ../../features/auth/presentation/donor_health_details_screen.dart, ../../features/auth/presentation/location_picker_screen.dart, ../../features/auth/presentation/login_screen.dart, ../../features/auth/presentation/otp_verification_screen.dart, ../../features/auth/presentation/phone_input_screen.dart (+32 more)

### Community 16 - "session_profile_guard.dart"
Cohesion: 0.11
Nodes (18): auth_session_revocation_outbox.dart, ../../features/auth/controllers/auth_controller.dart, ../../features/auth/presentation/donor_opt_in_dialog.dart, _accountBlocked, _authSession, build, child, createState (+10 more)

### Community 17 - "auth_session_revocation_outbox.dart"
Cohesion: 0.11
Nodes (17): app_session_startup.dart, dart:convert, AuthSessionRevocationOutbox, clear, _enqueue, _isolatedSessionKey, _outboxKey, _pendingRetry (+9 more)

### Community 18 - "app_session_startup.dart"
Cohesion: 0.11
Nodes (18): dart:ui, _cachedDonorStatusKey, _cachedUserIdKey, cacheProfile, clearProfileCache, _clearSavedAuthentication, _firstInstallKey, hasRestoredSession (+10 more)

### Community 19 - "login_screen.dart"
Cohesion: 0.12
Nodes (17): donor_opt_in_dialog.dart, FocusNode, build, createState, dispose, donorOptInPending, _errorMessage, _handleForgotPin (+9 more)

### Community 20 - "sign_in_screen.dart"
Cohesion: 0.05
Nodes (47): ../core/network/serverpod_client.dart, FlutterAuthSessionManager get, SessionProfileGuard, _SessionProfileGuardState, DeleteAccountDialog, _DeleteAccountDialogState, DonorHealthDetailsScreen, _DonorHealthDetailsScreenState (+39 more)

### Community 21 - "phone_input_screen.dart"
Cohesion: 0.11
Nodes (18): build, createState, dispose, _donorOptIn, _errorMessage, _handleSendOtp, initState, isForgotPin (+10 more)

### Community 22 - "blood_drop_logo.dart"
Cohesion: 0.12
Nodes (16): animated, BloodDropLogo, _BloodDropLogoState, build, _controller, createState, deepColor, dispose (+8 more)

### Community 23 - "onboarding_screen.dart"
Cohesion: 0.12
Nodes (16): badgeColor, badgeText, build, createState, _currentPage, description, dispose, icon (+8 more)

### Community 24 - "theme_controller.dart"
Cohesion: 0.12
Nodes (15): blood_theme2.dart, blood_theme.dart, BloodThemePreset get, BloodThemePreset, instance, isModern, _preset, setPreset (+7 more)

### Community 25 - "pin_setup_screen.dart"
Cohesion: 0.12
Nodes (15): ../controllers/auth_controller.dart, build, _buildKeypadButton, _buildKeypadRow, createState, _currentInput, donorOptIn, _errorMessage (+7 more)

### Community 26 - "splash_screen.dart"
Cohesion: 0.15
Nodes (13): Animation, AnimationController, ../../auth/controllers/auth_controller.dart, Color, build, _checkNavigation, createState, dispose (+5 more)

### Community 27 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.13
Nodes (14): connectivity_plus, desktop_webview_window, file_selector_macos, flutter_secure_storage_darwin, flutter_web_auth_2, Foundation, geolocator_apple, google_sign_in_ios (+6 more)

### Community 28 - "app_sentry_service.dart"
Cohesion: 0.15
Nodes (12): dart:async, AppSentryService, captureException, captureFlutterError, captureMessage, captureUnhandledError, _enabled, init (+4 more)

### Community 29 - "package:flutter/material.dart"
Cohesion: 0.15
Nodes (12): ../../../core/localization/blood_strings.dart, ../../../core/theme/blood_colors.dart, ../../../core/widgets/blood_button.dart, ../../../core/widgets/blood_drop_logo.dart, build, _buildPoint, show, build (+4 more)

### Community 30 - "delete_account_dialog.dart"
Cohesion: 0.15
Nodes (12): core/router/app_routes.dart, ../../../core/widgets/blood_text_field.dart, build, _canDelete, createState, dispose, _handleDelete, initState (+4 more)

### Community 31 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 32 - "ios/RunnerTests/RunnerTests.swift"
Cohesion: 0.32
Nodes (5): Flutter, FlutterSceneDelegate, SceneDelegate, UIKit, XCTest

### Community 33 - "app_language.dart"
Cohesion: 0.17
Nodes (11): bool get, instance, isBangla, _locale, _saveLocale, setLocale, toggleLanguage, Locale (+3 more)

### Community 34 - "AppDelegate"
Cohesion: 0.25
Nodes (6): Any, FlutterImplicitEngineBridge, FlutterImplicitEngineDelegate, AppDelegate, Bool, UIApplication

### Community 35 - "serverpod_client.dart"
Cohesion: 0.25
Nodes (7): Client, client, initializeClient, serverUrl, package:blood_client/blood_client.dart, package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart, package:serverpod_flutter/serverpod_flutter.dart

### Community 36 - "FlutterMacOS"
Cohesion: 0.38
Nodes (4): Cocoa, FlutterMacOS, MainFlutterWindow, NSWindow

### Community 37 - "AppDelegate"
Cohesion: 0.47
Nodes (4): FlutterAppDelegate, AppDelegate, Bool, NSApplication

### Community 38 - "_"
Cohesion: 0.29
Nodes (7): _, BangladeshLocations, districts, districtUpazilas, getUpazilas, static const List, static const Map

### Community 39 - "phone_input_screen_test.dart"
Cohesion: 0.11
Nodes (15): Checkbox, CheckboxListTile, package:blood_flutter/core/data/bangladesh_locations.dart, package:blood_flutter/core/localization/app_language.dart, package:blood_flutter/core/localization/blood_strings.dart, package:blood_flutter/features/auth/controllers/auth_controller.dart, package:blood_flutter/features/auth/presentation/donor_opt_in_dialog.dart, package:blood_flutter/features/auth/presentation/phone_input_screen.dart (+7 more)

### Community 40 - "RunnerTests"
Cohesion: 0.40
Nodes (3): RunnerTests, RunnerTests, XCTestCase

### Community 42 - "ChangeNotifier"
Cohesion: 0.50
Nodes (4): ChangeNotifier, AppLanguage, AppThemeController, AuthController

### Community 45 - "GeneratedPluginRegistrant.m"
Cohesion: 0.10
Nodes (18): connectivityplusplugin, fltimagepickerplugin, fluttersecurestoragedarwinplugin, flutterwebauth2plugin, fpppackageinfoplusplugin, geolocatorplugin, googlesigninplugin, image_picker_ios (+10 more)

### Community 53 - "otp_verification_screen.dart"
Cohesion: 0.14
Nodes (13): build, createState, dispose, _enteredCode, _errorMessage, _focusNodes, _handleResend, _handleVerify (+5 more)

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

### Community 62 - "gradlew"
Cohesion: 0.60
Nodes (3): gradlew script, die(), warn()

### Community 63 - "_BloodButtonState"
Cohesion: 0.67
Nodes (3): BloodButton, _BloodButtonState, SingleTickerProviderStateMixin

## Knowledge Gaps
- **763 isolated node(s):** `flutter_export_environment.sh script`, `+registerWithRegistry`, `BangladeshLocations`, `districts`, `districtUpazilas` (+758 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 932 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **12 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Win32Window` connect `Win32Window` to `string`?**
  _High betweenness centrality (0.055) - this node is a cross-community bridge._
- **Why does `OnCreate` connect `Win32Window` to `my_application.cc`?**
  _High betweenness centrality (0.018) - this node is a cross-community bridge._
- **Why does `RegisterPlugins()` connect `my_application.cc` to `Win32Window`?**
  _High betweenness centrality (0.017) - this node is a cross-community bridge._
- **What connects `flutter_export_environment.sh script`, `+registerWithRegistry`, `BangladeshLocations` to the rest of the system?**
  _763 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `blood_strings.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.009852216748768473 - nodes in this community are weakly interconnected._
- **Should `Win32Window` be split into smaller, more focused modules?**
  _Cohesion score 0.05407925407925408 - nodes in this community are weakly interconnected._
- **Should `blood_theme2.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.04 - nodes in this community are weakly interconnected._