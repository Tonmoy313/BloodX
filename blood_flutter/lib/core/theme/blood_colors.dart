import 'package:flutter/material.dart';

/// BloodX curated color palette.
/// Follows aesthetic standards: avoids plain generic red, utilizes deep crimson,
/// rich rose accents, elegant dark mode and warm neutral surfaces.
class BloodColors {
  BloodColors._();

  // Primary Crimson Palette
  static const Color primary = Color(0xFFC62828); // Vibrant rich crimson
  static const Color primaryDark = Color(0xFF8E0000); // Deep blood red
  static const Color primaryLight = Color(0xFFFF5F52); // Soft coral crimson
  static const Color accent = Color(0xFF9C27B0); // Deep mulberry accent
  static const Color wine = Color(0xFF4A0E17); // Premium dark wine

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE53935), Color(0xFF8E0000)],
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF221518), Color(0xFF140D0F)],
  );

  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x1AFFFFFF), Color(0x05FFFFFF)],
  );

  // Backgrounds & Surfaces (Light)
  static const Color backgroundLight = Color(0xFFFAFAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceMutedLight = Color(0xFFF3F4F6);

  // Backgrounds & Surfaces (Dark)
  static const Color backgroundDark = Color(0xFF0F0E11);
  static const Color surfaceDark = Color(0xFF19171C);
  static const Color surfaceMutedDark = Color(0xFF232027);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF1B1B1E);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textMutedLight = Color(0xFF9CA3AF);

  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textMutedDark = Color(0xFF6B7280);

  // Functional Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Soft Tint Shadows
  static BoxShadow redGlow = BoxShadow(
    color: primary.withValues(alpha: 0.35),
    blurRadius: 20,
    offset: const Offset(0, 8),
  );

  static BoxShadow softCardShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.04),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );
}
