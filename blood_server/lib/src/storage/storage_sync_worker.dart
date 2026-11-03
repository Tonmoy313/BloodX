import 'dart:async';

import 'package:serverpod/serverpod.dart';

import 'hybrid_cloud_storage.dart';
import '../monitoring/sentry_service.dart';

/// Periodically uploads disk-fallback files to their configured cloud storage.
class StorageSyncWorker {
  StorageSyncWorker({
    required this.serverpod,
    required this.storages,
    this.interval = const Duration(minutes: 1),
  });

  final Serverpod serverpod;
  final List<HybridCloudStorage> storages;
  final Duration interval;

  Timer? _timer;
  bool _isSyncing = false;

  void start() {
    if (_timer != null || storages.every((storage) => storage.cloud == null)) {
      return;
    }
    unawaited(syncOnce());
    _timer = Timer.periodic(interval, (_) => unawaited(syncOnce()));
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> syncOnce() async {
    if (_isSyncing || storages.every((storage) => storage.cloud == null)) {
      return;
    }
    _isSyncing = true;

    try {
      final session = await serverpod.createSession();
      try {
        for (final storage in storages) {
          await storage.syncPendingFiles(session);
        }
      } catch (error) {
        session.log(
          'Storage sync worker failed (${error.runtimeType}); it will retry.',
          level: LogLevel.warning,
        );
      } finally {
        await session.close();
      }
    } catch (error) {
      SentryService.logWarning(
        'Storage sync worker could not create a session '
        '(${error.runtimeType}); it will retry.',
      );
    } finally {
      _isSyncing = false;
    }
  }
}
