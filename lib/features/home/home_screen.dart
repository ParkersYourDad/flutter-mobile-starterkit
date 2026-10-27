import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_tokens.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_surface.dart';
import '../../l10n/generated/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.settings,
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.tune_rounded),
          ),
          const SizedBox(width: AppTokens.space8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTokens.pageMaxWidth),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.pageHorizontalInset,
              AppTokens.space24,
              AppTokens.pageHorizontalInset,
              AppTokens.space48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.welcomeEyebrow,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: AppTokens.space12),
                Text(l10n.welcomeTitle, style: theme.textTheme.headlineSmall),
                const SizedBox(height: AppTokens.space12),
                Text(l10n.welcomeBody, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppTokens.space32),
                _PrincipleRow(
                  icon: Icons.palette_outlined,
                  title: l10n.neutralDesign,
                  description: l10n.neutralDesignDescription,
                ),
                const Divider(height: AppTokens.space24),
                _PrincipleRow(
                  icon: Icons.widgets_outlined,
                  title: l10n.reusableComponents,
                  description: l10n.reusableComponentsDescription,
                ),
                const Divider(height: AppTokens.space24),
                _PrincipleRow(
                  icon: Icons.accessibility_new_rounded,
                  title: l10n.inclusiveByDefault,
                  description: l10n.inclusiveByDefaultDescription,
                ),
                const SizedBox(height: AppTokens.space32),
                AppButton(
                  width: double.infinity,
                  label: l10n.customizeButton,
                  onPressed: () => context.push('/settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrincipleRow extends StatelessWidget {
  const _PrincipleRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSurface(
          radius: AppTokens.radius12,
          padding: const EdgeInsets.all(AppTokens.space12),
          child: Icon(icon, size: 20, color: theme.colorScheme.onSurface),
        ),
        const SizedBox(width: AppTokens.space16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              const SizedBox(height: AppTokens.space4),
              Text(description, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
