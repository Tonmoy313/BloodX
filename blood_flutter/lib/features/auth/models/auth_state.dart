import 'package:blood_client/blood_client.dart';

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

/// Persisted profile fields use the names and types from Serverpod tables.
/// The remaining fields are transient client-side authentication state.
class AuthState {
  final AuthStatus status;
  final String rawPhone;
  final String phoneE164;
  final String maskedPhone;
  final int? appUserId;
  final String? authUserId;
  final int? otpChallengeId;
  final int resendCountdown;
  final bool isNewUser;
  final bool donorOptIn;
  final String? displayName;
  final Sex? sex;
  final DateTime? dateOfBirth;
  final String? profileImagePath;
  final String? pendingProfileImagePath;
  final Language language;
  final UserStatus? accountStatus;
  final String? bloodGroup;
  final String? area;
  final String? address;
  final double? latitude;
  final double? longitude;
  final List<String> preferredCenters;
  final bool donorProfileComplete;
  final bool isForgotPin;
  final bool appVersionSupported;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.rawPhone = '',
    this.phoneE164 = '',
    this.maskedPhone = '',
    this.appUserId,
    this.authUserId,
    this.otpChallengeId,
    this.resendCountdown = 60,
    this.isNewUser = false,
    this.donorOptIn = false, // D-015: Default OFF
    this.displayName,
    this.sex,
    this.dateOfBirth,
    this.profileImagePath,
    this.pendingProfileImagePath,
    this.language = Language.bn,
    this.accountStatus,
    this.bloodGroup,
    this.area,
    this.address,
    this.latitude,
    this.longitude,
    this.preferredCenters = const [],
    this.donorProfileComplete = false,
    this.isForgotPin = false,
    this.appVersionSupported = true,
    this.errorMessage,
  });

  bool get isLoading =>
      status == AuthStatus.sendingOtp ||
      status == AuthStatus.verifyingOtp ||
      status == AuthStatus.authenticatingPin;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    String? rawPhone,
    String? phoneE164,
    String? maskedPhone,
    int? appUserId,
    String? authUserId,
    int? otpChallengeId,
    int? resendCountdown,
    bool? isNewUser,
    bool? donorOptIn,
    String? displayName,
    Sex? sex,
    DateTime? dateOfBirth,
    String? profileImagePath,
    String? pendingProfileImagePath,
    Language? language,
    UserStatus? accountStatus,
    String? bloodGroup,
    String? area,
    String? address,
    double? latitude,
    double? longitude,
    List<String>? preferredCenters,
    bool? donorProfileComplete,
    bool? isForgotPin,
    bool? appVersionSupported,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      rawPhone: rawPhone ?? this.rawPhone,
      phoneE164: phoneE164 ?? this.phoneE164,
      maskedPhone: maskedPhone ?? this.maskedPhone,
      appUserId: appUserId ?? this.appUserId,
      authUserId: authUserId ?? this.authUserId,
      otpChallengeId: otpChallengeId ?? this.otpChallengeId,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      isNewUser: isNewUser ?? this.isNewUser,
      donorOptIn: donorOptIn ?? this.donorOptIn,
      displayName: displayName ?? this.displayName,
      sex: sex ?? this.sex,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      pendingProfileImagePath:
          pendingProfileImagePath ?? this.pendingProfileImagePath,
      language: language ?? this.language,
      accountStatus: accountStatus ?? this.accountStatus,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      area: area ?? this.area,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      preferredCenters: preferredCenters ?? this.preferredCenters,
      donorProfileComplete: donorProfileComplete ?? this.donorProfileComplete,
      isForgotPin: isForgotPin ?? this.isForgotPin,
      appVersionSupported: appVersionSupported ?? this.appVersionSupported,
      errorMessage: errorMessage,
    );
  }
}
