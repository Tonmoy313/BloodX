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
import 'admin_role.dart' as _i3;
import 'package:blood_server/src/generated/protocol.dart' as _i4;

abstract class AdminUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AdminUser._({
    this.id,
    required this.userId,
    this.user,
    required this.role,
    bool? enabled,
    DateTime? createdAt,
  }) : enabled = enabled ?? true,
       createdAt = createdAt ?? DateTime.now();

  factory AdminUser({
    int? id,
    required int userId,
    _i2.User? user,
    required _i3.AdminRole role,
    bool? enabled,
    DateTime? createdAt,
  }) = _AdminUserImpl;

  factory AdminUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminUser(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      role: _i3.AdminRole.fromJson((jsonSerialization['role'] as String)),
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AdminUserTable();

  static const db = AdminUserRepository._();

  @override
  int? id;

  int userId;

  _i2.User? user;

  _i3.AdminRole role;

  bool enabled;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminUser copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    _i3.AdminRole? role,
    bool? enabled,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminUser',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'role': role.toJson(),
      'enabled': enabled,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static AdminUserInclude include({_i2.UserInclude? user}) {
    return AdminUserInclude._(user: user);
  }

  static AdminUserIncludeList includeList({
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminUserTable>? orderByList,
    AdminUserInclude? include,
  }) {
    return AdminUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdminUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminUserImpl extends AdminUser {
  _AdminUserImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required _i3.AdminRole role,
    bool? enabled,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         role: role,
         enabled: enabled,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminUser copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    _i3.AdminRole? role,
    bool? enabled,
    DateTime? createdAt,
  }) {
    return AdminUser(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      role: role ?? this.role,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AdminUserUpdateTable extends _i1.UpdateTable<AdminUserTable> {
  AdminUserUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<_i3.AdminRole, _i3.AdminRole> role(_i3.AdminRole value) =>
      _i1.ColumnValue(
        table.role,
        value,
      );

  _i1.ColumnValue<bool, bool> enabled(bool value) => _i1.ColumnValue(
    table.enabled,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AdminUserTable extends _i1.Table<int?> {
  AdminUserTable({super.tableRelation}) : super(tableName: 'admin_user') {
    updateTable = AdminUserUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
    );
    enabled = _i1.ColumnBool(
      'enabled',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AdminUserUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  _i2.UserTable? _user;

  late final _i1.ColumnEnum<_i3.AdminRole> role;

  late final _i1.ColumnBool enabled;

  late final _i1.ColumnDateTime createdAt;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: AdminUser.t.userId,
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
    role,
    enabled,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class AdminUserInclude extends _i1.IncludeObject {
  AdminUserInclude._({_i2.UserInclude? user}) {
    _user = user;
  }

  _i2.UserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => AdminUser.t;
}

class AdminUserIncludeList extends _i1.IncludeList {
  AdminUserIncludeList._({
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AdminUser.t;
}

class AdminUserRepository {
  const AdminUserRepository._();

  final attachRow = const AdminUserAttachRowRepository._();

  /// Returns a list of [AdminUser]s matching the given query parameters.
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
  Future<List<AdminUser>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminUserTable>? orderByList,
    _i1.Transaction? transaction,
    AdminUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminUser>(
      where: where?.call(AdminUser.t),
      orderBy: orderBy?.call(AdminUser.t),
      orderByList: orderByList?.call(AdminUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AdminUser] matching the given query parameters.
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
  Future<AdminUser?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdminUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminUserTable>? orderByList,
    _i1.Transaction? transaction,
    AdminUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminUser>(
      where: where?.call(AdminUser.t),
      orderBy: orderBy?.call(AdminUser.t),
      orderByList: orderByList?.call(AdminUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminUser] by its [id] or null if no such row exists.
  Future<AdminUser?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AdminUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AdminUser>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AdminUser]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AdminUser>> insert(
    _i1.DatabaseSession session,
    List<AdminUser> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AdminUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AdminUser] and returns the inserted row.
  ///
  /// The returned [AdminUser] will have its `id` field set.
  Future<AdminUser> insertRow(
    _i1.DatabaseSession session,
    AdminUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AdminUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AdminUser>> update(
    _i1.DatabaseSession session,
    List<AdminUser> rows, {
    _i1.ColumnSelections<AdminUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdminUser>(
      rows,
      columns: columns?.call(AdminUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminUser> updateRow(
    _i1.DatabaseSession session,
    AdminUser row, {
    _i1.ColumnSelections<AdminUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminUser>(
      row,
      columns: columns?.call(AdminUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminUser?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AdminUserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminUser>(
      id,
      columnValues: columnValues(AdminUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AdminUser>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AdminUserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AdminUserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminUserTable>? orderBy,
    _i1.OrderByListBuilder<AdminUserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AdminUser>(
      columnValues: columnValues(AdminUser.t.updateTable),
      where: where(AdminUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminUser.t),
      orderByList: orderByList?.call(AdminUser.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AdminUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AdminUser>> delete(
    _i1.DatabaseSession session,
    List<AdminUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdminUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AdminUser].
  Future<AdminUser> deleteRow(
    _i1.DatabaseSession session,
    AdminUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AdminUser>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdminUser>(
      where: where(AdminUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdminUser>(
      where: where?.call(AdminUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminUser] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminUserTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminUser>(
      where: where(AdminUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AdminUserAttachRowRepository {
  const AdminUserAttachRowRepository._();

  /// Creates a relation between the given [AdminUser] and [User]
  /// by setting the [AdminUser]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.DatabaseSession session,
    AdminUser adminUser,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (adminUser.id == null) {
      throw ArgumentError.notNull('adminUser.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $adminUser = adminUser.copyWith(userId: user.id);
    await session.db.updateRow<AdminUser>(
      $adminUser,
      columns: [AdminUser.t.userId],
      transaction: transaction,
    );
  }
}
