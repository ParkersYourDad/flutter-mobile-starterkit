import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_tokens.dart';
import '../../core/settings/app_settings.dart';
import '../../core/settings/app_settings_controller.dart';
import '../../core/widgets/app_surface.dart';
import '../../l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settingsValue = ref.watch(appSettingsControllerProvider);
    final settings = settingsValue.value ?? const AppSettings();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTokens.pageMaxWidth),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.pageHorizontalInset,
              AppTokens.space16,
              AppTokens.pageHorizontalInset,
              AppTokens.space48,
            ),
            children: [
              Text(l10n.settingsDescription, style: theme.textTheme.bodyMedium),
              if (!settings.persistenceAvailable) ...[
                const SizedBox(height: AppTokens.space24),
                AppSurface(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(width: AppTokens.space12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.persistenceWarningTitle,
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: AppTokens.space4),
                            Text(
                              l10n.persistenceWarningBody,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppTokens.space32),
              SectionHeader(
                title: l10n.appearance,
                description: l10n.appearanceDescription,
              ),
              const SizedBox(height: AppTokens.space16),
              SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                    value: ThemeMode.system,
                    label: Text(l10n.systemMode),
                    icon: const Icon(Icons.brightness_auto_outlined),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    label: Text(l10n.lightMode),
                    icon: const Icon(Icons.light_mode_outlined),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    label: Text(l10n.darkMode),
                    icon: const Icon(Icons.dark_mode_outlined),
                  ),
                ],
                selected: {settings.themeMode},
                onSelectionChanged: (selection) {
                  if (selection.isNotEmpty) {
                    _saveTheme(context, ref, selection.first, l10n);
                  }
                },
              ),
              const SizedBox(height: AppTokens.space32),
              SectionHeader(
                title: l10n.language,
                description: l10n.languageDescription,
              ),
              const SizedBox(height: AppTokens.space16),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: 'system',
                    label: Text(l10n.followSystem),
                  ),
                  ButtonSegment(value: 'en', label: Text(l10n.english)),
                  ButtonSegment(value: 'ar', label: Text(l10n.arabic)),
                ],
                selected: {settings.locale?.languageCode ?? 'system'},
                onSelectionChanged: (selection) {
                  if (selection.isNotEmpty) {
                    final value = selection.first;
                    final locale = switch (value) {
                      'en' => const Locale('en'),
                      'ar' => const Locale('ar'),
                      _ => null,
                    };
                    _saveLocale(context, ref, locale, l10n);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveTheme(
    BuildContext context,
    WidgetRef ref,
    ThemeMode mode,
    AppLocalizations l10n,
  ) async {
    try {
      await ref.read(appSettingsControllerProvider.notifier).setThemeMode(mode);
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.preferenceSaveFailed)));
    }
  }

  Future<void> _saveLocale(
    BuildContext context,
    WidgetRef ref,
    Locale? locale,
    AppLocalizations l10n,
  ) async {
    try {
      await ref.read(appSettingsControllerProvider.notifier).setLocale(locale);
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.preferenceSaveFailed)));
    }
  }
}
