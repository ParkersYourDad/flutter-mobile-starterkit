import 'package:flutter/material.dart';
import 'package:flutter_mobile_starterkit/app/theme/app_theme.dart';
import 'package:flutter_mobile_starterkit/core/widgets/app_bottom_bar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selecting a destination reports its index', (tester) async {
    var selectedIndex = -1;
    const destinations = [
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
    ];

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          bottomNavigationBar: AppBottomBar(
            currentIndex: 0,
            destinations: destinations,
            onDestinationSelected: (index) => selectedIndex = index,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Library'));
    expect(selectedIndex, 1);
  });

  testWidgets('selected destination is announced semantically', (tester) async {
    const destinations = [
      AppBottomBarDestination(
        label: 'Home',
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
      ),
      AppBottomBarDestination(
        label: 'Settings',
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings_rounded,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          bottomNavigationBar: AppBottomBar(
            currentIndex: 1,
            destinations: destinations,
            onDestinationSelected: (_) {},
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.text('Settings'));
    expect(
      semantics,
      matchesSemantics(isButton: true, isSelected: true, label: 'Settings'),
    );
  });
}
