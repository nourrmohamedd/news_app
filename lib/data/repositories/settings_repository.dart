import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/storage_keys.dart';

class SettingsRepository {
  SettingsRepository(this._prefs);
  final SharedPreferences _prefs;

  ThemeMode readThemeMode() =>
      _prefs.getString(StorageKeys.themeMode) == 'light'
      ? ThemeMode.light
      : ThemeMode.dark;

  Locale readLocale() =>
      Locale(_prefs.getString(StorageKeys.languageCode) ?? 'en');

  Future<void> saveThemeMode(ThemeMode mode) =>
      _prefs.setString(StorageKeys.themeMode, mode.name);

  Future<void> saveLocale(Locale locale) =>
      _prefs.setString(StorageKeys.languageCode, locale.languageCode);
}
