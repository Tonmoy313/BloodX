import 'package:serverpod/serverpod.dart';

import '../auth/tier_service.dart';
import '../generated/protocol.dart';
import 'bangladesh_locations_data.dart';

class DatabaseSeeder {
  const DatabaseSeeder._();

  /// Seeds default Tiers and Bangladesh Areas if not already present.
  static Future<void> seedAll(Session session) async {
    await seedTiers(session);
    await seedAreas(session);
  }

  static Future<void> seedTiers(Session session) async {
    await TierService.getOrCreateFreeTier(session);
  }

  static Future<void> seedAreas(Session session) async {
    final count = await Area.db.count(session);
    if (count > 0) {
      return;
    }

    session.log(
      '[DatabaseSeeder] Seeding Bangladesh districts and upazilas into Area table...',
      level: LogLevel.info,
    );

    await session.db.transaction((transaction) async {
      for (final district in BangladeshLocationsData.districts) {
        // Seed district entry
        await Area.db.insertRow(
          session,
          Area(
            type: AreaType.district,
            district: district,
            name: district,
            centroidCell: BigInt.zero,
          ),
          transaction: transaction,
        );

        // Seed upazilas under this district
        final upazilas =
            BangladeshLocationsData.districtUpazilas[district] ?? const [];
        for (final upazila in upazilas) {
          await Area.db.insertRow(
            session,
            Area(
              type: AreaType.upazilla,
              district: district,
              name: upazila,
              centroidCell: BigInt.zero,
            ),
            transaction: transaction,
          );
        }
      }
    });

    session.log(
      '[DatabaseSeeder] Successfully seeded all Bangladesh locations.',
      level: LogLevel.info,
    );
  }
}
