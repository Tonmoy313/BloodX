/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i3;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i4;
import 'package:blood_client/src/protocol/greetings/greeting.dart' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointAccountDeletion extends _i1.EndpointRef {
  EndpointAccountDeletion(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'accountDeletion';

  _i2.Future<void> deleteMyAccount() => caller.callServerEndpoint<void>(
    'accountDeletion',
    'deleteMyAccount',
    {},
  );

  _i2.Future<void> deleteAccountAfterReview({
    required int userId,
    required String reviewReference,
  }) => caller.callServerEndpoint<void>(
    'accountDeletion',
    'deleteAccountAfterReview',
    {
      'userId': userId,
      'reviewReference': reviewReference,
    },
  );
}

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<void> setPin({required String pin}) =>
      caller.callServerEndpoint<void>(
        'auth',
        'setPin',
        {'pin': pin},
      );

  _i2.Future<_i3.AuthSuccess> loginWithPin({
    required String phone,
    required String pin,
    required String installId,
  }) => caller.callServerEndpoint<_i3.AuthSuccess>(
    'auth',
    'loginWithPin',
    {
      'phone': phone,
      'pin': pin,
      'installId': installId,
    },
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointAuthIdp extends _i4.EndpointIdpBase {
  EndpointAuthIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'authIdp';

  @override
  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'authIdp',
    'hasAccount',
    {},
  );

  _i2.Future<int> startLogin({
    required String phone,
    required String installId,
    required bool isForgotPin,
  }) => caller.callServerEndpoint<int>(
    'authIdp',
    'startLogin',
    {
      'phone': phone,
      'installId': installId,
      'isForgotPin': isForgotPin,
    },
    authenticated: false,
  );

  _i2.Future<_i3.AuthSuccess> finishLogin({
    required int challengeId,
    required String code,
    required String installId,
  }) => caller.callServerEndpoint<_i3.AuthSuccess>(
    'authIdp',
    'finishLogin',
    {
      'challengeId': challengeId,
      'code': code,
      'installId': installId,
    },
    authenticated: false,
  );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i4.EndpointEmailIdpBase {
  EndpointEmailIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<_i3.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i3.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i2.Future<_i1.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i2.Future<String> verifyRegistrationCode({
    required _i1.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i2.Future<_i3.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i3.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i2.Future<_i1.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i2.Future<String> verifyPasswordResetCode({
    required _i1.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i3.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  @override
  _i2.Future<_i3.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i3.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointR2 extends _i1.EndpointRef {
  EndpointR2(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'r2';

  /// Allows an authenticated client to get a pre-signed upload URL for slips.
  _i2.Future<String> signedUploadUrl(String key) =>
      caller.callServerEndpoint<String>(
        'r2',
        'signedUploadUrl',
        {'key': key},
      );

  /// Allows an authenticated client to get a pre-signed download URL.
  _i2.Future<String> signedDownloadUrl({
    required String storageId,
    required String key,
  }) => caller.callServerEndpoint<String>(
    'r2',
    'signedDownloadUrl',
    {
      'storageId': storageId,
      'key': key,
    },
  );
}

/// {@category Endpoint}
class EndpointDonorProfile extends _i1.EndpointRef {
  EndpointDonorProfile(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'donorProfile';

  _i2.Future<void> saveMyProfile({
    required String bloodGroup,
    required String area,
    required String address,
    required double latitude,
    required double longitude,
    required List<String> preferredCenters,
  }) => caller.callServerEndpoint<void>(
    'donorProfile',
    'saveMyProfile',
    {
      'bloodGroup': bloodGroup,
      'area': area,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'preferredCenters': preferredCenters,
    },
  );
}

/// {@category Endpoint}
class EndpointDonorPrompt extends _i1.EndpointRef {
  EndpointDonorPrompt(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'donorPrompt';

  _i2.Future<bool> claimDonorPrompt() => caller.callServerEndpoint<bool>(
    'donorPrompt',
    'claimDonorPrompt',
    {},
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i5.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i5.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointProfile extends _i1.EndpointRef {
  EndpointProfile(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  _i2.Future<_i3.AuthUserModel> getMyProfile() =>
      caller.callServerEndpoint<_i3.AuthUserModel>(
        'profile',
        'getMyProfile',
        {},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i4.Caller(client);
    serverpod_auth_core = _i3.Caller(client);
  }

  late final _i4.Caller serverpod_auth_idp;

  late final _i3.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i6.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    accountDeletion = EndpointAccountDeletion(this);
    auth = EndpointAuth(this);
    authIdp = EndpointAuthIdp(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    r2 = EndpointR2(this);
    donorProfile = EndpointDonorProfile(this);
    donorPrompt = EndpointDonorPrompt(this);
    greeting = EndpointGreeting(this);
    profile = EndpointProfile(this);
    modules = Modules(this);
  }

  late final EndpointAccountDeletion accountDeletion;

  late final EndpointAuth auth;

  late final EndpointAuthIdp authIdp;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointR2 r2;

  late final EndpointDonorProfile donorProfile;

  late final EndpointDonorPrompt donorPrompt;

  late final EndpointGreeting greeting;

  late final EndpointProfile profile;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'accountDeletion': accountDeletion,
    'auth': auth,
    'authIdp': authIdp,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'r2': r2,
    'donorProfile': donorProfile,
    'donorPrompt': donorPrompt,
    'greeting': greeting,
    'profile': profile,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
