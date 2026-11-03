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

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'area_type.dart' as _i2;

abstract class Area implements _i1.SerializableModel {
  Area._({
    this.id,
    required this.type,
    required this.district,
    required this.name,
    this.centroidCell,
  });

  factory Area({
    int? id,
    required _i2.AreaType type,
    required String district,
    required String name,
    BigInt? centroidCell,
  }) = _AreaImpl;

  factory Area.fromJson(Map<String, dynamic> jsonSerialization) {
    return Area(
      id: jsonSerialization['id'] as int?,
      type: _i2.AreaType.fromJson((jsonSerialization['type'] as String)),
      district: jsonSerialization['district'] as String,
      name: jsonSerialization['name'] as String,
      centroidCell: jsonSerialization['centroidCell'] == null
          ? null
          : _i1.BigIntJsonExtension.fromJson(jsonSerialization['centroidCell']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.AreaType type;

  String district;

  String name;

  BigInt? centroidCell;

  /// Returns a shallow copy of this [Area]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Area copyWith({
    int? id,
    _i2.AreaType? type,
    String? district,
    String? name,
    BigInt? centroidCell,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Area',
      if (id != null) 'id': id,
      'type': type.toJson(),
      'district': district,
      'name': name,
      if (centroidCell != null) 'centroidCell': centroidCell?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AreaImpl extends Area {
  _AreaImpl({
    int? id,
    required _i2.AreaType type,
    required String district,
    required String name,
    BigInt? centroidCell,
  }) : super._(
         id: id,
         type: type,
         district: district,
         name: name,
         centroidCell: centroidCell,
       );

  /// Returns a shallow copy of this [Area]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Area copyWith({
    Object? id = _Undefined,
    _i2.AreaType? type,
    String? district,
    String? name,
    Object? centroidCell = _Undefined,
  }) {
    return Area(
      id: id is int? ? id : this.id,
      type: type ?? this.type,
      district: district ?? this.district,
      name: name ?? this.name,
      centroidCell: centroidCell is BigInt? ? centroidCell : this.centroidCell,
    );
  }
}
