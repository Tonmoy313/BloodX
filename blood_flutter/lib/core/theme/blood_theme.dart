import 'package:flutter/material.dart';
import 'blood_colors.dart';

/// BloodX Application Theme
class BloodTheme {
  BloodTheme._();

  // Semantic colors (available in both light and dark UI).
  static const Color success = Color(0xFF16803C);
  static const Color successLight = Color(0xFFE5F6EA);
  static const Color successDark = Color(0xFF75D995);
  static const Color successContainerLight = Color(0xFFD8F3E0);
  static const Color successContainerDark = Color(0xFF123D25);

  static const Color warning = Color(0xFF9A6700);
  static const Color warningLight = Color(0xFFFFF4CC);
  static const Color warningDark = Color(0xFFFFD166);
  static const Color warningContainerLight = Color(0xFFFFE9A6);
  static const Color warningContainerDark = Color(0xFF493700);

  static const Color info = Color(0xFF1769AA);
  static const Color infoLight = Color(0xFFE5F2FF);
  static const Color infoDark = Color(0xFF8BC5FF);
  static const Color infoContainerLight = Color(0xFFD4E9FF);
  static const Color infoContainerDark = Color(0xFF123451);

  static const Color neutral = Color(0xFF59666D);
  static const Color neutralLight = Color(0xFFF0F3F4);
  static const Color neutralDark = Color(0xFFB7C3C9);

  // Text colors for explicit use in custom widgets.
  static const Color textPrimaryLight = Color(0xFF171D22);
  static const Color textSecondaryLight = Color(0xFF59666D);
  static const Color textTertiaryLight = Color(0xFF78868D);
  static const Color textDisabledLight = Color(0xFF9AA5AA);
  static const Color textOnDark = Color(0xFFE6EDF0);
  static const Color textSecondaryDark = Color(0xFFC0CDD2);
  static const Color textTertiaryDark = Color(0xFF899DA6);
  static const Color textDisabledDark = Color(0xFF667983);

  // Reusable container, border, and overlay colors.
  static const Color containerLight = Color(0xFFFFFFFF);
  static const Color containerSubtleLight = Color(0xFFF0F3F2);
  static const Color containerMutedLight = Color(0xFFE7ECEB);
  static const Color containerDark = Color(0xFF061D33);
  static const Color containerSubtleDark = Color(0xFF0B293B);
  static const Color containerMutedDark = Color(0xFF12364B);
  static const Color borderLight = Color(0xFFE0E6E5);
  static const Color borderDark = Color(0xFF344E5B);
  static const Color overlayLight = Color(0x14061D33);
  static const Color overlayDark = Color(0x52000000);

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BloodColors.primary,
        brightness: Brightness.light,
        primary: BloodColors.primary,
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFFFFDAD6),
        onPrimaryContainer: BloodColors.primaryDark,
        surface: BloodColors.surfaceLight,
        onSurface: BloodColors.textPrimaryLight,
        error: BloodColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: BloodColors.backgroundLight,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: BloodColors.textPrimaryLight),
        titleTextStyle: TextStyle(
          color: BloodColors.textPrimaryLight,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BloodColors.surfaceMutedLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: BloodColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: BloodColors.error, width: 1.5),
        ),
        hintStyle: const TextStyle(
          color: BloodColors.textMutedLight,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BloodColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: BloodColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BloodColors.primary,
        brightness: Brightness.dark,
        primary: BloodColors.primaryLight,
        onPrimary: Colors.white,
        surface: BloodColors.surfaceDark,
        onSurface: BloodColors.textPrimaryDark,
        error: BloodColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: BloodColors.backgroundDark,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: BloodColors.textPrimaryDark),
        titleTextStyle: TextStyle(
          color: BloodColors.textPrimaryDark,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BloodColors.surfaceMutedDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF2D2A32), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: BloodColors.primaryLight,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: BloodColors.error, width: 1.5),
        ),
        hintStyle: const TextStyle(
          color: BloodColors.textMutedDark,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BloodColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: BloodColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF2E2B35), width: 1),
        ),
      ),
    );
  }
}
