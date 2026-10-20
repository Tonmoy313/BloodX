import 'package:blood_flutter/core/theme/blood_theme.dart';
import 'package:blood_flutter/core/theme/blood_theme_modern.dart';
import 'package:blood_flutter/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final controller = AppThemeController.instance;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    controller.setPreset(BloodThemePreset.modern);
    controller.setThemeMode(ThemeMode.system);
  });

  group('AppThemeController - preset selection', () {
    test('defaults to the modern preset', () {
      expect(controller.preset, BloodThemePreset.modern);
      expect(controller.isModern, isTrue);
    });

    test('togglePreset switches between the two presets', () {
      controller.togglePreset();
      expect(controller.preset, BloodThemePreset.classic);
      expect(controller.isModern, isFalse);

      controller.togglePreset();
      expect(controller.preset, BloodThemePreset.modern);
    });

    test('fromName falls back to modern for an unknown or missing value', () {
      expect(BloodThemePreset.fromName('classic'), BloodThemePreset.classic);
      expect(BloodThemePreset.fromName('modern'), BloodThemePreset.modern);
      expect(BloodThemePreset.fromName(null), BloodThemePreset.modern);
      expect(BloodThemePreset.fromName('neon'), BloodThemePreset.modern);
    });
  });

  group('AppThemeController - persistence', () {
    test('persists the preset and mode', () async {
      controller.setPreset(BloodThemePreset.classic);
      controller.setThemeMode(ThemeMode.dark);
      await Future<void>.delayed(Duration.zero);

      final preferences = await SharedPreferences.getInstance();
      expect(preferences.getString('app.theme_preset'), 'classic');
      expect(preferences.getString('app.theme_mode'), 'dark');
    });

    test('restores a persisted preset and mode on load', () async {
      SharedPreferences.setMockInitialValues({
        'app.theme_preset': 'classic',
        'app.theme_mode': 'light',
      });

      await controller.load();

      expect(controller.preset, BloodThemePreset.classic);
      expect(controller.themeMode, ThemeMode.light);
    });

    test('load keeps the defaults when nothing was persisted', () async {
      await controller.load();

      expect(controller.preset, BloodThemePreset.modern);
      expect(controller.themeMode, ThemeMode.system);
    });
  });

  group('Theme presets - structural parity', () {
    test('both presets expose the same component themes', () {
      final presets = <BloodThemePreset, ThemeData>{
        BloodThemePreset.classic: BloodTheme.lightTheme,
        BloodThemePreset.modern: BloodThemeModern.lightTheme,
      };

      for (final entry in presets.entries) {
        final theme = entry.value;
        expect(
          theme.colorScheme.brightness,
          Brightness.light,
          reason: '${entry.key} should be a light theme',
        );
        expect(theme.useMaterial3, isTrue, reason: '${entry.key}');
        expect(
          theme.inputDecorationTheme.filled,
          isTrue,
          reason: '${entry.key}',
        );
        expect(
          theme.textTheme.bodyMedium?.fontFamilyFallback,
          contains('NotoSansBengali'),
          reason: '${entry.key} must fall back to the Bangla font',
        );
      }
    });

    test('both presets declare every color scheme role', () {
      for (final scheme in [
        BloodTheme.lightScheme,
        BloodTheme.darkScheme,
        BloodThemeModern.lightScheme,
        BloodThemeModern.darkScheme,
      ]) {
        expect(scheme.primary, isNot(scheme.onPrimary));
        expect(scheme.surface, isNot(scheme.onSurface));
        expect(scheme.error, isNot(scheme.onError));
        expect(scheme.outline, isNot(scheme.outlineVariant));
      }
    });

    test('the two presets are visually distinct', () {
      expect(
        BloodTheme.lightScheme.primary,
        isNot(BloodThemeModern.lightScheme.primary),
      );
    });
  });
}
