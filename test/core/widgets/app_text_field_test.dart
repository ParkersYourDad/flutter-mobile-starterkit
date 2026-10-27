import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/app/theme/app_theme.dart';
import 'package:flutter_mobile_starterkit/core/widgets/app_text_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('label, hint, and input changes are wired', (tester) async {
    final values = <String>[];

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextField(
              label: 'Display name',
              hint: 'Type your name',
              onChanged: values.add,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Display name'), findsOneWidget);
    expect(find.text('Type your name'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Example');
    expect(values, ['Example']);
  });

  testWidgets('error text is visible and field can be disabled', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16),
            child: AppTextField(
              label: 'Email',
              errorText: 'Enter a valid email',
              enabled: false,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Enter a valid email'), findsOneWidget);
    final field = tester.widget<TextFormField>(find.byType(TextFormField));
    expect(field.enabled, isFalse);
  });
}
