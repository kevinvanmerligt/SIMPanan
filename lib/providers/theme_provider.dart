import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeModePreference {
  system,
  light,
  dark;

  String get label {
    switch (this) {
      case AppThemeModePreference.system:
        return 'Sistem';
      case AppThemeModePreference.light:
        return 'Terang';
      case AppThemeModePreference.dark:
        return 'Gelap';
    }
  }

  String get description {
    switch (this) {
      case AppThemeModePreference.system:
        return 'Menyesuaikan tema otomatis dengan pengaturan perangkat';
      case AppThemeModePreference.light:
        return 'Warna hijau lebih gelap & elegan di latar terang';
      case AppThemeModePreference.dark:
        return 'Warna hijau lebih cerah bercahaya di latar gelap';
    }
  }

  IconData get icon {
    switch (this) {
      case AppThemeModePreference.system:
        return Icons.phone_android_rounded;
      case AppThemeModePreference.light:
        return Icons.light_mode_rounded;
      case AppThemeModePreference.dark:
        return Icons.dark_mode_rounded;
    }
  }
}

class ThemeProvider extends ChangeNotifier {
  static const String _prefKey = 'simpanan_theme_mode_preference';
  AppThemeModePreference _preference = AppThemeModePreference.system;

  AppThemeModePreference get preference => _preference;

  ThemeMode get themeMode {
    switch (_preference) {
      case AppThemeModePreference.system:
        return ThemeMode.system;
      case AppThemeModePreference.light:
        return ThemeMode.light;
      case AppThemeModePreference.dark:
        return ThemeMode.dark;
    }
  }

  ThemeProvider() {
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_prefKey);
      if (saved == AppThemeModePreference.light.name) {
        _preference = AppThemeModePreference.light;
      } else if (saved == AppThemeModePreference.dark.name) {
        _preference = AppThemeModePreference.dark;
      } else {
        _preference = AppThemeModePreference.system;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme preference: $e');
    }
  }

  Future<void> setThemePreference(AppThemeModePreference pref) async {
    if (_preference == pref) return;
    _preference = pref;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, pref.name);
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
    }
  }
}
