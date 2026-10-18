import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('migration installs immutable audit triggers and actor attribution', () {
    final migration = File(
      'migrations/20261018134707116-p0-8-session-audit-hardening/migration.sql',
    ).readAsStringSync();

    expect(migration, contains("current_setting('app.actor_user_id', true)"));
    expect(migration, contains('"updatedById"'));
    expect(migration, contains('BEFORE UPDATE OR DELETE ON "audit_log"'));
    expect(migration, contains('BEFORE TRUNCATE ON "audit_log"'));
    expect(migration, contains('app_config_no_delete'));
    expect(migration, contains('json_build_object(\'source\', source_tag)'));
    expect(migration, contains('WHERE "pushToken" IS NOT NULL'));
  });
}
