import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'core/localization/app_language.dart';
import 'core/network/serverpod_client.dart';
import 'core/router/app_routes.dart';
import 'core/session/app_session_startup.dart';
import 'core/theme/theme_controller.dart';
import 'features/splash/presentation/update_required_screen.dart';
import 'features/splash/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(_systemUiOverlayStyle(Brightness.light));

  serverUrl = await getServerUrl();
  initializeClient(serverUrl);

  final startup = await AppSessionStartup.initialize(
    serverUrl: serverUrl,
    client: client,
  );

  runApp(BloodApp(startup: startup));
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
