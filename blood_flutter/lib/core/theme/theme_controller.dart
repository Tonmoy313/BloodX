import 'package:flutter/material.dart';
import 'blood_theme.dart';
import 'blood_theme2.dart';

/// Available theme variants in BloodX:
/// - [classic]: Original Crimson Blood Theme (blood_theme.dart)
/// - [modern]: Modern Palette Theme (blood_theme2.dart)
enum BloodThemePreset {
  classic,
  modern,
}

/// App theme controller managing theme preset (classic vs modern) and mode (system/light/dark).
class AppThemeController extends ChangeNotifier {
  static final AppThemeController instance = AppThemeController._();
  AppThemeController._();

  BloodThemePreset _preset = BloodThemePreset.modern;
  ThemeMode _themeMode = ThemeMode.system;

  BloodThemePreset get preset => _preset;
  ThemeMode get themeMode => _themeMode;
  bool get isModern => _preset == BloodThemePreset.modern;

  ThemeData get lightTheme {
    switch (_preset) {
      case BloodThemePreset.classic:
        return BloodTheme.lightTheme;
      case BloodThemePreset.modern:
        return AppTheme.lightTheme;
    }
  }

  ThemeData get darkTheme {
    switch (_preset) {
      case BloodThemePreset.classic:
        return BloodTheme.darkTheme;
      case BloodThemePreset.modern:
        return AppTheme.darkTheme;
    }
  }

  void setPreset(BloodThemePreset newPreset) {
    if (_preset != newPreset) {
      _preset = newPreset;
      notifyListeners();
    }
  }

  void togglePreset() {
    setPreset(isModern ? BloodThemePreset.classic : BloodThemePreset.modern);
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  void toggleThemeMode() {
    if (_themeMode == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }
}
