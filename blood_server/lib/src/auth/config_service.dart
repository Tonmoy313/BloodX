import 'package:serverpod/serverpod.dart';
import 'package:serverpod/protocol.dart' show AccessDeniedException;

import '../generated/protocol.dart';

class ConfigService {
  static final RegExp _sensitiveName = RegExp(
    r'(api[_-]?key|secret|password|token|credential|private[_-]?key)',
    caseSensitive: false,
  );

  Future<Config> put(
    Session session, {
    required String key,
    required Map<String, String> value,
    required bool enabled,
  }) async {
    final normalizedKey = key.trim();
    if (normalizedKey.isEmpty ||
        _sensitiveName.hasMatch(normalizedKey) ||
        value.keys.any(_sensitiveName.hasMatch)) {
      throw ArgumentError('Config cannot store credentials or secrets.');
    }

    return session.db.transaction((transaction) async {
      final authenticated = session.authenticated;
      if (authenticated == null) {
        throw AccessDeniedException(message: 'Authentication is required.');
      }
      final authUserId = UuidValue.fromString(authenticated.userIdentifier);
      final actorUsers = await User.db.find(
        session,
        where: (row) => row.authUserId.equals(authUserId),
        limit: 2,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (actorUsers.length != 1 ||
          actorUsers.single.status != UserStatus.active) {
        throw AccessDeniedException(
          message: 'Application account is unavailable.',
        );
      }
      final actorUserId = actorUsers.single.id!;
      final admin = await AdminUser.db.findFirstRow(
        session,
        where: (row) =>
            row.userId.equals(actorUserId) & row.enabled.equals(true),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (admin == null || admin.role != AdminRole.superAdmin) {
        throw AccessDeniedException(
          message: 'Only an enabled super administrator can change Config.',
        );
      }
      await session.db.unsafeQuery(
        "SELECT set_config('app.actor_user_id', @actor, true), "
        "set_config('app.audit_source', 'application', true)",
        transaction: transaction,
        parameters: QueryParameters.named({'actor': actorUserId.toString()}),
      );

      final existing = await Config.db.findFirstRow(
        session,
        where: (row) => row.key.equals(normalizedKey),
        transaction: transaction,
      );
      if (existing == null) {
        return Config.db.insertRow(
          session,
          Config(
            key: normalizedKey,
            value: value,
            enabled: enabled,
            updatedById: actorUserId,
          ),
          transaction: transaction,
        );
      }

      return Config.db.updateRow(
        session,
        existing.copyWith(
          value: value,
          enabled: enabled,
          updatedById: actorUserId,
          updatedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
    });
  }
}
