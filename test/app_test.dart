import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/app/app.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings_controller.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAppSettingsRepository implements AppSettingsRepository {
  FakeAppSettingsRepository([this.settings = const AppSettings()]);

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

class DelayedAppSettingsRepository extends FakeAppSettingsRepository {
  DelayedAppSettingsRepository(this.completer);

  final Completer<AppSettings> completer;

  @override
  Future<AppSettings> load() => completer.future;
}

void main() {
  testWidgets('home can navigate to preferences', (tester) async {
    final repository = FakeAppSettingsRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appSettingsRepositoryProvider.overrideWithValue(repository),
        ],
        child: const StarterApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('A calmer starting point'), findsOneWidget);
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
  });

  testWidgets('Arabic locale sets right-to-left directionality', (
    tester,
  ) async {
    final repository = FakeAppSettingsRepository(
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

    final arabicHeading = find.text('بداية أكثر هدوءًا');
    expect(arabicHeading, findsOneWidget);
    expect(Directionality.of(tester.element(arabicHeading)), TextDirection.rtl);
  });

  testWidgets('compact Arabic preferences fit and expose RTL back navigation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repository = FakeAppSettingsRepository(
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
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test(
    'settings controller waits for initial load before persisting a change',
    () async {
      final completer = Completer<AppSettings>();
      final repository = DelayedAppSettingsRepository(completer);
      final container = ProviderContainer(
        overrides: [
          appSettingsRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final subscription = container.listen(
        appSettingsControllerProvider,
        (_, _) {},
        fireImmediately: true,
      );
      addTearDown(subscription.close);

      final update = container
          .read(appSettingsControllerProvider.notifier)
          .setThemeMode(ThemeMode.dark);
      completer.complete(const AppSettings());
      await update;

      expect(
        container.read(appSettingsControllerProvider).requireValue.themeMode,
        ThemeMode.dark,
      );
      expect(repository.settings.themeMode, ThemeMode.dark);
    },
  );
}
