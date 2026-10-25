import 'package:serverpod/serverpod.dart';
import '../storage/r2_signed_url_service.dart';

///R2Endpoint (The Gateway): 
///Serverpod requires classes that extend Endpoint to expose functions over the network 
///to your Flutter app. Without an endpoint, your Flutter app has no way to make a remote
/// call to ask the server for a signed URL.
class R2Endpoint extends Endpoint {
  /// Allows an authenticated client to get a pre-signed upload URL for slips.
  Future<String> signedUploadUrl(Session session, String key) async {
    // Security check: ensure user is logged in
    if (session.authenticated == null) {
      throw StateError('Unauthorized: Authentication required to upload files.');
    }

    final service = R2SignedUrlService();
    return await service.signedUploadUrl(session, key: key);
  }

  /// Allows an authenticated client to get a pre-signed download URL.
  Future<String> signedDownloadUrl(
    Session session, {
    required String storageId,
    required String key,
  }) async {
    // Security check: ensure user is logged in
    if (session.authenticated == null) {
      throw StateError('Unauthorized: Authentication required to download files.');
    }

    final service = R2SignedUrlService();
    return await service.signedDownloadUrl(
      session,
      storageId: storageId,
      key: key,
    );
  }
}