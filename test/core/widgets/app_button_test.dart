import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/app/theme/app_theme.dart';
import 'package:flutter_mobile_starterkit/core/widgets/app_button.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('loading button disables activation and exposes progress', (
    tester,
  ) async {
    var activations = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: AppButton(
            label: 'Continue',
            loading: true,
            onPressed: () => activations += 1,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);

    await tester.tap(find.text('Continue'));
    expect(activations, 0);
  });
}
