import 'package:flutter/material.dart';

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
    }
  }

  void toggleLanguage() {
    setLocale(isBangla ? const Locale('en') : const Locale('bn'));
  }
}
