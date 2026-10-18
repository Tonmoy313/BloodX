import 'package:flutter/material.dart';

/// App-wide light and dark themes based on the supplied color palette.
///
/// Palette:
/// D90B1A - primary red
/// 8F101B - deep red
/// 061D33 - midnight navy
/// 093552 - deep blue
/// 68899C - muted blue-grey
/// CED9D8 - pale grey
/// F6F5EE - warm off-white
class AppTheme {
  AppTheme._();

  static const Color primaryRed = Color(0xFFD90B1A);
  static const Color deepRed = Color(0xFF8F101B);
  static const Color midnightNavy = Color(0xFF061D33);
  static const Color deepBlue = Color(0xFF093552);
  static const Color mutedBlueGrey = Color(0xFF68899C);
  static const Color paleGrey = Color(0xFFCED9D8);
  static const Color warmOffWhite = Color(0xFFF6F5EE);

  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightBackground = Color(0xFFF6F5EE);
  static const Color _darkBackground = Color(0xFF041321);
  static const Color _darkSurface = Color(0xFF061D33);
  static const Color _darkSurfaceVariant = Color(0xFF12364B);

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
    const scheme = ColorScheme(
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
      surface: _lightSurface,
      onSurface: Color(0xFF171D22),
      surfaceContainerHighest: Color(0xFFE7ECEB),
      onSurfaceVariant: Color(0xFF424B50),
      outline: Color(0xFF78868D),
      outlineVariant: paleGrey,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: midnightNavy,
      onInverseSurface: warmOffWhite,
      inversePrimary: Color(0xFFFFB3B7),
      surfaceTint: primaryRed,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _lightBackground,
      canvasColor: _lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightBackground,
        foregroundColor: midnightNavy,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: _lightSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        shadowColor: midnightNavy.withValues(alpha: 0.08),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE5EAE9)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: paleGrey,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: paleGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: paleGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryRed, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
        ),
        labelStyle: const TextStyle(color: Color(0xFF59666D)),
        hintStyle: const TextStyle(color: Color(0xFF78868D)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: Colors.white,
          disabledBackgroundColor: paleGrey,
          disabledForegroundColor: Color(0xFF59666D),
          elevation: 0,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: deepBlue,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          side: const BorderSide(color: mutedBlueGrey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: deepBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _lightSurface,
        indicatorColor: const Color(0xFFFFDADB),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFE7ECEB),
        selectedColor: const Color(0xFFFFDADB),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        labelStyle: const TextStyle(color: midnightNavy),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryRed,
        linearTrackColor: paleGrey,
      ),
    );
  }

  static ThemeData get darkTheme {
    const scheme = ColorScheme(
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
      surface: _darkSurface,
      onSurface: Color(0xFFE6EDF0),
      surfaceContainerHighest: _darkSurfaceVariant,
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

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _darkBackground,
      canvasColor: _darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: warmOffWhite,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: _darkSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.22),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF1B3A4D)),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF344E5B),
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF344E5B)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF344E5B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF6670), width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFFB4AB)),
        ),
        labelStyle: const TextStyle(color: Color(0xFFC0CDD2)),
        hintStyle: const TextStyle(color: Color(0xFF899DA6)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6670),
          foregroundColor: const Color(0xFF450006),
          disabledBackgroundColor: const Color(0xFF344E5B),
          disabledForegroundColor: const Color(0xFF899DA6),
          elevation: 0,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFB7D8E7),
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          side: const BorderSide(color: mutedBlueGrey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFB7D8E7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFFF6670),
        foregroundColor: Color(0xFF450006),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: _darkSurface,
        indicatorColor: deepRed,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _darkSurfaceVariant,
        selectedColor: deepRed,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        labelStyle: const TextStyle(color: Color(0xFFE6EDF0)),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFFFF6670),
        linearTrackColor: Color(0xFF344E5B),
      ),
    );
  }
}
