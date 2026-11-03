import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:sentry/sentry.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cloud_storage_s3_compat/serverpod_cloud_storage_s3_compat.dart';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/auth/phone_otp_idp.dart';
import 'src/database/partial_index_schema.dart';
import 'src/monitoring/sentry_service.dart';
import 'src/storage/r2_signed_url_service.dart';
import 'src/storage/hybrid_cloud_storage.dart';
import 'src/storage/storage_sync_worker.dart';
import 'src/seed/database_seeder.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/health_route.dart';
import 'src/web/routes/root.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  final dotEnv = dotenv.DotEnv(includePlatformEnvironment: true);
  if (io.File('.env').existsSync()) {
    dotEnv.load(['.env']);
  }

  SentryService.logInfo('Starting BloodX server...');
  final skipSentry = dotEnv['SKIP_SENTRY'] == 'true';
  final skipR2 = dotEnv['SKIP_R2'] == 'true';
  SentryService.logInfo('SKIP_SENTRY=$skipSentry, SKIP_R2=$skipR2');
  if (!skipSentry) {
    await Sentry.init(
      (options) {
        options.dsn = dotEnv['SENTRY_DSN_SERVER'];
        options.tracesSampleRate = 1.0;
      },
    );
  }

  // Initialize Serverpod and connect it with your generated code.
  configurePartialIndexPredicates();
  final pod = Serverpod(args, Protocol(), Endpoints());
  SentryService.logInfo('runMode: ${pod.config.runMode}');
  SentryService.logInfo(
    pod.config.runMode == 'development'
        ? 'OTP delivery: development codes are printed to this terminal.'
        : 'OTP delivery: SMS provider.',
  );

  // Register cloud storage where credentials are configured. The hybrid
  // adapter always receives uploads through Serverpod so a cloud failure can
  // be caught and written to local disk.
  final runMode = pod.config.runMode;
  final isProductionMode = runMode == 'staging' || runMode == 'production';
  if (skipR2 && isProductionMode) {
    throw StateError('SKIP_R2 is only supported in development.');
  }
  final hasR2Credentials = [
    'R2_ACCOUNT_ID',
    'R2_ACCESS_KEY_ID',
    'R2_SECRET_ACCESS_KEY',
    'R2_BUCKET_SLIPS',
    'R2_BUCKET_GENERATED',
  ].every((name) => dotEnv[name]?.trim().isNotEmpty == true);
  CloudStorage? cloudSlips;
  CloudStorage? cloudGenerated;
  if (!skipR2 && hasR2Credentials) {
    final endpoint = CustomEndpointConfig(
      baseUri: Uri.parse(
        'https://${dotEnv['R2_ACCOUNT_ID']}.r2.cloudflarestorage.com',
      ),
      serviceName: 'Cloudflare R2',
    );
    cloudSlips = _createR2Storage(
      storageId: R2SignedUrlService.storageIdSlips,
      bucket: dotEnv['R2_BUCKET_SLIPS']!,
      accessKey: dotEnv['R2_ACCESS_KEY_ID']!,
      secretKey: dotEnv['R2_SECRET_ACCESS_KEY']!,
      endpoint: endpoint,
    );
    cloudGenerated = _createR2Storage(
      storageId: R2SignedUrlService.storageIdGenerated,
      bucket: dotEnv['R2_BUCKET_GENERATED']!,
      accessKey: dotEnv['R2_ACCESS_KEY_ID']!,
      secretKey: dotEnv['R2_SECRET_ACCESS_KEY']!,
      endpoint: endpoint,
    );
  } else if (!skipR2 && isProductionMode) {
    throw StateError('R2 credentials are missing in $runMode mode.');
  }

  final localStoragePath = io.Directory('storage_uploads').absolute;
  await localStoragePath.create(recursive: true);
  final hybridStorages = [
    HybridCloudStorage(
      storageId: R2SignedUrlService.storageIdSlips,
      localRoot: localStoragePath,
      cloud: cloudSlips,
    ),
    HybridCloudStorage(
      storageId: R2SignedUrlService.storageIdGenerated,
      localRoot: localStoragePath,
      cloud: cloudGenerated,
    ),
  ];
  for (final storage in hybridStorages) {
    pod.addCloudStorage(storage);
  }
  if (cloudSlips != null || cloudGenerated != null) {
    SentryService.logInfo('Hybrid cloud and local file storage registered.');
  } else {
    SentryService.logInfo(
      'Local file storage registered at ${localStoragePath.path}; '
      'cloud credentials are not configured.',
    );
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
      minSupportedAppVersion: dotEnv['MIN_SUPPORTED_APP_VERSION'] ?? '1.0.0',
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

  final seedSession = await pod.createSession();
  try {
    await DatabaseSeeder.seedAll(seedSession);
  } catch (error, stack) {
    seedSession.log(
      '[DatabaseSeeder] Seeding error: $error',
      level: LogLevel.warning,
      exception: error,
      stackTrace: stack,
    );
  } finally {
    await seedSession.close();
  }

  StorageSyncWorker(serverpod: pod, storages: hybridStorages).start();
}

S3CompatCloudStorage _createR2Storage({
  required String storageId,
  required String bucket,
  required String accessKey,
  required String secretKey,
  required CustomEndpointConfig endpoint,
}) {
  return S3CompatCloudStorage(
    storageId: storageId,
    accessKey: accessKey,
    secretKey: secretKey,
    bucket: bucket,
    region: 'auto',
    public: false,
    endpoints: endpoint,
    uploadStrategy: PresignedPutUploadStrategy(),
  );
}

Future<void> _sendOtp(
  Session session, {
  required String phone,
  required String code,
}) async {
  final dotEnv = dotenv.DotEnv(includePlatformEnvironment: true);

  if (Serverpod.instance.config.runMode == 'development') {
    io.stdout.writeln(
      '[DEV ONLY] OTP for ${PhoneOtpIdp.maskPhone(phone)}: $code',
    );
    return;
  }
  if (Serverpod.instance.config.runMode == 'test') return;
  if (!{'staging', 'production'}.contains(
    Serverpod.instance.config.runMode,
  )) {
    throw StateError(
      'OTP delivery is not configured for '
      '${Serverpod.instance.config.runMode} mode.',
    );
  }

  final accountSid = dotEnv['TWILIO_ACCOUNT_SID'];
  final authToken = dotEnv['TWILIO_AUTH_TOKEN'];
  final fromNumber = dotEnv['TWILIO_FROM_NUMBER'];
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

Future<void> initFirebase() async {
  final path = io.Platform.environment['FCM_SERVICE_ACCOUNT_JSON_PATH'];
  if (path == null || path.isEmpty) {
    throw StateError('FCM_SERVICE_ACCOUNT_JSON_PATH is not set');
  }

  final file = io.File(path);
  if (!await file.exists()) {
    throw StateError('FCM service account file not found at $path');
  }

  final raw = await file.readAsString();
  if (jsonDecode(raw) is! Map<String, dynamic>) {
    throw const FormatException('FCM service account JSON must be an object.');
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
