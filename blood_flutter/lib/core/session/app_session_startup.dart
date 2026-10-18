import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:blood_client/blood_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localization/app_language.dart';
import '../../features/auth/controllers/auth_controller.dart';
import 'auth_session_revocation_outbox.dart';
import 'session_profile_validator.dart';

class AppSessionStartup {
  const AppSessionStartup({
    required this.updateRequired,
    required this.hasRestoredSession,
  });

  final bool updateRequired;
  final bool hasRestoredSession;

  static const _minimumVersionKey = 'app.minimum_version';
  static const _firstInstallKey = 'app.first_install_complete';
  static const _cachedUserIdKey = 'session.user_id';
  static const _cachedDonorStatusKey = 'session.is_donor';
  static const _languageKey = 'app.language';

  static Future<AppSessionStartup> initialize({
    required String serverUrl,
    required Client client,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();
    final minimumVersion = await _loadMinimumVersion(
      serverUrl,
      preferences,
    );

    if (!isVersionSupported(packageInfo.version, minimumVersion)) {
      return const AppSessionStartup(
        updateRequired: true,
        hasRestoredSession: false,
      );
    }

    final hasRestoredSession = await SessionRestorePolicy.restore(
      isFirstInstall: preferences.getBool(_firstInstallKey) != true,
      clear: () async {
        await _clearSavedAuthentication(client);
        await _clearProfileCache(preferences);
      },
      markInstallComplete: () async {
        await preferences.setBool(_firstInstallKey, true);
      },
      restore: () async {
        await client.auth.restore();
        final authInfo = client.auth.authInfo;
        if (authInfo == null) return false;
        if (authInfo.token.isEmpty || authInfo.refreshToken?.isEmpty != false) {
          await _clearSavedAuthentication(client);
          return false;
        }
        return true;
      },
    );

    unawaited(AuthSessionRevocationOutbox.retryPending(serverUrl));

    if (hasRestoredSession) {
      final userId = client.auth.authInfo!.authUserId.toString();
      final cachedUserId = preferences.getString(_cachedUserIdKey);
      final cacheMatchesSession = cachedUserId == userId;
      final language = preferences.getString(_languageKey);
      final locale = switch (language) {
        'en' => const Locale('en'),
        'bn' => const Locale('bn'),
        _ => null,
      };
      if (locale != null) {
        AppLanguage.instance.setLocale(locale);
      }
      AuthController.instance.restoreCachedSession(
        userId: userId,
        donorOptIn:
            cacheMatchesSession &&
            (preferences.getBool(_cachedDonorStatusKey) ?? false),
      );
    } else {
      await _clearProfileCache(preferences);
    }

    return AppSessionStartup(
      updateRequired: false,
      hasRestoredSession: hasRestoredSession,
    );
  }

  static Future<void> cacheProfile({
    required String userId,
    required bool donorOptIn,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_cachedUserIdKey, userId);
    await preferences.setBool(_cachedDonorStatusKey, donorOptIn);
  }

  static Future<void> clearProfileCache() async {
    final preferences = await SharedPreferences.getInstance();
    await _clearProfileCache(preferences);
  }

  static Future<void> _clearProfileCache(
    SharedPreferences preferences,
  ) async {
    await preferences.remove(_cachedUserIdKey);
    await preferences.remove(_cachedDonorStatusKey);
  }

  static Future<void> _clearSavedAuthentication(Client client) async {
    try {
      await client.auth.storage.set(null);
      await client.auth.restore();
    } on PlatformException catch (error) {
      debugPrint('Could not clear saved authentication: ${error.code}');
    }
  }

  static Future<String> _loadMinimumVersion(
    String serverUrl,
    SharedPreferences preferences,
  ) async {
    final cachedVersion = preferences.getString(_minimumVersionKey) ?? '1.0.0';
    final configUri = Uri.parse(
      serverUrl,
    ).resolve('/app/assets/assets/config.json');

    try {
      final response = await http
          .get(configUri)
          .timeout(const Duration(milliseconds: 800));
      if (response.statusCode != HttpStatus.ok) {
        throw HttpException(
          'Client config returned HTTP ${response.statusCode}.',
          uri: configUri,
        );
      }

      final config = jsonDecode(response.body);
      if (config is! Map<String, dynamic>) {
        throw const FormatException('Client config must be a JSON object.');
      }
      final version = config['minSupportedAppVersion'];
      if (version is! String || !_isValidVersion(version)) {
        throw const FormatException(
          'Client config has an invalid minimum app version.',
        );
      }

      await preferences.setString(_minimumVersionKey, version);
      return version;
    } on SocketException catch (error) {
      debugPrint('Client config unavailable; using cached policy: $error');
    } on TimeoutException {
      debugPrint('Client config timed out; using cached policy.');
    } on HttpException catch (error) {
      debugPrint('Client config unavailable; using cached policy: $error');
    } on FormatException catch (error) {
      debugPrint('Client config invalid; using cached policy: $error');
    }

    return cachedVersion;
  }

  static bool isVersionSupported(String installed, String minimum) {
    if (!_isValidVersion(installed) || !_isValidVersion(minimum)) return false;
    final installedParts = installed.split('.').map(int.parse).toList();
    final minimumParts = minimum.split('.').map(int.parse).toList();
    for (var index = 0; index < installedParts.length; index++) {
      if (installedParts[index] != minimumParts[index]) {
        return installedParts[index] > minimumParts[index];
      }
    }
    return true;
  }

  static bool _isValidVersion(String version) =>
      RegExp(r'^\d+\.\d+\.\d+$').hasMatch(version);

  static Future<void> persistLanguage(String language) async {
    if (language != 'bn' && language != 'en') {
      throw ArgumentError.value(language, 'language', 'Expected bn or en.');
    }
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_languageKey, language);
  }
}
