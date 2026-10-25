import 'package:blood_server/src/donor/donor_prompt_service.dart';
import 'package:test/test.dart';

void main() {
  group('DonorPromptService.isCooldownComplete', () {
    final now = DateTime.utc(2026, 5, 1);
    final createdAt = now.subtract(const Duration(days: 31));

    test('does not re-engage new users during their first 30 days', () {
      expect(
        DonorPromptService.isCooldownComplete(
          null,
          now.subtract(const Duration(days: 29)),
          now,
        ),
        isFalse,
      );
      expect(
        DonorPromptService.isCooldownComplete(null, createdAt, now),
        isTrue,
      );
    });

    test('waits until the full 30-day cooldown has elapsed', () {
      expect(
        DonorPromptService.isCooldownComplete(
          now.subtract(const Duration(days: 29, hours: 23)),
          createdAt,
          now,
        ),
        isFalse,
      );
      expect(
        DonorPromptService.isCooldownComplete(
          now.subtract(const Duration(days: 30)),
          createdAt,
          now,
        ),
        isTrue,
      );
    });

    test('normalizes timestamps to UTC before comparing', () {
      final offsetTimestamp = DateTime.parse('2026-04-01T03:00:00+03:00');
      expect(
        DonorPromptService.isCooldownComplete(
          offsetTimestamp,
          createdAt,
          now,
        ),
        isTrue,
      );
    });
  });
}
