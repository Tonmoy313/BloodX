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
// ignore_for_file: unnecessary_null_comparison

import 'package:serverpod/serverpod.dart' as _i1;
import 'user.dart' as _i2;
import 'package:blood_server/src/generated/protocol.dart' as _i3;

abstract class Config implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Config._({
    this.id,
    required this.key,
    required this.value,
    bool? enabled,
    required this.updatedById,
    this.updatedBy,
    DateTime? updatedAt,
  }) : enabled = enabled ?? true,
       updatedAt = updatedAt ?? DateTime.now();

  factory Config({
    int? id,
    required String key,
    required Map<String, String> value,
    bool? enabled,
    required int updatedById,
    _i2.User? updatedBy,
    DateTime? updatedAt,
  }) = _ConfigImpl;

  factory Config.fromJson(Map<String, dynamic> jsonSerialization) {
    return Config(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      value: _i3.Protocol().deserialize<Map<String, String>>(
        jsonSerialization['value'],
      ),
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      updatedById: jsonSerialization['updatedById'] as int,
      updatedBy: jsonSerialization['updatedBy'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(
              jsonSerialization['updatedBy'],
            ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ConfigTable();

  static const db = ConfigRepository._();

  @override
  int? id;

  String key;

  Map<String, String> value;

  bool enabled;

  int updatedById;

  _i2.User? updatedBy;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Config]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Config copyWith({
    int? id,
    String? key,
    Map<String, String>? value,
    bool? enabled,
    int? updatedById,
    _i2.User? updatedBy,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Config',
      if (id != null) 'id': id,
      'key': key,
      'value': value.toJson(),
      'enabled': enabled,
      'updatedById': updatedById,
      if (updatedBy != null) 'updatedBy': updatedBy?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ConfigInclude include({_i2.UserInclude? updatedBy}) {
    return ConfigInclude._(updatedBy: updatedBy);
  }

  static ConfigIncludeList includeList({
    _i1.WhereExpressionBuilder<ConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConfigTable>? orderByList,
    ConfigInclude? include,
  }) {
    return ConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Config.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Config.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConfigImpl extends Config {
  _ConfigImpl({
    int? id,
    required String key,
    required Map<String, String> value,
    bool? enabled,
    required int updatedById,
    _i2.User? updatedBy,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         key: key,
         value: value,
         enabled: enabled,
         updatedById: updatedById,
         updatedBy: updatedBy,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Config]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Config copyWith({
    Object? id = _Undefined,
    String? key,
    Map<String, String>? value,
    bool? enabled,
    int? updatedById,
    Object? updatedBy = _Undefined,
    DateTime? updatedAt,
  }) {
    return Config(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      value:
          value ??
          this.value.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      enabled: enabled ?? this.enabled,
      updatedById: updatedById ?? this.updatedById,
      updatedBy: updatedBy is _i2.User?
          ? updatedBy
          : this.updatedBy?.copyWith(),
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ConfigUpdateTable extends _i1.UpdateTable<ConfigTable> {
  ConfigUpdateTable(super.table);

  _i1.ColumnValue<String, String> key(String value) => _i1.ColumnValue(
    table.key,
    value,
  );

  _i1.ColumnValue<Map<String, String>, Map<String, String>> value(
    Map<String, String> value,
  ) => _i1.ColumnValue(
    table.value,
    value,
  );

  _i1.ColumnValue<bool, bool> enabled(bool value) => _i1.ColumnValue(
    table.enabled,
    value,
  );

  _i1.ColumnValue<int, int> updatedById(int value) => _i1.ColumnValue(
    table.updatedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ConfigTable extends _i1.Table<int?> {
  ConfigTable({super.tableRelation}) : super(tableName: 'app_config') {
    updateTable = ConfigUpdateTable(this);
    key = _i1.ColumnString(
      'key',
      this,
    );
    value = _i1.ColumnSerializable<Map<String, String>>(
      'value',
      this,
    );
    enabled = _i1.ColumnBool(
      'enabled',
      this,
      hasDefault: true,
    );
    updatedById = _i1.ColumnInt(
      'updatedById',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ConfigUpdateTable updateTable;

  late final _i1.ColumnString key;

  late final _i1.ColumnSerializable<Map<String, String>> value;

  late final _i1.ColumnBool enabled;

  late final _i1.ColumnInt updatedById;

  _i2.UserTable? _updatedBy;

  late final _i1.ColumnDateTime updatedAt;

  _i2.UserTable get updatedBy {
    if (_updatedBy != null) return _updatedBy!;
    _updatedBy = _i1.createRelationTable(
      relationFieldName: 'updatedBy',
      field: Config.t.updatedById,
      foreignField: _i2.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return _updatedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    key,
    value,
    enabled,
    updatedById,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'updatedBy') {
      return updatedBy;
    }
    return null;
  }
}

class ConfigInclude extends _i1.IncludeObject {
  ConfigInclude._({_i2.UserInclude? updatedBy}) {
    _updatedBy = updatedBy;
  }

  _i2.UserInclude? _updatedBy;

  @override
  Map<String, _i1.Include?> get includes => {'updatedBy': _updatedBy};

  @override
  _i1.Table<int?> get table => Config.t;
}

class ConfigIncludeList extends _i1.IncludeList {
  ConfigIncludeList._({
    _i1.WhereExpressionBuilder<ConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Config.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Config.t;
}

class ConfigRepository {
  const ConfigRepository._();

  final attachRow = const ConfigAttachRowRepository._();

  /// Returns a list of [Config]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Config>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConfigTable>? orderByList,
    _i1.Transaction? transaction,
    ConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Config>(
      where: where?.call(Config.t),
      orderBy: orderBy?.call(Config.t),
      orderByList: orderByList?.call(Config.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Config] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Config?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConfigTable>? where,
    int? offset,
    _i1.OrderByBuilder<ConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConfigTable>? orderByList,
    _i1.Transaction? transaction,
    ConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Config>(
      where: where?.call(Config.t),
      orderBy: orderBy?.call(Config.t),
      orderByList: orderByList?.call(Config.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Config] by its [id] or null if no such row exists.
  Future<Config?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Config>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Config]s in the list and returns the inserted rows.
  ///
  /// The returned [Config]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Config>> insert(
    _i1.DatabaseSession session,
    List<Config> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Config>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Config] and returns the inserted row.
  ///
  /// The returned [Config] will have its `id` field set.
  Future<Config> insertRow(
    _i1.DatabaseSession session,
    Config row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Config>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Config]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Config>> update(
    _i1.DatabaseSession session,
    List<Config> rows, {
    _i1.ColumnSelections<ConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Config>(
      rows,
      columns: columns?.call(Config.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Config]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Config> updateRow(
    _i1.DatabaseSession session,
    Config row, {
    _i1.ColumnSelections<ConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Config>(
      row,
      columns: columns?.call(Config.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Config] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Config?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ConfigUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Config>(
      id,
      columnValues: columnValues(Config.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Config]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Config>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ConfigUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ConfigTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConfigTable>? orderBy,
    _i1.OrderByListBuilder<ConfigTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Config>(
      columnValues: columnValues(Config.t.updateTable),
      where: where(Config.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Config.t),
      orderByList: orderByList?.call(Config.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Config]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Config>> delete(
    _i1.DatabaseSession session,
    List<Config> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Config>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Config].
  Future<Config> deleteRow(
    _i1.DatabaseSession session,
    Config row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Config>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Config>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ConfigTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Config>(
      where: where(Config.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConfigTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Config>(
      where: where?.call(Config.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Config] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ConfigTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Config>(
      where: where(Config.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ConfigAttachRowRepository {
  const ConfigAttachRowRepository._();

  /// Creates a relation between the given [Config] and [User]
  /// by setting the [Config]'s foreign key `updatedById` to refer to the [User].
  Future<void> updatedBy(
    _i1.DatabaseSession session,
    Config config,
    _i2.User updatedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (config.id == null) {
      throw ArgumentError.notNull('config.id');
    }
    if (updatedBy.id == null) {
      throw ArgumentError.notNull('updatedBy.id');
    }

    var $config = config.copyWith(updatedById: updatedBy.id);
    await session.db.updateRow<Config>(
      $config,
      columns: [Config.t.updatedById],
      transaction: transaction,
    );
  }
}
