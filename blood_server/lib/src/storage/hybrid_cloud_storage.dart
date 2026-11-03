import 'dart:io' as io;
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

/// Writes to cloud storage first and keeps a disk copy when the cloud is down.
///
/// Upload descriptions use Serverpod's own endpoint so the server can observe
/// cloud failures and fall back to disk. Clients do not receive a cloud URL.
class HybridCloudStorage extends DatabaseCloudStorage {
  static const int maxUploadBytes = 10 * 1024 * 1024;

  HybridCloudStorage({
    required String storageId,
    required this.localRoot,
    required this.cloud,
  }) : super(storageId);

  final io.Directory localRoot;
  final CloudStorage? cloud;

  io.Directory get _storageDirectory =>
      io.Directory('${localRoot.path}${io.Platform.pathSeparator}$storageId');

  io.File _localFile(String path) {
    final segments = path.split(RegExp(r'[/\\]+'));
    if (path.isEmpty ||
        path.startsWith('/') ||
        segments.any(
          (segment) => segment.isEmpty || segment == '.' || segment == '..',
        )) {
      throw CloudStorageException('Invalid storage path.');
    }
    return io.File(
      '${_storageDirectory.path}${io.Platform.pathSeparator}'
      '${segments.join(io.Platform.pathSeparator)}',
    );
  }

  @override
  Future<void> storeFile({
    required Session session,
    required String path,
    required ByteData byteData,
    DateTime? expiration,
    bool verified = true,
  }) async {
    if (byteData.lengthInBytes > maxUploadBytes) {
      throw CloudStorageException(
        'Upload exceeds the $maxUploadBytes byte local storage limit.',
      );
    }

    final cloudStorage = cloud;
    if (cloudStorage != null) {
      try {
        await cloudStorage.storeFile(
          session: session,
          path: path,
          byteData: byteData,
          expiration: expiration,
          verified: verified,
        );
        if (verified) {
          await _removeLocalCopy(path);
        } else {
          await _writeLocalCopy(path, byteData, verified: false);
        }
        return;
      } catch (error) {
        session.log(
          'Cloud upload failed for storage $storageId; saving locally '
          '(${error.runtimeType}).',
          level: LogLevel.warning,
        );
      }
    }

    await _writeLocalCopy(path, byteData, verified: verified);
  }

  @override
  Future<bool> verifyDirectFileUpload({
    required Session session,
    required String path,
  }) async {
    final cloudStorage = cloud;
    if (cloudStorage != null) {
      try {
        if (await cloudStorage.verifyDirectFileUpload(
          session: session,
          path: path,
        )) {
          await _removeLocalCopy(path);
          return true;
        }
      } catch (_) {
        // A failed cloud verification is allowed to use the local copy below.
      }
    }

    final file = _localFile(path);
    if (!await file.exists()) return false;
    final unverifiedMarker = io.File('${file.path}.unverified');
    final pendingMarker = io.File('${file.path}.pending');
    if (await unverifiedMarker.exists()) {
      await unverifiedMarker.delete();
      await pendingMarker.writeAsString('pending');
      return true;
    }
    if (!await pendingMarker.exists()) return false;
    return true;
  }

  @override
  Future<ByteData?> retrieveFile({
    required Session session,
    required String path,
  }) async {
    final cloudStorage = cloud;
    if (cloudStorage != null) {
      try {
        final cloudFile = await cloudStorage.retrieveFile(
          session: session,
          path: path,
        );
        if (cloudFile != null) return cloudFile;
      } catch (_) {
        // Serve the durable local fallback if cloud retrieval is unavailable.
      }
    }

    final file = _localFile(path);
    if (!await file.exists()) return null;
    final bytes = await file.readAsBytes();
    return ByteData.view(
      bytes.buffer,
      bytes.offsetInBytes,
      bytes.lengthInBytes,
    );
  }

  @override
  Future<bool> fileExists({
    required Session session,
    required String path,
  }) async {
    final cloudStorage = cloud;
    if (cloudStorage != null) {
      try {
        if (await cloudStorage.fileExists(session: session, path: path)) {
          return true;
        }
      } catch (_) {
        // Check the local fallback below.
      }
    }
    return _localFile(path).exists();
  }

  @override
  Future<void> deleteFile({
    required Session session,
    required String path,
  }) async {
    final cloudStorage = cloud;
    if (cloudStorage != null) {
      await cloudStorage.deleteFile(session: session, path: path);
    }
    await _removeLocalCopy(path);
  }

  /// Retries every local file marked for sync and removes it after cloud ack.
  Future<void> syncPendingFiles(Session session) async {
    final storageDirectory = _storageDirectory;
    if (!await storageDirectory.exists() || cloud == null) return;

    await for (final entity in storageDirectory.list(recursive: true)) {
      if (entity is! io.File || !entity.path.endsWith('.pending')) continue;

      final markerPath = entity.path;
      final filePath = markerPath.substring(
        0,
        markerPath.length - '.pending'.length,
      );
      final file = io.File(filePath);
      if (!await file.exists()) {
        await entity.delete();
        continue;
      }

      final relativePath = file.path
          .substring(storageDirectory.path.length + 1)
          .split(io.Platform.pathSeparator)
          .join('/');
      try {
        final bytes = await file.readAsBytes();
        await cloud!.storeFile(
          session: session,
          path: relativePath,
          byteData: ByteData.view(
            bytes.buffer,
            bytes.offsetInBytes,
            bytes.lengthInBytes,
          ),
          verified: true,
        );
        await entity.delete();
        await file.delete();
        session.log(
          'Synced a local file to cloud storage $storageId.',
          level: LogLevel.info,
        );
      } catch (error) {
        session.log(
          'Local file sync failed for storage $storageId '
          '(${error.runtimeType}); it will be retried.',
          level: LogLevel.warning,
        );
      }
    }
  }

  Future<void> _removeLocalCopy(String path) async {
    final file = _localFile(path);
    if (await file.exists()) await file.delete();
    final marker = io.File('${file.path}.pending');
    if (await marker.exists()) await marker.delete();
    final unverifiedMarker = io.File('${file.path}.unverified');
    if (await unverifiedMarker.exists()) await unverifiedMarker.delete();
  }

  Future<void> _writeLocalCopy(
    String path,
    ByteData byteData, {
    required bool verified,
  }) async {
    final file = _localFile(path);
    await file.parent.create(recursive: true);
    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    final marker = io.File(
      '${file.path}.${verified ? 'pending' : 'unverified'}',
    );
    await marker.writeAsString(verified ? 'pending' : 'unverified');
  }
}
