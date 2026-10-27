import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/app/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

double _contrastRatio(Color foreground, Color background) {
  final first = foreground.computeLuminance();
  final second = background.computeLuminance();
  return (first > second ? first + 0.05 : second + 0.05) /
      (first < second ? first + 0.05 : second + 0.05);
}

void main() {
  test(
    'central text, secondary, primary-action, and error color pairs meet contrast targets',
    () {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        final background = theme.scaffoldBackgroundColor;
        final scheme = theme.colorScheme;
        final body = theme.textTheme.bodyMedium!.color!;
        final muted = theme.textTheme.bodySmall!.color!;

        expect(_contrastRatio(body, background), greaterThanOrEqualTo(4.5));
        expect(_contrastRatio(muted, background), greaterThanOrEqualTo(4.5));
        expect(
          _contrastRatio(scheme.secondary, background),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrastRatio(scheme.onPrimary, scheme.primary),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrastRatio(scheme.error, scheme.surface),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrastRatio(scheme.onError, scheme.error),
          greaterThanOrEqualTo(4.5),
        );
      }
    },
  );
}
