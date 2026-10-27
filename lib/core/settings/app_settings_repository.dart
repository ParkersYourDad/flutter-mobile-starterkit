import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings.dart';

abstract interface class SettingsStorage {
  Future<String?> readString(String key);
  Future<void> writeString(String key, String value);
  Future<void> remove(String key);
}

class SharedPreferencesSettingsStorage implements SettingsStorage {
  SharedPreferencesSettingsStorage()
      : _preferences = SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> readString(String key) => _preferences.getString(key);

  @override
  Future<void> writeString(String key, String value) {
    return _preferences.setString(key, value);
  }

  @override
  Future<void> remove(String key) => _preferences.remove(key);
}

abstract interface class AppSettingsRepository {
  Future<AppSettings> load();
  Future<void> saveThemeMode(ThemeMode mode);
  Future<void> saveLocale(Locale? locale);
}

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  AppSettingsRepositoryImpl(this._storage);

  static const themeModeKey = 'appearance.themeMode';
  static const localeKey = 'appearance.locale';

  final SettingsStorage _storage;

  @override
  Future<AppSettings> load() async {
    final themeValue = await _storage.readString(themeModeKey);
    final localeValue = await _storage.readString(localeKey);

    final themeMode = switch (themeValue) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    final locale = switch (localeValue) {
      'en' => const Locale('en'),
      'ar' => const Locale('ar'),
      _ => null,
    };

    return AppSettings(
      themeMode: themeMode,
      locale: locale,
      persistenceAvailable: true,
    );
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) {
    return _storage.writeString(themeModeKey, mode.name);
  }

  @override
  Future<void> saveLocale(Locale? locale) async {
    if (locale == null) {
      await _storage.remove(localeKey);
      return;
    }

    if (locale.languageCode != 'en' && locale.languageCode != 'ar') {
      throw ArgumentError.value(
        locale,
        'locale',
        'Only English and Arabic are supported.',
      );
    }

    await _storage.writeString(localeKey, locale.languageCode);
  }
}

final settingsStorageProvider = Provider<SettingsStorage>((ref) {
  return SharedPreferencesSettingsStorage();
});

final appSettingsRepositoryProvider = Provider<AppSettingsRepository>((ref) {
  return AppSettingsRepositoryImpl(ref.watch(settingsStorageProvider));
});
