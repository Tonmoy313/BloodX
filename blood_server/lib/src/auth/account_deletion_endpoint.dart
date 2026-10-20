import 'package:serverpod/serverpod.dart';

import 'account_deletion_service.dart';

class AccountDeletionEndpoint extends Endpoint {
  final AccountDeletionService _service = AccountDeletionService();

  @override
  bool get requireLogin => true;

  Future<void> deleteMyAccount(Session session) {
    return _service.deleteCurrentUser(session);
  }

  Future<void> deleteAccountAfterReview(
    Session session, {
    required int userId,
    required String reviewReference,
  }) {
    return _service.deleteUserAfterAdminReview(
      session,
      userId: userId,
      reviewReference: reviewReference,
    );
  }
}
