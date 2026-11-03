import 'package:blood_server/src/donor/donor_profile_endpoint.dart';
import 'package:test/test.dart';

void main() {
  test('donor profile endpoint requires authentication', () {
    expect(DonorProfileEndpoint().requireLogin, isTrue);
  });

  group('DonorProfileValidation', () {
    test('accepts a complete profile with valid coordinates', () {
      expect(
        DonorProfileValidation.isValid(
          bloodGroup: 'O+',
          area: 'Dhanmondi',
          address: 'Road 3, Dhaka',
          latitude: 23.7465,
          longitude: 90.3760,
          preferredCenters: ['Hospital A'],
        ),
        isTrue,
      );
    });

    test('rejects invalid blood groups and missing required profile data', () {
      expect(
        DonorProfileValidation.isValid(
          bloodGroup: 'X+',
          area: 'Dhanmondi',
          address: 'Road 3, Dhaka',
          latitude: 23.7465,
          longitude: 90.3760,
          preferredCenters: ['Hospital A'],
        ),
        isFalse,
      );
      expect(
        DonorProfileValidation.isValid(
          bloodGroup: 'O+',
          area: ' ',
          address: 'Road 3, Dhaka',
          latitude: 23.7465,
          longitude: 90.3760,
          preferredCenters: ['Hospital A'],
        ),
        isFalse,
      );
    });

    test('rejects non-finite coordinates and empty centers', () {
      expect(
        DonorProfileValidation.isValid(
          bloodGroup: 'O+',
          area: 'Dhanmondi',
          address: 'Road 3, Dhaka',
          latitude: double.nan,
          longitude: 90.376,
          preferredCenters: ['Hospital A'],
        ),
        isFalse,
      );
      expect(
        DonorProfileValidation.isValid(
          bloodGroup: 'O+',
          area: 'Dhanmondi',
          address: 'Road 3, Dhaka',
          latitude: 23.7465,
          longitude: 90.376,
          preferredCenters: ['  '],
        ),
        isFalse,
      );
    });

    test('accepts only the expected readiness questionnaire shape', () {
      expect(
        DonorProfileValidation.isValidReadinessCheck(
          weightKg: 62.5,
          answers: List.filled(7, true),
          locale: 'en',
          appVersion: '1.2.3',
        ),
        isTrue,
      );
      expect(
        DonorProfileValidation.isValidReadinessCheck(
          weightKg: 62.5,
          answers: List.filled(6, true),
          locale: 'en',
          appVersion: '1.2.3',
        ),
        isFalse,
      );
      expect(
        DonorProfileValidation.isValidReadinessCheck(
          weightKg: double.infinity,
          answers: List.filled(7, true),
          locale: 'en',
          appVersion: '1.2.3',
        ),
        isFalse,
      );
    });

    test('converts answers to an outcome without retaining the answers', () {
      expect(
        DonorProfileValidation.readinessOutcome(List.filled(7, true)).name,
        'passed',
      );
      expect(
        DonorProfileValidation.readinessOutcome([
          true,
          true,
          true,
          false,
          true,
          true,
          true,
        ]).name,
        'deferredResult',
      );
      expect(
        () => DonorProfileValidation.readinessOutcome([true]),
        throwsArgumentError,
      );
    });
  });
}
