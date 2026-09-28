import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsCache {
  static const String _themeKey = 'app_theme';
  static const String _pushNotificationsKey = 'push_notifications';
  static const String _postNotificationsKey = 'post_notifications';
  static const String _messageNotificationsKey = 'message_notifications';

  static Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  static Future<bool> getPushNotifications() async {
    return AppSettingsCache._getBool(_pushNotificationsKey);
  }

  static Future<bool> getPostNotifications() async {
    return AppSettingsCache._getBool(_postNotificationsKey);
  }

  static Future<bool> getMessageNotifications() async {
    return AppSettingsCache._getBool(_messageNotificationsKey);
  }

  static Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  static Future<void> savePushNotifications(bool value) async {
    await AppSettingsCache._saveBool(_pushNotificationsKey, value);
  }

  static Future<void> savePostNotifications(bool value) async {
    await AppSettingsCache._saveBool(_postNotificationsKey, value);
  }

  static Future<void> saveMessageNotifications(bool value) async {
    await AppSettingsCache._saveBool(_messageNotificationsKey, value);
  }

  static Future<bool> _getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? true;
  }

  static Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
