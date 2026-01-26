import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      },
    );
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(
            label: 'Tickets',
            icon: selectedIndex == 0
                ? const Icon(Icons.confirmation_num)
                : const Icon(Icons.confirmation_num_outlined),
          ),
          NavigationDestination(
            label: 'Receipts',
            icon: selectedIndex == 1
                ? const Icon(Icons.receipt)
                : const Icon(Icons.receipt_outlined),
          ),
          NavigationDestination(
            label: 'Stats',
            icon: selectedIndex == 2
                ? const Icon(Icons.leaderboard)
                : const Icon(Icons.leaderboard_outlined),
          ),
          NavigationDestination(
            label: 'Settings',
            icon: selectedIndex == 3
                ? const Icon(Icons.settings)
                : const Icon(Icons.settings_outlined),
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
