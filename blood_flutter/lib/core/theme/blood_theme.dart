import 'package:flutter/material.dart';
import 'blood_colors.dart';

/// BloodX Application Theme
class BloodTheme {
  BloodTheme._();

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
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
          borderSide: const BorderSide(color: BloodColors.primaryLight, width: 2),
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
