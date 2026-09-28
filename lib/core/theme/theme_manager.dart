import 'package:flutter/material.dart';
import 'package:blog_app/core/storage/app_settings_cache.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadThemeMode() async {
    _themeMode = await AppSettingsCache.getThemeMode();
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
