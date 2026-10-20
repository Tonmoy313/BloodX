import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AuthUserModel> getMyProfile(Session session) async {
    return const AuthUsers().get(
      session,
      authUserId: UuidValue.fromString(
        session.authenticated!.userIdentifier,
      ),
    );
  }
}
