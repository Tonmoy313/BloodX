enum AuthStatus {
  unauthenticated,
  sendingOtp,
  otpSent,
  verifyingOtp,
  authenticated,
  error,
}

/// BloodX Auth state model.
class AuthState {
  final AuthStatus status;
  final String rawPhone;
  final String normalizedE164;
  final String maskedPhone;
  final String? challengeId;
  final int resendCountdown;
  final bool isNewUser;
  final bool donorOptIn;
  final String? displayName;
  final String? bloodGroup;
  final String? area;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.rawPhone = '',
    this.normalizedE164 = '',
    this.maskedPhone = '',
    this.challengeId,
    this.resendCountdown = 60,
    this.isNewUser = false,
    this.donorOptIn = false, // D-015: Default OFF
    this.displayName,
    this.bloodGroup,
    this.area,
    this.errorMessage,
  });

  bool get isLoading =>
      status == AuthStatus.sendingOtp || status == AuthStatus.verifyingOtp;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    String? rawPhone,
    String? normalizedE164,
    String? maskedPhone,
    String? challengeId,
    int? resendCountdown,
    bool? isNewUser,
    bool? donorOptIn,
    String? displayName,
    String? bloodGroup,
    String? area,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      rawPhone: rawPhone ?? this.rawPhone,
      normalizedE164: normalizedE164 ?? this.normalizedE164,
      maskedPhone: maskedPhone ?? this.maskedPhone,
      challengeId: challengeId ?? this.challengeId,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      isNewUser: isNewUser ?? this.isNewUser,
      donorOptIn: donorOptIn ?? this.donorOptIn,
      displayName: displayName ?? this.displayName,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      area: area ?? this.area,
      errorMessage: errorMessage,
    );
  }
}
