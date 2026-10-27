import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mobile_starterkit/app/app.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings.dart';
import 'package:flutter_mobile_starterkit/core/settings/app_settings_repository.dart';

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

  testWidgets('Arabic locale sets right-to-left directionality', (tester) async {
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
    expect(
      Directionality.of(tester.element(arabicHeading)),
      TextDirection.rtl,
    );
  });
}
