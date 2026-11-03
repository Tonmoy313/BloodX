import '../generated/protocol.dart';

void configurePartialIndexPredicates() {
  // Serverpod model YAML cannot declare predicates for PostgreSQL partial indexes.
  const predicates = {
    'deferral_user_id_active_idx': '("liftedAt" IS NULL)',
    'donor_area_gps_cell': '("gpsCell" IS NOT NULL)',
    'donor_profile_matching':
        '(("donorStatus" = \'active\'::text) AND ("alertMode" <> \'off\'::text))',
    'donor_profile_availability_expiry': '("alertMode" <> \'off\'::text)',
    'kyc_verification_subject_hmac_verified': '(status = \'verified\'::text)',
    'kyc_verification_user_type_pending': '(status = \'pending\'::text)',
    'otp_challenge_phone_type_open': '("consumedAt" IS NULL)',
  };
  final configured = <String>{};

  for (final table in Protocol.targetTableDefinitions) {
    for (final index in table.indexes) {
      final predicate = predicates[index.indexName];
      if (predicate != null) {
        index.predicate = predicate;
        configured.add(index.indexName);
      }
    }
  }

  final missing = predicates.keys.toSet().difference(configured);
  if (missing.isNotEmpty) {
    throw StateError(
      'Partial indexes are missing from the generated schema: '
      '${missing.join(', ')}',
    );
  }
}
