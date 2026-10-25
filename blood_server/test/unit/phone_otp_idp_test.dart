import 'package:serverpod/serverpod.dart' show UuidValue;
import 'package:blood_server/src/auth/phone_otp_idp.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneOtpIdp.normalizeBangladeshPhone', () {
    test('normalizes Bangladesh mobile numbers to E.164', () {
      expect(
        PhoneOtpIdp.normalizeBangladeshPhone('+8801712345678'),
        '+8801712345678',
      );
      expect(
        PhoneOtpIdp.normalizeBangladeshPhone('01712345678'),
        '+8801712345678',
      );
      expect(
        PhoneOtpIdp.normalizeBangladeshPhone('1712345678'),
        '+8801712345678',
      );
    });

    test('rejects invalid operator prefixes and lengths', () {
      for (final phone in [
        '01212345678',
        '171234567',
        '+14155552671',
        '+8801212345678',
      ]) {
        expect(
          () => PhoneOtpIdp.normalizeBangladeshPhone(phone),
          throwsFormatException,
        );
      }
    });
  });

  group('PhoneOtpIdp.isValidPin', () {
    test('accepts only five digits and blocks the default PIN', () {
      expect(PhoneOtpIdp.isValidPin('12345'), isTrue);
      expect(PhoneOtpIdp.isValidPin('00000'), isFalse);
      expect(PhoneOtpIdp.isValidPin('1234'), isFalse);
      expect(PhoneOtpIdp.isValidPin('123456'), isFalse);
      expect(PhoneOtpIdp.isValidPin('12a45'), isFalse);
    });
  });

  group('PhoneOtpIdp.matchesInstallBinding', () {
    final installId = UuidValue.withValidation(
      'b18ac499-0fa9-4c42-b7e2-dd0f7e6ac42a',
    );

    test('requires a matching existing install binding', () {
      expect(
        PhoneOtpIdp.matchesInstallBinding(
          boundInstallId: installId,
          presentedInstallId: installId,
        ),
        isTrue,
      );
      expect(
        PhoneOtpIdp.matchesInstallBinding(
          boundInstallId: null,
          presentedInstallId: installId,
        ),
        isFalse,
      );
    });
  });

  test('masks all but the phone prefix and last two digits', () {
    expect(
      PhoneOtpIdp.maskPhone('+8801712345678'),
      '+88017••• •••78',
    );
  });
}
