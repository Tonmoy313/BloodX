import 'dart:convert';
import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';
import 'package:serverpod/protocol.dart' show AccessDeniedException;
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../storage/r2_signed_url_service.dart';

class ProfileImageValidation {
  const ProfileImageValidation._();

  static bool isOwnedImageKey({
    required int userId,
    required String imageKey,
  }) => RegExp(
    '^profile/$userId/[A-Fa-f0-9]{32}\\.(jpg|jpeg|png|webp)\$',
  ).hasMatch(imageKey);
}

class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AuthUserModel> getMyProfile(Session session) async {
    return const AuthUsers().get(
      session,
      authUserId: UuidValue.fromString(
        session.authenticated!.userIdentifier,
      ),
    );
  }

  Future<String> createMyProfileImageUploadDescription(
    Session session, {
    required String extension,
  }) async {
    final normalizedExtension = extension.toLowerCase();
    if (!{'jpg', 'jpeg', 'png', 'webp'}.contains(normalizedExtension)) {
      throw ArgumentError('Profile image type is not supported.');
    }

    final user = await _findCurrentUser(session);
    final key = 'profile/${user.id}/${_secureToken()}.$normalizedExtension';
    final uploadDescription = await session.storage
        .createDirectFileUploadDescription(
          storageId: R2SignedUrlService.storageIdGenerated,
          path: key,
          expirationDuration: const Duration(minutes: 10),
          maxFileSize: 10 * 1024 * 1024,
        );
    if (uploadDescription == null) {
      throw StateError('Unable to create a profile image upload.');
    }
    return jsonEncode({
      'imageKey': key,
      'uploadDescription': uploadDescription,
    });
  }

  Future<void> confirmMyProfileImage(
    Session session, {
    required String imageKey,
  }) async {
    final user = await _findCurrentUser(session);
    if (!ProfileImageValidation.isOwnedImageKey(
      userId: user.id!,
      imageKey: imageKey,
    )) {
      throw ArgumentError('Profile image key is invalid.');
    }

    final verified = await session.storage.verifyDirectFileUpload(
      storageId: R2SignedUrlService.storageIdGenerated,
      path: imageKey,
    );
    if (!verified) {
      throw ArgumentError('Profile image upload could not be verified.');
    }

    await session.db.transaction((transaction) async {
      final current = await User.db.findFirstRow(
        session,
        where: (row) => row.id.equals(user.id!),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (current == null || current.status != UserStatus.active) {
        throw AccessDeniedException(
          message: 'Application account is unavailable.',
        );
      }
      await User.db.updateRow(
        session,
        current.copyWith(imageKey: imageKey, updatedAt: DateTime.now().toUtc()),
        transaction: transaction,
      );
    });
  }

  Future<User> _findCurrentUser(Session session) async {
    final authUserId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );
    final user = await User.db.findFirstRow(
      session,
      where: (row) => row.authUserId.equals(authUserId),
    );
    if (user == null || user.status != UserStatus.active) {
      throw AccessDeniedException(
        message: 'Application account is unavailable.',
      );
    }
    return user;
  }

  String _secureToken() {
    final random = math.Random.secure();
    return List.generate(
      16,
      (_) => random.nextInt(256),
    ).map((value) => value.toRadixString(16).padLeft(2, '0')).join();
  }
}
