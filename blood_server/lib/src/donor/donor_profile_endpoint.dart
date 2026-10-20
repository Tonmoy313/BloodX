import 'package:serverpod/serverpod.dart';
import 'package:serverpod/protocol.dart' show AccessDeniedException;

import '../generated/protocol.dart';

class DonorProfileValidation {
  const DonorProfileValidation._();

  static bool isValid({
    required String bloodGroup,
    required String area,
    required String address,
    required double latitude,
    required double longitude,
    required List<String> preferredCenters,
  }) {
    const bloodGroups = {'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'};
    final normalizedArea = area.trim();
    final normalizedAddress = address.trim();
    final centers = preferredCenters
        .map((center) => center.trim())
        .where((center) => center.isNotEmpty)
        .toSet()
        .toList(growable: false);

    return bloodGroups.contains(bloodGroup) &&
        normalizedArea.isNotEmpty &&
        normalizedArea.length <= 100 &&
        normalizedAddress.isNotEmpty &&
        normalizedAddress.length <= 250 &&
        latitude.isFinite &&
        latitude >= -90 &&
        latitude <= 90 &&
        longitude.isFinite &&
        longitude >= -180 &&
        longitude <= 180 &&
        centers.isNotEmpty &&
        centers.length <= 5 &&
        centers.every((center) => center.length <= 100);
  }
}

class DonorProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> saveMyProfile(
    Session session, {
    required String bloodGroup,
    required String area,
    required String address,
    required double latitude,
    required double longitude,
    required List<String> preferredCenters,
  }) async {
    final normalizedArea = area.trim();
    final normalizedAddress = address.trim();
    final centers = preferredCenters
        .map((center) => center.trim())
        .where((center) => center.isNotEmpty)
        .toSet()
        .toList(growable: false);

    if (!DonorProfileValidation.isValid(
      bloodGroup: bloodGroup,
      area: normalizedArea,
      address: normalizedAddress,
      latitude: latitude,
      longitude: longitude,
      preferredCenters: centers,
    )) {
      throw ArgumentError('Donor profile details are invalid.');
    }

    final authUserId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );
    await session.db.transaction((transaction) async {
      final users = await User.db.find(
        session,
        where: (row) => row.authUserId.equals(authUserId),
        limit: 2,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (users.length != 1 || users.single.status != UserStatus.active) {
        throw AccessDeniedException(
          message: 'Application account is unavailable.',
        );
      }
      final userId = users.single.id!;
      final existing = await DonorProfile.db.findFirstRow(
        session,
        where: (row) => row.userId.equals(userId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      final now = DateTime.now().toUtc();
      final profile = DonorProfile(
        id: existing?.id,
        userId: userId,
        bloodGroup: bloodGroup,
        area: normalizedArea,
        address: normalizedAddress,
        latitude: latitude,
        longitude: longitude,
        preferredCenters: centers,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      );
      if (existing == null) {
        await DonorProfile.db.insertRow(
          session,
          profile,
          transaction: transaction,
        );
      } else {
        await DonorProfile.db.updateRow(
          session,
          profile,
          transaction: transaction,
        );
      }
    });
  }
}
