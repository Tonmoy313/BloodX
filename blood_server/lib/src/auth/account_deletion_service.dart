import 'package:serverpod/serverpod.dart';
import 'package:serverpod/protocol.dart' show AccessDeniedException;
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

class AccountDeletionPolicy {
  const AccountDeletionPolicy._();

  static final RegExp _reviewReferencePattern = RegExp(
    r'^[A-Za-z0-9][A-Za-z0-9._:-]{0,99}$',
  );

  static bool canSelfDelete(User user) => user.status == UserStatus.active;

  static User anonymize(User user, DateTime deletedAt) {
    return user.copyWith(
      phoneE164: null,
      phoneHmac: null,
      displayName: 'Deleted user',
      authUserId: null,
      boundInstallId: null,
      pinHash: null,
      pinSetAt: null,
      pinFailedAttempts: 0,
      pinLockedUntil: null,
      status: UserStatus.deleted,
      suspendedReason: null,
      updatedAt: deletedAt,
      lastSeenAt: null,
      deletedAt: deletedAt,
    );
  }

  static bool canAdminDelete({
    required AdminUser? admin,
    required User target,
    required String reviewReference,
  }) {
    return admin != null &&
        admin.enabled &&
        admin.role == AdminRole.superAdmin &&
        _reviewReferencePattern.hasMatch(reviewReference.trim()) &&
        target.status != UserStatus.deleted;
  }
}

class AccountDeletionService {
  Future<void> deleteCurrentUser(Session session) async {
    final authUserId = _authenticatedUserId(session);
    await session.db.transaction((transaction) async {
      final user = await _findAppUser(
        session,
        authUserId,
        transaction: transaction,
      );
      if (!AccountDeletionPolicy.canSelfDelete(user)) {
        throw AccessDeniedException(
          message: 'Suspended accounts require admin review for deletion.',
        );
      }
      await _deleteUser(
        session,
        transaction: transaction,
        actor: user,
        target: user,
        authUserId: authUserId,
        source: 'self_service',
      );
    });
    await _notifyRevocation(session, authUserId);
  }

  Future<void> deleteUserAfterAdminReview(
    Session session, {
    required int userId,
    required String reviewReference,
  }) async {
    final authUserId = _authenticatedUserId(session);
    late UuidValue targetAuthUserId;
    await session.db.transaction((transaction) async {
      final actor = await _findAppUser(
        session,
        authUserId,
        transaction: transaction,
      );
      final admin = await AdminUser.db.findFirstRow(
        session,
        where: (row) => row.userId.equals(actor.id!),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      final target = await User.db.findById(
        session,
        userId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (target == null ||
          !AccountDeletionPolicy.canAdminDelete(
            admin: admin,
            target: target,
            reviewReference: reviewReference,
          )) {
        throw AccessDeniedException(
          message: 'Admin review is required to delete this account.',
        );
      }
      final authUserToDelete = target.authUserId;
      if (authUserToDelete == null) {
        throw StateError('Cannot revoke authentication for this account.');
      }

      targetAuthUserId = authUserToDelete;
      await _deleteUser(
        session,
        transaction: transaction,
        actor: actor,
        target: target,
        authUserId: authUserToDelete,
        source: 'admin_review:${reviewReference.trim()}',
      );
    });
    await _notifyRevocation(session, targetAuthUserId);
  }

  UuidValue _authenticatedUserId(Session session) {
    final authenticated = session.authenticated;
    if (authenticated == null) {
      throw AccessDeniedException(message: 'Authentication is required.');
    }
    return UuidValue.fromString(authenticated.userIdentifier);
  }

  Future<User> _findAppUser(
    Session session,
    UuidValue authUserId, {
    required Transaction transaction,
  }) async {
    final users = await User.db.find(
      session,
      where: (row) => row.authUserId.equals(authUserId),
      limit: 2,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (users.length != 1 || users.single.status != UserStatus.active) {
      throw AccessDeniedException(
        message: 'Application account is unavailable.',
      );
    }
    return users.single;
  }

  Future<void> _deleteUser(
    Session session, {
    required Transaction transaction,
    required User actor,
    required User target,
    required UuidValue authUserId,
    required String source,
  }) async {
    final actorId = actor.id!;
    final targetId = target.id!;
    final phone = target.phoneE164;
    final now = DateTime.now().toUtc();

    await AuditLog.db.insertRow(
      session,
      AuditLog(
        actorId: actorId,
        action: 'account_deleted',
        entityType: 'User',
        entityKey: targetId.toString(),
        details: source,
        metadata: {'source': 'application'},
        createdAt: now,
      ),
      transaction: transaction,
    );

    if (phone != null) {
      await OtpChallenge.db.deleteWhere(
        session,
        where: (row) => row.phoneE164.equals(phone),
        transaction: transaction,
      );
    }
    await Device.db.deleteWhere(
      session,
      where: (row) => row.userId.equals(targetId),
      transaction: transaction,
    );
    await DonorProfile.db.deleteWhere(
      session,
      where: (row) => row.userId.equals(targetId),
      transaction: transaction,
    );
    await const AuthUsers().delete(
      session,
      authUserId: authUserId,
      transaction: transaction,
    );
    await User.db.updateRow(
      session,
      AccountDeletionPolicy.anonymize(target, now),
      transaction: transaction,
    );
  }

  Future<void> _notifyRevocation(
    Session session,
    UuidValue authUserId,
  ) async {
    await session.messages.authenticationRevoked(
      authUserId.uuid,
      RevokedAuthenticationUser(),
    );
  }
}
