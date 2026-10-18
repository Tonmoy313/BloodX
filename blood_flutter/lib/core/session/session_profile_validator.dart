import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:serverpod_client/serverpod_client.dart';

class SessionProfileSnapshot {
  const SessionProfileSnapshot({
    required this.userId,
    required this.isBlocked,
    required this.isDonor,
  });

  final String userId;
  final bool isBlocked;
  final bool isDonor;
}

enum SessionValidationResult {
  authenticated,
  blocked,
  signedOut,
  unavailable,
}

class SessionProfileValidator {
  SessionProfileValidator({
    required Future<SessionProfileSnapshot> Function() getProfile,
    required Future<void> Function() discardSession,
  }) : _getProfile = getProfile,
       _discardSession = discardSession;

  final Future<SessionProfileSnapshot> Function() _getProfile;
  final Future<void> Function() _discardSession;
  Future<SessionValidationResult>? _pendingValidation;

  Future<SessionValidationResult> validate() {
    return _pendingValidation ??= _validate().whenComplete(() {
      _pendingValidation = null;
    });
  }

  Future<SessionValidationResult> _validate() async {
    try {
      final profile = await _getProfile();
      return profile.isBlocked
          ? SessionValidationResult.blocked
          : SessionValidationResult.authenticated;
    } on ServerpodClientException catch (error) {
      if (error.statusCode == 401) {
        await _discardSession();
        return SessionValidationResult.signedOut;
      }
      if (error.statusCode == 403) return SessionValidationResult.blocked;
      return SessionValidationResult.unavailable;
    } on SocketException {
      return SessionValidationResult.unavailable;
    } on TimeoutException {
      return SessionValidationResult.unavailable;
    } on PlatformException catch (error) {
      debugPrint('Session validation storage error: ${error.code}');
      return SessionValidationResult.unavailable;
    }
  }
}

class SessionRestorePolicy {
  const SessionRestorePolicy._();

  static Future<bool> restore({
    required bool isFirstInstall,
    required Future<void> Function() clear,
    required Future<void> Function() markInstallComplete,
    required Future<bool> Function() restore,
  }) async {
    if (isFirstInstall) {
      await _clearSafely(clear);
      await markInstallComplete();
      return false;
    }

    try {
      return await restore();
    } on FormatException {
      await _clearSafely(clear);
    } on TypeError {
      await _clearSafely(clear);
    } on PlatformException {
      await _clearSafely(clear);
    }
    return false;
  }

  static Future<void> _clearSafely(Future<void> Function() clear) async {
    try {
      await clear();
    } on FormatException {
      debugPrint('Corrupted session storage could not be fully cleared.');
    } on TypeError {
      debugPrint('Malformed session storage could not be fully cleared.');
    } on PlatformException catch (error) {
      debugPrint('Session storage could not be cleared: ${error.code}');
    }
  }
}
