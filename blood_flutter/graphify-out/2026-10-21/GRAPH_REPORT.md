# Graph Report - blood_flutter  (2026-10-19)

## Corpus Check
- 75 files · ~35,323 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 42 file(s) not represented in the graph (top: .xcconfig 8, .plist 7, .xml 5)

## Summary
- 1053 nodes · 1334 edges · 52 communities (43 shown, 9 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 17 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `57c1371a`
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
- State
- phone_input_screen.dart
- blood_drop_logo.dart
- onboarding_screen.dart
- theme_controller.dart
- pin_setup_screen.dart
- splash_screen.dart
- GeneratedPluginRegistrant.swift
- app_language.dart
- ../../../core/localization/blood_strings.dart
- delete_account_dialog.dart
- manifest.json
- ios/RunnerTests/RunnerTests.swift
- package:flutter/material.dart
- AppDelegate
- serverpod_client.dart
- FlutterMacOS
- AppDelegate
- donor_opt_in_dialog.dart
- package:flutter_test/flutter_test.dart
- phone_input_screen_test.dart
- RegisterGeneratedPlugins
- ChangeNotifier
- MainActivity.kt
- blood_flutter
- c_users_user_documents_blood_blood_blood_flutter_ios_runner_generatedpluginregistrant_h
- LaunchImage.imageset/README.md
- widget_test.dart
- String?

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

## Communities (52 total, 9 thin omitted)

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
Cohesion: 0.05
Nodes (44): ../../auth/controllers/auth_controller.dart, core/localization/app_language.dart, ../core/network/serverpod_client.dart, core/session/app_session_startup.dart, ../../../core/session/auth_session_revocation_outbox.dart, ../../../core/session/session_profile_guard.dart, core/theme/theme_controller.dart, DateTime? (+36 more)

### Community 4 - "blood_text_field.dart"
Cohesion: 0.05
Nodes (44): blood_button.dart, IconData, int?, autofocus, BloodTextField, build, controller, errorText (+36 more)

### Community 5 - "my_application.cc"
Cohesion: 0.05
Nodes (37): connectivity_plus_windows_plugin, desktop_webview_window_plugin, FlPluginRegistry, flutter_linux, flutter_secure_storage_linux_plugin, flutter_secure_storage_windows_plugin, FlView, GApplication (+29 more)

### Community 6 - "auth_state.dart"
Cohesion: 0.05
Nodes (41): appVersionSupported, area, AuthState, AuthStatus, bloodGroup, challengeId, copyWith, displayName (+33 more)

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
Cohesion: 0.08
Nodes (27): dart:async, dart:io, Future, _, _clearSafely, isBlocked, isDonor, _pendingValidation (+19 more)

### Community 11 - "donor_health_details_screen.dart"
Cohesion: 0.07
Nodes (27): _addressController, _allEligibilityPassed, _bloodGroups, build, _buildEligibilityTile, _checkAge, _checkCooldown, _checkHealth (+19 more)

### Community 12 - "auth_controller.dart"
Cohesion: 0.07
Nodes (26): AuthState get, completeProfile, _countdownTimer, deleteAccount, dispose, hashPin, instance, loginWithPin (+18 more)

### Community 13 - "utils.cpp"
Cohesion: 0.12
Nodes (19): dart_project, flutter_view_controller, flutter_windows, functional, _In_, _In_opt_, io, iostream (+11 more)

### Community 14 - "blood_button.dart"
Cohesion: 0.09
Nodes (23): double?, backgroundColor, BloodButton, _BloodButtonState, BloodButtonStyle, borderRadius, build, createState (+15 more)

### Community 15 - "app_routes.dart"
Cohesion: 0.08
Nodes (23): ../../features/auth/presentation/donor_health_details_screen.dart, ../../features/auth/presentation/location_picker_screen.dart, ../../features/auth/presentation/login_screen.dart, ../../features/auth/presentation/otp_verification_screen.dart, ../../features/auth/presentation/phone_input_screen.dart, ../../features/auth/presentation/pin_setup_screen.dart, ../../features/home/presentation/home_placeholder_screen.dart, ../../features/onboarding/presentation/onboarding_screen.dart (+15 more)

### Community 16 - "session_profile_guard.dart"
Cohesion: 0.11
Nodes (18): app_session_startup.dart, auth_session_revocation_outbox.dart, ../../features/auth/presentation/donor_opt_in_dialog.dart, _accountBlocked, build, child, createState, _discardExpiredSession (+10 more)

### Community 17 - "auth_session_revocation_outbox.dart"
Cohesion: 0.11
Nodes (18): dart:convert, ../../features/auth/controllers/auth_controller.dart, AuthSessionRevocationOutbox, clear, _enqueue, _isolatedSessionKey, _outboxKey, _pendingRetry (+10 more)

### Community 18 - "app_session_startup.dart"
Cohesion: 0.11
Nodes (18): dart:ui, _cachedDonorStatusKey, _cachedUserIdKey, cacheProfile, clearProfileCache, _clearSavedAuthentication, _firstInstallKey, hasRestoredSession (+10 more)

### Community 19 - "login_screen.dart"
Cohesion: 0.12
Nodes (17): donor_opt_in_dialog.dart, FocusNode, build, createState, dispose, donorOptInPending, _errorMessage, _handleForgotPin (+9 more)

### Community 20 - "State"
Cohesion: 0.16
Nodes (18): SessionProfileGuard, _SessionProfileGuardState, DeleteAccountDialog, _DeleteAccountDialogState, DonorOptInDialog, _DonorOptInDialogState, LoginPinScreen, _LoginPinScreenState (+10 more)

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
Cohesion: 0.12
Nodes (15): blood_theme2.dart, blood_theme.dart, BloodThemePreset get, BloodThemePreset, instance, isModern, _preset, setPreset (+7 more)

### Community 25 - "pin_setup_screen.dart"
Cohesion: 0.13
Nodes (14): ../controllers/auth_controller.dart, build, _buildKeypadButton, _buildKeypadRow, createState, _currentInput, donorOptIn, _errorMessage (+6 more)

### Community 26 - "splash_screen.dart"
Cohesion: 0.15
Nodes (13): Animation, AnimationController, Color, core/router/app_routes.dart, build, _checkNavigation, createState, dispose (+5 more)

### Community 27 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.15
Nodes (12): connectivity_plus, desktop_webview_window, flutter_secure_storage_darwin, flutter_web_auth_2, Foundation, geolocator_apple, google_sign_in_ios, package_info_plus (+4 more)

### Community 28 - "app_language.dart"
Cohesion: 0.17
Nodes (11): bool get, instance, isBangla, _locale, _saveLocale, setLocale, toggleLanguage, Locale (+3 more)

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

### Community 33 - "package:flutter/material.dart"
Cohesion: 0.25
Nodes (7): CheckboxListTile, package:blood_flutter/core/localization/blood_strings.dart, package:blood_flutter/core/widgets/permission_dialogs.dart, package:blood_flutter/features/auth/presentation/donor_opt_in_dialog.dart, package:flutter/material.dart, main, main

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

### Community 38 - "donor_opt_in_dialog.dart"
Cohesion: 0.33
Nodes (5): build, createState, initialValue, _optedIn, show

### Community 39 - "package:flutter_test/flutter_test.dart"
Cohesion: 0.33
Nodes (5): package:blood_flutter/core/localization/app_language.dart, package:blood_flutter/features/auth/controllers/auth_controller.dart, package:flutter_test/flutter_test.dart, package:shared_preferences/shared_preferences.dart, main

### Community 40 - "phone_input_screen_test.dart"
Cohesion: 0.40
Nodes (4): Checkbox, package:blood_flutter/features/auth/presentation/phone_input_screen.dart, ScrollableState, main

### Community 41 - "RegisterGeneratedPlugins"
Cohesion: 0.40
Nodes (4): FlutterPluginRegistry, RegisterGeneratedPlugins(), MainFlutterWindow, NSWindow

### Community 42 - "ChangeNotifier"
Cohesion: 0.50
Nodes (4): ChangeNotifier, AppLanguage, AppThemeController, AuthController

## Knowledge Gaps
- **654 isolated node(s):** `instance`, `_locale`, `isBangla`, `setLocale`, `toggleLanguage` (+649 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 791 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **9 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_` connect `_` to `app_language.dart`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **Why does `OnCreate` connect `Win32Window` to `my_application.cc`?**
  _High betweenness centrality (0.003) - this node is a cross-community bridge._
- **What connects `instance`, `_locale`, `isBangla` to the rest of the system?**
  _654 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `blood_strings.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.013157894736842105 - nodes in this community are weakly interconnected._
- **Should `Win32Window` be split into smaller, more focused modules?**
  _Cohesion score 0.05407925407925408 - nodes in this community are weakly interconnected._
- **Should `blood_theme2.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.04 - nodes in this community are weakly interconnected._
- **Should `home_placeholder_screen.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.04521276595744681 - nodes in this community are weakly interconnected._