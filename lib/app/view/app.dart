import 'package:cafe_analog_app/buy_tickets/buy_tickets_screen.dart';
import 'package:cafe_analog_app/buy_tickets/product.dart';
import 'package:cafe_analog_app/buy_tickets/ticket_detail_screen.dart';
import 'package:cafe_analog_app/login/login_screen.dart';
import 'package:cafe_analog_app/login/secret_page.dart';
import 'package:cafe_analog_app/receipts/receipts_screen.dart';
import 'package:cafe_analog_app/redeem_voucher/redeem_voucher_screen.dart';
import 'package:cafe_analog_app/settings/view/settings_screen.dart';
import 'package:cafe_analog_app/stats/view/stats_screen.dart';
import 'package:cafe_analog_app/tickets/tickets_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/tickets',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
    ),
    GoRoute(
      path: '/verify-mobilepay/:id',
      pageBuilder: (_, state) => MaterialPage(
        child: SecretScreen(id: state.pathParameters['id']!),
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
              path: '/tickets',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TicketsScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'buy',
                  builder: (_, _) => const BuyTicketsScreen(),
                  routes: [
                    GoRoute(
                      path: 'ticket/:id',
                      pageBuilder: (context, state) {
                        final product = state.extra! as Product;
                        return MaterialPage(
                          fullscreenDialog: true,
                          child: TicketDetailScreen(product: product),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: 'redeem_voucher',
                  pageBuilder: (context, state) => const MaterialPage(
                    child: RedeemVoucherScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/receipts',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ReceiptsScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'purchase_receipt/:id',
                  builder: (context, state) =>
                      Container(), // TODO(marfavi): Implement receipt screen
                ),
                GoRoute(
                  path: 'swipe_receipt/:id',
                  builder: (context, state) =>
                      Container(), // TODO(marfavi): Implement receipt screen
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: StatsScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SettingsScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // TODO(marfavi): Remove theme switching when all widgets support system theme
  Brightness _brightness = Brightness.light;

  void _setBrightness(Brightness brightness) {
    setState(() {
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(
        brightness: _brightness,
        colorScheme: ColorScheme.fromSeed(
          brightness: _brightness,
          // brightness: Brightness.dark,
          // dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
          seedColor: const Color(0xFF785B38),
          // seedColor: const Color(0xFF362619), // GOOD
          // primary: const Color(0xFF785B38),
          // surface: const Color(0xFFF9F8F2),
          // surfaceContainer: const Color(0xFFF0E8D8),
          // secondaryContainer: const Color(0xFFE9D4B7),
        ),
      ),
      builder: (context, child) {
        return AppBrightnessProvider(
          onBrightnessChanged: _setBrightness,
          child: child!,
        );
      },
    );
  }
}

class AppBrightnessProvider extends InheritedWidget {
  const AppBrightnessProvider({
    required this.onBrightnessChanged,
    required super.child,
    super.key,
  });

  final void Function(Brightness) onBrightnessChanged;

  static AppBrightnessProvider of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<AppBrightnessProvider>();
    assert(result != null, 'No AppBrightnessProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppBrightnessProvider oldWidget) {
    return onBrightnessChanged != oldWidget.onBrightnessChanged;
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
