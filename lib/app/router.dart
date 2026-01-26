import 'dart:async';

import 'package:cafe_analog_app/app/navigation_scaffolds.dart';
import 'package:cafe_analog_app/app/splash_screen.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/ui/authentication_navigator.dart';
import 'package:cafe_analog_app/login/ui/email_sent_screen.dart';
import 'package:cafe_analog_app/login/ui/login_screen.dart';
import 'package:cafe_analog_app/login/ui/verify_magic_link_screen.dart';
import 'package:cafe_analog_app/receipts/receipts_screen.dart';
import 'package:cafe_analog_app/redeem_voucher/redeem_voucher_screen.dart';
import 'package:cafe_analog_app/settings/settings_screen.dart';
import 'package:cafe_analog_app/settings/your_profile_screen.dart';
import 'package:cafe_analog_app/stats/view/stats_screen.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/buy_tickets_screen.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/product.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/ticket_detail_screen.dart';
import 'package:cafe_analog_app/tickets/my_tickets/ui/tickets_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnalogGoRouter {
  AnalogGoRouter._internal();

  static final AnalogGoRouter instance = AnalogGoRouter._internal();

  late final goRouter = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
    routes: routes,
    onEnter: onEnter,
    redirect: redirect,
  );

  late final routes = [
    // Root shell that listens to auth state changes
    ShellRoute(
      builder: (_, _, child) => AuthNavigator(child: child),
      routes: [
        // Splash screen shown at app start
        GoRoute(
          path: '/',
          pageBuilder: (_, _) => const NoTransitionPage(child: SplashScreen()),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (_, _) => CustomTransitionPage(
            child: const LoginScreen(),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
          routes: [
            GoRoute(
              path: 'email-sent',
              pageBuilder: (_, state) {
                final email = state.uri.queryParameters['email'] ?? '';
                return MaterialPage(child: EmailSentScreen(email: email));
              },
            ),
            GoRoute(
              path: 'auth/:token',
              pageBuilder: (_, state) => CustomTransitionPage(
                child: VerifyMagicLinkScreen(
                  magicLinkToken: state.pathParameters['token']!,
                ),
                transitionsBuilder: (_, animation, _, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/verify-mobilepay/:id',
          pageBuilder: (_, state) => MaterialPage(
            // TODO(marfavi): Implement MobilePay verification screen
            child: Container(),
          ),
        ),
        StatefulShellRoute.indexedStack(
          // fade in the main scaffold (doesn't affect branch transitions)
          pageBuilder: (_, _, shell) => CustomTransitionPage(
            child: ScaffoldWithNestedNavigation(navigationShell: shell),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
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
                            // we don't use id here, but in a real app you might
                            // fetch the product details based on the id
                            // we pass the whole product via extra
                            //
                            // cast state.extra to Product
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
                      // TODO(marfavi): Implement receipt screen
                      builder: (context, state) => Container(),
                    ),
                    GoRoute(
                      path: 'swipe_receipt/:id',
                      // TODO(marfavi): Implement receipt screen
                      builder: (context, state) => Container(),
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
                  routes: [
                    GoRoute(
                      path: 'your-profile',
                      pageBuilder: (context, state) =>
                          const MaterialPage(child: YourProfileScreen()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final loc = state.matchedLocation;
    final isLoggedIn = context.read<AuthCubit>().state is AuthAuthenticated;

    // User is going anywhere within [/login, /login/email-sent, /login/auth/]
    final goingToLoginFlow = loc.startsWith('/login');

    // User is specifically accessing the app via a magic link (/login/auth/)
    final goingToAuthenticate = loc.startsWith('/login/auth/');

    // User is starting the app
    final isStartingApp = loc == '/';

    // If not logged in, always go to login unless already going there
    // (or starting the app, which will handle redirection itself)
    if (!isLoggedIn &&
        !goingToLoginFlow &&
        !goingToAuthenticate &&
        !isStartingApp) {
      if (kDebugMode) {
        print('Redirecting to /login');
      }
      return '/login';
    }

    // If logged in and accessing app via login deep link, redirect to main app
    if (isLoggedIn && goingToAuthenticate) {
      // Show a snackbar after the frame is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are already logged in.')),
        );
      });
      return '/tickets';
    }

    // If logged in and going to login, redirect to main app
    if (isLoggedIn && goingToLoginFlow) {
      return '/tickets';
    }

    // No need to redirect at all
    return null;
  }

  FutureOr<OnEnterResult> onEnter(
    BuildContext context,
    GoRouterState currentState,
    GoRouterState nextState,
    GoRouter goRouter,
  ) {
    final currentLoc = currentState.matchedLocation;
    final nextLoc = nextState.matchedLocation;
    final isLoggedIn = context.read<AuthCubit>().state is AuthAuthenticated;

    // User is going anywhere within [/login, /login/email-sent, /login/auth/]
    final goingToLoginFlow = nextLoc.startsWith('/login');

    // User is starting the app
    final isStartingApp = nextLoc == '/';

    // We consider the 'main' app sections to be the branches under the shell.
    final isInMainArea =
        currentLoc.startsWith('/tickets') ||
        currentLoc.startsWith('/receipts') ||
        currentLoc.startsWith('/stats') ||
        currentLoc.startsWith('/settings');

    // If the user is in the main app area and trying to go to the login flow
    // while already logged in, block the navigation and show a snackbar.
    if (isLoggedIn && goingToLoginFlow && isInMainArea) {
      if (kDebugMode) {
        print('Navigation to $nextLoc blocked: already logged in.');
      }
      return Block.then(
        () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are already logged in.')),
        ),
      );
    }
    // If the user is not logged in and trying to go to the main app area,
    // block the navigation and show a snackbar.
    if (!isLoggedIn && !goingToLoginFlow && !isStartingApp) {
      if (kDebugMode) {
        print('Navigation to $nextLoc blocked: not logged in.');
      }
      return Block.then(
        () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to continue.')),
        ),
      );
    }
    return const Allow();
  }
}
import 'dart:async';

import 'package:cafe_analog_app/app/navigation_scaffolds.dart';
import 'package:cafe_analog_app/app/splash_screen.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/ui/verify_magic_link_screen.dart';
import 'package:cafe_analog_app/login/ui/auth_navigator.dart';
import 'package:cafe_analog_app/login/ui/email_sent_screen.dart';
import 'package:cafe_analog_app/login/ui/login_screen.dart';
import 'package:cafe_analog_app/receipts/receipts_screen.dart';
import 'package:cafe_analog_app/redeem_voucher/redeem_voucher_screen.dart';
import 'package:cafe_analog_app/settings/settings_screen.dart';
import 'package:cafe_analog_app/settings/your_profile_screen.dart';
import 'package:cafe_analog_app/stats/view/stats_screen.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/buy_tickets_screen.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/product.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/ticket_detail_screen.dart';
import 'package:cafe_analog_app/tickets/my_tickets/tickets_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnalogGoRouter {
  AnalogGoRouter._internal();

  static final AnalogGoRouter instance = AnalogGoRouter._internal();

  late final goRouter = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
    routes: routes,
    onEnter: onEnter,
    redirect: redirect,
  );

  late final routes = [
    // Root shell that listens to auth state changes
    ShellRoute(
      builder: (_, _, child) => AuthNavigator(child: child),
      routes: [
        // Splash screen shown at app start
        GoRoute(
          path: '/',
          pageBuilder: (_, _) => const NoTransitionPage(child: SplashScreen()),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (_, _) => CustomTransitionPage(
            child: const LoginScreen(),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
          routes: [
            GoRoute(
              path: 'email-sent',
              pageBuilder: (_, state) {
                final email = state.uri.queryParameters['email'] ?? '';
                return MaterialPage(child: EmailSentScreen(email: email));
              },
            ),
            GoRoute(
              path: 'auth/:token',
              pageBuilder: (_, state) => CustomTransitionPage(
                child: VerifyMagicLinkScreen(
                  magicLinkToken: state.pathParameters['token']!,
                ),
                transitionsBuilder: (_, animation, _, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/verify-mobilepay/:id',
          pageBuilder: (_, state) => MaterialPage(
            // TODO(marfavi): Implement MobilePay verification screen
            child: Container(),
          ),
        ),
        StatefulShellRoute.indexedStack(
          // fade in the main scaffold (doesn't affect branch transitions)
          pageBuilder: (_, _, shell) => CustomTransitionPage(
            child: ScaffoldWithNestedNavigation(navigationShell: shell),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
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
                            // we don't use id here, but in a real app you might
                            // fetch the product details based on the id
                            // we pass the whole product via extra
                            //
                            // cast state.extra to Product
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
                      // TODO(marfavi): Implement receipt screen
                      builder: (context, state) => Container(),
                    ),
                    GoRoute(
                      path: 'swipe_receipt/:id',
                      // TODO(marfavi): Implement receipt screen
                      builder: (context, state) => Container(),
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
                  routes: [
                    GoRoute(
                      path: 'your-profile',
                      pageBuilder: (context, state) =>
                          const MaterialPage(child: YourProfileScreen()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final loc = state.matchedLocation;
    final isLoggedIn = context.read<AuthCubit>().state is AuthAuthenticated;

    // User is going anywhere within [/login, /login/email-sent, /login/auth/]
    final goingToLoginFlow = loc.startsWith('/login');

    // User is specifically accessing the app via a magic link (/login/auth/)
    final goingToAuthenticate = loc.startsWith('/login/auth/');

    // User is starting the app
    final isStartingApp = loc == '/';

    // If not logged in, always go to login unless already going there
    // (or starting the app, which will handle redirection itself)
    if (!isLoggedIn &&
        !goingToLoginFlow &&
        !goingToAuthenticate &&
        !isStartingApp) {
      if (kDebugMode) {
        print('Redirecting to /login');
      }
      return '/login';
    }

    // If logged in and accessing app via login deep link, redirect to main app
    if (isLoggedIn && goingToAuthenticate) {
      // Show a snackbar after the frame is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are already logged in.')),
        );
      });
      return '/tickets';
    }

    // If logged in and going to login, redirect to main app
    if (isLoggedIn && goingToLoginFlow) {
      return '/tickets';
    }

    // No need to redirect at all
    return null;
  }

  FutureOr<OnEnterResult> onEnter(
    BuildContext context,
    GoRouterState currentState,
    GoRouterState nextState,
    GoRouter goRouter,
  ) {
    final currentLoc = currentState.matchedLocation;
    final nextLoc = nextState.matchedLocation;
    final isLoggedIn = context.read<AuthCubit>().state is AuthAuthenticated;

    // User is going anywhere within [/login, /login/email-sent, /login/auth/]
    final goingToLoginFlow = nextLoc.startsWith('/login');

    // User is starting the app
    final isStartingApp = nextLoc == '/';

    // We consider the 'main' app sections to be the branches under the shell.
    final isInMainArea =
        currentLoc.startsWith('/tickets') ||
        currentLoc.startsWith('/receipts') ||
        currentLoc.startsWith('/stats') ||
        currentLoc.startsWith('/settings');

    // If the user is in the main app area and trying to go to the login flow
    // while already logged in, block the navigation and show a snackbar.
    if (isLoggedIn && goingToLoginFlow && isInMainArea) {
      if (kDebugMode) {
        print('Navigation to $nextLoc blocked: already logged in.');
      }
      return Block.then(
        () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are already logged in.')),
        ),
      );
    }
    // If the user is not logged in and trying to go to the main app area,
    // block the navigation and show a snackbar.
    if (!isLoggedIn && !goingToLoginFlow && !isStartingApp) {
      if (kDebugMode) {
        print('Navigation to $nextLoc blocked: not logged in.');
      }
      return Block.then(
        () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to continue.')),
        ),
      );
    }
    return const Allow();
  }
}
