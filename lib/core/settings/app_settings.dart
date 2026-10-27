import 'package:flutter/material.dart';

class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.locale,
    this.persistenceAvailable = true,
  });

  final ThemeMode themeMode;

  /// Null means follow the operating system locale.
  final Locale? locale;

  /// False means preferences fell back to in-memory defaults or a write failed.
  final bool persistenceAvailable;

  AppSettings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool clearLocale = false,
    bool? persistenceAvailable,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: clearLocale ? null : (locale ?? this.locale),
      persistenceAvailable:
          persistenceAvailable ?? this.persistenceAvailable,
    );
  }
}
