import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod/protocol.dart' show AccessDeniedException;
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

typedef SendPhoneOtp =
    Future<void> Function(
      Session session, {
      required String phone,
      required String code,
    });

class PhoneOtpIdpConfig extends IdentityProviderBuilder<PhoneOtpIdp> {
  final SendPhoneOtp sendOtp;
  final String secretHashPepper;
  final String ipRateLimitHmacKey;
  final String Function() codeGenerator;
  final DateTime Function() clock;
  final Duration otpLifetime;
  final Duration resendDelay;
  final Duration rateLimitWindow;
  final int maxOtpAttempts;
  final int maxChallengesPerPhone;
  final int maxChallengesPerDevice;
  final int maxChallengesPerIp;
  final int maxPinAttempts;
  final Duration pinLockoutDuration;

  PhoneOtpIdpConfig({
    required this.sendOtp,
    required this.ipRateLimitHmacKey,
    String? secretHashPepper,
    this.codeGenerator = _generateOtp,
    this.clock = DateTime.now,
    this.otpLifetime = const Duration(minutes: 5),
    this.resendDelay = const Duration(seconds: 60),
    this.rateLimitWindow = const Duration(hours: 1),
    this.maxOtpAttempts = 5,
    this.maxChallengesPerPhone = 5,
    this.maxChallengesPerDevice = 10,
    this.maxChallengesPerIp = 20,
    this.maxPinAttempts = 5,
    this.pinLockoutDuration = const Duration(minutes: 15),
  }) : secretHashPepper =
           secretHashPepper ??
           Serverpod.instance.getPassword('emailSecretHashPepper') ??
           (throw StateError('Missing emailSecretHashPepper password.'));

  @override
  PhoneOtpIdp build({
    required TokenManager tokenManager,
    required AuthUsers authUsers,
    required UserProfiles userProfiles,
  }) {
    return PhoneOtpIdp(
      this,
      tokenManager: tokenManager,
      authUsers: authUsers,
    );
  }
}

class PhoneOtpIdp {
  static const String method = 'phone_otp';
  static const String _genericOtpError =
      'Invalid or expired verification code.';
  static const String _genericPinError = 'Invalid mobile number or PIN.';

  final PhoneOtpIdpConfig config;
  final TokenManager _tokenManager;
  final AuthUsers _authUsers;
  final Argon2HashUtil _hashUtil;

  late final Future<String> _dummyPinHash = _hashUtil.createHashFromString(
    secret: 'bloodx-invalid-pin-placeholder',
  );

  PhoneOtpIdp(
    this.config, {
    required TokenManager tokenManager,
    required AuthUsers authUsers,
  }) : _tokenManager = tokenManager,
       _authUsers = authUsers,
       _hashUtil = Argon2HashUtil(
         hashPepper: config.secretHashPepper,
         hashSaltLength: 16,
         parameters: Argon2HashParameters(memory: 19456),
       );
  
  Future<bool> hasAccount(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) return false;

    final user = await User.db.findFirstRow(
      session,
      where: (row) => row.authUserId.equals(authUserId),
    );
    return user != null &&
        user.status == UserStatus.active &&
        user.deletedAt == null;
  }

  Future<int> startLogin(
    Session session, {
    required String phone,
    required String installId,
    required OtpType type,
  }) async {
    final phoneE164 = normalizeBangladeshPhone(phone);
    final deviceId = _parseInstallId(installId);
    final ipHash = _hashClientIp(session);
    final now = config.clock().toUtc();

    final challenge = await DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        final lockKeys = [
          'phone:$phoneE164',
          'device:${deviceId.uuid}',
          'ip:$ipHash',
        ]..sort();
        for (final key in lockKeys) {
          await session.db.unsafeQuery(
            'SELECT pg_advisory_xact_lock(hashtext(@key))',
            transaction: transaction,
            parameters: QueryParameters.named({'key': key}),
          );
        }

        final phoneChallenges = await _recentChallenges(
          session,
          transaction: transaction,
          where: (row) => row.phoneE164.equals(phoneE164),
          limit: config.maxChallengesPerPhone,
          now: now,
        );
        if (phoneChallenges.isNotEmpty &&
            now.difference(phoneChallenges.first.createdAt.toUtc()) <
                config.resendDelay) {
          throw AccessDeniedException(
            message: 'Please wait before requesting another verification code.',
          );
        }
        if (phoneChallenges.length >= config.maxChallengesPerPhone) {
          throw AccessDeniedException(
            message: 'Too many verification code requests. Try again later.',
          );
        }

        final deviceChallenges = await _recentChallenges(
          session,
          transaction: transaction,
          where: (row) => row.installId.equals(deviceId),
          limit: config.maxChallengesPerDevice,
          now: now,
        );
        if (deviceChallenges.length >= config.maxChallengesPerDevice) {
          throw AccessDeniedException(
            message: 'Too many verification code requests. Try again later.',
          );
        }

        if (ipHash != _unavailableIpHash) {
          final ipChallenges = await _recentChallenges(
            session,
            transaction: transaction,
            where: (row) => row.ip.equals(ipHash),
            limit: config.maxChallengesPerIp,
            now: now,
          );
          if (ipChallenges.length >= config.maxChallengesPerIp) {
            throw AccessDeniedException(
              message: 'Too many verification code requests. Try again later.',
            );
          }
        }

        for (final previous in phoneChallenges) {
          if (previous.consumedAt == null && previous.expiresAt.isAfter(now)) {
            await OtpChallenge.db.updateRow(
              session,
              previous.copyWith(consumedAt: now),
              transaction: transaction,
            );
          }
        }

        final code = config.codeGenerator();
        if (!RegExp(r'^\d{6}$').hasMatch(code)) {
          throw StateError('The OTP generator must return six digits.');
        }
        final codeHash = await _hashUtil.createHashFromString(secret: code);
        final row = await OtpChallenge.db.insertRow(
          session,
          OtpChallenge(
            phoneE164: phoneE164,
            codeHash: codeHash,
            type: type,
            attempts: 0,
            installId: deviceId,
            ip: ipHash,
            createdAt: now,
            expiresAt: now.add(config.otpLifetime),
          ),
          transaction: transaction,
        );
        return (id: row.id!, phone: phoneE164, code: code);
      },
    );

    try {
      await config.sendOtp(
        session,
        phone: challenge.phone,
        code: challenge.code,
      );
    } on PhoneOtpDeliveryException {
      await _consumeChallenge(session, challenge.id);
      rethrow;
    }
    return challenge.id;
  }

  Future<AuthSuccess> finishLogin(
    Session session, {
    required int challengeId,
    required String code,
    required String installId,
  }) async {
    if (challengeId <= 0) {
      throw AccessDeniedException(message: _genericOtpError);
    }
    final deviceId = _parseInstallId(installId);
    final now = config.clock().toUtc();

    final authSuccess = await DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        final challenge = await OtpChallenge.db.findById(
          session,
          challengeId,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (challenge == null ||
            challenge.installId != deviceId ||
            challenge.consumedAt != null ||
            !challenge.expiresAt.isAfter(now) ||
            challenge.attempts >= config.maxOtpAttempts) {
          return null;
        }

        final codeMatches =
            RegExp(r'^\d{6}$').hasMatch(code) &&
            await _hashUtil.validateHashFromString(
              secret: code,
              hashString: challenge.codeHash,
            );
        if (!codeMatches) {
          final attempts = challenge.attempts + 1;
          await OtpChallenge.db.updateRow(
            session,
            challenge.copyWith(
              attempts: attempts,
              consumedAt: attempts >= config.maxOtpAttempts ? now : null,
            ),
            transaction: transaction,
          );
          return null;
        }

        await OtpChallenge.db.updateRow(
          session,
          challenge.copyWith(consumedAt: now),
          transaction: transaction,
        );

        var user = await User.db.findFirstRow(
          session,
          where: (row) => row.phoneE164.equals(challenge.phoneE164),
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (challenge.type == OtpType.newAccount &&
            user != null &&
            user.pinHash != null) {
          return null;
        }
        if (challenge.type != OtpType.newAccount && user == null) {
          return null;
        }
        if (user != null &&
            (user.status != UserStatus.active || user.deletedAt != null)) {
          return null;
        }

        if (user == null) {
          final authUser = await _authUsers.create(
            session,
            transaction: transaction,
          );
          user = await User.db.insertRow(
            session,
            User(
              phoneE164: challenge.phoneE164,
              displayName: '',
              authUserId: authUser.id,
              boundInstallId: deviceId,
              pinFailedAttempts: 0,
              createdAt: now,
              updatedAt: now,
            ),
            transaction: transaction,
          );
        } else if (user.authUserId == null) {
          final authUser = await _authUsers.create(
            session,
            transaction: transaction,
          );
          user = await User.db.updateRow(
            session,
            user.copyWith(
              authUserId: authUser.id,
              boundInstallId: deviceId,
              updatedAt: now,
            ),
            transaction: transaction,
          );
        } else if (user.boundInstallId != deviceId) {
          await _tokenManager.revokeAllTokens(
            session,
            authUserId: user.authUserId,
            transaction: transaction,
          );
          user = await User.db.updateRow(
            session,
            user.copyWith(
              boundInstallId: deviceId,
              pinFailedAttempts: 0,
              pinLockedUntil: null,
              updatedAt: now,
            ),
            transaction: transaction,
          );
        }

        final authUserId = user.authUserId;
        if (authUserId == null) {
          throw StateError('The phone account has no linked auth user.');
        }
        return _issueToken(
          session,
          authUserId: authUserId,
          transaction: transaction,
        );
      },
    );

    if (authSuccess == null) {
      throw AccessDeniedException(message: _genericOtpError);
    }
    return authSuccess;
  }

  Future<void> setPin(Session session, {required String pin}) async {
    if (!isValidPin(pin)) {
      throw AccessDeniedException(message: 'PIN must be five digits.');
    }
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw AccessDeniedException(message: 'Authentication is required.');
    }
    final now = config.clock().toUtc();
    final pinHash = await _hashUtil.createHashFromString(secret: pin);

    await DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        final user = await User.db.findFirstRow(
          session,
          where: (row) => row.authUserId.equals(authUserId),
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (user == null ||
            user.status != UserStatus.active ||
            user.deletedAt != null) {
          throw AccessDeniedException(message: 'Authentication is required.');
        }
        await User.db.updateRow(
          session,
          user.copyWith(
            pinHash: pinHash,
            pinSetAt: now,
            pinFailedAttempts: 0,
            pinLockedUntil: null,
            updatedAt: now,
          ),
          transaction: transaction,
        );
      },
    );
  }

  Future<AuthSuccess> loginWithPin(
    Session session, {
    required String phone,
    required String pin,
    required String installId,
  }) async {
    final phoneE164 = normalizeBangladeshPhone(phone);
    final deviceId = _parseInstallId(installId);
    if (!isValidPin(pin)) {
      throw AccessDeniedException(message: _genericPinError);
    }
    final now = config.clock().toUtc();

    final authSuccess = await DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        final user = await User.db.findFirstRow(
          session,
          where: (row) => row.phoneE164.equals(phoneE164),
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        final pinHash = user?.pinHash ?? await _dummyPinHash;
        final pinMatches = await _hashUtil.validateHashFromString(
          secret: pin,
          hashString: pinHash,
        );
        final isLocked =
            user?.pinLockedUntil != null && user!.pinLockedUntil!.isAfter(now);
        final deviceMatches = matchesInstallBinding(
          boundInstallId: user?.boundInstallId,
          presentedInstallId: deviceId,
        );

        if (user == null ||
            user.status != UserStatus.active ||
            user.deletedAt != null ||
            user.authUserId == null ||
            user.pinHash == null ||
            isLocked ||
            !deviceMatches ||
            !pinMatches) {
          if (user != null &&
              deviceMatches &&
              user.status == UserStatus.active &&
              user.deletedAt == null &&
              user.authUserId != null &&
              user.pinHash != null &&
              !isLocked) {
            final failedAttempts =
                user.pinLockedUntil != null &&
                    !user.pinLockedUntil!.isAfter(now)
                ? 1
                : user.pinFailedAttempts + 1;
            await User.db.updateRow(
              session,
              user.copyWith(
                pinFailedAttempts: failedAttempts >= config.maxPinAttempts
                    ? config.maxPinAttempts
                    : failedAttempts,
                pinLockedUntil: failedAttempts >= config.maxPinAttempts
                    ? now.add(config.pinLockoutDuration)
                    : null,
              ),
              transaction: transaction,
            );
          }
          return null;
        }

        await User.db.updateRow(
          session,
          user.copyWith(
            boundInstallId: deviceId,
            pinFailedAttempts: 0,
            pinLockedUntil: null,
            updatedAt: now,
          ),
          transaction: transaction,
        );
        return _issueToken(
          session,
          authUserId: user.authUserId!,
          transaction: transaction,
        );
      },
    );

    if (authSuccess == null) {
      throw AccessDeniedException(message: _genericPinError);
    }
    return authSuccess;
  }

  Future<AuthSuccess> _issueToken(
    Session session, {
    required UuidValue authUserId,
    required Transaction? transaction,
  }) async {
    final authUser = await _authUsers.get(
      session,
      authUserId: authUserId,
      transaction: transaction,
    );
    return _tokenManager.issueToken(
      session,
      authUserId: authUserId,
      method: method,
      scopes: authUser.scopes,
      transaction: transaction,
    );
  }

  Future<List<OtpChallenge>> _recentChallenges(
    Session session, {
    required Transaction transaction,
    required Expression Function(OtpChallengeTable) where,
    required int limit,
    required DateTime now,
  }) async {
    final rows = await OtpChallenge.db.find(
      session,
      where: where,
      orderBy: (row) => row.createdAt,
      orderDescending: true,
      limit: limit,
      transaction: transaction,
    );
    final cutoff = now.subtract(config.rateLimitWindow);
    return rows.where((row) => row.createdAt.isAfter(cutoff)).toList();
  }

  Future<void> _consumeChallenge(Session session, int challengeId) async {
    await DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        final challenge = await OtpChallenge.db.findById(
          session,
          challengeId,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (challenge == null || challenge.consumedAt != null) return;
        await OtpChallenge.db.updateRow(
          session,
          challenge.copyWith(consumedAt: config.clock().toUtc()),
          transaction: transaction,
        );
      },
    );
  }

  String _hashClientIp(Session session) {
    final remoteAddress = session.request?.connectionInfo.remote.address;
    if (remoteAddress == null) return _unavailableIpHash;
    final address = InternetAddress.tryParse(remoteAddress.toString());
    if (address == null) return _unavailableIpHash;
    return Hmac(
      sha256,
      config.ipRateLimitHmacKey.codeUnits,
    ).convert(address.address.codeUnits).toString();
  }

  static const _unavailableIpHash = 'unavailable';

  static UuidValue _parseInstallId(String value) {
    try {
      return UuidValue.withValidation(value);
    } on FormatException {
      throw AccessDeniedException(message: 'Invalid device identifier.');
    }
  }

  static String normalizeBangladeshPhone(String phone) {
    if (RegExp(r'^\+8801[3-9]\d{8}$').hasMatch(phone)) return phone;
    if (RegExp(r'^01[3-9]\d{8}$').hasMatch(phone)) return '+88$phone';
    if (RegExp(r'^1[3-9]\d{8}$').hasMatch(phone)) return '+880$phone';
    throw FormatException('Invalid Bangladesh phone number.');
  }

  static bool matchesInstallBinding({
    required UuidValue? boundInstallId,
    required UuidValue presentedInstallId,
  }) => boundInstallId == presentedInstallId;

  static bool isValidPin(String pin) =>
      RegExp(r'^\d{5}$').hasMatch(pin) && pin != '00000';

  static String maskPhone(String phoneE164) {
    if (phoneE164.length < 14) return '***';
    return '${phoneE164.substring(0, 6)}••• •••${phoneE164.substring(phoneE164.length - 2)}';
  }
}

class PhoneOtpDeliveryException implements Exception {
  const PhoneOtpDeliveryException();
}

extension PhoneOtpIdpGetter on AuthServices {
  PhoneOtpIdp get phoneOtpIdp =>
      AuthServices.getIdentityProvider<PhoneOtpIdp>();
}

String _generateOtp() =>
    Random.secure().nextInt(1000000).toString().padLeft(6, '0');
