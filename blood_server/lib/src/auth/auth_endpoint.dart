import 'package:serverpod/serverpod.dart';
import 'package:serverpod/protocol.dart' show AccessDeniedException;
import 'package:serverpod_auth_idp_server/core.dart';

import 'phone_otp_idp.dart';
class AuthEndpoint extends Endpoint {
  PhoneOtpIdp get phoneOtpIdp => AuthServices.instance.phoneOtpIdp;

  Future<void> setPin(Session session, {required String pin}) =>
      phoneOtpIdp.setPin(session, pin: pin);

  @unauthenticatedClientCall
  Future<AuthSuccess> loginWithPin(
    Session session, {
    required String phone,
    required String pin,
    required String installId,
  }) {
    if (session.authenticated != null) {
      throw AccessDeniedException(message: 'Sign out before using PIN login.');
    }
    return phoneOtpIdp.loginWithPin(
      session,
      phone: phone,
      pin: pin,
      installId: installId,
    );
  }
}
