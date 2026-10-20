import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blood_client/blood_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    show AuthSuccess;
import 'package:serverpod_flutter/serverpod_flutter.dart'
    show FlutterConnectivityMonitor;
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart'
    as auth_flutter;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as auth_core;
import '../../features/auth/controllers/auth_controller.dart';
import 'app_session_startup.dart';

class AuthSessionRevocationOutbox {
  AuthSessionRevocationOutbox._();

  static const _outboxKey = 'bloodx.auth.pending_revocations.v1';
  static const _isolatedSessionKey = 'bloodx.auth.pending_revoke_session.v1';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    mOptions: MacOsOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  static Future<void>? _pendingRetry;

  static Future<void> signOut(Client client) async {
    final auth = auth_core.ClientAuthSessionManagerExtension(client).auth;
    final authInfo = auth.authInfo;
    if (authInfo != null) {
      try {
        await _enqueue(authInfo);
      } on PlatformException catch (error) {
        debugPrint('Could not queue session revocation: ${error.code}');
      } on FormatException catch (error) {
        debugPrint('Could not queue session revocation: ${error.message}');
      }
    }

    try {
      if (authInfo != null) {
        final revoked = await auth.signOutDevice();
        if (revoked) await _removeQueued(authInfo);
      } else {
        await auth.updateSignedInUser(null);
      }
    } finally {
      await auth.storage.set(null);
      await auth.restore();
      await AuthController.instance.signOut();
      await AppSessionStartup.clearProfileCache();
    }
  }

  static Future<void> retryPending(String serverUrl) async {
    final pending = _pendingRetry;
    if (pending != null) {
      await pending;
      return;
    }

    final retry = _retryPending(serverUrl);
    _pendingRetry = retry;
    try {
      await retry;
    } on PlatformException catch (error) {
      debugPrint(
        'Pending logout retry could not read secure storage: ${error.code}',
      );
    } on FormatException catch (error) {
      debugPrint('Pending logout retry data is invalid: ${error.message}');
    } finally {
      _pendingRetry = null;
    }
  }

  static Future<void> clear() async {
    await _secureStorage.delete(key: _outboxKey);
    await _secureStorage.delete(key: _isolatedSessionKey);
  }

  static Future<void> _retryPending(String serverUrl) async {
    final encoded = await _secureStorage.read(key: _outboxKey);
    if (encoded == null) return;

    final List<dynamic> entries;
    try {
      final decoded = jsonDecode(encoded);
      if (decoded is! List<dynamic>) {
        throw const FormatException('Invalid session-revocation queue.');
      }
      entries = decoded;
    } on FormatException catch (error) {
      debugPrint('Discarding corrupted revocation queue: ${error.message}');
      await clear();
      return;
    }

    for (final entry in entries) {
      if (entry is! Map<String, dynamic>) {
        debugPrint('Discarding malformed session-revocation entry.');
        continue;
      }
      final AuthSuccess session;
      try {
        session = AuthSuccess.fromJson(entry);
      } on FormatException catch (error) {
        debugPrint('Discarding malformed session-revocation entry: $error');
        continue;
      } on TypeError {
        debugPrint('Discarding malformed session-revocation entry.');
        continue;
      }

      if (!await _revoke(serverUrl, session)) return;
      await _removeQueued(session);
    }
  }

  static Future<bool> _revoke(String serverUrl, AuthSuccess authInfo) async {
    final storage = auth_flutter.SecureClientAuthSuccessStorage(
      secureStorage: _secureStorage,
      authSuccessStorageKey: _isolatedSessionKey,
    );
    final client = Client(serverUrl)
      ..connectivityMonitor = FlutterConnectivityMonitor();
    auth_flutter.FlutterAuthSessionManagerExtension(
      client,
    ).authSessionManager = auth_flutter.FlutterAuthSessionManager(
      storage: storage,
    );

    try {
      await storage.set(authInfo);
      final auth = auth_core.ClientAuthSessionManagerExtension(client).auth;
      await auth.restore();
      return await auth.signOutDevice();
    } on ServerpodClientException catch (error) {
      debugPrint(
        'Session revocation will retry later (HTTP ${error.statusCode}).',
      );
      return false;
    } on SocketException {
      debugPrint('Session revocation will retry after network is restored.');
      return false;
    } on TimeoutException {
      debugPrint('Session revocation timed out and will retry later.');
      return false;
    } finally {
      await storage.set(null);
    }
  }

  static Future<void> _enqueue(AuthSuccess authInfo) async {
    final encoded = await _secureStorage.read(key: _outboxKey);
    final List<dynamic> entries;
    if (encoded == null) {
      entries = [];
    } else {
      final decoded = jsonDecode(encoded);
      if (decoded is! List<dynamic>) {
        throw const FormatException('Invalid session-revocation queue.');
      }
      entries = decoded;
    }

    final sessionJson = authInfo.toJson();
    final alreadyQueued = entries.any(
      (entry) =>
          entry is Map<String, dynamic> &&
          entry['refreshToken'] == sessionJson['refreshToken'],
    );
    if (!alreadyQueued) entries.add(sessionJson);
    await _secureStorage.write(key: _outboxKey, value: jsonEncode(entries));
  }

  static Future<void> _removeQueued(AuthSuccess authInfo) async {
    final encoded = await _secureStorage.read(key: _outboxKey);
    if (encoded == null) return;

    final decoded = jsonDecode(encoded);
    if (decoded is! List<dynamic>) {
      throw const FormatException('Invalid session-revocation queue.');
    }
    final refreshToken = authInfo.refreshToken;
    decoded.removeWhere(
      (entry) =>
          entry is Map<String, dynamic> &&
          entry['refreshToken'] == refreshToken,
    );
    if (decoded.isEmpty) {
      await _secureStorage.delete(key: _outboxKey);
    } else {
      await _secureStorage.write(key: _outboxKey, value: jsonEncode(decoded));
    }
  }
}
