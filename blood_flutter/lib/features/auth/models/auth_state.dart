enum AuthStatus {
  unauthenticated,
  sendingOtp,
  otpSent,
  verifyingOtp,
  pinSetupRequired,
  authenticatingPin,
  authenticated,
  lockedOut,
  error,
}

/// BloodX Auth state model aligned with spec/auth.md.
class AuthState {
  final AuthStatus status;
  final String rawPhone;
  final String normalizedE164;
  final String maskedPhone;
  final String? userId;
  final String? challengeId;
  final int resendCountdown;
  final bool isNewUser;
  final bool donorOptIn;
  final String? displayName;
  final String? bloodGroup;
  final String? area;
  final String? locationCoordinates;
  final List<String> preferredHospitals;
  final bool donorProfileComplete;
  final String? pinHash;
  final int failedPinAttempts;
  final DateTime? lockoutUntil;
  final bool isForgotPin;
  final bool appVersionSupported;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.rawPhone = '',
    this.normalizedE164 = '',
    this.maskedPhone = '',
    this.userId,
    this.challengeId,
    this.resendCountdown = 60,
    this.isNewUser = false,
    this.donorOptIn = false, // D-015: Default OFF
    this.displayName,
    this.bloodGroup,
    this.area,
    this.locationCoordinates,
    this.preferredHospitals = const [],
    this.donorProfileComplete = false,
    this.pinHash,
    this.failedPinAttempts = 0,
    this.lockoutUntil,
    this.isForgotPin = false,
    this.appVersionSupported = true,
    this.errorMessage,
  });

  bool get isLoading =>
      status == AuthStatus.sendingOtp ||
      status == AuthStatus.verifyingOtp ||
      status == AuthStatus.authenticatingPin;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  bool get isLockedOut {
    if (lockoutUntil == null) return false;
    return DateTime.now().isBefore(lockoutUntil!);
  }

  int get remainingLockoutMinutes {
    if (lockoutUntil == null) return 0;
    final diff = lockoutUntil!.difference(DateTime.now()).inMinutes;
    return diff < 0 ? 0 : diff + 1;
  }

  AuthState copyWith({
    AuthStatus? status,
    String? rawPhone,
    String? normalizedE164,
    String? maskedPhone,
    String? userId,
    String? challengeId,
    int? resendCountdown,
    bool? isNewUser,
    bool? donorOptIn,
    String? displayName,
    String? bloodGroup,
    String? area,
    String? locationCoordinates,
    List<String>? preferredHospitals,
    bool? donorProfileComplete,
    String? pinHash,
    int? failedPinAttempts,
    DateTime? lockoutUntil,
    bool? isForgotPin,
    bool? appVersionSupported,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      rawPhone: rawPhone ?? this.rawPhone,
      normalizedE164: normalizedE164 ?? this.normalizedE164,
      maskedPhone: maskedPhone ?? this.maskedPhone,
      userId: userId ?? this.userId,
      challengeId: challengeId ?? this.challengeId,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      isNewUser: isNewUser ?? this.isNewUser,
      donorOptIn: donorOptIn ?? this.donorOptIn,
      displayName: displayName ?? this.displayName,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      area: area ?? this.area,
      locationCoordinates: locationCoordinates ?? this.locationCoordinates,
      preferredHospitals: preferredHospitals ?? this.preferredHospitals,
      donorProfileComplete: donorProfileComplete ?? this.donorProfileComplete,
      pinHash: pinHash ?? this.pinHash,
      failedPinAttempts: failedPinAttempts ?? this.failedPinAttempts,
      lockoutUntil: lockoutUntil ?? this.lockoutUntil,
      isForgotPin: isForgotPin ?? this.isForgotPin,
      appVersionSupported: appVersionSupported ?? this.appVersionSupported,
      errorMessage: errorMessage,
    );
  }
}
