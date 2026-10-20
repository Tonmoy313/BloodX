import 'package:blood_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final tables = {
    for (final table in Protocol.targetTableDefinitions) table.name: table,
  };

  test('registers the six requested application tables', () {
    expect(
      tables.keys,
      containsAll([
        'app_user',
        'device',
        'otp_challenge',
        'consent_record',
        'feature_flag',
        'app_config',
        'audit_log',
      ]),
    );
  });

  test('enforces unique user phone and device identifiers', () {
    expect(
      tables['app_user']!.indexes.any(
        (index) => index.indexName == 'app_user_phone_e164' && index.isUnique,
      ),
      isTrue,
    );
    expect(
      tables['device']!.indexes.any(
        (index) => index.indexName == 'device_install_id' && index.isUnique,
      ),
      isTrue,
    );
    expect(
      tables['device']!.indexes.any(
        (index) => index.indexName == 'device_push_token' && index.isUnique,
      ),
      isTrue,
    );
  });

  test('allows phone removal while retaining the unique constraint', () {
    final phone = tables['app_user']!.columns.singleWhere(
      (column) => column.name == 'phoneE164',
    );

    expect(phone.isNullable, isTrue);
  });

  test('stores optional onboarding profile fields on app_user', () {
    final userColumns = tables['app_user']!.columns;
    for (final field in ['sex', 'dateOfBirth', 'profileImagePath']) {
      final column = userColumns.singleWhere(
        (candidate) => candidate.name == field,
      );
      expect(
        column.isNullable,
        isTrue,
        reason: '$field supports existing users',
      );
    }
  });
}
