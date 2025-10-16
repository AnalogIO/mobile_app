import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_test_app/app/view/details_screen.dart';
import 'package:router_test_app/app/view/screen_with_next_page.dart';
import 'package:router_test_app/settings/view/settings_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const MaterialPage(
        child: ScreenWithNextPage(label: 'Login', nextPagePath: '/a'),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/a',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ScreenWithNextPage(
                  label: 'Tickets',
                  nextPagePath: '/a/details',
                ),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (_, _) => const ReceiptsScreen(label: 'A'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/b',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ScreenWithNextPage(
                  label: 'Receipts',
                  nextPagePath: '/b/details',
                ),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                      const ReceiptsScreen(label: 'Receipts'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/c',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ScreenWithNextPage(
                  label: 'Stats',
                ),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) =>
                      const ReceiptsScreen(label: 'Stats'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/d',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SettingsScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF362619)),
      ),
    );
  }
}

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
            icon: Icon(
              selectedIndex == 1 ? Icons.receipt : Icons.receipt_outlined,
            ),
          ),
          NavigationDestination(
            label: 'Stats',
            icon: Icon(
              selectedIndex == 2
                  ? Icons.leaderboard
                  : Icons.leaderboard_outlined,
            ),
          ),
          NavigationDestination(
            label: 'Settings',
            icon: Icon(
              selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
            ),
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
