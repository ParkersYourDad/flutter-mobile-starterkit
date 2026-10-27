import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings_controller.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubSettingsRepository implements AppSettingsRepository {
  _StubSettingsRepository({
    this.initial = const AppSettings(),
    this.loadError,
    this.themeSaveError,
    this.localeSaveError,
  });

  final AppSettings initial;
  final Object? loadError;
  final Object? themeSaveError;
  final Object? localeSaveError;

  @override
  Future<AppSettings> load() async {
    if (loadError != null) throw loadError!;
    return initial;
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    if (themeSaveError != null) throw themeSaveError!;
  }

  @override
  Future<void> saveLocale(Locale? locale) async {
    if (localeSaveError != null) throw localeSaveError!;
  }
}

void main() {
  test(
    'load failure falls back to system preferences and marks storage unavailable',
    () async {
      final container = ProviderContainer(
        overrides: [
          appSettingsRepositoryProvider.overrideWithValue(
            _StubSettingsRepository(loadError: StateError('read failed')),
          ),
        ],
      );
      addTearDown(container.dispose);

      final settings = await container.read(
        appSettingsControllerProvider.future,
      );

      expect(settings.themeMode, ThemeMode.system);
      expect(settings.locale, isNull);
      expect(settings.persistenceAvailable, isFalse);
    },
  );

  test(
    'theme write failure is surfaced and does not claim persistence success',
    () async {
      final error = StateError('write failed');
      final container = ProviderContainer(
        overrides: [
          appSettingsRepositoryProvider.overrideWithValue(
            _StubSettingsRepository(themeSaveError: error),
          ),
        ],
      );
      addTearDown(container.dispose);
      await container.read(appSettingsControllerProvider.future);

      await expectLater(
        container
            .read(appSettingsControllerProvider.notifier)
            .setThemeMode(ThemeMode.dark),
        throwsA(same(error)),
      );

      final state = container.read(appSettingsControllerProvider).requireValue;
      expect(state.themeMode, ThemeMode.dark);
      expect(state.persistenceAvailable, isFalse);
    },
  );

  test(
    'locale write failure is surfaced and marks persistence unavailable',
    () async {
      final error = StateError('write failed');
      final container = ProviderContainer(
        overrides: [
          appSettingsRepositoryProvider.overrideWithValue(
            _StubSettingsRepository(localeSaveError: error),
          ),
        ],
      );
      addTearDown(container.dispose);
      await container.read(appSettingsControllerProvider.future);

      await expectLater(
        container
            .read(appSettingsControllerProvider.notifier)
            .setLocale(const Locale('ar')),
        throwsA(same(error)),
      );

      final state = container.read(appSettingsControllerProvider).requireValue;
      expect(state.locale, const Locale('ar'));
      expect(state.persistenceAvailable, isFalse);
    },
  );
}
