import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

/// Thin Sentry + structured-logging helper for the BloodX server.
///
/// ## Structured logs
/// Serverpod writes JSON session logs when `consoleLogFormat: json` is
/// configured. Use [SentryService.logInfo] / [logWarning] for extra
/// out-of-session entries; Cloud Run's log agent picks them up via stderr.
///
/// ## Sentry
/// Call [SentryService.init] once in `server.dart` before `pod.start()`.
/// Inject `SENTRY_DSN_SERVER` and optionally `SENTRY_RELEASE` (Git SHA or
/// vX.Y.Z) from Secret Manager. When the DSN is absent (local dev) the
/// service logs only to stderr; it never throws.
///
/// ## What is never logged
/// OTPs, PINs, auth tokens, full phone numbers, health answers, or deferral
/// categories. Mask phones before passing them to log helpers.
class SentryService {
  SentryService._();

  static String? _dsn;
  static String _env = 'development';
  static String _release = 'unknown';
  static bool _initialised = false;

  static final _random = Random.secure();

  /// Initialise from environment variables. Safe to call multiple times.
  static void init({String? dsn, String? release}) {
    if (_initialised) return;
    _dsn = dsn ?? io.Platform.environment['SENTRY_DSN_SERVER'];
    _env = io.Platform.environment['APP_ENV'] ?? 'development';
    _release = release ?? io.Platform.environment['SENTRY_RELEASE'] ?? 'unknown';
    _initialised = true;

    final hasDsn = _dsn != null && _dsn!.trim().isNotEmpty;
    _writeLog({
      'severity': hasDsn ? 'INFO' : 'WARNING',
      'message': hasDsn
          ? '[SentryService] Sentry enabled for env=$_env release=$_release'
          : '[SentryService] SENTRY_DSN_SERVER not set; Sentry disabled.',
    });
  }

  // ── Public helpers ───────────────────────────────────────────────────────

  /// Capture an exception. Logs to stderr and forwards to Sentry if configured.
  ///
  /// [extras] must not contain OTPs, PINs, tokens, or full phone numbers.
  static Future<void> captureException(
    Object exception, {
    StackTrace? stackTrace,
    Session? session,
    Map<String, Object?>? extras,
  }) async {
    final authUserId = session?.authenticated?.authUserId.toString();
    _writeLog({
      'severity': 'ERROR',
      'message': exception.toString(),
      'user_id': ?authUserId,
      if (extras != null) ...extras,
      if (stackTrace != null) 'stack_trace': stackTrace.toString(),
      'environment': _env,
      'release': _release,
    });

    if (_dsn == null || _dsn!.trim().isEmpty) return;
    try {
      await _sendEnvelope(
        exception: exception,
        stackTrace: stackTrace,
        authUserId: authUserId,
        extras: extras,
      );
    } catch (e) {
      _writeLog({
        'severity': 'WARNING',
        'message': '[SentryService] Failed to send Sentry envelope: $e',
      });
    }
  }

  /// Log a structured INFO entry to stderr (Cloud Logging compatible).
  static void logInfo(String message, {Map<String, Object?>? context}) {
    _writeLog({'severity': 'INFO', 'message': message, ...?context});
  }

  /// Log a structured WARNING entry.
  static void logWarning(String message, {Map<String, Object?>? context}) {
    _writeLog({'severity': 'WARNING', 'message': message, ...?context});
  }

  // ── Internal ─────────────────────────────────────────────────────────────

  static void _writeLog(Map<String, Object?> entry) {
    // Each stderr line is one Cloud Logging entry when running in Cloud Run.
    io.stderr.writeln(jsonEncode(entry));
  }

  static Future<void> _sendEnvelope({
    required Object exception,
    StackTrace? stackTrace,
    String? authUserId,
    Map<String, Object?>? extras,
  }) async {
    final dsn = _dsn!;
    final eventId = _generateEventId();
    final now = DateTime.now().toUtc().toIso8601String();

    final envelopeHeader = jsonEncode({'event_id': eventId, 'sent_at': now});
    final itemHeader = jsonEncode({
      'type': 'event',
      'content_type': 'application/json',
    });
    final item = jsonEncode({
      'event_id': eventId,
      'timestamp': now,
      'platform': 'dart',
      'level': 'error',
      'release': _release,
      'environment': _env,
      'exception': {
        'values': [
          {
            'type': exception.runtimeType.toString(),
            'value': exception.toString(),
            if (stackTrace != null)
              'stacktrace': {
                'frames': stackTrace
                    .toString()
                    .split('\n')
                    .where((l) => l.trim().isNotEmpty)
                    .map((l) => {'function': l.trim()})
                    .toList()
                    .reversed
                    .toList(),
              },
          },
        ],
      },
      if (authUserId != null) 'user': {'id': authUserId},
      'extra': ?extras,
    });

    final body = '$envelopeHeader\n$itemHeader\n$item\n';
    final uri = _envelopeUri(dsn);
    final authHeader = _authHeader(dsn);

    final client = io.HttpClient()
      ..connectionTimeout = const Duration(seconds: 5);
    try {
      final request = await client
          .postUrl(uri)
          .timeout(const Duration(seconds: 5));
      request.headers
        ..set(
          io.HttpHeaders.contentTypeHeader,
          'application/x-sentry-envelope',
        )
        ..set('X-Sentry-Auth', authHeader);
      request.write(body);
      final response = await request.close().timeout(
        const Duration(seconds: 5),
      );
      await response.drain<void>();
    } finally {
      client.close(force: true);
    }
  }

  static Uri _envelopeUri(String dsn) {
    final uri = Uri.parse(dsn);
    final projectId = uri.pathSegments.last;
    return Uri.https(uri.host, '/api/$projectId/envelope/');
  }

  static String _authHeader(String dsn) {
    final uri = Uri.parse(dsn);
    final key = uri.userInfo.split(':').first;
    return 'Sentry sentry_version=7, sentry_client=bloodx-server/1.0, '
        'sentry_key=$key';
  }

  static String _generateEventId() {
    // 128-bit hex (32 chars) — valid Sentry event UUID without dashes.
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
