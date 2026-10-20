import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class DonorPromptService {
  static const cooldown = Duration(days: 30);

  Future<void> scheduleAfterTokenRefresh(
    Session session, {
    required UuidValue authUserId,
    required Transaction transaction,
  }) async {
    final users = await User.db.find(
      session,
      where: (row) => row.authUserId.equals(authUserId),
      limit: 2,
      transaction: transaction,
      lockMode: LockMode.forUpdate,
    );
    if (users.length != 1 || users.single.status != UserStatus.active) return;

    final user = users.single;
    final profile = await DonorProfile.db.findFirstRow(
      session,
      where: (row) => row.userId.equals(user.id!),
      transaction: transaction,
    );
    if (profile != null ||
        user.donorPromptPending ||
        !isCooldownComplete(
          user.lastDonorPromptAt,
          user.createdAt,
          DateTime.now().toUtc(),
        )) {
      return;
    }

    await User.db.updateRow(
      session,
      user.copyWith(donorPromptPending: true),
      transaction: transaction,
    );
  }

  Future<bool> claimPrompt(Session session) async {
    final authUserId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );
    return session.db.transaction((transaction) async {
      final users = await User.db.find(
        session,
        where: (row) => row.authUserId.equals(authUserId),
        limit: 2,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (users.length != 1 || users.single.status != UserStatus.active) {
        return false;
      }

      final user = users.single;
      final now = DateTime.now().toUtc();
      final profile = await DonorProfile.db.findFirstRow(
        session,
        where: (row) => row.userId.equals(user.id!),
        transaction: transaction,
      );
      if (profile != null ||
          (!isCooldownComplete(user.lastDonorPromptAt, user.createdAt, now) &&
              !user.donorPromptPending)) {
        return false;
      }

      await User.db.updateRow(
        session,
        user.copyWith(
          lastDonorPromptAt: now,
          donorPromptPending: false,
        ),
        transaction: transaction,
      );
      return true;
    });
  }

  static bool isCooldownComplete(
    DateTime? lastPromptAt,
    DateTime createdAt,
    DateTime now,
  ) {
    final cooldownStart = lastPromptAt ?? createdAt;
    return now.toUtc().difference(cooldownStart.toUtc()) >= cooldown;
  }
}
