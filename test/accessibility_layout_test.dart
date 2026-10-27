import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/app/app.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _MemorySettingsRepository implements AppSettingsRepository {
  _MemorySettingsRepository(this.settings);

  AppSettings settings;

  @override
  Future<AppSettings> load() async => settings;

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    settings = settings.copyWith(themeMode: mode);
  }

  @override
  Future<void> saveLocale(Locale? locale) async {
    settings = locale == null
        ? settings.copyWith(clearLocale: true)
        : settings.copyWith(locale: locale);
  }
}

void main() {
  testWidgets(
    'Arabic preferences remain usable on a compact phone with enlarged text',
    (tester) async {
      tester.view.physicalSize = const Size(320, 720);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final repository = _MemorySettingsRepository(
        const AppSettings(locale: Locale('ar')),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appSettingsRepositoryProvider.overrideWithValue(repository),
          ],
          child: const StarterApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('الإعدادات'));
      await tester.pumpAndSettle();

      expect(find.text('التفضيلات'), findsOneWidget);
      expect(find.byType(BackButtonIcon), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
