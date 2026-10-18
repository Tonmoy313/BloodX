import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App language controller for managing Bangla-first and English toggling (P-002).
class AppLanguage extends ChangeNotifier {
  static final AppLanguage instance = AppLanguage._();
  AppLanguage._();

  Locale _locale = const Locale('bn'); // Bangla-first by default

  Locale get locale => _locale;
  bool get isBangla => _locale.languageCode == 'bn';

  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
      unawaited(_saveLocale(newLocale.languageCode));
    }
  }

  void toggleLanguage() {
    setLocale(isBangla ? const Locale('en') : const Locale('bn'));
  }

  Future<void> _saveLocale(String languageCode) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('app.language', languageCode);
    } on PlatformException catch (error) {
      debugPrint('Could not save app language: ${error.code}');
    }
  }
}
