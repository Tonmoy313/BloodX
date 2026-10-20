import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'phone_otp_idp.dart';

class AuthIdpEndpoint extends IdpBaseEndpoint {
  PhoneOtpIdp get phoneOtpIdp => AuthServices.instance.phoneOtpIdp;

  @override
  Future<bool> hasAccount(Session session) => phoneOtpIdp.hasAccount(session);

  @unauthenticatedClientCall
  Future<int> startLogin(
    Session session, {
    required String phone,
    required String installId,
    bool isForgotPin = false,
  }) {
    return phoneOtpIdp.startLogin(
      session,
      phone: phone,
      installId: installId,
      type: isForgotPin ? OtpType.forgetPin : OtpType.newAccount,
    );
  }

  @unauthenticatedClientCall
  Future<AuthSuccess> finishLogin(
    Session session, {
    required int challengeId,
    required String code,
    required String installId,
  }) {
    return phoneOtpIdp.finishLogin(
      session,
      challengeId: challengeId,
      code: code,
      installId: installId,
    );
  }
}
