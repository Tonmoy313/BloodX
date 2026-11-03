import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class TierService {
  const TierService._();

  static const String freeTierCode = 'free';

  /// Returns the default free tier row, creating it if it does not already exist.
  static Future<Tier> getOrCreateFreeTier(
    DatabaseSession session, {
    Transaction? transaction,
  }) async {
    final existing = await Tier.db.findFirstRow(
      session,
      where: (row) => row.code.equals(freeTierCode),
      transaction: transaction,
    );
    if (existing != null) {
      return existing;
    }

    final now = DateTime.now().toUtc();
    return Tier.db.insertRow(
      session,
      Tier(
        code: freeTierCode,
        name: 'Free Tier',
        maxOpenRequests: 1,
        requiresVerificationLevel: VerificationLevel.phone,
        isActive: true,
        createdAt: now,
      ),
      transaction: transaction,
    );
  }
}
