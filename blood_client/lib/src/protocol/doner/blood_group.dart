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

enum BloodGroup implements _i1.SerializableModel {
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  oPositive,
  oNegative,
  abPositive,
  abNegative;

  static BloodGroup fromJson(String name) {
    switch (name) {
      case 'aPositive':
        return BloodGroup.aPositive;
      case 'aNegative':
        return BloodGroup.aNegative;
      case 'bPositive':
        return BloodGroup.bPositive;
      case 'bNegative':
        return BloodGroup.bNegative;
      case 'oPositive':
        return BloodGroup.oPositive;
      case 'oNegative':
        return BloodGroup.oNegative;
      case 'abPositive':
        return BloodGroup.abPositive;
      case 'abNegative':
        return BloodGroup.abNegative;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "BloodGroup"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
