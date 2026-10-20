import 'package:blood_server/src/auth/account_deletion_service.dart';
import 'package:blood_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  group('AccountDeletionPolicy', () {
    test('self-service deletion is limited to active accounts', () {
      expect(
        AccountDeletionPolicy.canSelfDelete(
          User(displayName: 'Active', status: UserStatus.active),
        ),
        isTrue,
      );
      expect(
        AccountDeletionPolicy.canSelfDelete(
          User(displayName: 'Suspended', status: UserStatus.suspended),
        ),
        isFalse,
      );
    });

    test('anonymization clears retained personal data and session linkage', () {
      final deletedAt = DateTime.utc(2026, 1, 1);
      final deleted = AccountDeletionPolicy.anonymize(
        User(
          phoneE164: '+8801712345678',
          phoneHmac: 'phone-hmac',
          displayName: 'Example',
          authUserId: UuidValue.fromString(
            '00000000-0000-0000-0000-000000000001',
          ),
          boundInstallId: UuidValue.fromString(
            '00000000-0000-4000-8000-000000000002',
          ),
          pinHash: 'argon2-hash',
          pinSetAt: DateTime.utc(2025, 12, 30),
          pinFailedAttempts: 3,
          pinLockedUntil: DateTime.utc(2025, 12, 31),
          status: UserStatus.suspended,
          suspendedReason: 'personal reason',
          lastSeenAt: DateTime.utc(2025, 12, 31),
        ),
        deletedAt,
      );

      expect(deleted.phoneE164, isNull);
      expect(deleted.phoneHmac, isNull);
      expect(deleted.displayName, 'Deleted user');
      expect(deleted.authUserId, isNull);
      expect(deleted.boundInstallId, isNull);
      expect(deleted.pinHash, isNull);
      expect(deleted.pinSetAt, isNull);
      expect(deleted.pinFailedAttempts, 0);
      expect(deleted.pinLockedUntil, isNull);
      expect(deleted.status, UserStatus.deleted);
      expect(deleted.suspendedReason, isNull);
      expect(deleted.lastSeenAt, isNull);
      expect(deleted.deletedAt, deletedAt);
    });

    test(
      'suspended deletion requires enabled super-admin review reference',
      () {
        final target = User(
          displayName: 'Suspended',
          status: UserStatus.suspended,
        );

        expect(
          AccountDeletionPolicy.canAdminDelete(
            admin: AdminUser(userId: 1, role: AdminRole.ops),
            target: target,
            reviewReference: 'review-123',
          ),
          isFalse,
        );
        expect(
          AccountDeletionPolicy.canAdminDelete(
            admin: AdminUser(
              userId: 1,
              role: AdminRole.superAdmin,
              enabled: false,
            ),
            target: target,
            reviewReference: 'review-123',
          ),
          isFalse,
        );
        expect(
          AccountDeletionPolicy.canAdminDelete(
            admin: AdminUser(userId: 1, role: AdminRole.superAdmin),
            target: target,
            reviewReference: ' ',
          ),
          isFalse,
        );
        expect(
          AccountDeletionPolicy.canAdminDelete(
            admin: AdminUser(userId: 1, role: AdminRole.superAdmin),
            target: target,
            reviewReference: 'review id with spaces',
          ),
          isFalse,
        );
        expect(
          AccountDeletionPolicy.canAdminDelete(
            admin: AdminUser(userId: 1, role: AdminRole.superAdmin),
            target: target,
            reviewReference: 'review-123',
          ),
          isTrue,
        );
      },
    );
  });
}
