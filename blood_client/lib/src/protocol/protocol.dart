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
import 'KycVerificationType.dart' as _i2;
import 'area.dart' as _i3;
import 'area_type.dart' as _i4;
import 'consent_type.dart' as _i5;
import 'deferral/deferral_reason.dart' as _i6;
import 'deferral/deferral_source.dart' as _i7;
import 'deferral/deferral_type.dart' as _i8;
import 'device_platform.dart' as _i9;
import 'doner/alert_mode.dart' as _i10;
import 'doner/blood_group.dart' as _i11;
import 'doner/blood_group_source.dart' as _i12;
import 'doner/donor_area_kind.dart' as _i13;
import 'doner/donor_status.dart' as _i14;
import 'flag_scope.dart' as _i15;
import 'greetings/greeting.dart' as _i16;
import 'kycStatus.dart' as _i17;
import 'otp_type.dart' as _i18;
import 'readiness_outcome.dart' as _i19;
import 'sex.dart' as _i20;
import 'user_lagnuage.dart' as _i21;
import 'user_status.dart' as _i22;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i23;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i24;
export 'KycVerificationType.dart';
export 'area.dart';
export 'area_type.dart';
export 'consent_type.dart';
export 'deferral/deferral_reason.dart';
export 'deferral/deferral_source.dart';
export 'deferral/deferral_type.dart';
export 'device_platform.dart';
export 'doner/alert_mode.dart';
export 'doner/blood_group.dart';
export 'doner/blood_group_source.dart';
export 'doner/donor_area_kind.dart';
export 'doner/donor_status.dart';
export 'flag_scope.dart';
export 'greetings/greeting.dart';
export 'kycStatus.dart';
export 'otp_type.dart';
export 'readiness_outcome.dart';
export 'sex.dart';
export 'user_lagnuage.dart';
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

    if (t == _i2.KycVerificationType) {
      return _i2.KycVerificationType.fromJson(data) as T;
    }
    if (t == _i3.Area) {
      return _i3.Area.fromJson(data) as T;
    }
    if (t == _i4.AreaType) {
      return _i4.AreaType.fromJson(data) as T;
    }
    if (t == _i5.ConsentType) {
      return _i5.ConsentType.fromJson(data) as T;
    }
    if (t == _i6.DeferralReason) {
      return _i6.DeferralReason.fromJson(data) as T;
    }
    if (t == _i7.DeferralSource) {
      return _i7.DeferralSource.fromJson(data) as T;
    }
    if (t == _i8.DeferralType) {
      return _i8.DeferralType.fromJson(data) as T;
    }
    if (t == _i9.Platform) {
      return _i9.Platform.fromJson(data) as T;
    }
    if (t == _i10.AlertMode) {
      return _i10.AlertMode.fromJson(data) as T;
    }
    if (t == _i11.BloodGroup) {
      return _i11.BloodGroup.fromJson(data) as T;
    }
    if (t == _i12.BloodGroupSource) {
      return _i12.BloodGroupSource.fromJson(data) as T;
    }
    if (t == _i13.DonorAreaKind) {
      return _i13.DonorAreaKind.fromJson(data) as T;
    }
    if (t == _i14.DonorStatus) {
      return _i14.DonorStatus.fromJson(data) as T;
    }
    if (t == _i15.FlagScope) {
      return _i15.FlagScope.fromJson(data) as T;
    }
    if (t == _i16.Greeting) {
      return _i16.Greeting.fromJson(data) as T;
    }
    if (t == _i17.KycStatus) {
      return _i17.KycStatus.fromJson(data) as T;
    }
    if (t == _i18.OtpType) {
      return _i18.OtpType.fromJson(data) as T;
    }
    if (t == _i19.ReadinessOutcome) {
      return _i19.ReadinessOutcome.fromJson(data) as T;
    }
    if (t == _i20.Sex) {
      return _i20.Sex.fromJson(data) as T;
    }
    if (t == _i21.Language) {
      return _i21.Language.fromJson(data) as T;
    }
    if (t == _i22.UserStatus) {
      return _i22.UserStatus.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.KycVerificationType?>()) {
      return (data != null ? _i2.KycVerificationType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.Area?>()) {
      return (data != null ? _i3.Area.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AreaType?>()) {
      return (data != null ? _i4.AreaType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ConsentType?>()) {
      return (data != null ? _i5.ConsentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.DeferralReason?>()) {
      return (data != null ? _i6.DeferralReason.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.DeferralSource?>()) {
      return (data != null ? _i7.DeferralSource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DeferralType?>()) {
      return (data != null ? _i8.DeferralType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Platform?>()) {
      return (data != null ? _i9.Platform.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AlertMode?>()) {
      return (data != null ? _i10.AlertMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.BloodGroup?>()) {
      return (data != null ? _i11.BloodGroup.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.BloodGroupSource?>()) {
      return (data != null ? _i12.BloodGroupSource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.DonorAreaKind?>()) {
      return (data != null ? _i13.DonorAreaKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.DonorStatus?>()) {
      return (data != null ? _i14.DonorStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.FlagScope?>()) {
      return (data != null ? _i15.FlagScope.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Greeting?>()) {
      return (data != null ? _i16.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.KycStatus?>()) {
      return (data != null ? _i17.KycStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.OtpType?>()) {
      return (data != null ? _i18.OtpType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ReadinessOutcome?>()) {
      return (data != null ? _i19.ReadinessOutcome.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Sex?>()) {
      return (data != null ? _i20.Sex.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Language?>()) {
      return (data != null ? _i21.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.UserStatus?>()) {
      return (data != null ? _i22.UserStatus.fromJson(data) : null) as T;
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
      return _i23.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i24.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.KycVerificationType => 'KycVerificationType',
      _i3.Area => 'Area',
      _i4.AreaType => 'AreaType',
      _i5.ConsentType => 'ConsentType',
      _i6.DeferralReason => 'DeferralReason',
      _i7.DeferralSource => 'DeferralSource',
      _i8.DeferralType => 'DeferralType',
      _i9.Platform => 'Platform',
      _i10.AlertMode => 'AlertMode',
      _i11.BloodGroup => 'BloodGroup',
      _i12.BloodGroupSource => 'BloodGroupSource',
      _i13.DonorAreaKind => 'DonorAreaKind',
      _i14.DonorStatus => 'DonorStatus',
      _i15.FlagScope => 'FlagScope',
      _i16.Greeting => 'Greeting',
      _i17.KycStatus => 'KycStatus',
      _i18.OtpType => 'OtpType',
      _i19.ReadinessOutcome => 'ReadinessOutcome',
      _i20.Sex => 'Sex',
      _i21.Language => 'Language',
      _i22.UserStatus => 'UserStatus',
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
      case _i2.KycVerificationType():
        return 'KycVerificationType';
      case _i3.Area():
        return 'Area';
      case _i4.AreaType():
        return 'AreaType';
      case _i5.ConsentType():
        return 'ConsentType';
      case _i6.DeferralReason():
        return 'DeferralReason';
      case _i7.DeferralSource():
        return 'DeferralSource';
      case _i8.DeferralType():
        return 'DeferralType';
      case _i9.Platform():
        return 'Platform';
      case _i10.AlertMode():
        return 'AlertMode';
      case _i11.BloodGroup():
        return 'BloodGroup';
      case _i12.BloodGroupSource():
        return 'BloodGroupSource';
      case _i13.DonorAreaKind():
        return 'DonorAreaKind';
      case _i14.DonorStatus():
        return 'DonorStatus';
      case _i15.FlagScope():
        return 'FlagScope';
      case _i16.Greeting():
        return 'Greeting';
      case _i17.KycStatus():
        return 'KycStatus';
      case _i18.OtpType():
        return 'OtpType';
      case _i19.ReadinessOutcome():
        return 'ReadinessOutcome';
      case _i20.Sex():
        return 'Sex';
      case _i21.Language():
        return 'Language';
      case _i22.UserStatus():
        return 'UserStatus';
    }
    className = _i23.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i24.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.KycVerificationType>(data['data']);
    }
    if (dataClassName == 'Area') {
      return deserialize<_i3.Area>(data['data']);
    }
    if (dataClassName == 'AreaType') {
      return deserialize<_i4.AreaType>(data['data']);
    }
    if (dataClassName == 'ConsentType') {
      return deserialize<_i5.ConsentType>(data['data']);
    }
    if (dataClassName == 'DeferralReason') {
      return deserialize<_i6.DeferralReason>(data['data']);
    }
    if (dataClassName == 'DeferralSource') {
      return deserialize<_i7.DeferralSource>(data['data']);
    }
    if (dataClassName == 'DeferralType') {
      return deserialize<_i8.DeferralType>(data['data']);
    }
    if (dataClassName == 'Platform') {
      return deserialize<_i9.Platform>(data['data']);
    }
    if (dataClassName == 'AlertMode') {
      return deserialize<_i10.AlertMode>(data['data']);
    }
    if (dataClassName == 'BloodGroup') {
      return deserialize<_i11.BloodGroup>(data['data']);
    }
    if (dataClassName == 'BloodGroupSource') {
      return deserialize<_i12.BloodGroupSource>(data['data']);
    }
    if (dataClassName == 'DonorAreaKind') {
      return deserialize<_i13.DonorAreaKind>(data['data']);
    }
    if (dataClassName == 'DonorStatus') {
      return deserialize<_i14.DonorStatus>(data['data']);
    }
    if (dataClassName == 'FlagScope') {
      return deserialize<_i15.FlagScope>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i16.Greeting>(data['data']);
    }
    if (dataClassName == 'KycStatus') {
      return deserialize<_i17.KycStatus>(data['data']);
    }
    if (dataClassName == 'OtpType') {
      return deserialize<_i18.OtpType>(data['data']);
    }
    if (dataClassName == 'ReadinessOutcome') {
      return deserialize<_i19.ReadinessOutcome>(data['data']);
    }
    if (dataClassName == 'Sex') {
      return deserialize<_i20.Sex>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i21.Language>(data['data']);
    }
    if (dataClassName == 'UserStatus') {
      return deserialize<_i22.UserStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i23.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i24.Protocol().deserializeByClassName(data);
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
      return _i23.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i24.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
