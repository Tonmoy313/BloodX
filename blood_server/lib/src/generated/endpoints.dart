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

import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/account_deletion_endpoint.dart' as _i2;
import '../auth/auth_endpoint.dart' as _i3;
import '../auth/auth_idp_endpoint.dart' as _i4;
import '../auth/email_idp_endpoint.dart' as _i5;
import '../auth/jwt_refresh_endpoint.dart' as _i6;
import '../config/aws_endpoint_config.dart' as _i7;
import '../donor/donor_profile_endpoint.dart' as _i8;
import '../donor/donor_prompt_endpoint.dart' as _i9;
import '../greetings/greeting_endpoint.dart' as _i10;
import '../profile/profile_endpoint.dart' as _i11;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i12;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i13;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'accountDeletion': _i2.AccountDeletionEndpoint()
        ..initialize(
          server,
          'accountDeletion',
          null,
        ),
      'auth': _i3.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'authIdp': _i4.AuthIdpEndpoint()
        ..initialize(
          server,
          'authIdp',
          null,
        ),
      'emailIdp': _i5.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i6.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'r2': _i7.R2Endpoint()
        ..initialize(
          server,
          'r2',
          null,
        ),
      'donorProfile': _i8.DonorProfileEndpoint()
        ..initialize(
          server,
          'donorProfile',
          null,
        ),
      'donorPrompt': _i9.DonorPromptEndpoint()
        ..initialize(
          server,
          'donorPrompt',
          null,
        ),
      'greeting': _i10.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'profile': _i11.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
    };
    connectors['accountDeletion'] = _i1.EndpointConnector(
      name: 'accountDeletion',
      endpoint: endpoints['accountDeletion']!,
      methodConnectors: {
        'deleteMyAccount': _i1.MethodConnector(
          name: 'deleteMyAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accountDeletion'] as _i2.AccountDeletionEndpoint)
                      .deleteMyAccount(session),
        ),
        'deleteAccountAfterReview': _i1.MethodConnector(
          name: 'deleteAccountAfterReview',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reviewReference': _i1.ParameterDescription(
              name: 'reviewReference',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accountDeletion'] as _i2.AccountDeletionEndpoint)
                      .deleteAccountAfterReview(
                        session,
                        userId: params['userId'],
                        reviewReference: params['reviewReference'],
                      ),
        ),
      },
    );
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'setPin': _i1.MethodConnector(
          name: 'setPin',
          params: {
            'pin': _i1.ParameterDescription(
              name: 'pin',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i3.AuthEndpoint).setPin(
                session,
                pin: params['pin'],
              ),
        ),
        'loginWithPin': _i1.MethodConnector(
          name: 'loginWithPin',
          params: {
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'pin': _i1.ParameterDescription(
              name: 'pin',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'installId': _i1.ParameterDescription(
              name: 'installId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i3.AuthEndpoint).loginWithPin(
                session,
                phone: params['phone'],
                pin: params['pin'],
                installId: params['installId'],
              ),
        ),
      },
    );
    connectors['authIdp'] = _i1.EndpointConnector(
      name: 'authIdp',
      endpoint: endpoints['authIdp']!,
      methodConnectors: {
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['authIdp'] as _i4.AuthIdpEndpoint)
                  .hasAccount(session),
        ),
        'startLogin': _i1.MethodConnector(
          name: 'startLogin',
          params: {
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'installId': _i1.ParameterDescription(
              name: 'installId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isForgotPin': _i1.ParameterDescription(
              name: 'isForgotPin',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['authIdp'] as _i4.AuthIdpEndpoint).startLogin(
                    session,
                    phone: params['phone'],
                    installId: params['installId'],
                    isForgotPin: params['isForgotPin'],
                  ),
        ),
        'finishLogin': _i1.MethodConnector(
          name: 'finishLogin',
          params: {
            'challengeId': _i1.ParameterDescription(
              name: 'challengeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'installId': _i1.ParameterDescription(
              name: 'installId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['authIdp'] as _i4.AuthIdpEndpoint).finishLogin(
                    session,
                    challengeId: params['challengeId'],
                    code: params['code'],
                    installId: params['installId'],
                  ),
        ),
      },
    );
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i5.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i6.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['r2'] = _i1.EndpointConnector(
      name: 'r2',
      endpoint: endpoints['r2']!,
      methodConnectors: {
        'signedUploadUrl': _i1.MethodConnector(
          name: 'signedUploadUrl',
          params: {
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['r2'] as _i7.R2Endpoint).signedUploadUrl(
                session,
                params['key'],
              ),
        ),
        'signedDownloadUrl': _i1.MethodConnector(
          name: 'signedDownloadUrl',
          params: {
            'storageId': _i1.ParameterDescription(
              name: 'storageId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'key': _i1.ParameterDescription(
              name: 'key',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['r2'] as _i7.R2Endpoint).signedDownloadUrl(
                session,
                storageId: params['storageId'],
                key: params['key'],
              ),
        ),
      },
    );
    connectors['donorProfile'] = _i1.EndpointConnector(
      name: 'donorProfile',
      endpoint: endpoints['donorProfile']!,
      methodConnectors: {
        'saveMyProfile': _i1.MethodConnector(
          name: 'saveMyProfile',
          params: {
            'bloodGroup': _i1.ParameterDescription(
              name: 'bloodGroup',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'area': _i1.ParameterDescription(
              name: 'area',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'address': _i1.ParameterDescription(
              name: 'address',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'preferredCenters': _i1.ParameterDescription(
              name: 'preferredCenters',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['donorProfile'] as _i8.DonorProfileEndpoint)
                  .saveMyProfile(
                    session,
                    bloodGroup: params['bloodGroup'],
                    area: params['area'],
                    address: params['address'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    preferredCenters: params['preferredCenters'],
                  ),
        ),
      },
    );
    connectors['donorPrompt'] = _i1.EndpointConnector(
      name: 'donorPrompt',
      endpoint: endpoints['donorPrompt']!,
      methodConnectors: {
        'claimDonorPrompt': _i1.MethodConnector(
          name: 'claimDonorPrompt',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['donorPrompt'] as _i9.DonorPromptEndpoint)
                  .claimDonorPrompt(session),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i10.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    connectors['profile'] = _i1.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getMyProfile': _i1.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i11.ProfileEndpoint)
                  .getMyProfile(session),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i12.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i13.Endpoints()
      ..initializeEndpoints(server);
  }
}
