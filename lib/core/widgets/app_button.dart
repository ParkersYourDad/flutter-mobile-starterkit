import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';

enum AppButtonVariant { primary, secondary, tertiary }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.loading = false,
    this.width,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool loading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnPressed = loading ? null : onPressed;
    final child = _buildChild();

    final Widget button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      AppButtonVariant.tertiary => TextButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
    };

    if (width == null) {
      return button;
    }

    return SizedBox(width: width, child: button);
  }

  Widget _buildChild() {
    if (!loading) {
      return Text(label);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: AppTokens.space16,
          height: AppTokens.space16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: AppTokens.space12),
        Text(label),
      ],
    );
  }
}
