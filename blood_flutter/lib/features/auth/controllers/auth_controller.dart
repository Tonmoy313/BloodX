import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

import '../../../core/network/serverpod_client.dart';
import '../models/auth_state.dart';
import '../services/device_identity.dart';

/// Business logic controller for BloodX Authentication.
/// Aligns with spec/auth.md security rules:
/// - "validate all input; +880 only; mask phones; 5-digit PIN hashed at rest; lock login for 15 min after 5 wrong attempts; no secret logging".
class AuthController extends ChangeNotifier {
  static final AuthController instance = AuthController._();
  AuthController._();

  AuthState _state = const AuthState();
  Timer? _countdownTimer;

  AuthState get state => _state;

  void restoreCachedSession({
    required String userId,
    required bool donorOptIn,
  }) {
    _state = _state.copyWith(
      status: AuthStatus.authenticated,
      userId: userId,
      donorOptIn: donorOptIn,
    );
    notifyListeners();
  }

  void updateCachedProfile({required String userId, required bool donorOptIn}) {
    _state = _state.copyWith(userId: userId, donorOptIn: donorOptIn);
    notifyListeners();
  }

  /// Validates and normalizes Bangladesh phone number (+880 only).
  /// Valid prefixes: 013, 014, 015, 016, 017, 018, 019.
  static String? normalizeBangladeshPhone(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), '');

    if (digits.startsWith('880')) {
      digits = digits.substring(3);
    }

    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }

    if (digits.length != 10) return null;
    final prefix = digits.substring(0, 2);
    const validPrefixes = {'13', '14', '15', '16', '17', '18', '19'};
    if (!validPrefixes.contains(prefix)) return null;

    return '+880$digits';
  }

  /// Masks phone number for safe display (+880 17••• •••89).
  static String maskPhone(String e164Phone) {
    if (e164Phone.length < 13) return e164Phone;
    final prefix = e164Phone.substring(0, 6); // "+88017"
    final suffix = e164Phone.substring(e164Phone.length - 2); // last 2 digits
    return '$prefix••• •••$suffix';
  }

  /// Sets donor opt-in checkbox preference (D-015: unchecked by default).
  void setDonorOptIn(bool value) {
    _state = _state.copyWith(donorOptIn: value);
    notifyListeners();
  }

  /// Sets whether the current flow is Forgot PIN.
  void setForgotPinFlow(bool isForgot) {
    _state = _state.copyWith(isForgotPin: isForgot);
    notifyListeners();
  }

  /// Toggles/simulates app version support for S22 testing.
  void setAppVersionSupported(bool supported) {
    _state = _state.copyWith(appVersionSupported: supported);
    notifyListeners();
  }

  /// Requests OTP for the given phone number.
  Future<bool> requestOtp(String phoneInput, {bool isForgotPin = false}) async {
    final normalized = normalizeBangladeshPhone(phoneInput);
    if (normalized == null) {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage:
            'Invalid Bangladesh phone number. Enter 11 digits (e.g. 017XXXXXXXX).',
      );
      notifyListeners();
      return false;
    }

    _state = _state.copyWith(
      status: AuthStatus.sendingOtp,
      rawPhone: phoneInput,
      normalizedE164: normalized,
      maskedPhone: maskPhone(normalized),
      isForgotPin: isForgotPin,
      errorMessage: null,
    );
    notifyListeners();

    try {
      final installId = await DeviceIdentity.getInstallId();
      final challengeId = await client.authIdp.startLogin(
        phone: normalized,
        installId: installId,
        isForgotPin: isForgotPin,
      );
      _state = _state.copyWith(
        status: AuthStatus.otpSent,
        challengeId: challengeId,
        resendCountdown: 60,
      );
      _startCountdownTimer();
      notifyListeners();
      return true;
    } on ServerpodClientException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to send a verification code. Try again.',
      );
    } on TimeoutException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'The request timed out. Check your connection and retry.',
      );
    } on FormatException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to read this device identity. Try again.',
      );
    } on PlatformException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to access secure device storage. Try again.',
      );
    }
    notifyListeners();
    return false;
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.resendCountdown > 1) {
        _state = _state.copyWith(resendCountdown: _state.resendCountdown - 1);
        notifyListeners();
      } else {
        _state = _state.copyWith(resendCountdown: 0);
        timer.cancel();
        notifyListeners();
      }
    });
  }

  /// Resends OTP if cooldown timer has elapsed.
  Future<bool> resendOtp() async {
    if (_state.resendCountdown > 0) return false;
    return requestOtp(_state.rawPhone, isForgotPin: _state.isForgotPin);
  }

  /// Verifies 6-digit OTP code (S4 -> S5).
  Future<bool> verifyOtp(String code) async {
    if (!RegExp(r'^\d{6}$').hasMatch(code)) {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Please enter a 6-digit verification code.',
      );
      notifyListeners();
      return false;
    }

    _state = _state.copyWith(
      status: AuthStatus.verifyingOtp,
      errorMessage: null,
    );
    notifyListeners();

    final challengeId = _state.challengeId;
    if (challengeId == null) {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Request a new verification code and try again.',
      );
      notifyListeners();
      return false;
    }
    try {
      final installId = await DeviceIdentity.getInstallId();
      final authSuccess = await client.authIdp.finishLogin(
        challengeId: challengeId,
        code: code,
        installId: installId,
      );
      await FlutterAuthSessionManagerExtension(
        client,
      ).authSessionManager.updateSignedInUser(authSuccess);
      _state = _state.copyWith(
        status: AuthStatus.pinSetupRequired,
        isNewUser: !_state.isForgotPin,
        errorMessage: null,
      );
      _countdownTimer?.cancel();
      notifyListeners();
      return true;
    } on ServerpodClientException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Invalid or expired verification code.',
      );
    } on TimeoutException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'The request timed out. Check your connection and retry.',
      );
    } on FormatException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to read this device identity. Try again.',
      );
    } on PlatformException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to access secure device storage. Try again.',
      );
    }
    notifyListeners();
    return false;
  }

  /// Sets up a 5-digit PIN (S5 per spec/auth.md).
  Future<bool> setupPin(String pin) async {
    if (pin.length != 5 || !RegExp(r'^\d{5}$').hasMatch(pin)) {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'PIN must be exactly 5 digits.',
      );
      notifyListeners();
      return false;
    }

    if (pin == '00000') {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Insecure PIN (00000) is rejected.',
      );
      notifyListeners();
      return false;
    }

    try {
      await client.auth.setPin(pin: pin);
      await FlutterAuthSessionManagerExtension(
        client,
      ).authSessionManager.updateSignedInUser(null);
      _state = _state.copyWith(
        status: AuthStatus.unauthenticated,
        isForgotPin: false,
        errorMessage: null,
      );
      notifyListeners();
      return true;
    } on ServerpodClientException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to save your PIN. Try again.',
      );
    } on TimeoutException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'The request timed out. Check your connection and retry.',
      );
    } on PlatformException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to access secure session storage. Try again.',
      );
    }
    notifyListeners();
    return false;
  }

  /// Authenticates using Phone + 5-digit PIN (S6 Login).
  /// Enforces lockout for 15 minutes after 5 consecutive failed attempts.
  Future<bool> loginWithPin(String phoneInput, String pin) async {
    // Check lockout
    if (_state.isLockedOut) {
      _state = _state.copyWith(
        status: AuthStatus.lockedOut,
        errorMessage:
            'Too many failed attempts. Locked for ${_state.remainingLockoutMinutes} minutes.',
      );
      notifyListeners();
      return false;
    }

    final normalized = normalizeBangladeshPhone(phoneInput);
    if (normalized == null) {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Invalid Bangladesh phone number.',
      );
      notifyListeners();
      return false;
    }

    if (!RegExp(r'^\d{5}$').hasMatch(pin) || pin == '00000') {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'PIN must be 5 digits.',
      );
      notifyListeners();
      return false;
    }

    _state = _state.copyWith(
      status: AuthStatus.authenticatingPin,
      rawPhone: phoneInput,
      normalizedE164: normalized,
      maskedPhone: maskPhone(normalized),
      errorMessage: null,
    );
    notifyListeners();

    try {
      final installId = await DeviceIdentity.getInstallId();
      final authSuccess = await client.auth.loginWithPin(
        phone: normalized,
        pin: pin,
        installId: installId,
      );
      await FlutterAuthSessionManagerExtension(
        client,
      ).authSessionManager.updateSignedInUser(authSuccess);
      _state = _state.copyWith(
        status: AuthStatus.authenticated,
        failedPinAttempts: 0,
        lockoutUntil: null,
        isNewUser: false,
        errorMessage: null,
      );
      notifyListeners();
      return true;
    } on ServerpodClientException {
      _state = _state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Invalid mobile number or PIN.',
      );
    } on TimeoutException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'The request timed out. Check your connection and retry.',
      );
    } on FormatException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to read this device identity. Try again.',
      );
    } on PlatformException {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Unable to access secure device storage. Try again.',
      );
    }
    notifyListeners();
    return false;
  }

  /// Legacy / Quick profile completion for tests.
  Future<void> completeProfile({
    required String name,
    required String bloodGroup,
    required String area,
    required bool isDonor,
  }) async {
    _state = _state.copyWith(
      displayName: name.trim(),
      bloodGroup: bloodGroup,
      area: area,
      donorOptIn: isDonor,
      isNewUser: false,
    );
    notifyListeners();
  }

  /// Saves donor health details (S8 -> becomeDonor).
  Future<void> saveDonorHealthDetails({
    required String bloodGroup,
    required String area,
    required String locationCoordinates,
    required List<String> preferredHospitals,
  }) async {
    _state = _state.copyWith(
      bloodGroup: bloodGroup,
      area: area,
      locationCoordinates: locationCoordinates,
      preferredHospitals: preferredHospitals,
      donorOptIn: true,
      donorProfileComplete: true,
      status: AuthStatus.authenticated,
    );
    notifyListeners();
  }

  /// Permanently deletes account (D4: requires typed "DELETE").
  Future<bool> deleteAccount(String confirmText) async {
    if (confirmText.trim() != 'DELETE') {
      return false;
    }

    _countdownTimer?.cancel();
    _state = const AuthState(
      status: AuthStatus.unauthenticated,
      donorOptIn: false,
    );
    notifyListeners();
    return true;
  }

  /// Signs out current session per spec: "app -> s6 (logout)".
  Future<void> signOut() async {
    _countdownTimer?.cancel();
    await FlutterAuthSessionManagerExtension(
      client,
    ).authSessionManager.updateSignedInUser(null);
    _state = const AuthState();
    notifyListeners();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}
