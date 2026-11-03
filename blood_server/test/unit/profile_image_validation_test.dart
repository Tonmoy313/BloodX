import 'package:blood_server/src/profile/profile_endpoint.dart';
import 'package:test/test.dart';

void main() {
  group('ProfileImageValidation', () {
    test('accepts a supported image key owned by the account', () {
      expect(
        ProfileImageValidation.isOwnedImageKey(
          userId: 42,
          imageKey: 'profile/42/0123456789abcdef0123456789abcdef.jpg',
        ),
        isTrue,
      );
    });

    test('rejects another account, traversal, and unsupported formats', () {
      expect(
        ProfileImageValidation.isOwnedImageKey(
          userId: 42,
          imageKey: 'profile/41/0123456789abcdef0123456789abcdef.jpg',
        ),
        isFalse,
      );
      expect(
        ProfileImageValidation.isOwnedImageKey(
          userId: 42,
          imageKey: 'profile/42/../0123456789abcdef0123456789abcdef.jpg',
        ),
        isFalse,
      );
      expect(
        ProfileImageValidation.isOwnedImageKey(
          userId: 42,
          imageKey: 'profile/42/0123456789abcdef0123456789abcdef.pdf',
        ),
        isFalse,
      );
    });
  });
}
