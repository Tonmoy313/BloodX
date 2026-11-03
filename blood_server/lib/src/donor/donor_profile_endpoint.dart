import 'package:serverpod/serverpod.dart';
import 'package:serverpod/protocol.dart' show AccessDeniedException;

import '../generated/protocol.dart';

class DonorProfileValidation {
  const DonorProfileValidation._();

  static bool isValidWeight(double weightKg) =>
      weightKg.isFinite && weightKg >= 20 && weightKg <= 300;

  static bool isValidReadinessCheck({
    required double weightKg,
    required List<bool> answers,
    required String locale,
    required String appVersion,
  }) {
    return isValidWeight(weightKg) &&
        answers.length == 7 &&
        {'bn', 'en'}.contains(locale) &&
        RegExp(r'^[A-Za-z0-9.+-]{1,40}$').hasMatch(appVersion);
  }

  static ReadinessOutcome readinessOutcome(List<bool> answers) {
    if (answers.length != 7) {
      throw ArgumentError('The readiness questionnaire version is invalid.');
    }
    return answers.every((answer) => answer)
        ? ReadinessOutcome.passed
        : ReadinessOutcome.deferredResult;
  }

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
    required DateTime dateOfBirth,
    required String sex,
    required String bloodGroup,
    required String bloodGroupSource,
    required double weightKg,
    DateTime? lastDonatedAt,
    required bool apheresisWilling,
    required List<String> primaryArea,
    required List<String> secondaryAreas,
    List<String>? tertiaryAreas,
    required String address,
    required double latitude,
    required double longitude,
    required List<String> preferredCenters,
  }) async {
    final normalizedArea = primaryArea.isNotEmpty
        ? primaryArea.first.trim()
        : '';
    final normalizedAddress = address.trim();
    final centers = preferredCenters
        .map((center) => center.trim())
        .where((center) => center.isNotEmpty)
        .toSet()
        .toList(growable: false);
    final normalizedBirthDate = _dateOnlyUtc(dateOfBirth);
    final normalizedLastDonatedAt = lastDonatedAt == null
        ? null
        : _dateOnlyUtc(lastDonatedAt);
    final now = DateTime.now().toUtc();

    if (!DonorProfileValidation.isValid(
          bloodGroup: bloodGroup,
          area: normalizedArea,
          address: normalizedAddress,
          latitude: latitude,
          longitude: longitude,
          preferredCenters: centers,
        ) ||
        !DateTime(1900).isBefore(normalizedBirthDate) ||
        normalizedBirthDate.isAfter(_dateOnlyUtc(now)) ||
        !{'male', 'female'}.contains(sex) ||
        !{'self', 'lab'}.contains(bloodGroupSource) ||
        !DonorProfileValidation.isValidWeight(weightKg) ||
        (normalizedLastDonatedAt != null &&
            normalizedLastDonatedAt.isAfter(_dateOnlyUtc(now)))) {
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
      final profile = DonorProfile(
        id: existing?.id,
        userId: userId,
        dateOfBirth: normalizedBirthDate,
        sex: Sex.values.byName(sex),
        bloodGroup: _bloodGroupFromLabel(bloodGroup),
        bloodGroupSource: BloodGroupSource.values.byName(bloodGroupSource),
        weightKg: weightKg,
        weightDeclaredAt: now,
        lastDonatedAt: normalizedLastDonatedAt,
        apheresisWilling: apheresisWilling,
        donorStatus: existing?.donorStatus ?? DonorStatus.setupIncomplete,
        alertMode: existing?.alertMode ?? AlertMode.off,
        availableUntil: existing?.availableUntil,
        eligibiltyReminder: existing?.eligibiltyReminder ?? true,
        lastPromptAt: existing?.lastPromptAt,
        totalDonations: existing?.totalDonations ?? 0,
        leftDonorAt: existing?.leftDonorAt,
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      );
      final savedProfile = existing == null
          ? await DonorProfile.db.insertRow(
              session,
              profile,
              transaction: transaction,
            )
          : await DonorProfile.db.updateRow(
              session,
              profile,
              transaction: transaction,
            );
      final profileId = savedProfile.id!;

      await DonorArea.db.deleteWhere(
        session,
        where: (row) => row.donorProfileId.equals(profileId),
        transaction: transaction,
      );

      final areasToSave = <(DonorAreaKind, List<String>)>[
        (DonorAreaKind.home, primaryArea),
        (DonorAreaKind.secondary, secondaryAreas),
        if (tertiaryAreas != null && tertiaryAreas.isNotEmpty)
          (DonorAreaKind.tertiary, tertiaryAreas),
      ];

      for (final (kind, areaList) in areasToSave) {
        if (areaList.isEmpty) continue;
        final district = areaList.first.trim();
        final areaName = areaList.length > 1
            ? areaList[1].trim()
            : areaList[0].trim();
        if (areaName.isEmpty) continue;
        var appArea = await Area.db.findFirstRow(
          session,
          where: (row) =>
              row.district.equals(district) & row.name.equals(areaName),
          transaction: transaction,
        );
        appArea ??= await Area.db.insertRow(
          session,
          Area(
            type: AreaType.upazilla,
            district: district,
            name: areaName,
            centroidCell: BigInt.zero,
          ),
          transaction: transaction,
        );
        await DonorArea.db.insertRow(
          session,
          DonorArea(
            donorProfileId: profileId,
            kind: kind,
            areaId: appArea.id!,
            gpsCell: null,
            confirmedAt: now,
            createdAt: now,
            updatedAt: now,
          ),
          transaction: transaction,
        );
      }
    });
  }

  /// Stores only a readiness result and declared weight, never raw answers.
  Future<bool> submitReadinessCheck(
    Session session, {
    required double weightKg,
    required List<bool> answers,
    required String locale,
    required String appVersion,
  }) async {
    if (!DonorProfileValidation.isValidReadinessCheck(
      weightKg: weightKg,
      answers: answers,
      locale: locale,
      appVersion: appVersion,
    )) {
      throw ArgumentError('Readiness check details are invalid.');
    }

    final authUserId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );
    final now = DateTime.now().toUtc();
    final selfCheckPassed =
        DonorProfileValidation.readinessOutcome(answers) ==
        ReadinessOutcome.passed;

    return session.db.transaction((transaction) async {
      final user = await User.db.findFirstRow(
        session,
        where: (row) => row.authUserId.equals(authUserId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (user == null || user.status != UserStatus.active) {
        throw AccessDeniedException(
          message: 'Application account is unavailable.',
        );
      }
      final profile = await DonorProfile.db.findFirstRow(
        session,
        where: (row) => row.userId.equals(user.id!),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (profile == null) {
        throw ArgumentError('Complete the donor profile before readiness.');
      }

      final homeArea = await DonorArea.db.findFirstRow(
        session,
        where: (row) =>
            row.donorProfileId.equals(profile.id!) &
            row.kind.equals(DonorAreaKind.home),
        transaction: transaction,
      );
      if (homeArea == null) {
        throw ArgumentError('Set a home area before readiness.');
      }

      final activeDeferral = await Deferral.db.findFirstRow(
        session,
        where: (row) =>
            row.userId.equals(user.id!) &
            row.liftedAt.equals(null) &
            (row.type.equals(DeferralType.permanent) |
                (row.endsAt > now)),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      final passed = selfCheckPassed && activeDeferral == null;
      final outcome = passed
          ? ReadinessOutcome.passed
          : ReadinessOutcome.deferredResult;
      final validUntil = passed ? now.add(const Duration(hours: 24)) : null;
      final readinessCheck = await ReadinessCheck.db.insertRow(
        session,
        ReadinessCheck(
          donorProfileId: profile.id!,
          questionnaireVersion: 'bloodx-placeholder-v1',
          outcome: outcome,
          weightKg: weightKg,
          validUntil: validUntil,
          locale: locale,
          appVersion: appVersion,
          checkedAt: now,
        ),
        transaction: transaction,
      );
      if (passed) {
        await DonorProfile.db.updateRow(
          session,
          profile.copyWith(
            donorStatus: DonorStatus.active,
            weightKg: weightKg,
            weightDeclaredAt: now,
            updatedAt: now,
          ),
          transaction: transaction,
        );
      } else {
        if (activeDeferral == null) {
          await Deferral.db.insertRow(
            session,
            Deferral(
              userId: user.id!,
              type: DeferralType.temporary,
              reason: DeferralReason.medicalReview,
              source: DeferralSource.selfCheck,
              readinessCheckId: readinessCheck.id,
              startsAt: now,
              endsAt: now.add(const Duration(days: 30)),
              createdAt: now,
            ),
            transaction: transaction,
          );
        }
        await DonorProfile.db.updateRow(
          session,
          profile.copyWith(
            alertMode: AlertMode.off,
            availableUntil: null,
            updatedAt: now,
          ),
          transaction: transaction,
        );
      }
      return passed;
    });
  }
}

DateTime _dateOnlyUtc(DateTime value) =>
    DateTime.utc(value.year, value.month, value.day);

BloodGroup _bloodGroupFromLabel(String label) => switch (label) {
  'A+' => BloodGroup.aPositive,
  'A-' => BloodGroup.aNegative,
  'B+' => BloodGroup.bPositive,
  'B-' => BloodGroup.bNegative,
  'AB+' => BloodGroup.abPositive,
  'AB-' => BloodGroup.abNegative,
  'O+' => BloodGroup.oPositive,
  'O-' => BloodGroup.oNegative,
  _ => throw ArgumentError.value(label, 'bloodGroup'),
};
