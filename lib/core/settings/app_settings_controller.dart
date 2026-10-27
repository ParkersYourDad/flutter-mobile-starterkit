import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_settings.dart';
import 'app_settings_repository.dart';

final appSettingsControllerProvider =
    AsyncNotifierProvider<AppSettingsController, AppSettings>(
      AppSettingsController.new,
    );

class AppSettingsController extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() async {
    try {
      return await ref.read(appSettingsRepositoryProvider).load();
    } catch (_) {
      // Keep the app usable when preference storage is unavailable.
      return const AppSettings(persistenceAvailable: false);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final current = state.requireValue;
    state = AsyncData(current.copyWith(themeMode: mode));

    try {
      await ref.read(appSettingsRepositoryProvider).saveThemeMode(mode);
    } catch (error, stackTrace) {
      state = AsyncData(
        state.requireValue.copyWith(persistenceAvailable: false),
      );
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> setLocale(Locale? locale) async {
    final current = state.requireValue;
    state = AsyncData(
      locale == null
          ? current.copyWith(clearLocale: true)
          : current.copyWith(locale: locale),
    );

    try {
      await ref.read(appSettingsRepositoryProvider).saveLocale(locale);
    } catch (error, stackTrace) {
      state = AsyncData(
        state.requireValue.copyWith(persistenceAvailable: false),
      );
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
