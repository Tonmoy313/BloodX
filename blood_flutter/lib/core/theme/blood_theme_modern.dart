import 'package:flutter/material.dart';

import 'blood_theme_base.dart';

/// BloodX modern theme preset.
///
/// Crimson primary over a midnight navy and warm off-white shell. The scheme
/// is declared explicitly so every role keeps the same meaning as in the
/// classic preset.
class BloodThemeModern {
  BloodThemeModern._();

  // Palette.
  static const Color primaryRed = Color(0xFFD90B1A);
  static const Color deepRed = Color(0xFF8F101B);
  static const Color midnightNavy = Color(0xFF061D33);
  static const Color deepBlue = Color(0xFF093552);
  static const Color mutedBlueGrey = Color(0xFF68899C);
  static const Color paleGrey = Color(0xFFCED9D8);
  static const Color warmOffWhite = Color(0xFFF6F5EE);

  // Light surfaces.
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF6F5EE);
  static const Color surfaceMutedLight = Color(0xFFE7ECEB);

  // Dark surfaces.
  static const Color backgroundDark = Color(0xFF041321);
  static const Color surfaceDark = Color(0xFF061D33);
  static const Color surfaceMutedDark = Color(0xFF12364B);

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryRed,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFFFDADB),
    onPrimaryContainer: Color(0xFF65000A),
    secondary: deepBlue,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFD5E7F0),
    onSecondaryContainer: midnightNavy,
    tertiary: mutedBlueGrey,
    onTertiary: Colors.white,
    tertiaryContainer: paleGrey,
    onTertiaryContainer: midnightNavy,
    error: Color(0xFFBA1A1A),
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: surfaceLight,
    onSurface: Color(0xFF171D22),
    surfaceContainerHighest: surfaceMutedLight,
    onSurfaceVariant: Color(0xFF424B50),
    outline: Color(0xFF6C757D),
    outlineVariant: Color(0xFFE5EAE9),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: midnightNavy,
    onInverseSurface: warmOffWhite,
    inversePrimary: Color(0xFFFFB3B7),
    surfaceTint: primaryRed,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFF6670),
    onPrimary: Color(0xFF450006),
    primaryContainer: deepRed,
    onPrimaryContainer: Color(0xFFFFDADB),
    secondary: Color(0xFF8ABBD4),
    onSecondary: Color(0xFF003549),
    secondaryContainer: deepBlue,
    onSecondaryContainer: Color(0xFFD5E7F0),
    tertiary: Color(0xFFA9C3D0),
    onTertiary: midnightNavy,
    tertiaryContainer: Color(0xFF35596B),
    onTertiaryContainer: Color(0xFFD7E8EF),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: surfaceDark,
    onSurface: Color(0xFFE6EDF0),
    surfaceContainerHighest: surfaceMutedDark,
    onSurfaceVariant: Color(0xFFC0CDD2),
    outline: Color(0xFF899DA6),
    outlineVariant: Color(0xFF344E5B),
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: warmOffWhite,
    onInverseSurface: midnightNavy,
    inversePrimary: primaryRed,
    surfaceTint: Color(0xFFFF6670),
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
