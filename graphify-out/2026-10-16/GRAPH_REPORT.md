# Graph Report - blood  (2026-10-16)

## Corpus Check
- 113 files · ~59,977 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 46 file(s) not represented in the graph (top: .xcconfig 8, .plist 7, .xml 5)

## Summary
- 855 nodes · 1001 edges · 76 communities (35 shown, 41 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 18 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `efd767fb`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Win32Window
- blood_strings.dart
- client.dart
- my_application.cc
- GeneratedPluginRegistrant.swift
- generated/protocol.dart
- blood_button.dart
- memory.md — Shared project memory (all AI models)
- serverpod_test_tools.dart
- blood_colors.dart
- generated/greetings/greeting.dart
- greetings_screen.dart
- server.dart
- blood_text_field.dart
- auth_controller.dart
- auth_state.dart
- onboarding_screen.dart
- otp_verification_screen.dart
- register_profile_screen.dart
- phone_input_screen.dart
- lib/main.dart
- sign_in_screen.dart
- splash_screen.dart
- manifest.json
- app_language.dart
- core — shared definitions (read when a slice points here)
- home_placeholder_screen.dart
- STATE — single source of truth (keep small; edit only when something changes)
- StatelessWidget
- forgot_password_sheet.dart
- auth_controller_test.dart
- package:flutter/material.dart
- greeting_endpoint_test.dart
- gh_bootstrap.sh
- MainActivity.kt
- AppLanguage
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
- auth.md
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

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 24 edges
2. `MessageHandler` - 12 edges
3. `memory.md — Shared project memory (all AI models)` - 11 edges
4. `FlutterWindow` - 10 edges
5. `Create` - 10 edges
6. `WndProc` - 10 edges
7. `MessageHandler` - 9 edges
8. `core — shared definitions (read when a slice points here)` - 9 edges
9. `_MyApplication` - 7 edges
10. `OnCreate` - 7 edges

## Surprising Connections (you probably didn't know these)
- `Git (trunk-based)` --references--> `main()`  [INFERRED]
  AGENTS.md → blood_flutter/linux/runner/main.cc
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  blood_flutter/windows/runner/main.cpp → blood_flutter/windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  blood_flutter/windows/runner/win32_window.cpp → blood_flutter/windows/runner/win32_window.h
- `my_application_activate()` --calls--> `fl_register_plugins()`  [INFERRED]
  blood_flutter/linux/runner/my_application.cc → blood_flutter/linux/flutter/generated_plugin_registrant.cc
- `main()` --calls--> `my_application_new()`  [INFERRED]
  blood_flutter/linux/runner/main.cc → blood_flutter/linux/runner/my_application.cc

## Import Cycles
- None detected.

## Communities (76 total, 41 thin omitted)

### Community 0 - "Win32Window"
Cohesion: 0.05
Nodes (61): RegisterPlugins(), DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM, FlutterWindow (+53 more)

### Community 1 - "blood_strings.dart"
Cohesion: 0.03
Nodes (62): app_language.dart, agreed, and, appName, areaLabel, bloodGroupLabel, BloodStrings, _bn (+54 more)

### Community 2 - "client.dart"
Cohesion: 0.04
Nodes (46): AuthSuccess, emailIdp, EndpointEmailIdp, EndpointGreeting, EndpointJwtRefresh, endpointRefLookup, finishPasswordReset, finishRegistration (+38 more)

### Community 3 - "my_application.cc"
Cohesion: 0.05
Nodes (40): AGENTS.md — BloodX, Git (trunk-based), Graph (graphify, `graphify-out/`), Non-negotiables, Questions: ask in parallel, never wait, Read (this order; nothing else unless told), Token rules, fl_register_plugins() (+32 more)

### Community 4 - "GeneratedPluginRegistrant.swift"
Cohesion: 0.05
Nodes (33): Any, AppDelegate, Bool, SceneDelegate, RunnerTests, RegisterGeneratedPlugins(), AppDelegate, Bool (+25 more)

### Community 5 - "generated/protocol.dart"
Cohesion: 0.05
Nodes (41): ../auth/email_idp_endpoint.dart, ../auth/jwt_refresh_endpoint.dart, Endpoints, initializeEndpoints, deserializeByClassName, getClassNameForObject, getClassNameForType, getClassNameFromObjectJson (+33 more)

### Community 6 - "blood_button.dart"
Cohesion: 0.06
Nodes (36): Animation, AnimationController, BloodButtonStyle, borderRadius, build, createState, dispose, height (+28 more)

### Community 7 - "memory.md — Shared project memory (all AI models)"
Cohesion: 0.07
Nodes (32): wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), dart_project, flutter_view_controller (+24 more)

### Community 8 - "serverpod_test_tools.dart"
Cohesion: 0.06
Nodes (33): emailIdp, _EmailIdpEndpoint, _endpointDispatch, finishPasswordReset, finishRegistration, greeting, _GreetingEndpoint, hasAccount (+25 more)

### Community 9 - "blood_colors.dart"
Cohesion: 0.06
Nodes (30): accent, backgroundDark, backgroundLight, BloodColors, darkCardGradient, error, glassGradient, info (+22 more)

### Community 10 - "generated/greetings/greeting.dart"
Cohesion: 0.08
Nodes (26): abstract class, @_i1, author, copyWith, fromJson, Greeting, _GreetingImpl, message (+18 more)

### Community 11 - "greetings_screen.dart"
Cohesion: 0.10
Nodes (26): BloodButton, _BloodButtonState, BloodDropLogo, _BloodDropLogoState, OtpVerificationScreen, _OtpVerificationScreenState, PhoneInputScreen, _PhoneInputScreenState (+18 more)

### Community 12 - "server.dart"
Cohesion: 0.09
Nodes (19): appDir, pod, root, run, _sendPasswordResetCode, _sendRegistrationCode, start, EmailIdpEndpoint (+11 more)

### Community 13 - "blood_text_field.dart"
Cohesion: 0.10
Nodes (20): autofocus, build, controller, errorText, focusNode, hintText, inputFormatters, keyboardType (+12 more)

### Community 14 - "auth_controller.dart"
Cohesion: 0.11
Nodes (18): AuthState get, completeProfile, _countdownTimer, dispose, instance, maskPhone, normalizeBangladeshPhone, requestOtp (+10 more)

### Community 15 - "auth_state.dart"
Cohesion: 0.11
Nodes (17): area, AuthState, AuthStatus, bloodGroup, challengeId, copyWith, displayName, donorOptIn (+9 more)

### Community 16 - "onboarding_screen.dart"
Cohesion: 0.12
Nodes (16): ../../auth/presentation/phone_input_screen.dart, badgeColor, badgeText, build, createState, _currentPage, description, dispose (+8 more)

### Community 17 - "otp_verification_screen.dart"
Cohesion: 0.12
Nodes (15): build, createState, dispose, _enteredCode, _errorMessage, _focusNodes, _handleResend, _handleVerify (+7 more)

### Community 18 - "register_profile_screen.dart"
Cohesion: 0.13
Nodes (14): _bloodGroups, build, createState, _dhakaAreas, dispose, _donorOptIn, _handleComplete, initState (+6 more)

### Community 19 - "phone_input_screen.dart"
Cohesion: 0.14
Nodes (13): build, createState, dispose, _donorOptIn, _errorMessage, _handleSendOtp, initState, _phoneController (+5 more)

### Community 20 - "lib/main.dart"
Cohesion: 0.17
Nodes (11): Client, build, client, main, serverUrl, core/theme/blood_theme.dart, features/splash/presentation/splash_screen.dart, _i2.ServerpodClientShared (+3 more)

### Community 21 - "sign_in_screen.dart"
Cohesion: 0.18
Nodes (11): build, child, createState, dispose, initState, _isSignedIn, showSnackBar, SignInScreen (+3 more)

### Community 22 - "splash_screen.dart"
Cohesion: 0.18
Nodes (10): build, _checkNavigation, createState, dispose, _fadeAnimation, _fadeController, initState, Color (+2 more)

### Community 23 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 24 - "app_language.dart"
Cohesion: 0.20
Nodes (9): instance, isBangla, _locale, setLocale, toggleLanguage, bool get, Locale, Locale get (+1 more)

### Community 25 - "core — shared definitions (read when a slice points here)"
Cohesion: 0.20
Nodes (9): Config defaults (all tunable in config; **medical**/**legal** = confirm before launch; [G] = guess, tune from beta), core — shared definitions (read when a slice points here), Cross-cutting rules, Enums, Errors, Stack, State machines, Verify before relying [Likely] (+1 more)

### Community 26 - "home_placeholder_screen.dart"
Cohesion: 0.25
Nodes (7): ../../auth/controllers/auth_controller.dart, build, _handleSignOut, _showComingSoonSnackBar, core/localization/app_language.dart, ../../../core/widgets/blood_drop_logo.dart, ../../onboarding/presentation/onboarding_screen.dart

### Community 27 - "STATE — single source of truth (keep small; edit only when something changes)"
Cohesion: 0.25
Nodes (7): DECIDED, Deps (one line each: name · why · task), Open questions, Product, PROPOSED, Spec map (read ONE per task), STATE — single source of truth (keep small; edit only when something changes)

### Community 28 - "StatelessWidget"
Cohesion: 0.33
Nodes (6): BloodTextField, ForgotPasswordSheet, HomePlaceholderScreen, BloodApp, ResultDisplay, StatelessWidget

### Community 29 - "forgot_password_sheet.dart"
Cohesion: 0.33
Nodes (5): build, show, ../../../core/localization/blood_strings.dart, ../../../core/theme/blood_colors.dart, ../../../core/widgets/blood_button.dart

### Community 30 - "auth_controller_test.dart"
Cohesion: 0.40
Nodes (4): main, package:blood_flutter/core/localization/app_language.dart, package:blood_flutter/features/auth/controllers/auth_controller.dart, package:flutter_test/flutter_test.dart

### Community 31 - "package:flutter/material.dart"
Cohesion: 0.50
Nodes (3): blood_colors.dart, BloodTheme, package:flutter/material.dart

### Community 32 - "greeting_endpoint_test.dart"
Cohesion: 0.50
Nodes (3): main, package:test/test.dart, test_tools/serverpod_test_tools.dart

### Community 33 - "gh_bootstrap.sh"
Cohesion: 1.00
Nodes (3): make_label(), run(), gh_bootstrap.sh script

### Community 35 - "AppLanguage"
Cohesion: 0.67
Nodes (3): AppLanguage, AuthController, ChangeNotifier

## Knowledge Gaps
- **420 isolated node(s):** `Modules`, `name`, `serverpod_auth_idp`, `serverpod_auth_core`, `emailIdp` (+415 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 595 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **41 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Client` connect `lib/main.dart` to `client.dart`?**
  _High betweenness centrality (0.016) - this node is a cross-community bridge._
- **Why does `AuthState` connect `auth_state.dart` to `auth_controller.dart`?**
  _High betweenness centrality (0.010) - this node is a cross-community bridge._
- **Why does `Win32Window` connect `Win32Window` to `memory.md — Shared project memory (all AI models)`?**
  _High betweenness centrality (0.009) - this node is a cross-community bridge._
- **Are the 4 inferred relationships involving `MessageHandler` (e.g. with `Destroy` and `GetClientArea`) actually correct?**
  _`MessageHandler` has 4 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Modules`, `name`, `serverpod_auth_idp` to the rest of the system?**
  _420 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Win32Window` be split into smaller, more focused modules?**
  _Cohesion score 0.05179982440737489 - nodes in this community are weakly interconnected._
- **Should `blood_strings.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.031746031746031744 - nodes in this community are weakly interconnected._