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
import 'consent_type.dart' as _i3;
import 'package:blood_server/src/generated/protocol.dart' as _i4;

abstract class ConsentRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ConsentRecord._({
    this.id,
    required this.userId,
    this.user,
    required this.type,
    required this.version,
    required this.acceptedAt,
    required this.locale,
    required this.appVersion,
    this.withdrawnAt,
  });

  factory ConsentRecord({
    int? id,
    required int userId,
    _i2.User? user,
    required _i3.ConsentType type,
    required String version,
    required DateTime acceptedAt,
    required String locale,
    required String appVersion,
    DateTime? withdrawnAt,
  }) = _ConsentRecordImpl;

  factory ConsentRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConsentRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      type: _i3.ConsentType.fromJson((jsonSerialization['type'] as String)),
      version: jsonSerialization['version'] as String,
      acceptedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['acceptedAt'],
      ),
      locale: jsonSerialization['locale'] as String,
      appVersion: jsonSerialization['appVersion'] as String,
      withdrawnAt: jsonSerialization['withdrawnAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['withdrawnAt'],
            ),
    );
  }

  static final t = ConsentRecordTable();

  static const db = ConsentRecordRepository._();

  @override
  int? id;

  int userId;

  _i2.User? user;

  _i3.ConsentType type;

  String version;

  DateTime acceptedAt;

  String locale;

  String appVersion;

  DateTime? withdrawnAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ConsentRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ConsentRecord copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    _i3.ConsentType? type,
    String? version,
    DateTime? acceptedAt,
    String? locale,
    String? appVersion,
    DateTime? withdrawnAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConsentRecord',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'type': type.toJson(),
      'version': version,
      'acceptedAt': acceptedAt.toJson(),
      'locale': locale,
      'appVersion': appVersion,
      if (withdrawnAt != null) 'withdrawnAt': withdrawnAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ConsentRecordInclude include({_i2.UserInclude? user}) {
    return ConsentRecordInclude._(user: user);
  }

  static ConsentRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConsentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsentRecordTable>? orderByList,
    ConsentRecordInclude? include,
  }) {
    return ConsentRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConsentRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ConsentRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConsentRecordImpl extends ConsentRecord {
  _ConsentRecordImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required _i3.ConsentType type,
    required String version,
    required DateTime acceptedAt,
    required String locale,
    required String appVersion,
    DateTime? withdrawnAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         type: type,
         version: version,
         acceptedAt: acceptedAt,
         locale: locale,
         appVersion: appVersion,
         withdrawnAt: withdrawnAt,
       );

  /// Returns a shallow copy of this [ConsentRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ConsentRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    _i3.ConsentType? type,
    String? version,
    DateTime? acceptedAt,
    String? locale,
    String? appVersion,
    Object? withdrawnAt = _Undefined,
  }) {
    return ConsentRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      type: type ?? this.type,
      version: version ?? this.version,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      locale: locale ?? this.locale,
      appVersion: appVersion ?? this.appVersion,
      withdrawnAt: withdrawnAt is DateTime? ? withdrawnAt : this.withdrawnAt,
    );
  }
}

class ConsentRecordUpdateTable extends _i1.UpdateTable<ConsentRecordTable> {
  ConsentRecordUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<_i3.ConsentType, _i3.ConsentType> type(
    _i3.ConsentType value,
  ) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<String, String> version(String value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> acceptedAt(DateTime value) =>
      _i1.ColumnValue(
        table.acceptedAt,
        value,
      );

  _i1.ColumnValue<String, String> locale(String value) => _i1.ColumnValue(
    table.locale,
    value,
  );

  _i1.ColumnValue<String, String> appVersion(String value) => _i1.ColumnValue(
    table.appVersion,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> withdrawnAt(DateTime? value) =>
      _i1.ColumnValue(
        table.withdrawnAt,
        value,
      );
}

class ConsentRecordTable extends _i1.Table<int?> {
  ConsentRecordTable({super.tableRelation})
    : super(tableName: 'consent_record') {
    updateTable = ConsentRecordUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    version = _i1.ColumnString(
      'version',
      this,
    );
    acceptedAt = _i1.ColumnDateTime(
      'acceptedAt',
      this,
    );
    locale = _i1.ColumnString(
      'locale',
      this,
    );
    appVersion = _i1.ColumnString(
      'appVersion',
      this,
    );
    withdrawnAt = _i1.ColumnDateTime(
      'withdrawnAt',
      this,
    );
  }

  late final ConsentRecordUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  _i2.UserTable? _user;

  late final _i1.ColumnEnum<_i3.ConsentType> type;

  late final _i1.ColumnString version;

  late final _i1.ColumnDateTime acceptedAt;

  late final _i1.ColumnString locale;

  late final _i1.ColumnString appVersion;

  late final _i1.ColumnDateTime withdrawnAt;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: ConsentRecord.t.userId,
      foreignField: _i2.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    type,
    version,
    acceptedAt,
    locale,
    appVersion,
    withdrawnAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class ConsentRecordInclude extends _i1.IncludeObject {
  ConsentRecordInclude._({_i2.UserInclude? user}) {
    _user = user;
  }

  _i2.UserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => ConsentRecord.t;
}

class ConsentRecordIncludeList extends _i1.IncludeList {
  ConsentRecordIncludeList._({
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ConsentRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ConsentRecord.t;
}

class ConsentRecordRepository {
  const ConsentRecordRepository._();

  final attachRow = const ConsentRecordAttachRowRepository._();

  /// Returns a list of [ConsentRecord]s matching the given query parameters.
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
  Future<List<ConsentRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConsentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsentRecordTable>? orderByList,
    _i1.Transaction? transaction,
    ConsentRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ConsentRecord>(
      where: where?.call(ConsentRecord.t),
      orderBy: orderBy?.call(ConsentRecord.t),
      orderByList: orderByList?.call(ConsentRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ConsentRecord] matching the given query parameters.
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
  Future<ConsentRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<ConsentRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsentRecordTable>? orderByList,
    _i1.Transaction? transaction,
    ConsentRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ConsentRecord>(
      where: where?.call(ConsentRecord.t),
      orderBy: orderBy?.call(ConsentRecord.t),
      orderByList: orderByList?.call(ConsentRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ConsentRecord] by its [id] or null if no such row exists.
  Future<ConsentRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ConsentRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ConsentRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ConsentRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [ConsentRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ConsentRecord>> insert(
    _i1.DatabaseSession session,
    List<ConsentRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ConsentRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ConsentRecord] and returns the inserted row.
  ///
  /// The returned [ConsentRecord] will have its `id` field set.
  Future<ConsentRecord> insertRow(
    _i1.DatabaseSession session,
    ConsentRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ConsentRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ConsentRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ConsentRecord>> update(
    _i1.DatabaseSession session,
    List<ConsentRecord> rows, {
    _i1.ColumnSelections<ConsentRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ConsentRecord>(
      rows,
      columns: columns?.call(ConsentRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConsentRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ConsentRecord> updateRow(
    _i1.DatabaseSession session,
    ConsentRecord row, {
    _i1.ColumnSelections<ConsentRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ConsentRecord>(
      row,
      columns: columns?.call(ConsentRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConsentRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ConsentRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ConsentRecordUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ConsentRecord>(
      id,
      columnValues: columnValues(ConsentRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ConsentRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ConsentRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ConsentRecordUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ConsentRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConsentRecordTable>? orderBy,
    _i1.OrderByListBuilder<ConsentRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ConsentRecord>(
      columnValues: columnValues(ConsentRecord.t.updateTable),
      where: where(ConsentRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConsentRecord.t),
      orderByList: orderByList?.call(ConsentRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ConsentRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ConsentRecord>> delete(
    _i1.DatabaseSession session,
    List<ConsentRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ConsentRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ConsentRecord].
  Future<ConsentRecord> deleteRow(
    _i1.DatabaseSession session,
    ConsentRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ConsentRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ConsentRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ConsentRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ConsentRecord>(
      where: where(ConsentRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConsentRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ConsentRecord>(
      where: where?.call(ConsentRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ConsentRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ConsentRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ConsentRecord>(
      where: where(ConsentRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ConsentRecordAttachRowRepository {
  const ConsentRecordAttachRowRepository._();

  /// Creates a relation between the given [ConsentRecord] and [User]
  /// by setting the [ConsentRecord]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.DatabaseSession session,
    ConsentRecord consentRecord,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (consentRecord.id == null) {
      throw ArgumentError.notNull('consentRecord.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $consentRecord = consentRecord.copyWith(userId: user.id);
    await session.db.updateRow<ConsentRecord>(
      $consentRecord,
      columns: [ConsentRecord.t.userId],
      transaction: transaction,
    );
  }
}
