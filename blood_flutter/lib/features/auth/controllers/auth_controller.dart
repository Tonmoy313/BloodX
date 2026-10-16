import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/auth_state.dart';

/// Business logic controller for BloodX Authentication.
/// Follows principle: "no logic in widgets; validate all input; +880 only; mask phones".
class AuthController extends ChangeNotifier {
  static final AuthController instance = AuthController._();
  AuthController._();

  AuthState _state = const AuthState();
  Timer? _countdownTimer;

  AuthState get state => _state;

  /// Validates and normalizes Bangladesh phone number (+880 only).
  /// Valid prefixes: 013, 014, 015, 016, 017, 018, 019.
  static String? normalizeBangladeshPhone(String input) {
    // Strip all non-digit characters
    String digits = input.replaceAll(RegExp(r'\D'), '');

    // If starts with 880, strip it to check the 10-digit base
    if (digits.startsWith('880')) {
      digits = digits.substring(3);
    }

    // Strip leading 0 if present
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }

    // Must now be exactly 10 digits starting with 13-19
    if (digits.length != 10) return null;
    final prefix = digits.substring(0, 2);
    const validPrefixes = {'13', '14', '15', '16', '17', '18', '19'};
    if (!validPrefixes.contains(prefix)) return null;

    return '+880$digits';
  }

  /// Masks phone number for safe display (+880 17••• •••89).
  static String maskPhone(String e164Phone) {
    if (e164Phone.length < 13) return e164Phone;
    final prefix = e164Phone.substring(0, 7); // "+880 17"
    final suffix = e164Phone.substring(e164Phone.length - 2); // last 2 digits
    return '$prefix••• •••$suffix';
  }

  /// Sets donor opt-in checkbox preference (D-015: unchecked by default).
  void setDonorOptIn(bool value) {
    _state = _state.copyWith(donorOptIn: value);
    notifyListeners();
  }

  /// Requests OTP for the given phone number.
  Future<bool> requestOtp(String phoneInput) async {
    final normalized = normalizeBangladeshPhone(phoneInput);
    if (normalized == null) {
      _state = _state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Invalid Bangladesh phone number. Enter 11 digits (e.g. 017XXXXXXXX).',
      );
      notifyListeners();
      return false;
    }

    _state = _state.copyWith(
      status: AuthStatus.sendingOtp,
      rawPhone: phoneInput,
      normalizedE164: normalized,
      maskedPhone: maskPhone(normalized),
      errorMessage: null,
    );
    notifyListeners();

    // Simulated network call with fallback / ready for Serverpod auth endpoint
    await Future.delayed(const Duration(milliseconds: 900));

    // Simulated challenge ID (7-day retention in spec)
    final challenge = 'chal_${DateTime.now().millisecondsSinceEpoch}';

    _state = _state.copyWith(
      status: AuthStatus.otpSent,
      challengeId: challenge,
      resendCountdown: 60,
    );
    _startCountdownTimer();
    notifyListeners();
    return true;
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
    return requestOtp(_state.rawPhone);
  }

  /// Verifies 6-digit OTP code.
  Future<bool> verifyOtp(String code) async {
    if (code.length != 6) {
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

    await Future.delayed(const Duration(milliseconds: 900));

    // Demo/Development mode: Any 6 digits or '123456' succeeds
    // In production, Serverpod auth verifyOtp endpoint validates hash
    final isFirstTimeUser = _state.displayName == null || _state.displayName!.isEmpty;

    _state = _state.copyWith(
      status: AuthStatus.authenticated,
      isNewUser: isFirstTimeUser,
    );
    _countdownTimer?.cancel();
    notifyListeners();
    return true;
  }

  /// Completes profile registration for new users.
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

  /// Signs out current session.
  void signOut() {
    _countdownTimer?.cancel();
    _state = const AuthState();
    notifyListeners();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}
