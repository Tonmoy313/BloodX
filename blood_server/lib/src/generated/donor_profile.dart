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

abstract class DonorProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DonorProfile._({
    this.id,
    required this.userId,
    this.user,
    required this.bloodGroup,
    required this.area,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.preferredCenters,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DonorProfile({
    int? id,
    required int userId,
    _i2.User? user,
    required String bloodGroup,
    required String area,
    required String address,
    required double latitude,
    required double longitude,
    required List<String> preferredCenters,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DonorProfileImpl;

  factory DonorProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return DonorProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      bloodGroup: jsonSerialization['bloodGroup'] as String,
      area: jsonSerialization['area'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      preferredCenters: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['preferredCenters'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DonorProfileTable();

  static const db = DonorProfileRepository._();

  @override
  int? id;

  int userId;

  _i2.User? user;

  String bloodGroup;

  String area;

  String address;

  double latitude;

  double longitude;

  List<String> preferredCenters;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DonorProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DonorProfile copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    String? bloodGroup,
    String? area,
    String? address,
    double? latitude,
    double? longitude,
    List<String>? preferredCenters,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DonorProfile',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'bloodGroup': bloodGroup,
      'area': area,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'preferredCenters': preferredCenters.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DonorProfileInclude include({_i2.UserInclude? user}) {
    return DonorProfileInclude._(user: user);
  }

  static DonorProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<DonorProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DonorProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DonorProfileTable>? orderByList,
    DonorProfileInclude? include,
  }) {
    return DonorProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DonorProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DonorProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DonorProfileImpl extends DonorProfile {
  _DonorProfileImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required String bloodGroup,
    required String area,
    required String address,
    required double latitude,
    required double longitude,
    required List<String> preferredCenters,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         bloodGroup: bloodGroup,
         area: area,
         address: address,
         latitude: latitude,
         longitude: longitude,
         preferredCenters: preferredCenters,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DonorProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DonorProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? bloodGroup,
    String? area,
    String? address,
    double? latitude,
    double? longitude,
    List<String>? preferredCenters,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DonorProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      bloodGroup: bloodGroup ?? this.bloodGroup,
      area: area ?? this.area,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      preferredCenters:
          preferredCenters ?? this.preferredCenters.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DonorProfileUpdateTable extends _i1.UpdateTable<DonorProfileTable> {
  DonorProfileUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> bloodGroup(String value) => _i1.ColumnValue(
    table.bloodGroup,
    value,
  );

  _i1.ColumnValue<String, String> area(String value) => _i1.ColumnValue(
    table.area,
    value,
  );

  _i1.ColumnValue<String, String> address(String value) => _i1.ColumnValue(
    table.address,
    value,
  );

  _i1.ColumnValue<double, double> latitude(double value) => _i1.ColumnValue(
    table.latitude,
    value,
  );

  _i1.ColumnValue<double, double> longitude(double value) => _i1.ColumnValue(
    table.longitude,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> preferredCenters(
    List<String> value,
  ) => _i1.ColumnValue(
    table.preferredCenters,
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
}

class DonorProfileTable extends _i1.Table<int?> {
  DonorProfileTable({super.tableRelation}) : super(tableName: 'donor_profile') {
    updateTable = DonorProfileUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    bloodGroup = _i1.ColumnString(
      'bloodGroup',
      this,
    );
    area = _i1.ColumnString(
      'area',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    preferredCenters = _i1.ColumnSerializable<List<String>>(
      'preferredCenters',
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
  }

  late final DonorProfileUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  _i2.UserTable? _user;

  late final _i1.ColumnString bloodGroup;

  late final _i1.ColumnString area;

  late final _i1.ColumnString address;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnSerializable<List<String>> preferredCenters;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: DonorProfile.t.userId,
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
    bloodGroup,
    area,
    address,
    latitude,
    longitude,
    preferredCenters,
    createdAt,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class DonorProfileInclude extends _i1.IncludeObject {
  DonorProfileInclude._({_i2.UserInclude? user}) {
    _user = user;
  }

  _i2.UserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => DonorProfile.t;
}

class DonorProfileIncludeList extends _i1.IncludeList {
  DonorProfileIncludeList._({
    _i1.WhereExpressionBuilder<DonorProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DonorProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DonorProfile.t;
}

class DonorProfileRepository {
  const DonorProfileRepository._();

  final attachRow = const DonorProfileAttachRowRepository._();

  /// Returns a list of [DonorProfile]s matching the given query parameters.
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
  Future<List<DonorProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DonorProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DonorProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DonorProfileTable>? orderByList,
    _i1.Transaction? transaction,
    DonorProfileInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DonorProfile>(
      where: where?.call(DonorProfile.t),
      orderBy: orderBy?.call(DonorProfile.t),
      orderByList: orderByList?.call(DonorProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DonorProfile] matching the given query parameters.
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
  Future<DonorProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DonorProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<DonorProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DonorProfileTable>? orderByList,
    _i1.Transaction? transaction,
    DonorProfileInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DonorProfile>(
      where: where?.call(DonorProfile.t),
      orderBy: orderBy?.call(DonorProfile.t),
      orderByList: orderByList?.call(DonorProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DonorProfile] by its [id] or null if no such row exists.
  Future<DonorProfile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    DonorProfileInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DonorProfile>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DonorProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [DonorProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DonorProfile>> insert(
    _i1.DatabaseSession session,
    List<DonorProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DonorProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DonorProfile] and returns the inserted row.
  ///
  /// The returned [DonorProfile] will have its `id` field set.
  Future<DonorProfile> insertRow(
    _i1.DatabaseSession session,
    DonorProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DonorProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DonorProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DonorProfile>> update(
    _i1.DatabaseSession session,
    List<DonorProfile> rows, {
    _i1.ColumnSelections<DonorProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DonorProfile>(
      rows,
      columns: columns?.call(DonorProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DonorProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DonorProfile> updateRow(
    _i1.DatabaseSession session,
    DonorProfile row, {
    _i1.ColumnSelections<DonorProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DonorProfile>(
      row,
      columns: columns?.call(DonorProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DonorProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DonorProfile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DonorProfileUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DonorProfile>(
      id,
      columnValues: columnValues(DonorProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DonorProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DonorProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DonorProfileUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DonorProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DonorProfileTable>? orderBy,
    _i1.OrderByListBuilder<DonorProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DonorProfile>(
      columnValues: columnValues(DonorProfile.t.updateTable),
      where: where(DonorProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DonorProfile.t),
      orderByList: orderByList?.call(DonorProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DonorProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DonorProfile>> delete(
    _i1.DatabaseSession session,
    List<DonorProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DonorProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DonorProfile].
  Future<DonorProfile> deleteRow(
    _i1.DatabaseSession session,
    DonorProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DonorProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DonorProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DonorProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DonorProfile>(
      where: where(DonorProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DonorProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DonorProfile>(
      where: where?.call(DonorProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DonorProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DonorProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DonorProfile>(
      where: where(DonorProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DonorProfileAttachRowRepository {
  const DonorProfileAttachRowRepository._();

  /// Creates a relation between the given [DonorProfile] and [User]
  /// by setting the [DonorProfile]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.DatabaseSession session,
    DonorProfile donorProfile,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (donorProfile.id == null) {
      throw ArgumentError.notNull('donorProfile.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $donorProfile = donorProfile.copyWith(userId: user.id);
    await session.db.updateRow<DonorProfile>(
      $donorProfile,
      columns: [DonorProfile.t.userId],
      transaction: transaction,
    );
  }
}
