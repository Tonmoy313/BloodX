import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../donor/donor_prompt_service.dart';

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
class JwtRefreshEndpoint extends RefreshJwtTokensEndpoint {
  final DonorPromptService _donorPromptService = DonorPromptService();

  @override
  @unauthenticatedClientCall
  Future<AuthSuccess> refreshAccessToken(
    Session session, {
    required String refreshToken,
  }) async {
    return session.db.transaction((transaction) async {
      final authSuccess = await jwt.refreshAccessToken(
        session,
        refreshToken: refreshToken,
        transaction: transaction,
      );
      await _donorPromptService.scheduleAfterTokenRefresh(
        session,
        authUserId: authSuccess.authUserId,
        transaction: transaction,
      );
      return authSuccess;
    });
  }
}
