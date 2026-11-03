import 'dart:io' as io;
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:blood_server/src/storage/hybrid_cloud_storage.dart';

void main() {
  late io.Directory temporaryDirectory;
  late _FakeCloudStorage cloud;
  late HybridCloudStorage storage;

  setUp(() async {
    temporaryDirectory = await io.Directory.systemTemp.createTemp(
      'blood-hybrid-storage-',
    );
    cloud = _FakeCloudStorage();
    storage = HybridCloudStorage(
      storageId: 'test-files',
      localRoot: io.Directory('${temporaryDirectory.path}/storage_uploads'),
      cloud: cloud,
    );
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test('uploads to cloud first when cloud storage is available', () async {
    cloud.failUploads = false;

    await storage.storeFile(
      session: _FakeSession(),
      path: 'requests/image.jpg',
      byteData: _data([1, 2, 3]),
    );

    expect(cloud.files['requests/image.jpg'], [1, 2, 3]);
    expect(
      await io.File(
        '${temporaryDirectory.path}/storage_uploads/test-files/requests/image.jpg',
      ).exists(),
      isFalse,
    );
  });

  test('falls back to disk and syncs after cloud recovers', () async {
    const path = 'requests/image.jpg';
    final session = _FakeSession();

    await storage.storeFile(
      session: session,
      path: path,
      byteData: _data([4, 5, 6]),
      verified: false,
    );
    expect(
      await io.File(
        '${temporaryDirectory.path}/storage_uploads/test-files/$path',
      ).exists(),
      isTrue,
    );
    expect(
      await storage.verifyDirectFileUpload(session: session, path: path),
      isTrue,
    );

    cloud.failUploads = false;
    await storage.syncPendingFiles(session);

    expect(cloud.files[path], [4, 5, 6]);
    expect(
      await io.File(
        '${temporaryDirectory.path}/storage_uploads/test-files/$path',
      ).exists(),
      isFalse,
    );
  });
}

ByteData _data(List<int> bytes) {
  final buffer = Uint8List.fromList(bytes);
  return ByteData.view(buffer.buffer);
}

class _FakeSession implements Session {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeCloudStorage extends CloudStorage {
  _FakeCloudStorage() : super('test-files');

  bool failUploads = true;
  final Map<String, Uint8List> files = {};

  @override
  Future<void> storeFile({
    required Session session,
    required String path,
    required ByteData byteData,
    DateTime? expiration,
    bool verified = true,
  }) async {
    if (failUploads) throw CloudStorageException('offline');
    files[path] = Uint8List.fromList(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
  }

  @override
  Future<ByteData?> retrieveFile({
    required Session session,
    required String path,
  }) async {
    final bytes = files[path];
    return bytes == null ? null : ByteData.view(bytes.buffer);
  }

  @override
  Future<Uri?> getPublicUrl({
    required Session session,
    required String path,
  }) async => null;

  @override
  Future<bool> fileExists({
    required Session session,
    required String path,
  }) async => files.containsKey(path);

  @override
  Future<void> deleteFile({
    required Session session,
    required String path,
  }) async {
    files.remove(path);
  }

  @override
  Future<String?> createDirectFileUploadDescription({
    required Session session,
    required String path,
    Duration expirationDuration = const Duration(minutes: 10),
    int maxFileSize = 10 * 1024 * 1024,
  }) async => null;

  @override
  Future<bool> verifyDirectFileUpload({
    required Session session,
    required String path,
  }) async => files.containsKey(path);
}
