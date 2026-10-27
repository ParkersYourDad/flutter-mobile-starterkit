import 'package:flutter_mobile_starterkit/core/settings/app_settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class FakeSettingsStorage implements SettingsStorage {
  final Map<String, String> values = {};

  @override
  Future<String?> readString(String key) async => values[key];

  @override
  Future<void> writeString(String key, String value) async {
    values[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }
}

void main() {
  group('AppSettingsRepositoryImpl', () {
    late FakeSettingsStorage storage;
    late AppSettingsRepositoryImpl repository;

    setUp(() {
      storage = FakeSettingsStorage();
      repository = AppSettingsRepositoryImpl(storage);
    });

    test('uses system appearance and locale by default', () async {
      final settings = await repository.load();

      expect(settings.themeMode, ThemeMode.system);
      expect(settings.locale, isNull);
      expect(settings.persistenceAvailable, isTrue);
    });

    test('loads stored theme and locale overrides', () async {
      storage.values[AppSettingsRepositoryImpl.themeModeKey] = 'dark';
      storage.values[AppSettingsRepositoryImpl.localeKey] = 'ar';

      final settings = await repository.load();

      expect(settings.themeMode, ThemeMode.dark);
      expect(settings.locale, const Locale('ar'));
    });

    test('falls back safely for unsupported stored values', () async {
      storage.values[AppSettingsRepositoryImpl.themeModeKey] = 'unknown';
      storage.values[AppSettingsRepositoryImpl.localeKey] = 'fr';

      final settings = await repository.load();

      expect(settings.themeMode, ThemeMode.system);
      expect(settings.locale, isNull);
    });

    test('removes locale override when system locale is selected', () async {
      storage.values[AppSettingsRepositoryImpl.localeKey] = 'ar';

      await repository.saveLocale(null);

      expect(
        storage.values.containsKey(AppSettingsRepositoryImpl.localeKey),
        isFalse,
      );
    });

    test('rejects unsupported locale writes', () async {
      await expectLater(
        repository.saveLocale(const Locale('fr')),
        throwsArgumentError,
      );
    });
  });
}
