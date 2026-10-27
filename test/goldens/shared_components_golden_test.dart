import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/app/theme/app_theme.dart';
import 'package:flutter_mobile_starterkit/core/widgets/app_bottom_bar.dart';
import 'package:flutter_mobile_starterkit/core/widgets/app_button.dart';
import 'package:flutter_mobile_starterkit/core/widgets/app_surface.dart';
import 'package:flutter_mobile_starterkit/core/widgets/app_text_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final brightness in Brightness.values) {
    final themeName = brightness == Brightness.light ? 'light' : 'dark';

    testWidgets('shared components $themeName golden', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          theme: brightness == Brightness.light
              ? AppTheme.light
              : AppTheme.dark,
          home: const _SharedComponentsGallery(),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('shared_components_$themeName.png'),
      );
    });
  }
}

class _SharedComponentsGallery extends StatelessWidget {
  const _SharedComponentsGallery();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Shared components', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 24),
            const AppButton(label: 'Continue', onPressed: _noop),
            const SizedBox(height: 12),
            const AppButton(
              label: 'Secondary action',
              onPressed: _noop,
              variant: AppButtonVariant.secondary,
            ),
            const SizedBox(height: 24),
            const AppSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('A quiet surface'),
                  SizedBox(height: 8),
                  Text(
                    'Reusable UI with consistent spacing and subtle borders.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const AppTextField(
              label: 'Display name',
              hint: 'Enter your name',
              initialValue: 'Example',
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomBar(
        currentIndex: 0,
        destinations: const [
          AppBottomBarDestination(
            label: 'Home',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home_rounded,
          ),
          AppBottomBarDestination(
            label: 'Library',
            icon: Icons.book_outlined,
            selectedIcon: Icons.book_rounded,
          ),
          AppBottomBarDestination(
            label: 'Settings',
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings_rounded,
          ),
        ],
        onDestinationSelected: _noopIndex,
      ),
    );
  }
}

void _noop() {}

void _noopIndex(int index) {}
