import 'package:flutter/material.dart';

/// Shared foundation for every BloodX theme preset.
///
/// Both the classic and the modern preset build their [ColorScheme] here and
/// only differ in the palette they pass in. Anything that is not palette
/// specific (typography, shape, input decoration, button metrics) lives here
/// so the two presets stay structurally identical and cannot drift apart.
class BloodThemeBase {
  BloodThemeBase._();

  /// Bangla-first: Noto Sans Bengali carries the Bengali glyphs, the platform
  /// default supplies Latin. Noto Sans Bengali has no Latin coverage, so it is
  /// registered as a fallback rather than the primary family.
  static const String bengaliFontFamily = 'NotoSansBengali';

  /// Corner radius used by cards, fields and buttons across both presets.
  static const double radius = 16;
  static const double radiusSmall = 12;
  static const double radiusLarge = 20;

  /// Minimum tappable target, matching the Material accessibility guidance.
  static const double minTapTarget = 48;

  /// Applies the shared typography baseline to a [TextTheme].
  ///
  /// Bengali conjuncts need room to breathe: negative tracking breaks the
  /// joined forms, so the whole scale is kept at neutral tracking.
  static TextTheme applyTypography(TextTheme textTheme) {
    return textTheme.apply(
      fontFamilyFallback: const [bengaliFontFamily],
    );
  }

  /// Shared input decoration. Only the palette-derived colors differ, so the
  /// shape and metrics are defined once.
  static InputDecorationTheme inputDecorationTheme(ColorScheme scheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: BorderSide(color: scheme.primary, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: BorderSide(color: scheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
        borderSide: BorderSide(color: scheme.error, width: 1.6),
      ),
      labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      hintStyle: TextStyle(color: scheme.onSurfaceVariant),
    );
  }

  /// Shared elevated button style.
  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme scheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        disabledBackgroundColor: scheme.surfaceContainerHighest,
        disabledForegroundColor: scheme.onSurfaceVariant,
        elevation: 0,
        minimumSize: const Size(minTapTarget, minTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Shared outlined button style.
  static OutlinedButtonThemeData outlinedButtonTheme(ColorScheme scheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.primary,
        disabledForegroundColor: scheme.onSurfaceVariant,
        minimumSize: const Size(minTapTarget, minTapTarget),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        side: BorderSide(color: scheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Shared text button style.
  static TextButtonThemeData textButtonTheme(ColorScheme scheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: scheme.primary,
        disabledForegroundColor: scheme.onSurfaceVariant,
        minimumSize: const Size(minTapTarget, minTapTarget),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Shared app bar. `centerTitle` is false so the app bar reads consistently
  /// on both platforms, and the title inherits the surface color.
  static AppBarTheme appBarTheme(ColorScheme scheme) {
    return AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: scheme.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: IconThemeData(color: scheme.onSurface),
    );
  }

  /// Shared card style.
  static CardThemeData cardTheme(ColorScheme scheme) {
    return CardThemeData(
      color: scheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    );
  }

  /// Shared divider style.
  static DividerThemeData dividerTheme(ColorScheme scheme) {
    return DividerThemeData(
      color: scheme.outlineVariant,
      thickness: 1,
      space: 1,
    );
  }

  /// Shared chip style.
  static ChipThemeData chipTheme(ColorScheme scheme) {
    return ChipThemeData(
      backgroundColor: scheme.surfaceContainerHighest,
      selectedColor: scheme.primaryContainer,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusSmall),
      ),
      labelStyle: TextStyle(color: scheme.onSurface),
    );
  }

  /// Shared floating action button style.
  static FloatingActionButtonThemeData floatingActionButtonTheme(
    ColorScheme scheme,
  ) {
    return FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
    );
  }

  /// Shared navigation bar style.
  static NavigationBarThemeData navigationBarTheme(ColorScheme scheme) {
    return NavigationBarThemeData(
      backgroundColor: scheme.surface,
      indicatorColor: scheme.primaryContainer,
      surfaceTintColor: Colors.transparent,
      labelTextStyle: const WidgetStatePropertyAll(
        TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// Shared progress indicator style.
  static ProgressIndicatorThemeData progressIndicatorTheme(
    ColorScheme scheme,
  ) {
    return ProgressIndicatorThemeData(
      color: scheme.primary,
      linearTrackColor: scheme.surfaceContainerHighest,
    );
  }
}
