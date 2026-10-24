import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:math' as math;

import 'package:sentry/sentry.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cloud_storage_s3/serverpod_cloud_storage_s3.dart';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/auth/phone_otp_idp.dart';
import 'src/monitoring/sentry_service.dart';
import 'src/storage/r2_signed_url_service.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/health_route.dart';
import 'src/web/routes/root.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  SentryService.init(); // P0-11: initialise before anything else
  SentryService.logInfo('Starting BloodX server...');
  SentryService.logInfo(
    'OTP mode: ${io.Platform.environment['SKIP_TWILIO'] == 'true' ? 'development' : 'production'}',
  );
  SentryService.logInfo(
    'runMode: ${io.Platform.environment['RUN_MODE'] ?? 'development'}',
  );
  await Sentry.init(
    (options) {
      options.dsn =io.Platform.environment["SENTRY_DSN_SERVER"]; // Or read from your server .env file
      options.tracesSampleRate = 1.0;
    },);
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());
  final useDevelopmentOtp =
      pod.config.runMode == 'development' &&
      io.Platform.environment['SKIP_TWILIO'] == 'true';

  // P0-5: Register private R2 buckets for staging and production.
  // Both buckets are private; clients receive short-lived signed URLs only.
  final runMode = pod.config.runMode;
  if (runMode == 'staging' || runMode == 'production') {
    _validateR2OrLog(); // fail fast if secrets are missing
    final accountId = io.Platform.environment['R2_ACCOUNT_ID'] ?? '';
    final endpoint = 'https://$accountId.r2.cloudflarestorage.com';

    
    pod.addCloudStorage(  
      S3CloudStorage(
        serverpod: pod,
        storageId: R2SignedUrlService.storageIdSlips,
        public: false,
        bucket: io.Platform.environment['R2_BUCKET_SLIPS'] ?? '',
        region: 'auto',
      ),
    );

    pod.addCloudStorage(
      S3CloudStorage(
        serverpod: pod,
        storageId: R2SignedUrlService.storageIdGenerated,
        public: false,
        bucket: io.Platform.environment['R2_BUCKET_GENERATED'] ?? '',
        region: 'auto',
         // Handle endpoint via CustomEndpointConfig from serverpod_cloud_storage_s3_compat
        ),
    );
    SentryService.logInfo('R2 private buckets registered.');
  }
  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ), 
      
      // Configure the phone OTP identity provider for phone number authentication.
      PhoneOtpIdpConfig(
        sendOtp: _sendOtp,
        codeGenerator: useDevelopmentOtp ? () => '000000' : _generateOtp,
        ipRateLimitHmacKey: _requiredSecret(
          'OTP_IP_RATE_LIMIT_HMAC_KEY',
          devFallback: pod.config.runMode == 'development'
              ? 'dev-only-key-do-not-use-in-prod'
              : null,
        ),
      ),
    ],
  );

  // P0-4: /health liveness probe — cheap, no DB I/O.
  pod.webServer.addRoute(HealthRoute(), '/health');

  // Setup a default page at the web root.
  // These are used by the default page.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  // Serve all files in the web/static relative directory under /.
  // These are used by the default web page.
  final root = io.Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(
      apiConfig: pod.config.apiServer,
      minSupportedAppVersion:
          io.Platform.environment['MIN_SUPPORTED_APP_VERSION'] ?? '1.0.0',
    ),
    '/app/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = io.Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under the /app path.
    pod.webServer.addRoute(
      FlutterRoute(
        io.Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    pod.webServer.addRoute(
      StaticRoute.file(
        io.File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  // Start the server.
  await pod.start();
}

Future<void> _sendOtp(
  Session session, {
  required String phone,
  required String code,
}) async {
  if (io.Platform.environment['SKIP_TWILIO'] == 'true' &&
      Serverpod.instance.config.runMode == 'development') {
    session.log(
      '[PhoneOtpIdp] Development SMS bypass for ${PhoneOtpIdp.maskPhone(phone)}; use the development test code.',
      level: LogLevel.info,
    );
    return;
  }

  final accountSid = io.Platform.environment['TWILIO_ACCOUNT_SID'];
  final authToken = io.Platform.environment['TWILIO_AUTH_TOKEN'];
  final fromNumber = io.Platform.environment['TWILIO_FROM_NUMBER'];
  if (accountSid == null ||
      accountSid.trim().isEmpty ||
      authToken == null ||
      authToken.trim().isEmpty ||
      fromNumber == null ||
      !RegExp(r'^AC[0-9a-fA-F]{32}$').hasMatch(accountSid) ||
      !RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(fromNumber) ||
      !RegExp(r'^\d{6}$').hasMatch(code)) {
    session.log(
      '[PhoneOtpIdp] Twilio configuration or generated OTP is invalid.',
      level: LogLevel.error,
    );
    throw const PhoneOtpDeliveryException();
  }

  final httpClient = io.HttpClient()
    ..connectionTimeout = const Duration(seconds: 10);
  try {
    final uri = Uri.https(
      'api.twilio.com',
      '/2010-04-01/Accounts/$accountSid/Messages.json',
    );
    final request = await httpClient
        .postUrl(uri)
        .timeout(
          const Duration(seconds: 10),
        );
    request.headers
      ..set(
        io.HttpHeaders.authorizationHeader,
        'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
      )
      ..contentType = io.ContentType(
        'application',
        'x-www-form-urlencoded',
      );
    request.write(
      Uri(
        queryParameters: {
          'To': phone,
          'From': fromNumber,
          'Body': 'BloodX verification code: $code. Expires in 5 minutes.',
        },
      ).query,
    );
    final response = await request.close().timeout(
      const Duration(seconds: 10),
    );
    await response.drain<void>();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      session.log(
        '[PhoneOtpIdp] Twilio rejected SMS delivery (HTTP ${response.statusCode}) for ${PhoneOtpIdp.maskPhone(phone)}.',
        level: LogLevel.error,
      );
      throw const PhoneOtpDeliveryException();
    }
  } on io.SocketException {
    session.log(
      '[PhoneOtpIdp] Twilio SMS delivery failed due to a network error.',
      level: LogLevel.error,
    );
    throw const PhoneOtpDeliveryException();
  } on io.HttpException {
    session.log(
      '[PhoneOtpIdp] Twilio SMS delivery failed due to an HTTP client error.',
      level: LogLevel.error,
    );
    throw const PhoneOtpDeliveryException();
  } on TimeoutException {
    session.log(
      '[PhoneOtpIdp] Twilio SMS delivery timed out.',
      level: LogLevel.error,
    );
    throw const PhoneOtpDeliveryException();
  } finally {
    httpClient.close(force: true);
  }
}

String _requiredSecret(String name, {String? devFallback}) {
  final value = io.Platform.environment[name];
  if (value != null && value.trim().isNotEmpty) return value;
  if (devFallback != null) return devFallback;
  throw StateError(
    'Required secret-backed environment variable $name is missing.',
  );
}


/// Validate R2 environment variables. Logs a warning on missing vars instead
/// of throwing, so the server still starts; storage calls fail at request time
/// with a clear error rather than crashing on startup.
void _validateR2OrLog() {
  const required = [
    'R2_ACCOUNT_ID',
    'R2_ACCESS_KEY_ID',
    'R2_SECRET_ACCESS_KEY',
    'R2_BUCKET_SLIPS',
    'R2_BUCKET_GENERATED',
  ];
  final missing = required
      .where(
        (k) =>
            io.Platform.environment[k] == null ||
            io.Platform.environment[k]!.trim().isEmpty,
      )
      .toList();
  if (missing.isNotEmpty) {
    SentryService.logWarning(
      'Missing R2 environment variables: ${missing.join(', ')}. '
      'Signed-URL requests will fail until they are injected from Secret Manager.',
    );
  }
}

String _generateOtp() =>
    math.Random.secure().nextInt(1000000).toString().padLeft(6, '0');


void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log(
    '[EmailIdp] Registration email delivery is not configured.',
    level: LogLevel.error,
  );
  throw StateError('Email verification delivery is not configured.');
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log(
    '[EmailIdp] Password reset email delivery is not configured.',
    level: LogLevel.error,
  );
  throw StateError('Email verification delivery is not configured.');
}
