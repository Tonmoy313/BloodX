import 'dart:async';
import 'dart:io';

import 'package:blood_flutter/core/session/app_session_startup.dart';
import 'package:blood_flutter/core/session/session_profile_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_client/serverpod_client.dart';

void main() {
  group('SessionProfileValidator', () {
    test('keeps the session when the network is unavailable', () async {
      var discarded = false;
      final validator = SessionProfileValidator(
        getProfile: () async => throw const SocketException('offline'),
        discardSession: () async => discarded = true,
      );

      expect(
        await validator.validate(),
        SessionValidationResult.unavailable,
      );
      expect(discarded, isFalse);
    });

    test('reports blocked profiles without discarding the session', () async {
      var discarded = false;
      final validator = SessionProfileValidator(
        getProfile: () async => const SessionProfileSnapshot(
          userId: 'user-1',
          isBlocked: true,
          isDonor: false,
        ),
        discardSession: () async => discarded = true,
      );

      expect(await validator.validate(), SessionValidationResult.blocked);
      expect(discarded, isFalse);
    });

    test('coalesces parallel profile validation into one request', () async {
      var requests = 0;
      final response = Completer<SessionProfileSnapshot>();
      final validator = SessionProfileValidator(
        getProfile: () {
          requests++;
          return response.future;
        },
        discardSession: () async {},
      );

      final validations = List.generate(8, (_) => validator.validate());
      response.complete(
        const SessionProfileSnapshot(
          userId: 'user-1',
          isBlocked: false,
          isDonor: true,
        ),
      );

      expect(
        await Future.wait(validations),
        everyElement(SessionValidationResult.authenticated),
      );
      expect(requests, 1);
    });
  });

  group('SessionRestorePolicy', () {
    test('does not restore tokens on first install', () async {
      var cleared = 0;
      var restored = false;
      var installMarked = false;

      final result = await SessionRestorePolicy.restore(
        isFirstInstall: true,
        clear: () async => cleared++,
        markInstallComplete: () async => installMarked = true,
        restore: () async {
          restored = true;
          return true;
        },
      );

      expect(result, isFalse);
      expect(cleared, 1);
      expect(installMarked, isTrue);
      expect(restored, isFalse);
    });

    test('treats corrupted secure storage as signed out', () async {
      var cleared = 0;

      final result = await SessionRestorePolicy.restore(
        isFirstInstall: false,
        clear: () async => cleared++,
        markInstallComplete: () async {},
        restore: () async => throw const FormatException('corrupt'),
      );

      expect(result, isFalse);
      expect(cleared, 1);
    });
  });

  test('allows equal and newer app versions only', () {
    expect(AppSessionStartup.isVersionSupported('1.2.3', '1.2.3'), isTrue);
    expect(AppSessionStartup.isVersionSupported('1.3.0', '1.2.3'), isTrue);
    expect(AppSessionStartup.isVersionSupported('1.2.2', '1.2.3'), isFalse);
    expect(AppSessionStartup.isVersionSupported('invalid', '1.2.3'), isFalse);
  });

  test('parallel requests refresh an expired access token once', () async {
    final delegate = _DelayedRefreshProvider();
    final provider = MutexRefresherClientAuthKeyProvider(delegate);

    final authHeaders = await Future.wait(
      List.generate(8, (_) => provider.authHeaderValue),
    );

    expect(delegate.refreshCalls, 1);
    expect(authHeaders, everyElement('Bearer fresh-token'));
  });
}

class _DelayedRefreshProvider implements RefresherClientAuthKeyProvider {
  var refreshCalls = 0;
  var _isExpired = true;
  var _authHeader = 'Bearer expired-token';

  @override
  Future<String?> get authHeaderValue async => _authHeader;

  @override
  Future<RefreshAuthKeyResult> refreshAuthKey({bool force = false}) async {
    if (!_isExpired && !force) return RefreshAuthKeyResult.skipped;

    refreshCalls++;
    await Future<void>.delayed(const Duration(milliseconds: 10));
    _isExpired = false;
    _authHeader = 'Bearer fresh-token';
    return RefreshAuthKeyResult.success;
  }
}
