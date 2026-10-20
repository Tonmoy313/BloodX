import 'package:blood_client/blood_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blood_flutter/features/auth/controllers/auth_controller.dart';
import 'package:blood_flutter/core/localization/app_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('AuthController - Bangladesh Phone Normalization & Masking', () {
    test('normalizes valid 11-digit numbers with leading 0', () {
      expect(
        AuthController.normalizeBangladeshPhone('01712345678'),
        '+8801712345678',
      );
      expect(
        AuthController.normalizeBangladeshPhone('01987654321'),
        '+8801987654321',
      );
      expect(
        AuthController.normalizeBangladeshPhone('01300000000'),
        '+8801300000000',
      );
    });

    test('normalizes valid 10-digit numbers without leading 0', () {
      expect(
        AuthController.normalizeBangladeshPhone('1812345678'),
        '+8801812345678',
      );
    });

    test('normalizes numbers already starting with 880', () {
      expect(
        AuthController.normalizeBangladeshPhone('8801712345678'),
        '+8801712345678',
      );
    });

    test('rejects invalid numbers or non-Bangladesh operator prefixes', () {
      expect(
        AuthController.normalizeBangladeshPhone('01212345678'),
        isNull,
      ); // 012 not valid
      expect(
        AuthController.normalizeBangladeshPhone('01112345678'),
        isNull,
      ); // 011 Citycell retired
      expect(AuthController.normalizeBangladeshPhone('12345'), isNull);
      expect(
        AuthController.normalizeBangladeshPhone('0171234567899'),
        isNull,
      ); // too long
    });

    test('masks phone number correctly for privacy compliance', () {
      final masked = AuthController.maskPhone('+8801712345678');
      expect(masked, '+88017••• •••78');
      expect(masked.contains('123456'), isFalse); // Never leaks middle digits
    });
  });

  group('AuthController - Auth Flow & Volunteer Principle', () {
    test('donor opt-in is false by default (D-015)', () {
      final controller = AuthController.instance;
      expect(controller.state.donorOptIn, isFalse);
    });

    test(
      'rejects invalid auth input before contacting the server',
      () async {
        final controller = AuthController.instance;
        expect(await controller.requestOtp('invalid'), isFalse);
        expect(await controller.verifyOtp('12'), isFalse);
        expect(await controller.loginWithPin('invalid', '12345'), isFalse);
        expect(await controller.setupPin('00000'), isFalse);
      },
    );

    test('rejects invalid onboarding profile data', () {
      final controller = AuthController.instance;
      expect(
        controller.saveOnboardingProfile(
          name: ' ',
          sex: Sex.female,
          dateOfBirth: DateTime.utc(1990, 1, 1),
        ),
        isFalse,
      );
      expect(
        controller.saveOnboardingProfile(
          name: 'Valid Name',
          sex: Sex.female,
          dateOfBirth: DateTime.now().add(const Duration(days: 1)),
        ),
        isFalse,
      );
    });
  });

  group('AppLanguage - Bangla-first & English Toggle', () {
    test('defaults to Bangla (P-002)', () {
      expect(AppLanguage.instance.isBangla, isTrue);
      expect(AppLanguage.instance.locale.languageCode, 'bn');
    });

    test('toggles cleanly between Bengali and English', () {
      AppLanguage.instance.toggleLanguage();
      expect(AppLanguage.instance.isBangla, isFalse);
      expect(AppLanguage.instance.locale.languageCode, 'en');

      AppLanguage.instance.toggleLanguage();
      expect(AppLanguage.instance.isBangla, isTrue);
    });
  });
}
