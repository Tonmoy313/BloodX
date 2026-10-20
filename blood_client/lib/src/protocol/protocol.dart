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
import 'admin_role.dart' as _i2;
import 'consent_type.dart' as _i3;
import 'flag_scope.dart' as _i4;
import 'greetings/greeting.dart' as _i5;
import 'language.dart' as _i6;
import 'otp_type.dart' as _i7;
import 'platform.dart' as _i8;
import 'sex.dart' as _i9;
import 'user_status.dart' as _i10;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i11;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i12;
export 'admin_role.dart';
export 'consent_type.dart';
export 'flag_scope.dart';
export 'greetings/greeting.dart';
export 'language.dart';
export 'otp_type.dart';
export 'platform.dart';
export 'sex.dart';
export 'user_status.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.AdminRole) {
      return _i2.AdminRole.fromJson(data) as T;
    }
    if (t == _i3.ConsentType) {
      return _i3.ConsentType.fromJson(data) as T;
    }
    if (t == _i4.FlagScope) {
      return _i4.FlagScope.fromJson(data) as T;
    }
    if (t == _i5.Greeting) {
      return _i5.Greeting.fromJson(data) as T;
    }
    if (t == _i6.Language) {
      return _i6.Language.fromJson(data) as T;
    }
    if (t == _i7.OtpType) {
      return _i7.OtpType.fromJson(data) as T;
    }
    if (t == _i8.Platform) {
      return _i8.Platform.fromJson(data) as T;
    }
    if (t == _i9.Sex) {
      return _i9.Sex.fromJson(data) as T;
    }
    if (t == _i10.UserStatus) {
      return _i10.UserStatus.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AdminRole?>()) {
      return (data != null ? _i2.AdminRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ConsentType?>()) {
      return (data != null ? _i3.ConsentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.FlagScope?>()) {
      return (data != null ? _i4.FlagScope.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Greeting?>()) {
      return (data != null ? _i5.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Language?>()) {
      return (data != null ? _i6.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.OtpType?>()) {
      return (data != null ? _i7.OtpType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Platform?>()) {
      return (data != null ? _i8.Platform.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Sex?>()) {
      return (data != null ? _i9.Sex.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.UserStatus?>()) {
      return (data != null ? _i10.UserStatus.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    try {
      return _i11.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i12.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdminRole => 'AdminRole',
      _i3.ConsentType => 'ConsentType',
      _i4.FlagScope => 'FlagScope',
      _i5.Greeting => 'Greeting',
      _i6.Language => 'Language',
      _i7.OtpType => 'OtpType',
      _i8.Platform => 'Platform',
      _i9.Sex => 'Sex',
      _i10.UserStatus => 'UserStatus',
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
      case _i2.AdminRole():
        return 'AdminRole';
      case _i3.ConsentType():
        return 'ConsentType';
      case _i4.FlagScope():
        return 'FlagScope';
      case _i5.Greeting():
        return 'Greeting';
      case _i6.Language():
        return 'Language';
      case _i7.OtpType():
        return 'OtpType';
      case _i8.Platform():
        return 'Platform';
      case _i9.Sex():
        return 'Sex';
      case _i10.UserStatus():
        return 'UserStatus';
    }
    className = _i11.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i12.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AdminRole') {
      return deserialize<_i2.AdminRole>(data['data']);
    }
    if (dataClassName == 'ConsentType') {
      return deserialize<_i3.ConsentType>(data['data']);
    }
    if (dataClassName == 'FlagScope') {
      return deserialize<_i4.FlagScope>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i5.Greeting>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i6.Language>(data['data']);
    }
    if (dataClassName == 'OtpType') {
      return deserialize<_i7.OtpType>(data['data']);
    }
    if (dataClassName == 'Platform') {
      return deserialize<_i8.Platform>(data['data']);
    }
    if (dataClassName == 'Sex') {
      return deserialize<_i9.Sex>(data['data']);
    }
    if (dataClassName == 'UserStatus') {
      return deserialize<_i10.UserStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i11.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i12.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

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
      return _i11.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i12.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
