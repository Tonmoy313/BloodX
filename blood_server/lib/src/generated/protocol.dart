/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'KycVerificationType.dart' as _i5;
import 'area.dart' as _i6;
import 'area_type.dart' as _i7;
import 'audit_log.dart' as _i8;
import 'blood_component.dart' as _i9;
import 'config.dart' as _i10;
import 'consent_record.dart' as _i11;
import 'consent_type.dart' as _i12;
import 'deferral/deferral.dart' as _i13;
import 'deferral/deferral_reason.dart' as _i14;
import 'deferral/deferral_source.dart' as _i15;
import 'deferral/deferral_type.dart' as _i16;
import 'device.dart' as _i17;
import 'device_platform.dart' as _i18;
import 'doner/alert_mode.dart' as _i19;
import 'doner/blood_group.dart' as _i20;
import 'doner/blood_group_source.dart' as _i21;
import 'doner/donor_area.dart' as _i22;
import 'doner/donor_area_kind.dart' as _i23;
import 'doner/donor_profile.dart' as _i24;
import 'doner/donor_status.dart' as _i25;
import 'feature_flag.dart' as _i26;
import 'flag_scope.dart' as _i27;
import 'greetings/greeting.dart' as _i28;
import 'kycStatus.dart' as _i29;
import 'kyc_verificaiton.dart' as _i30;
import 'otp_challenge.dart' as _i31;
import 'otp_type.dart' as _i32;
import 'readiness_check.dart' as _i33;
import 'readiness_outcome.dart' as _i34;
import 'sex.dart' as _i35;
import 'tier_limit.dart' as _i36;
import 'tier_verification_level.dart' as _i37;
import 'tiers.dart' as _i38;
import 'user.dart' as _i39;
import 'user_credential.dart' as _i40;
import 'user_email.dart' as _i41;
import 'user_lagnuage.dart' as _i42;
import 'user_preference.dart' as _i43;
import 'user_status.dart' as _i44;
export 'KycVerificationType.dart';
export 'area.dart';
export 'area_type.dart';
export 'audit_log.dart';
export 'blood_component.dart';
export 'config.dart';
export 'consent_record.dart';
export 'consent_type.dart';
export 'deferral/deferral.dart';
export 'deferral/deferral_reason.dart';
export 'deferral/deferral_source.dart';
export 'deferral/deferral_type.dart';
export 'device.dart';
export 'device_platform.dart';
export 'doner/alert_mode.dart';
export 'doner/blood_group.dart';
export 'doner/blood_group_source.dart';
export 'doner/donor_area.dart';
export 'doner/donor_area_kind.dart';
export 'doner/donor_profile.dart';
export 'doner/donor_status.dart';
export 'feature_flag.dart';
export 'flag_scope.dart';
export 'greetings/greeting.dart';
export 'kycStatus.dart';
export 'kyc_verificaiton.dart';
export 'otp_challenge.dart';
export 'otp_type.dart';
export 'readiness_check.dart';
export 'readiness_outcome.dart';
export 'sex.dart';
export 'tier_limit.dart';
export 'tier_verification_level.dart';
export 'tiers.dart';
export 'user.dart';
export 'user_credential.dart';
export 'user_email.dart';
export 'user_lagnuage.dart';
export 'user_preference.dart';
export 'user_status.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'app_area',
      dartName: 'Area',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_area_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AreaType',
        ),
        _i2.ColumnDefinition(
          name: 'district',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'centroidCell',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'BigInt?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_area_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'app_area_type',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'app_area_district',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'district',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'app_area_district_name',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'district',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'app_config',
      dartName: 'Config',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_config_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'Map<String,String>',
        ),
        _i2.ColumnDefinition(
          name: 'enabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'app_config_fk_0',
          columns: ['updatedById'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_config_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'app_config_key',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'app_config_updated_by',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'updatedById',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'app_user',
      dartName: 'User',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_user_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'phoneE164',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'phoneHmac',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imageKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'tierId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'donorPromptPending',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'lastDonorPromptAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'boundInstallId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'language',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Language',
          columnDefault: '\'bn\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:UserStatus',
          columnDefault: '\'active\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'suspendedReason',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'deletedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'app_user_fk_0',
          columns: ['tierId'],
          referenceTable: 'tier',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'app_user_phone_e164',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'phoneE164',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'app_user_status',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'app_user_tier_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'tierId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'app_user_preference',
      dartName: 'UserPreference',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_user_preference_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'notifyRequest',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'notifyFeed',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'quietHoursEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'quietHoursStart',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'quietHoursEnd',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'app_user_preference_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_user_preference_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'app_user_preference_user_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'audit_log',
      dartName: 'AuditLog',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'audit_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'actorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entityType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entityKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'details',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'metadata',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'audit_log_fk_0',
          columns: ['actorId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'audit_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'audit_log_actor_created_at',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'actorId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'audit_log_entity_created_at',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'entityType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'entityKey',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'consent_record',
      dartName: 'ConsentRecord',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'consent_record_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ConsentType',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'acceptedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'locale',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'appVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'withdrawnAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'consent_record_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'consent_record_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'consent_record_user_type_version',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'consent_record_user_type_accepted_at',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'acceptedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'deferral',
      dartName: 'Deferral',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'deferral_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'phoneHmac',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeferralType',
        ),
        _i2.ColumnDefinition(
          name: 'reason',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeferralReason',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeferralSource',
        ),
        _i2.ColumnDefinition(
          name: 'readinessCheckId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'liftedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'liftedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'deferral_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'deferral_fk_1',
          columns: ['readinessCheckId'],
          referenceTable: 'readiness_check',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'deferral_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'deferral_user_id_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'device',
      dartName: 'Device',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'installId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'platform',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Platform',
        ),
        _i2.ColumnDefinition(
          name: 'pushToken',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'pushTokenUpdatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'appVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'osVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'appCheckOkAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'revokedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'device_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_install_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'installId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_user_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_push_token',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'pushToken',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'donor_area',
      dartName: 'DonorArea',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'donor_area_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'donorProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DonorAreaKind',
        ),
        _i2.ColumnDefinition(
          name: 'areaId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'gpsCell',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'confirmedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'donor_area_fk_0',
          columns: ['donorProfileId'],
          referenceTable: 'donor_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'donor_area_fk_1',
          columns: ['areaId'],
          referenceTable: 'app_area',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'donor_area_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'donor_area_profile_kind',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'donorProfileId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'kind',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'donor_area_area',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'areaId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'donor_area_gps_cell',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'gpsCell',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'donor_profile',
      dartName: 'DonorProfile',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'donor_profile_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'dateOfBirth',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'sex',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Sex',
        ),
        _i2.ColumnDefinition(
          name: 'bloodGroup',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BloodGroup',
        ),
        _i2.ColumnDefinition(
          name: 'bloodGroupSource',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BloodGroupSource',
          columnDefault: '\'self\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'apheresisWilling',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'weightKg',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'weightDeclaredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastDonatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'totalDonations',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'donorStatus',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DonorStatus',
          columnDefault: '\'setupIncomplete\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'leftDonorAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'alertMode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertMode',
          columnDefault: '\'off\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'availableUntil',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'eligibiltyReminder',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'lastPromptAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'donor_profile_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'donor_profile_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'donor_profile_user_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'donor_profile_matching',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bloodGroup',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'donor_profile_availability_expiry',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'availableUntil',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feature_flag',
      dartName: 'FeatureFlag',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'feature_flag_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'enabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'scope',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FlagScope',
          columnDefault: '\'all\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'minAppVersion',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedById',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_flag_fk_0',
          columns: ['updatedById'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feature_flag_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_flag_key',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_flag_updated_by',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'updatedById',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'kyc_verification',
      dartName: 'KycVerification',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'kyc_verification_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:KycVerificationType',
        ),
        _i2.ColumnDefinition(
          name: 'provider',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'providerRef',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:KycStatus',
          columnDefault: '\'pending\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'subjectHmac',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'rejectionCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'submittedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'kyc_verification_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'kyc_verification_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'kyc_verification_user_type_status',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'kyc_verification_provider_ref',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'provider',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'providerRef',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'kyc_verification_subject_hmac_verified',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'subjectHmac',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'kyc_verification_user_type_pending',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'otp_challenge',
      dartName: 'OtpChallenge',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'otp_challenge_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'phoneE164',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'codeHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OtpType',
        ),
        _i2.ColumnDefinition(
          name: 'attempts',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'sendCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'consumedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'installId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'ip',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'otp_challenge_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'otp_challenge_phone_created_at',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'phoneE164',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'otp_challenge_ip_created_at',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'ip',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'otp_challenge_install_created_at',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'installId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'otp_challenge_phone_type_open',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'phoneE164',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'type',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'readiness_check',
      dartName: 'ReadinessCheck',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'readiness_check_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'donorProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'questionnaireVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'outcome',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ReadinessOutcome',
        ),
        _i2.ColumnDefinition(
          name: 'weightKg',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'validUntil',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'locale',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'appVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'checkedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'readiness_check_fk_0',
          columns: ['donorProfileId'],
          referenceTable: 'donor_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'readiness_check_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'readiness_check_donor_checked_at',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'donorProfileId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'checkedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'tier',
      dartName: 'Tier',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'tier_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'maxOpenRequests',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'requiresVerificationLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:VerificationLevel',
          columnDefault: '\'phone\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'tier_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'tier_code',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'tier_limit',
      dartName: 'TierLimit',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'tier_limit_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'tierId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'component',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BloodComponent',
        ),
        _i2.ColumnDefinition(
          name: 'maxOpenBags',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'maxBagsPerWindow',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'windowDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'tier_limit_fk_0',
          columns: ['tierId'],
          referenceTable: 'tier',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'tier_limit_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'tier_limit_tier_component',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'tierId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'component',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_credential',
      dartName: 'UserCredential',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_credential_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pinHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'failedAttempts',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'lockedUntil',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'pinChangedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_credential_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_credential_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_credential_user_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_email',
      dartName: 'UserEmail',
      schema: 'public',
      module: 'blood',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_email_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'verifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_email_fk_0',
          columns: ['userId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_email_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_email_user_id',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'user_email_email',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.KycVerificationType) {
      return _i5.KycVerificationType.fromJson(data) as T;
    }
    if (t == _i6.Area) {
      return _i6.Area.fromJson(data) as T;
    }
    if (t == _i7.AreaType) {
      return _i7.AreaType.fromJson(data) as T;
    }
    if (t == _i8.AuditLog) {
      return _i8.AuditLog.fromJson(data) as T;
    }
    if (t == _i9.BloodComponent) {
      return _i9.BloodComponent.fromJson(data) as T;
    }
    if (t == _i10.Config) {
      return _i10.Config.fromJson(data) as T;
    }
    if (t == _i11.ConsentRecord) {
      return _i11.ConsentRecord.fromJson(data) as T;
    }
    if (t == _i12.ConsentType) {
      return _i12.ConsentType.fromJson(data) as T;
    }
    if (t == _i13.Deferral) {
      return _i13.Deferral.fromJson(data) as T;
    }
    if (t == _i14.DeferralReason) {
      return _i14.DeferralReason.fromJson(data) as T;
    }
    if (t == _i15.DeferralSource) {
      return _i15.DeferralSource.fromJson(data) as T;
    }
    if (t == _i16.DeferralType) {
      return _i16.DeferralType.fromJson(data) as T;
    }
    if (t == _i17.Device) {
      return _i17.Device.fromJson(data) as T;
    }
    if (t == _i18.Platform) {
      return _i18.Platform.fromJson(data) as T;
    }
    if (t == _i19.AlertMode) {
      return _i19.AlertMode.fromJson(data) as T;
    }
    if (t == _i20.BloodGroup) {
      return _i20.BloodGroup.fromJson(data) as T;
    }
    if (t == _i21.BloodGroupSource) {
      return _i21.BloodGroupSource.fromJson(data) as T;
    }
    if (t == _i22.DonorArea) {
      return _i22.DonorArea.fromJson(data) as T;
    }
    if (t == _i23.DonorAreaKind) {
      return _i23.DonorAreaKind.fromJson(data) as T;
    }
    if (t == _i24.DonorProfile) {
      return _i24.DonorProfile.fromJson(data) as T;
    }
    if (t == _i25.DonorStatus) {
      return _i25.DonorStatus.fromJson(data) as T;
    }
    if (t == _i26.FeatureFlag) {
      return _i26.FeatureFlag.fromJson(data) as T;
    }
    if (t == _i27.FlagScope) {
      return _i27.FlagScope.fromJson(data) as T;
    }
    if (t == _i28.Greeting) {
      return _i28.Greeting.fromJson(data) as T;
    }
    if (t == _i29.KycStatus) {
      return _i29.KycStatus.fromJson(data) as T;
    }
    if (t == _i30.KycVerification) {
      return _i30.KycVerification.fromJson(data) as T;
    }
    if (t == _i31.OtpChallenge) {
      return _i31.OtpChallenge.fromJson(data) as T;
    }
    if (t == _i32.OtpType) {
      return _i32.OtpType.fromJson(data) as T;
    }
    if (t == _i33.ReadinessCheck) {
      return _i33.ReadinessCheck.fromJson(data) as T;
    }
    if (t == _i34.ReadinessOutcome) {
      return _i34.ReadinessOutcome.fromJson(data) as T;
    }
    if (t == _i35.Sex) {
      return _i35.Sex.fromJson(data) as T;
    }
    if (t == _i36.TierLimit) {
      return _i36.TierLimit.fromJson(data) as T;
    }
    if (t == _i37.VerificationLevel) {
      return _i37.VerificationLevel.fromJson(data) as T;
    }
    if (t == _i38.Tier) {
      return _i38.Tier.fromJson(data) as T;
    }
    if (t == _i39.User) {
      return _i39.User.fromJson(data) as T;
    }
    if (t == _i40.UserCredential) {
      return _i40.UserCredential.fromJson(data) as T;
    }
    if (t == _i41.UserEmail) {
      return _i41.UserEmail.fromJson(data) as T;
    }
    if (t == _i42.Language) {
      return _i42.Language.fromJson(data) as T;
    }
    if (t == _i43.UserPreference) {
      return _i43.UserPreference.fromJson(data) as T;
    }
    if (t == _i44.UserStatus) {
      return _i44.UserStatus.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.KycVerificationType?>()) {
      return (data != null ? _i5.KycVerificationType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.Area?>()) {
      return (data != null ? _i6.Area.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AreaType?>()) {
      return (data != null ? _i7.AreaType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AuditLog?>()) {
      return (data != null ? _i8.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.BloodComponent?>()) {
      return (data != null ? _i9.BloodComponent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Config?>()) {
      return (data != null ? _i10.Config.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ConsentRecord?>()) {
      return (data != null ? _i11.ConsentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ConsentType?>()) {
      return (data != null ? _i12.ConsentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Deferral?>()) {
      return (data != null ? _i13.Deferral.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.DeferralReason?>()) {
      return (data != null ? _i14.DeferralReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.DeferralSource?>()) {
      return (data != null ? _i15.DeferralSource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.DeferralType?>()) {
      return (data != null ? _i16.DeferralType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Device?>()) {
      return (data != null ? _i17.Device.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Platform?>()) {
      return (data != null ? _i18.Platform.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.AlertMode?>()) {
      return (data != null ? _i19.AlertMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.BloodGroup?>()) {
      return (data != null ? _i20.BloodGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.BloodGroupSource?>()) {
      return (data != null ? _i21.BloodGroupSource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.DonorArea?>()) {
      return (data != null ? _i22.DonorArea.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.DonorAreaKind?>()) {
      return (data != null ? _i23.DonorAreaKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.DonorProfile?>()) {
      return (data != null ? _i24.DonorProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.DonorStatus?>()) {
      return (data != null ? _i25.DonorStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.FeatureFlag?>()) {
      return (data != null ? _i26.FeatureFlag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.FlagScope?>()) {
      return (data != null ? _i27.FlagScope.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.Greeting?>()) {
      return (data != null ? _i28.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.KycStatus?>()) {
      return (data != null ? _i29.KycStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.KycVerification?>()) {
      return (data != null ? _i30.KycVerification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.OtpChallenge?>()) {
      return (data != null ? _i31.OtpChallenge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.OtpType?>()) {
      return (data != null ? _i32.OtpType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.ReadinessCheck?>()) {
      return (data != null ? _i33.ReadinessCheck.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.ReadinessOutcome?>()) {
      return (data != null ? _i34.ReadinessOutcome.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Sex?>()) {
      return (data != null ? _i35.Sex.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.TierLimit?>()) {
      return (data != null ? _i36.TierLimit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.VerificationLevel?>()) {
      return (data != null ? _i37.VerificationLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.Tier?>()) {
      return (data != null ? _i38.Tier.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.User?>()) {
      return (data != null ? _i39.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.UserCredential?>()) {
      return (data != null ? _i40.UserCredential.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.UserEmail?>()) {
      return (data != null ? _i41.UserEmail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.Language?>()) {
      return (data != null ? _i42.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.UserPreference?>()) {
      return (data != null ? _i43.UserPreference.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.UserStatus?>()) {
      return (data != null ? _i44.UserStatus.fromJson(data) : null) as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == Map<String, List<String>>) {
      return (data as Map).map(
            (k, v) =>
                MapEntry(deserialize<String>(k), deserialize<List<String>>(v)),
          )
          as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<bool>) {
      return (data as List).map((e) => deserialize<bool>(e)).toList() as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.KycVerificationType => 'KycVerificationType',
      _i6.Area => 'Area',
      _i7.AreaType => 'AreaType',
      _i8.AuditLog => 'AuditLog',
      _i9.BloodComponent => 'BloodComponent',
      _i10.Config => 'Config',
      _i11.ConsentRecord => 'ConsentRecord',
      _i12.ConsentType => 'ConsentType',
      _i13.Deferral => 'Deferral',
      _i14.DeferralReason => 'DeferralReason',
      _i15.DeferralSource => 'DeferralSource',
      _i16.DeferralType => 'DeferralType',
      _i17.Device => 'Device',
      _i18.Platform => 'Platform',
      _i19.AlertMode => 'AlertMode',
      _i20.BloodGroup => 'BloodGroup',
      _i21.BloodGroupSource => 'BloodGroupSource',
      _i22.DonorArea => 'DonorArea',
      _i23.DonorAreaKind => 'DonorAreaKind',
      _i24.DonorProfile => 'DonorProfile',
      _i25.DonorStatus => 'DonorStatus',
      _i26.FeatureFlag => 'FeatureFlag',
      _i27.FlagScope => 'FlagScope',
      _i28.Greeting => 'Greeting',
      _i29.KycStatus => 'KycStatus',
      _i30.KycVerification => 'KycVerification',
      _i31.OtpChallenge => 'OtpChallenge',
      _i32.OtpType => 'OtpType',
      _i33.ReadinessCheck => 'ReadinessCheck',
      _i34.ReadinessOutcome => 'ReadinessOutcome',
      _i35.Sex => 'Sex',
      _i36.TierLimit => 'TierLimit',
      _i37.VerificationLevel => 'VerificationLevel',
      _i38.Tier => 'Tier',
      _i39.User => 'User',
      _i40.UserCredential => 'UserCredential',
      _i41.UserEmail => 'UserEmail',
      _i42.Language => 'Language',
      _i43.UserPreference => 'UserPreference',
      _i44.UserStatus => 'UserStatus',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('blood.', '');
    }

    switch (data) {
      case _i5.KycVerificationType():
        return 'KycVerificationType';
      case _i6.Area():
        return 'Area';
      case _i7.AreaType():
        return 'AreaType';
      case _i8.AuditLog():
        return 'AuditLog';
      case _i9.BloodComponent():
        return 'BloodComponent';
      case _i10.Config():
        return 'Config';
      case _i11.ConsentRecord():
        return 'ConsentRecord';
      case _i12.ConsentType():
        return 'ConsentType';
      case _i13.Deferral():
        return 'Deferral';
      case _i14.DeferralReason():
        return 'DeferralReason';
      case _i15.DeferralSource():
        return 'DeferralSource';
      case _i16.DeferralType():
        return 'DeferralType';
      case _i17.Device():
        return 'Device';
      case _i18.Platform():
        return 'Platform';
      case _i19.AlertMode():
        return 'AlertMode';
      case _i20.BloodGroup():
        return 'BloodGroup';
      case _i21.BloodGroupSource():
        return 'BloodGroupSource';
      case _i22.DonorArea():
        return 'DonorArea';
      case _i23.DonorAreaKind():
        return 'DonorAreaKind';
      case _i24.DonorProfile():
        return 'DonorProfile';
      case _i25.DonorStatus():
        return 'DonorStatus';
      case _i26.FeatureFlag():
        return 'FeatureFlag';
      case _i27.FlagScope():
        return 'FlagScope';
      case _i28.Greeting():
        return 'Greeting';
      case _i29.KycStatus():
        return 'KycStatus';
      case _i30.KycVerification():
        return 'KycVerification';
      case _i31.OtpChallenge():
        return 'OtpChallenge';
      case _i32.OtpType():
        return 'OtpType';
      case _i33.ReadinessCheck():
        return 'ReadinessCheck';
      case _i34.ReadinessOutcome():
        return 'ReadinessOutcome';
      case _i35.Sex():
        return 'Sex';
      case _i36.TierLimit():
        return 'TierLimit';
      case _i37.VerificationLevel():
        return 'VerificationLevel';
      case _i38.Tier():
        return 'Tier';
      case _i39.User():
        return 'User';
      case _i40.UserCredential():
        return 'UserCredential';
      case _i41.UserEmail():
        return 'UserEmail';
      case _i42.Language():
        return 'Language';
      case _i43.UserPreference():
        return 'UserPreference';
      case _i44.UserStatus():
        return 'UserStatus';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'KycVerificationType') {
      return deserialize<_i5.KycVerificationType>(data['data']);
    }
    if (dataClassName == 'Area') {
      return deserialize<_i6.Area>(data['data']);
    }
    if (dataClassName == 'AreaType') {
      return deserialize<_i7.AreaType>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_i8.AuditLog>(data['data']);
    }
    if (dataClassName == 'BloodComponent') {
      return deserialize<_i9.BloodComponent>(data['data']);
    }
    if (dataClassName == 'Config') {
      return deserialize<_i10.Config>(data['data']);
    }
    if (dataClassName == 'ConsentRecord') {
      return deserialize<_i11.ConsentRecord>(data['data']);
    }
    if (dataClassName == 'ConsentType') {
      return deserialize<_i12.ConsentType>(data['data']);
    }
    if (dataClassName == 'Deferral') {
      return deserialize<_i13.Deferral>(data['data']);
    }
    if (dataClassName == 'DeferralReason') {
      return deserialize<_i14.DeferralReason>(data['data']);
    }
    if (dataClassName == 'DeferralSource') {
      return deserialize<_i15.DeferralSource>(data['data']);
    }
    if (dataClassName == 'DeferralType') {
      return deserialize<_i16.DeferralType>(data['data']);
    }
    if (dataClassName == 'Device') {
      return deserialize<_i17.Device>(data['data']);
    }
    if (dataClassName == 'Platform') {
      return deserialize<_i18.Platform>(data['data']);
    }
    if (dataClassName == 'AlertMode') {
      return deserialize<_i19.AlertMode>(data['data']);
    }
    if (dataClassName == 'BloodGroup') {
      return deserialize<_i20.BloodGroup>(data['data']);
    }
    if (dataClassName == 'BloodGroupSource') {
      return deserialize<_i21.BloodGroupSource>(data['data']);
    }
    if (dataClassName == 'DonorArea') {
      return deserialize<_i22.DonorArea>(data['data']);
    }
    if (dataClassName == 'DonorAreaKind') {
      return deserialize<_i23.DonorAreaKind>(data['data']);
    }
    if (dataClassName == 'DonorProfile') {
      return deserialize<_i24.DonorProfile>(data['data']);
    }
    if (dataClassName == 'DonorStatus') {
      return deserialize<_i25.DonorStatus>(data['data']);
    }
    if (dataClassName == 'FeatureFlag') {
      return deserialize<_i26.FeatureFlag>(data['data']);
    }
    if (dataClassName == 'FlagScope') {
      return deserialize<_i27.FlagScope>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i28.Greeting>(data['data']);
    }
    if (dataClassName == 'KycStatus') {
      return deserialize<_i29.KycStatus>(data['data']);
    }
    if (dataClassName == 'KycVerification') {
      return deserialize<_i30.KycVerification>(data['data']);
    }
    if (dataClassName == 'OtpChallenge') {
      return deserialize<_i31.OtpChallenge>(data['data']);
    }
    if (dataClassName == 'OtpType') {
      return deserialize<_i32.OtpType>(data['data']);
    }
    if (dataClassName == 'ReadinessCheck') {
      return deserialize<_i33.ReadinessCheck>(data['data']);
    }
    if (dataClassName == 'ReadinessOutcome') {
      return deserialize<_i34.ReadinessOutcome>(data['data']);
    }
    if (dataClassName == 'Sex') {
      return deserialize<_i35.Sex>(data['data']);
    }
    if (dataClassName == 'TierLimit') {
      return deserialize<_i36.TierLimit>(data['data']);
    }
    if (dataClassName == 'VerificationLevel') {
      return deserialize<_i37.VerificationLevel>(data['data']);
    }
    if (dataClassName == 'Tier') {
      return deserialize<_i38.Tier>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i39.User>(data['data']);
    }
    if (dataClassName == 'UserCredential') {
      return deserialize<_i40.UserCredential>(data['data']);
    }
    if (dataClassName == 'UserEmail') {
      return deserialize<_i41.UserEmail>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i42.Language>(data['data']);
    }
    if (dataClassName == 'UserPreference') {
      return deserialize<_i43.UserPreference>(data['data']);
    }
    if (dataClassName == 'UserStatus') {
      return deserialize<_i44.UserStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.Area:
        return _i6.Area.t;
      case _i8.AuditLog:
        return _i8.AuditLog.t;
      case _i10.Config:
        return _i10.Config.t;
      case _i11.ConsentRecord:
        return _i11.ConsentRecord.t;
      case _i13.Deferral:
        return _i13.Deferral.t;
      case _i17.Device:
        return _i17.Device.t;
      case _i22.DonorArea:
        return _i22.DonorArea.t;
      case _i24.DonorProfile:
        return _i24.DonorProfile.t;
      case _i26.FeatureFlag:
        return _i26.FeatureFlag.t;
      case _i30.KycVerification:
        return _i30.KycVerification.t;
      case _i31.OtpChallenge:
        return _i31.OtpChallenge.t;
      case _i33.ReadinessCheck:
        return _i33.ReadinessCheck.t;
      case _i36.TierLimit:
        return _i36.TierLimit.t;
      case _i38.Tier:
        return _i38.Tier.t;
      case _i39.User:
        return _i39.User.t;
      case _i40.UserCredential:
        return _i40.UserCredential.t;
      case _i41.UserEmail:
        return _i41.UserEmail.t;
      case _i43.UserPreference:
        return _i43.UserPreference.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'blood';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
