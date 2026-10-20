import 'package:flutter/material.dart';

import 'blood_theme_base.dart';

/// BloodX classic theme preset.
///
/// Warm crimson palette over neutral surfaces. The scheme is declared
/// explicitly rather than derived from a seed color, so every role keeps the
/// same meaning in both presets instead of drifting into a tonal ramp.
class BloodTheme {
  BloodTheme._();

  // Brand colors.
  static const Color primary = Color(0xFFC62828); // Rich crimson
  static const Color primaryDark = Color(0xFF8E0000); // Deep blood red
  static const Color primaryLight = Color(0xFFFF5F52); // Soft coral crimson
  static const Color wine = Color(0xFF4A0E17); // Premium dark wine

  // Light surfaces.
  static const Color backgroundLight = Color(0xFFFAFAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceMutedLight = Color(0xFFF3F4F6);

  // Dark surfaces.
  static const Color backgroundDark = Color(0xFF0F0E11);
  static const Color surfaceDark = Color(0xFF19171C);
  static const Color surfaceMutedDark = Color(0xFF232027);

  // Text colors. Muted light is darkened to clear WCAG AA (4.5:1) on white.
  static const Color textPrimaryLight = Color(0xFF1B1B1E);
  static const Color textSecondaryLight = Color(0xFF5B6470);
  static const Color textMutedLight = Color(0xFF6B7280);

  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFB3BDC6);
  static const Color textMutedDark = Color(0xFF9CA3AF);

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFFFDAD6),
    onPrimaryContainer: Color(0xFF410002),
    secondary: Color(0xFF7A5260),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFFFD8E4),
    onSecondaryContainer: Color(0xFF2F111B),
    tertiary: Color(0xFF74565F),
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFFFD9E2),
    onTertiaryContainer: Color(0xFF2B151D),
    error: Color(0xFFBA1A1A),
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: surfaceLight,
    onSurface: textPrimaryLight,
    surfaceContainerHighest: surfaceMutedLight,
    onSurfaceVariant: textSecondaryLight,
    outline: Color(0xFF7A8189),
    outlineVariant: Color(0xFFDDE1E5),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFF303035),
    onInverseSurface: Color(0xFFF2F2F4),
    inversePrimary: primaryLight,
    surfaceTint: primary,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryLight,
    onPrimary: Color(0xFF5F0000),
    primaryContainer: primaryDark,
    onPrimaryContainer: Color(0xFFFFDAD6),
    secondary: Color(0xFFE5BDC7),
    onSecondary: Color(0xFF442630),
    secondaryContainer: Color(0xFF5D3C47),
    onSecondaryContainer: Color(0xFFFFD8E4),
    tertiary: Color(0xFFE2BDC6),
    onTertiary: Color(0xFF442A32),
    tertiaryContainer: Color(0xFF5C4048),
    onTertiaryContainer: Color(0xFFFFD9E2),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: surfaceDark,
    onSurface: textPrimaryDark,
    surfaceContainerHighest: surfaceMutedDark,
    onSurfaceVariant: textSecondaryDark,
    outline: Color(0xFF8E979F),
    outlineVariant: Color(0xFF343239),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Color(0xFFE6E6E9),
    onInverseSurface: Color(0xFF1B1B1E),
    inversePrimary: primary,
    surfaceTint: primaryLight,
  );

  static ThemeData get lightTheme {
    final scheme = lightScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: backgroundLight,
      canvasColor: backgroundLight,
      textTheme: BloodThemeBase.applyTypography(
        Typography.material2021().black.apply(
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        ),
      ),
      appBarTheme: BloodThemeBase.appBarTheme(scheme),
      cardTheme: BloodThemeBase.cardTheme(scheme),
      dividerTheme: BloodThemeBase.dividerTheme(scheme),
      inputDecorationTheme: BloodThemeBase.inputDecorationTheme(scheme),
      elevatedButtonTheme: BloodThemeBase.elevatedButtonTheme(scheme),
      outlinedButtonTheme: BloodThemeBase.outlinedButtonTheme(scheme),
      textButtonTheme: BloodThemeBase.textButtonTheme(scheme),
      chipTheme: BloodThemeBase.chipTheme(scheme),
      floatingActionButtonTheme: BloodThemeBase.floatingActionButtonTheme(
        scheme,
      ),
      navigationBarTheme: BloodThemeBase.navigationBarTheme(scheme),
      progressIndicatorTheme: BloodThemeBase.progressIndicatorTheme(scheme),
    );
  }

  static ThemeData get darkTheme {
    final scheme = darkScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: backgroundDark,
      canvasColor: backgroundDark,
      textTheme: BloodThemeBase.applyTypography(
        Typography.material2021().white.apply(
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        ),
      ),
      appBarTheme: BloodThemeBase.appBarTheme(scheme),
      cardTheme: BloodThemeBase.cardTheme(scheme),
      dividerTheme: BloodThemeBase.dividerTheme(scheme),
      inputDecorationTheme: BloodThemeBase.inputDecorationTheme(scheme),
      elevatedButtonTheme: BloodThemeBase.elevatedButtonTheme(scheme),
      outlinedButtonTheme: BloodThemeBase.outlinedButtonTheme(scheme),
      textButtonTheme: BloodThemeBase.textButtonTheme(scheme),
      chipTheme: BloodThemeBase.chipTheme(scheme),
      floatingActionButtonTheme: BloodThemeBase.floatingActionButtonTheme(
        scheme,
      ),
      navigationBarTheme: BloodThemeBase.navigationBarTheme(scheme),
      progressIndicatorTheme: BloodThemeBase.progressIndicatorTheme(scheme),
    );
  }
}
