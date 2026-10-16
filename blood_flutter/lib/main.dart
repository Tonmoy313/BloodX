import 'package:blood_client/blood_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'core/localization/app_language.dart';
import 'core/theme/blood_theme.dart';
import 'features/splash/presentation/splash_screen.dart';

/// Global Serverpod client object.
late final Client client;
late String serverUrl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    serverUrl = await getServerUrl();
    client = Client(serverUrl)
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();

    client.auth.initialize();
  } catch (_) {
    // Graceful fallback during local preview or before backend launch
  }

  runApp(const BloodApp());
}

class BloodApp extends StatelessWidget {
  const BloodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppLanguage.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'BloodX',
          debugShowCheckedModeBanner: false,
          theme: BloodTheme.lightTheme,
          darkTheme: BloodTheme.darkTheme,
          themeMode: ThemeMode.system,
          locale: AppLanguage.instance.locale,
          home: const SplashScreen(),
        );
      },
    );
  }
}
