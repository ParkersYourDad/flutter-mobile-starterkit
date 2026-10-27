import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/app/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('IBM Plex Sans Arabic is applied in both themes', () {
    expect(
      AppTheme.light.textTheme.bodyMedium?.fontFamily,
      'IBMPlexSansArabic',
    );
    expect(AppTheme.dark.textTheme.bodyMedium?.fontFamily, 'IBMPlexSansArabic');
  });

  test(
    'themes keep surfaces neutral and suppress decorative tint/elevation',
    () {
      expect(AppTheme.light.colorScheme.surfaceTint, Colors.transparent);
      expect(AppTheme.dark.colorScheme.surfaceTint, Colors.transparent);
      expect(AppTheme.light.appBarTheme.elevation, 0);
      expect(AppTheme.dark.appBarTheme.elevation, 0);
    },
  );
}
