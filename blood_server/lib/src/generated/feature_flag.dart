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
import 'flag_scope.dart' as _i2;
import 'user.dart' as _i3;
import 'package:blood_server/src/generated/protocol.dart' as _i4;

abstract class FeatureFlag
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatureFlag._({
    this.id,
    required this.key,
    required this.enabled,
    _i2.FlagScope? scope,
    this.minAppVersion,
    required this.updatedById,
    this.updatedBy,
    DateTime? updatedAt,
  }) : scope = scope ?? _i2.FlagScope.all,
       updatedAt = updatedAt ?? DateTime.now();

  factory FeatureFlag({
    int? id,
    required String key,
    required bool enabled,
    _i2.FlagScope? scope,
    String? minAppVersion,
    required int updatedById,
    _i3.User? updatedBy,
    DateTime? updatedAt,
  }) = _FeatureFlagImpl;

  factory FeatureFlag.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureFlag(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      scope: jsonSerialization['scope'] == null
          ? null
          : _i2.FlagScope.fromJson((jsonSerialization['scope'] as String)),
      minAppVersion: jsonSerialization['minAppVersion'] as String?,
      updatedById: jsonSerialization['updatedById'] as int,
      updatedBy: jsonSerialization['updatedBy'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.User>(
              jsonSerialization['updatedBy'],
            ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = FeatureFlagTable();

  static const db = FeatureFlagRepository._();

  @override
  int? id;

  String key;

  bool enabled;

  _i2.FlagScope scope;

  String? minAppVersion;

  int updatedById;

  _i3.User? updatedBy;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureFlag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureFlag copyWith({
    int? id,
    String? key,
    bool? enabled,
    _i2.FlagScope? scope,
    String? minAppVersion,
    int? updatedById,
    _i3.User? updatedBy,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureFlag',
      if (id != null) 'id': id,
      'key': key,
      'enabled': enabled,
      'scope': scope.toJson(),
      if (minAppVersion != null) 'minAppVersion': minAppVersion,
      'updatedById': updatedById,
      if (updatedBy != null) 'updatedBy': updatedBy?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static FeatureFlagInclude include({_i3.UserInclude? updatedBy}) {
    return FeatureFlagInclude._(updatedBy: updatedBy);
  }

  static FeatureFlagIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureFlagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureFlagTable>? orderByList,
    FeatureFlagInclude? include,
  }) {
    return FeatureFlagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureFlag.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureFlag.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureFlagImpl extends FeatureFlag {
  _FeatureFlagImpl({
    int? id,
    required String key,
    required bool enabled,
    _i2.FlagScope? scope,
    String? minAppVersion,
    required int updatedById,
    _i3.User? updatedBy,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         key: key,
         enabled: enabled,
         scope: scope,
         minAppVersion: minAppVersion,
         updatedById: updatedById,
         updatedBy: updatedBy,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FeatureFlag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureFlag copyWith({
    Object? id = _Undefined,
    String? key,
    bool? enabled,
    _i2.FlagScope? scope,
    Object? minAppVersion = _Undefined,
    int? updatedById,
    Object? updatedBy = _Undefined,
    DateTime? updatedAt,
  }) {
    return FeatureFlag(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      enabled: enabled ?? this.enabled,
      scope: scope ?? this.scope,
      minAppVersion: minAppVersion is String?
          ? minAppVersion
          : this.minAppVersion,
      updatedById: updatedById ?? this.updatedById,
      updatedBy: updatedBy is _i3.User?
          ? updatedBy
          : this.updatedBy?.copyWith(),
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FeatureFlagUpdateTable extends _i1.UpdateTable<FeatureFlagTable> {
  FeatureFlagUpdateTable(super.table);

  _i1.ColumnValue<String, String> key(String value) => _i1.ColumnValue(
    table.key,
    value,
  );

  _i1.ColumnValue<bool, bool> enabled(bool value) => _i1.ColumnValue(
    table.enabled,
    value,
  );

  _i1.ColumnValue<_i2.FlagScope, _i2.FlagScope> scope(_i2.FlagScope value) =>
      _i1.ColumnValue(
        table.scope,
        value,
      );

  _i1.ColumnValue<String, String> minAppVersion(String? value) =>
      _i1.ColumnValue(
        table.minAppVersion,
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

class FeatureFlagTable extends _i1.Table<int?> {
  FeatureFlagTable({super.tableRelation}) : super(tableName: 'feature_flag') {
    updateTable = FeatureFlagUpdateTable(this);
    key = _i1.ColumnString(
      'key',
      this,
    );
    enabled = _i1.ColumnBool(
      'enabled',
      this,
    );
    scope = _i1.ColumnEnum(
      'scope',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    minAppVersion = _i1.ColumnString(
      'minAppVersion',
      this,
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

  late final FeatureFlagUpdateTable updateTable;

  late final _i1.ColumnString key;

  late final _i1.ColumnBool enabled;

  late final _i1.ColumnEnum<_i2.FlagScope> scope;

  late final _i1.ColumnString minAppVersion;

  late final _i1.ColumnInt updatedById;

  _i3.UserTable? _updatedBy;

  late final _i1.ColumnDateTime updatedAt;

  _i3.UserTable get updatedBy {
    if (_updatedBy != null) return _updatedBy!;
    _updatedBy = _i1.createRelationTable(
      relationFieldName: 'updatedBy',
      field: FeatureFlag.t.updatedById,
      foreignField: _i3.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.UserTable(tableRelation: foreignTableRelation),
    );
    return _updatedBy!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    key,
    enabled,
    scope,
    minAppVersion,
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

class FeatureFlagInclude extends _i1.IncludeObject {
  FeatureFlagInclude._({_i3.UserInclude? updatedBy}) {
    _updatedBy = updatedBy;
  }

  _i3.UserInclude? _updatedBy;

  @override
  Map<String, _i1.Include?> get includes => {'updatedBy': _updatedBy};

  @override
  _i1.Table<int?> get table => FeatureFlag.t;
}

class FeatureFlagIncludeList extends _i1.IncludeList {
  FeatureFlagIncludeList._({
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureFlag.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureFlag.t;
}

class FeatureFlagRepository {
  const FeatureFlagRepository._();

  final attachRow = const FeatureFlagAttachRowRepository._();

  /// Returns a list of [FeatureFlag]s matching the given query parameters.
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
  Future<List<FeatureFlag>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureFlagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureFlagTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureFlagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureFlag>(
      where: where?.call(FeatureFlag.t),
      orderBy: orderBy?.call(FeatureFlag.t),
      orderByList: orderByList?.call(FeatureFlag.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatureFlag] matching the given query parameters.
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
  Future<FeatureFlag?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureFlagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureFlagTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureFlagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureFlag>(
      where: where?.call(FeatureFlag.t),
      orderBy: orderBy?.call(FeatureFlag.t),
      orderByList: orderByList?.call(FeatureFlag.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureFlag] by its [id] or null if no such row exists.
  Future<FeatureFlag?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    FeatureFlagInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureFlag>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureFlag]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureFlag]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FeatureFlag>> insert(
    _i1.DatabaseSession session,
    List<FeatureFlag> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FeatureFlag>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FeatureFlag] and returns the inserted row.
  ///
  /// The returned [FeatureFlag] will have its `id` field set.
  Future<FeatureFlag> insertRow(
    _i1.DatabaseSession session,
    FeatureFlag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureFlag>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureFlag]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureFlag>> update(
    _i1.DatabaseSession session,
    List<FeatureFlag> rows, {
    _i1.ColumnSelections<FeatureFlagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureFlag>(
      rows,
      columns: columns?.call(FeatureFlag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureFlag]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureFlag> updateRow(
    _i1.DatabaseSession session,
    FeatureFlag row, {
    _i1.ColumnSelections<FeatureFlagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureFlag>(
      row,
      columns: columns?.call(FeatureFlag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureFlag] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureFlag?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FeatureFlagUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureFlag>(
      id,
      columnValues: columnValues(FeatureFlag.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureFlag]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FeatureFlag>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FeatureFlagUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FeatureFlagTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureFlagTable>? orderBy,
    _i1.OrderByListBuilder<FeatureFlagTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FeatureFlag>(
      columnValues: columnValues(FeatureFlag.t.updateTable),
      where: where(FeatureFlag.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureFlag.t),
      orderByList: orderByList?.call(FeatureFlag.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureFlag]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureFlag>> delete(
    _i1.DatabaseSession session,
    List<FeatureFlag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureFlag>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureFlag].
  Future<FeatureFlag> deleteRow(
    _i1.DatabaseSession session,
    FeatureFlag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureFlag>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureFlag>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FeatureFlagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureFlag>(
      where: where(FeatureFlag.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureFlagTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureFlag>(
      where: where?.call(FeatureFlag.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureFlag] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FeatureFlagTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureFlag>(
      where: where(FeatureFlag.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FeatureFlagAttachRowRepository {
  const FeatureFlagAttachRowRepository._();

  /// Creates a relation between the given [FeatureFlag] and [User]
  /// by setting the [FeatureFlag]'s foreign key `updatedById` to refer to the [User].
  Future<void> updatedBy(
    _i1.DatabaseSession session,
    FeatureFlag featureFlag,
    _i3.User updatedBy, {
    _i1.Transaction? transaction,
  }) async {
    if (featureFlag.id == null) {
      throw ArgumentError.notNull('featureFlag.id');
    }
    if (updatedBy.id == null) {
      throw ArgumentError.notNull('updatedBy.id');
    }

    var $featureFlag = featureFlag.copyWith(updatedById: updatedBy.id);
    await session.db.updateRow<FeatureFlag>(
      $featureFlag,
      columns: [FeatureFlag.t.updatedById],
      transaction: transaction,
    );
  }
}
