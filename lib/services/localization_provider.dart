import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  static const _prefsKey = 'app_locale';

  static const supportedLocales = [
    Locale('en'),
    Locale('yo'), // Yoruba
    Locale('ig'), // Igbo
    Locale('ha'), // Hausa
  ];

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  LocalizationProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefsKey);
      if (code != null && code.isNotEmpty) {
        final locale = Locale(code);
        if (supportedLocales.any((l) => l.languageCode == locale.languageCode)) {
          _locale = locale;
          notifyListeners();
        }
      }
    } catch (_) {
      // ignore and keep default
    }
  }

  Future<void> _saveToPrefs(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, code);
    } catch (_) {}
  }

  void setLocale(Locale locale) {
    if (supportedLocales.any((l) => l.languageCode == locale.languageCode)) {
      _locale = Locale(locale.languageCode);
      _saveToPrefs(_locale.languageCode);
      notifyListeners();
    }
  }

  void setLocaleByLanguageCode(String languageCode) {
    setLocale(Locale(languageCode));
  }
}
