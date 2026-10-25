import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'core/localization/app_language.dart';
import 'core/monitoring/app_sentry_service.dart';
import 'core/network/serverpod_client.dart';
import 'core/router/app_routes.dart';
import 'core/session/app_session_startup.dart';
import 'core/theme/theme_controller.dart';
import 'features/splash/presentation/update_required_screen.dart';
import 'features/splash/presentation/splash_screen.dart';import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  const sentryDsn = String.fromEnvironment('SENTRY_DSN_APP');
  const appEnvironment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );
  const appRelease = String.fromEnvironment(
    'SENTRY_RELEASE',
    defaultValue: 'local',
  );

  await AppSentryService.init(
    dsn: sentryDsn.isEmpty ? null : sentryDsn,
    env: appEnvironment,
    release: appRelease,
    appRunner: () async {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        _systemUiOverlayStyle(Brightness.light),
      );

      serverUrl = await getServerUrl();
      initializeClient(serverUrl);

      final startup = await AppSessionStartup.initialize(
        serverUrl: serverUrl,
        client: client,
      );

      await SentryFlutter.init(
    (options) {
      options.dsn = 'https://5a0be9b864a5ea4ed98036e5cd3d97c5@o4512309581381632.ingest.us.sentry.io/4512309662515200';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(SentryWidget(child: BloodApp(startup: startup))),
  );
  // TODO: Remove this line after sending the first sample event to sentry.
  await Sentry.captureException(Exception('This is a sample exception.'));
    },
  );
}

class BloodApp extends StatelessWidget {
  const BloodApp({required this.startup, super.key});

  final AppSessionStartup startup;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        AppLanguage.instance,
        AppThemeController.instance,
      ]),
      builder: (context, _) {
        final themeController = AppThemeController.instance;

        return MaterialApp(
          title: 'BloodX',
          debugShowCheckedModeBanner: false,
          theme: themeController.lightTheme,
          darkTheme: themeController.darkTheme,
          themeMode: themeController.themeMode,
          locale: AppLanguage.instance.locale,
          builder: (context, child) {
            final systemUiStyle = _systemUiOverlayStyle(
              Theme.of(context).brightness,
            );

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemUiStyle,
              child: child ?? const SizedBox.shrink(),
            );
          },
          // Named route table — single source of truth
          home: startup.updateRequired
              ? const UpdateRequiredScreen()
              : const SplashScreen(),
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

/// Lets the app background show behind both system bars while keeping icons
/// legible for the active theme.
SystemUiOverlayStyle _systemUiOverlayStyle(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    systemNavigationBarIconBrightness: isDark
        ? Brightness.light
        : Brightness.dark,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarContrastEnforced: false,
  );
}
