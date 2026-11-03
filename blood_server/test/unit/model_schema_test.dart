import 'package:blood_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final tables = {
    for (final table in Protocol.targetTableDefinitions) table.name: table,
  };

  test('registers the requested application tables', () {
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
        'user_credential',
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

  test('stores PIN credentials separately with one row per user', () {
    final credentials = tables['user_credential']!;
    expect(
      credentials.indexes.any(
        (index) =>
            index.indexName == 'user_credential_user_id' && index.isUnique,
      ),
      isTrue,
    );
    expect(
      credentials.columns.any((column) => column.name == 'pinHash'),
      isTrue,
    );
    expect(
      tables['app_user']!.columns.any((column) => column.name == 'pinHash'),
      isFalse,
    );
  });
}
