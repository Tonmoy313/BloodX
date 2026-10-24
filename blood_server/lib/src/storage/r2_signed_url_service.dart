import 'dart:io' as io;

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cloud_storage_s3/serverpod_cloud_storage_s3.dart';

///This is a backend-only utility class (The logic). 
///It knows how to talk to Cloudflare R2 using Serverpod's storage APIs, 
///but it lives purely on the server.
class R2SignedUrlService {
  static const String storageIdSlips = 'r2-slips';
  static const String storageIdGenerated = 'r2-generated';

  /// Maximum allowed TTL to prevent long-lived leaked URLs.
  static const Duration maxTtl = Duration(hours: 1);

  /// Default expiry for signed upload and download URLs.
  static const Duration defaultTtl = Duration(minutes: 15);

  /// Returns a pre-signed **upload** (PUT) URL for a slip in the pending prefix.
  ///
  /// The caller must PUT the file to the returned URL within [defaultTtl].
  /// The `pending/` lifecycle rule on the bucket deletes unconsumed uploads
  /// after 24 hours.
  ///
  /// [key] must start with `pending/` and end with `.jpg`, `.jpeg`, or `.pdf`.
  Future<String> signedUploadUrl(
    Session session, {
    required String key,
    Duration ttl = defaultTtl,
  }) async {
    _validateSlipKey(key);
    _validateTtl(ttl);

    // The method returns the upload URL (String) directly.
    final uploadUrl = await session.storage.createDirectFileUploadDescription(
      storageId: storageIdSlips,
      path: key,
      expirationDuration: ttl,
      maxFileSize: 10 * 1024 * 1024, // 10 MB hard cap
    );

    if (uploadUrl == null) {
      throw Exception('Failed to generate upload URL for $key');
    }

    return uploadUrl;
  }

    /// Returns a pre-signed **download** (GET) URL for a stored asset.
  ///
  /// [storageId] must be [storageIdSlips] or [storageIdGenerated].
  /// [key] must not contain path traversal sequences.
  Future<String> signedDownloadUrl(
    Session session, {
    required String storageId,
    required String key,
    Duration ttl = defaultTtl,
  }) async {
    _validateStorageId(storageId);
    _validateKey(key);
    _validateTtl(ttl);

    final uri = await session.storage.getPublicUrl(
      storageId: storageId,
      path: key,
    );

    if (uri == null) {
      throw Exception('Asset not found or not publicly accessible: $key');
    }

    return uri.toString();
  }
  // ── Validators ───────────────────────────────────────────────────────────

  static final _slipKeyPattern = RegExp(
    r'^pending/[a-zA-Z0-9_\-]{1,200}\.(jpg|jpeg|pdf)$',
  );

  static void _validateSlipKey(String key) {
    if (!_slipKeyPattern.hasMatch(key)) {
      throw ArgumentError.value(
        key,
        'key',
        'Slip key must match pending/<safe-name>.(jpg|jpeg|pdf).',
      );
    }
  }

  static final _keyPattern = RegExp(r'^[a-zA-Z0-9/_\-]{1,512}$');

  static void _validateKey(String key) {
    if (!_keyPattern.hasMatch(key) || key.contains('..')) {
      throw ArgumentError.value(key, 'key', 'Key contains invalid characters.');
    }
  }

  static const _allowedStorageIds = {storageIdSlips, storageIdGenerated};

  static void _validateStorageId(String storageId) {
    if (!_allowedStorageIds.contains(storageId)) {
      throw ArgumentError.value(
        storageId,
        'storageId',
        'Unknown storage ID.',
      );
    }
  }

  static void _validateTtl(Duration ttl) {
    if (ttl > maxTtl || ttl.inSeconds <= 0) {
      throw ArgumentError.value(
        ttl,
        'ttl',
        'TTL must be between 1 second and ${maxTtl.inMinutes} minutes.',
      );
    }
  }
}

/// Environment variables expected in Cloud Run / Secret Manager:
///
///   R2_ACCOUNT_ID         — Cloudflare account ID
///   R2_ACCESS_KEY_ID      — R2 S3-compatible access key ID
///   R2_SECRET_ACCESS_KEY  — R2 S3-compatible secret access key
///   R2_BUCKET_SLIPS       — Private bucket for donation-slip uploads
///   R2_BUCKET_GENERATED   — Private bucket for server-generated assets
///
/// These are read by [S3CloudStorage] from environment variables at startup.
/// Validate their presence at startup to fail fast before accepting traffic.
void validateR2Env() {
  const required = [
    'R2_ACCOUNT_ID',
    'R2_ACCESS_KEY_ID',
    'R2_SECRET_ACCESS_KEY',
    'R2_BUCKET_SLIPS',
    'R2_BUCKET_GENERATED',
  ];
  final missing = required
      .where(
        (k) =>
            io.Platform.environment[k] == null ||
            io.Platform.environment[k]!.trim().isEmpty,
      )
      .toList();
  if (missing.isNotEmpty) {
    throw StateError(
      'Missing required R2 environment variables: ${missing.join(', ')}. '
      'Inject them from Secret Manager before deploying.',
    );
  }
}
