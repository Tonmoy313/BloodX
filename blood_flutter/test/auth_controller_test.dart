import 'package:flutter_test/flutter_test.dart';
import 'package:blood_flutter/features/auth/controllers/auth_controller.dart';
import 'package:blood_flutter/core/localization/app_language.dart';

void main() {
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
      expect(AuthController.normalizeBangladeshPhone('01212345678'), isNull); // 012 not valid
      expect(AuthController.normalizeBangladeshPhone('01112345678'), isNull); // 011 Citycell retired
      expect(AuthController.normalizeBangladeshPhone('12345'), isNull);
      expect(AuthController.normalizeBangladeshPhone('0171234567899'), isNull); // too long
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
      controller.signOut();
      expect(controller.state.donorOptIn, isFalse);
    });

    test('requestOtp, verifyOtp and completeProfile update state correctly', () async {
      final controller = AuthController.instance;
      controller.signOut();

      // Request OTP
      final requestSuccess = await controller.requestOtp('01712345678');
      expect(requestSuccess, isTrue);
      expect(controller.state.normalizedE164, '+8801712345678');
      expect(controller.state.challengeId, isNotNull);

      // Verify OTP
      final verifySuccess = await controller.verifyOtp('123456');
      expect(verifySuccess, isTrue);
      expect(controller.state.isAuthenticated, isTrue);

      // Complete Profile
      await controller.completeProfile(
        name: 'Rahim Ahmed',
        bloodGroup: 'B+',
        area: 'Mirpur',
        isDonor: true,
      );
      expect(controller.state.displayName, 'Rahim Ahmed');
      expect(controller.state.bloodGroup, 'B+');
      expect(controller.state.area, 'Mirpur');
      expect(controller.state.donorOptIn, isTrue);
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
