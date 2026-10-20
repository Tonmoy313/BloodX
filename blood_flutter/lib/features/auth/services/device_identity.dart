import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceIdentity {
  DeviceIdentity._();

  static const _storageKey = 'bloodx.auth.install_id.v1';
  static const _storage = FlutterSecureStorage();
  static final _uuidPattern = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
  );

  static Future<String> getInstallId() async {
    final storedId = await _storage.read(key: _storageKey);
    if (storedId != null) {
      if (!_uuidPattern.hasMatch(storedId)) {
        throw const FormatException('Stored device identifier is invalid.');
      }
      return storedId;
    }

    final generatedId = _generateUuidV4();
    await _storage.write(key: _storageKey, value: generatedId);
    return generatedId;
  }

  static String _generateUuidV4() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0'));
    final value = hex.join();
    return '${value.substring(0, 8)}-${value.substring(8, 12)}-'
        '${value.substring(12, 16)}-${value.substring(16, 20)}-'
        '${value.substring(20)}';
  }
}
