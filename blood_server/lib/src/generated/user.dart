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
import 'language.dart' as _i2;
import 'user_status.dart' as _i3;

abstract class User implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  User._({
    this.id,
    this.phoneE164,
    this.phoneHmac,
    required this.displayName,
    this.authUserId,
    _i2.Language? language,
    _i3.UserStatus? status,
    this.suspendedReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.lastSeenAt,
    this.deletedAt,
    this.lastDonorPromptAt,
    bool? donorPromptPending,
  }) : language = language ?? _i2.Language.bn,
       status = status ?? _i3.UserStatus.active,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now(),
       donorPromptPending = donorPromptPending ?? false;

  factory User({
    int? id,
    String? phoneE164,
    String? phoneHmac,
    required String displayName,
    _i1.UuidValue? authUserId,
    _i2.Language? language,
    _i3.UserStatus? status,
    String? suspendedReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSeenAt,
    DateTime? deletedAt,
    DateTime? lastDonorPromptAt,
    bool? donorPromptPending,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      phoneE164: jsonSerialization['phoneE164'] as String?,
      phoneHmac: jsonSerialization['phoneHmac'] as String?,
      displayName: jsonSerialization['displayName'] as String,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      language: jsonSerialization['language'] == null
          ? null
          : _i2.Language.fromJson((jsonSerialization['language'] as String)),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.UserStatus.fromJson((jsonSerialization['status'] as String)),
      suspendedReason: jsonSerialization['suspendedReason'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      lastDonorPromptAt: jsonSerialization['lastDonorPromptAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastDonorPromptAt'],
            ),
      donorPromptPending: jsonSerialization['donorPromptPending'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['donorPromptPending'],
            ),
    );
  }

  static final t = UserTable();

  static const db = UserRepository._();

  @override
  int? id;

  String? phoneE164;

  String? phoneHmac;

  String displayName;

  _i1.UuidValue? authUserId;

  _i2.Language language;

  _i3.UserStatus status;

  String? suspendedReason;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? lastSeenAt;

  DateTime? deletedAt;

  DateTime? lastDonorPromptAt;

  bool donorPromptPending;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? phoneE164,
    String? phoneHmac,
    String? displayName,
    _i1.UuidValue? authUserId,
    _i2.Language? language,
    _i3.UserStatus? status,
    String? suspendedReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSeenAt,
    DateTime? deletedAt,
    DateTime? lastDonorPromptAt,
    bool? donorPromptPending,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      if (phoneE164 != null) 'phoneE164': phoneE164,
      if (phoneHmac != null) 'phoneHmac': phoneHmac,
      'displayName': displayName,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      'language': language.toJson(),
      'status': status.toJson(),
      if (suspendedReason != null) 'suspendedReason': suspendedReason,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      if (lastDonorPromptAt != null)
        'lastDonorPromptAt': lastDonorPromptAt?.toJson(),
      'donorPromptPending': donorPromptPending,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static UserInclude include() {
    return UserInclude._();
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    String? phoneE164,
    String? phoneHmac,
    required String displayName,
    _i1.UuidValue? authUserId,
    _i2.Language? language,
    _i3.UserStatus? status,
    String? suspendedReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSeenAt,
    DateTime? deletedAt,
    DateTime? lastDonorPromptAt,
    bool? donorPromptPending,
  }) : super._(
         id: id,
         phoneE164: phoneE164,
         phoneHmac: phoneHmac,
         displayName: displayName,
         authUserId: authUserId,
         language: language,
         status: status,
         suspendedReason: suspendedReason,
         createdAt: createdAt,
         updatedAt: updatedAt,
         lastSeenAt: lastSeenAt,
         deletedAt: deletedAt,
         lastDonorPromptAt: lastDonorPromptAt,
         donorPromptPending: donorPromptPending,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    Object? phoneE164 = _Undefined,
    Object? phoneHmac = _Undefined,
    String? displayName,
    Object? authUserId = _Undefined,
    _i2.Language? language,
    _i3.UserStatus? status,
    Object? suspendedReason = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? lastSeenAt = _Undefined,
    Object? deletedAt = _Undefined,
    Object? lastDonorPromptAt = _Undefined,
    bool? donorPromptPending,
  }) {
    return User(
      id: id is int? ? id : this.id,
      phoneE164: phoneE164 is String? ? phoneE164 : this.phoneE164,
      phoneHmac: phoneHmac is String? ? phoneHmac : this.phoneHmac,
      displayName: displayName ?? this.displayName,
      authUserId: authUserId is _i1.UuidValue? ? authUserId : this.authUserId,
      language: language ?? this.language,
      status: status ?? this.status,
      suspendedReason: suspendedReason is String?
          ? suspendedReason
          : this.suspendedReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      lastDonorPromptAt: lastDonorPromptAt is DateTime?
          ? lastDonorPromptAt
          : this.lastDonorPromptAt,
      donorPromptPending: donorPromptPending ?? this.donorPromptPending,
    );
  }
}

class UserUpdateTable extends _i1.UpdateTable<UserTable> {
  UserUpdateTable(super.table);

  _i1.ColumnValue<String, String> phoneE164(String? value) => _i1.ColumnValue(
    table.phoneE164,
    value,
  );

  _i1.ColumnValue<String, String> phoneHmac(String? value) => _i1.ColumnValue(
    table.phoneHmac,
    value,
  );

  _i1.ColumnValue<String, String> displayName(String value) => _i1.ColumnValue(
    table.displayName,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<_i2.Language, _i2.Language> language(_i2.Language value) =>
      _i1.ColumnValue(
        table.language,
        value,
      );

  _i1.ColumnValue<_i3.UserStatus, _i3.UserStatus> status(
    _i3.UserStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> suspendedReason(String? value) =>
      _i1.ColumnValue(
        table.suspendedReason,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> deletedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.deletedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastDonorPromptAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastDonorPromptAt,
        value,
      );

  _i1.ColumnValue<bool, bool> donorPromptPending(bool value) => _i1.ColumnValue(
    table.donorPromptPending,
    value,
  );
}

class UserTable extends _i1.Table<int?> {
  UserTable({super.tableRelation}) : super(tableName: 'app_user') {
    updateTable = UserUpdateTable(this);
    phoneE164 = _i1.ColumnString(
      'phoneE164',
      this,
    );
    phoneHmac = _i1.ColumnString(
      'phoneHmac',
      this,
    );
    displayName = _i1.ColumnString(
      'displayName',
      this,
    );
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    language = _i1.ColumnEnum(
      'language',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    suspendedReason = _i1.ColumnString(
      'suspendedReason',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
    lastDonorPromptAt = _i1.ColumnDateTime(
      'lastDonorPromptAt',
      this,
    );
    donorPromptPending = _i1.ColumnBool(
      'donorPromptPending',
      this,
      hasDefault: true,
    );
  }

  late final UserUpdateTable updateTable;

  late final _i1.ColumnString phoneE164;

  late final _i1.ColumnString phoneHmac;

  late final _i1.ColumnString displayName;

  late final _i1.ColumnUuid authUserId;

  late final _i1.ColumnEnum<_i2.Language> language;

  late final _i1.ColumnEnum<_i3.UserStatus> status;

  late final _i1.ColumnString suspendedReason;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime lastSeenAt;

  late final _i1.ColumnDateTime deletedAt;

  late final _i1.ColumnDateTime lastDonorPromptAt;

  late final _i1.ColumnBool donorPromptPending;

  @override
  List<_i1.Column> get columns => [
    id,
    phoneE164,
    phoneHmac,
    displayName,
    authUserId,
    language,
    status,
    suspendedReason,
    createdAt,
    updatedAt,
    lastSeenAt,
    deletedAt,
    lastDonorPromptAt,
    donorPromptPending,
  ];
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => User.t;
}

class UserRepository {
  const UserRepository._();

  /// Returns a list of [User]s matching the given query parameters.
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
  Future<List<User>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [User] matching the given query parameters.
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
  Future<User?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [User] by its [id] or null if no such row exists.
  Future<User?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [User]s in the list and returns the inserted rows.
  ///
  /// The returned [User]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<User>> insert(
    _i1.DatabaseSession session,
    List<User> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [User] and returns the inserted row.
  ///
  /// The returned [User] will have its `id` field set.
  Future<User> insertRow(
    _i1.DatabaseSession session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [User]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<User>> update(
    _i1.DatabaseSession session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<User> updateRow(
    _i1.DatabaseSession session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<User?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<User>(
      id,
      columnValues: columnValues(User.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [User]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<User>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<User>(
      columnValues: columnValues(User.t.updateTable),
      where: where(User.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [User]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<User>> delete(
    _i1.DatabaseSession session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [User].
  Future<User> deleteRow(
    _i1.DatabaseSession session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<User>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [User] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<User>(
      where: where(User.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
