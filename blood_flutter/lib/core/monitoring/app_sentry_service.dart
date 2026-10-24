import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Thin wrapper around `package:sentry_flutter` for BloodX.
///
/// ## Setup
/// Call [AppSentryService.init] with your [FlutterErrorDetails] handler in
/// `main()` **before** `runApp`. It reads `SENTRY_DSN_APP` from the asset-
/// bundled `assets/config.json` (injected at build time; see [AppConfig]).
///
/// When no DSN is configured (dev flavour / local build) Sentry is disabled
/// silently — no network calls, no exceptions thrown.
///
/// ## What is never sent
/// OTPs, PINs, auth tokens, full phone numbers, raw health answers, or any
/// value sourced from a form field. Strip these before calling [captureException].
///
/// ## Usage
/// ```dart
/// await AppSentryService.init(dsn: appConfig.sentryDsnApp, env: appConfig.env);
///
/// // Later, in error handlers:
/// AppSentryService.captureException(e, stackTrace: st, userId: session.userId);
/// ```
class AppSentryService {
  AppSentryService._();

  static bool _initialised = false;
  static bool _enabled = false;

  /// Initialise Sentry. Safe to call multiple times (subsequent calls are no-ops).
  ///
  /// [dsn] — the Sentry DSN from config.json. Pass null or empty to disable.
  /// [env] — 'development', 'staging', or 'production'.
  /// [release] — the app version string (e.g. '1.0.0+42').
  static Future<void> init({
    required String? dsn,
    required String env,
    required String release,
    required Future<void> Function() appRunner,
  }) async {
    if (_initialised) {
      await appRunner();
      return;
    }
    _initialised = true;

    final hasDsn = dsn != null && dsn.trim().isNotEmpty;
    if (!hasDsn) {
      debugPrint('[AppSentryService] Sentry disabled (no DSN).');
      await appRunner();
      return;
    }

    _enabled = true;
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = dsn
          ..environment = env
          ..release = release
          ..tracesSampleRate = env == 'production' ? 0.05 : 0.0
          // Never send screenshots or view hierarchy in prod (health/PII risk).
          ..attachScreenshot = false
          // ignore: experimental_member_use
          ..attachViewHierarchy = false
          // Respect user privacy: do not send IP addresses.
          ..sendDefaultPii = false
          // Reduce noise in prod; log everything on staging.
          ..diagnosticLevel = env == 'production'
              ? SentryLevel.warning
              : SentryLevel.info;
      },
      appRunner: appRunner,
    );
  }

  /// Capture an exception. No-op when Sentry is not initialised.
  ///
  /// [userId] — pass the opaque server user ID (not phone, not name).
  /// [extras] — must not contain OTPs, PINs, tokens, or full phone numbers.
  static Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    String? userId,
    Map<String, dynamic>? extras,
  }) async {
    if (!_enabled) return;
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      withScope: (scope) {
        if (userId != null) {
          scope.setUser(SentryUser(id: userId));
        }
        if (extras != null) {
          scope.setContexts('extras', extras);
        }
      },
    );
  }

  /// Capture a message (info-level). No-op when Sentry is disabled.
  static Future<void> captureMessage(
    String message, {
    SentryLevel level = SentryLevel.info,
  }) async {
    if (!_enabled) return;
    await Sentry.captureMessage(message, level: level);
  }

  /// Report a Flutter framework error. Wire this to [FlutterError.onError].
  static Future<void> captureFlutterError(FlutterErrorDetails details) async {
    if (!_enabled) return;
    await Sentry.captureException(
      details.exception,
      stackTrace: details.stack,
    );
  }

  /// Report an unhandled platform/async error.
  /// Wire this to [PlatformDispatcher.instance.onError].
  static bool captureUnhandledError(Object error, StackTrace stackTrace) {
    if (!_enabled) return false;
    unawaited(Sentry.captureException(error, stackTrace: stackTrace));
    return true; // let Flutter's default handler also run
  }
}
