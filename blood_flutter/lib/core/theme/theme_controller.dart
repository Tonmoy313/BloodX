import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blood_theme.dart';
import 'blood_theme_modern.dart';

/// Available theme presets in BloodX:
/// - [classic]: Warm crimson over neutral surfaces (blood_theme.dart)
/// - [modern]: Crimson over midnight navy and warm off-white (blood_theme_modern.dart)
enum BloodThemePreset {
  classic,
  modern;

  static const BloodThemePreset fallback = BloodThemePreset.modern;

  static BloodThemePreset fromName(String? name) {
    return BloodThemePreset.values.firstWhere(
      (preset) => preset.name == name,
      orElse: () => BloodThemePreset.fallback,
    );
  }
}

/// App theme controller managing the theme preset (classic vs modern) and the
/// brightness mode (system/light/dark).
///
/// The choice is persisted in [SharedPreferences] so it survives a cold
/// start. The modern preset is the default for a fresh install.
class AppThemeController extends ChangeNotifier {
  static final AppThemeController instance = AppThemeController._();
  AppThemeController._();

  static const String _presetKey = 'app.theme_preset';
  static const String _modeKey = 'app.theme_mode';

  BloodThemePreset _preset = BloodThemePreset.fallback;
  ThemeMode _themeMode = ThemeMode.system;

  BloodThemePreset get preset => _preset;
  ThemeMode get themeMode => _themeMode;
  bool get isModern => _preset == BloodThemePreset.modern;

  ThemeData get lightTheme {
    switch (_preset) {
      case BloodThemePreset.classic:
        return BloodTheme.lightTheme;
      case BloodThemePreset.modern:
        return BloodThemeModern.lightTheme;
    }
  }

  ThemeData get darkTheme {
    switch (_preset) {
      case BloodThemePreset.classic:
        return BloodTheme.darkTheme;
      case BloodThemePreset.modern:
        return BloodThemeModern.darkTheme;
    }
  }

  /// Restores the persisted preset and mode. Safe to call more than once.
  Future<void> load() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final preset = BloodThemePreset.fromName(
        preferences.getString(_presetKey),
      );
      final modeName = preferences.getString(_modeKey);
      final mode = ThemeMode.values.firstWhere(
        (mode) => mode.name == modeName,
        orElse: () => ThemeMode.system,
      );

      if (preset != _preset || mode != _themeMode) {
        _preset = preset;
        _themeMode = mode;
        notifyListeners();
      }
    } on Exception {
      // A missing or unreadable preference keeps the defaults.
    }
  }

  void setPreset(BloodThemePreset newPreset) {
    if (_preset != newPreset) {
      _preset = newPreset;
      notifyListeners();
      _persist();
    }
  }

  void togglePreset() {
    setPreset(isModern ? BloodThemePreset.classic : BloodThemePreset.modern);
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
      _persist();
    }
  }

  void toggleThemeMode() {
    setThemeMode(
      _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  Future<void> _persist() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(_presetKey, _preset.name);
      await preferences.setString(_modeKey, _themeMode.name);
    } on Exception {
      // Failing to persist a cosmetic choice must never break the app.
    }
  }
}
