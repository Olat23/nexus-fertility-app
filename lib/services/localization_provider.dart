import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class LocalizationProvider extends ChangeNotifier {
  static const _prefsKey = 'app_locale';

  static const supportedLocales = [
    Locale('en'),
    Locale('yo'),
    Locale('ig'),
    Locale('ha'),
  ];

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
=======
>>>>>>> main

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

<<<<<<< HEAD
  // Simple runtime translation map for quick wiring of new screens.
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'profileTitle': 'Profile',
      'editProfile': 'Edit profile',
      'audioGuidance': 'Audio Guidance',
      'ttcHistory': 'TTC History',
      'faithPreference': 'Faith Preference',
      'cycleLength': 'Cycle Length',
      'lastPeriodDate': 'Last Period Date',
      'continue': 'Continue',
      'joined': 'Joined',
      'audioLessons': 'Audio Learning',
      'play': 'Play',
      'stop': 'Stop',
      'supportHub': 'Support Hub',
      'dailyAffirmation': 'Daily Affirmations',
      'chooseSupportMode': 'Choose your support mode',
      'exploreCommunityGroups': 'Explore Community Groups'
    },
    'yo': {
      'profileTitle': 'Profile',
      'editProfile': 'Edit profile',
      'audioGuidance': 'Audio Guidance',
      'ttcHistory': 'TTC History',
      'faithPreference': 'Faith Preference',
      'cycleLength': 'Cycle Length',
      'lastPeriodDate': 'Last Period Date',
      'continue': 'Continue',
      'joined': 'Joined',
      'audioLessons': 'Audio Learning',
      'play': 'Play',
      'stop': 'Stop',
      'supportHub': 'Support Hub',
      'dailyAffirmation': 'Daily Affirmations',
      'chooseSupportMode': 'Choose your support mode',
      'exploreCommunityGroups': 'Explore Community Groups'
    },
    'ig': {
      'profileTitle': 'Profile',
      'editProfile': 'Edit profile',
      'audioGuidance': 'Audio Guidance',
      'ttcHistory': 'TTC History',
      'faithPreference': 'Faith Preference',
      'cycleLength': 'Cycle Length',
      'lastPeriodDate': 'Last Period Date',
      'continue': 'Continue',
      'joined': 'Joined',
      'audioLessons': 'Audio Learning',
      'play': 'Play',
      'stop': 'Stop',
      'supportHub': 'Support Hub',
      'dailyAffirmation': 'Daily Affirmations',
      'chooseSupportMode': 'Choose your support mode',
      'exploreCommunityGroups': 'Explore Community Groups'
    },
    'ha': {
      'profileTitle': 'Profile',
      'editProfile': 'Edit profile',
      'audioGuidance': 'Audio Guidance',
      'ttcHistory': 'TTC History',
      'faithPreference': 'Faith Preference',
      'cycleLength': 'Cycle Length',
      'lastPeriodDate': 'Last Period Date',
      'continue': 'Continue',
      'joined': 'Joined',
      'audioLessons': 'Audio Learning',
      'play': 'Play',
      'stop': 'Stop',
      'supportHub': 'Support Hub',
      'dailyAffirmation': 'Daily Affirmations',
      'chooseSupportMode': 'Choose your support mode',
      'exploreCommunityGroups': 'Explore Community Groups'
    }
  };

  String translate(String key) {
    try {
      final code = _locale.languageCode;
      return _localizedValues[code]?[key] ?? _localizedValues['en']?[key] ?? key;
    } catch (e) {
      return key;
    }
  }

  LocalizationProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefsKey);
      if (code != null && code.isNotEmpty) {
        _locale = Locale(code);
        notifyListeners();
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
=======
  static const supportedLocales = [
    Locale('en'),
    Locale('yo'), // Yoruba
    Locale('ig'), // Igbo
    Locale('ha'), // Hausa
  ];

  void setLocale(Locale locale) {
    if (supportedLocales.contains(locale)) {
      _locale = locale;
>>>>>>> main
      notifyListeners();
    }
  }

  void setLocaleByLanguageCode(String languageCode) {
    setLocale(Locale(languageCode));
  }
}
