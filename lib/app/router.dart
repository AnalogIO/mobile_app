import 'dart:async';

import 'package:cafe_analog_app/app/navigation_scaffolds.dart';
import 'package:cafe_analog_app/app/pending_login_redirect_store.dart';
import 'package:cafe_analog_app/app/splash_screen.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:cafe_analog_app/features/redeem_voucher/redeem_voucher.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';

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
    observers: [RouteDebugObserver()],
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
                ShellRoute(
                  // provide TicketsRepository and cubits related
                  // to all routes under /tickets
                  // note: PurchaseFlowCubit is provided in DependenciesProvider
                  builder: (context, state, child) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) {
                            final cubit = OwnedTicketsCubit(
                              repository: context.read(),
                            );
                            unawaited(cubit.loadOwnedTickets());
                            return cubit;
                          },
                        ),
                        BlocProvider(
                          create: (context) {
                            final cubit = TicketCatalogCubit(
                              repository: context.read(),
                            );
                            unawaited(cubit.loadProducts());
                            return cubit;
                          },
                        ),
                      ],
                      child: PurchaseFlowCoordinator(child: child),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: '/tickets',
                      builder: (_, _) => const TicketsScreen(),
                      routes: [
                        GoRoute(
                          path: 'view-purchasable',
                          builder: (_, _) => const TicketCatalogScreen(),
                          routes: [
                            GoRoute(
                              path: ':ticketGroupId',
                              pageBuilder: (context, state) {
                                final group = state.extra;
                                const error =
                                    'No ticket group data found. '
                                    'Please go back and select a ticket '
                                    'group again.';

                                if (group is! PurchasableTicketGroup) {
                                  return const MaterialPage(
                                    child: Scaffold(
                                      body: Padding(
                                        padding: EdgeInsets.all(24),
                                        child: Center(
                                          child: Text(
                                            error,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return MaterialPage(
                                  // fullscreenDialog: true,
                                  child: TicketGroupDetailsScreen(
                                    ticketGroup: group,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        GoRoute(
                          path: 'verify-mobilepay-purchase',
                          redirect: (context, state) {
                            // Always redirect to /tickets but
                            // trigger purchase verification as a side effect
                            final _ = context
                                .read<PurchaseFlowCubit>()
                                .verifyPendingPurchase();
                            return '/tickets';
                          },
                        ),
                        GoRoute(
                          path: 'redeem-voucher',
                          pageBuilder: (context, state) => const MaterialPage(
                            child: RedeemVoucherScreen(),
                          ),
                        ),
                        GoRoute(
                          path: 'redeem-voucher/:initialVoucherCode',
                          pageBuilder: (context, state) {
                            final voucherCode =
                                state.pathParameters['initialVoucherCode']!;
                            return MaterialPage(
                              child: RedeemVoucherDeepLinkFlow(
                                voucherCode: voucherCode,
                              ),
                            );
                          },
                        ),
                      ],
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
    _logRouteDebug(
      'redirect check',
      'uri=${state.uri} matched=${state.matchedLocation} '
          'name=${state.name} fullPath=${state.fullPath}',
    );

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
      context.read<PendingLoginRedirectStore>().pendingRedirect = state.uri
          .toString();
      _logRouteDebug(
        'redirect apply',
        'from=${state.uri} to=/login reason=not_logged_in',
      );
      return '/login';
    }

    // If logged in and accessing app via login deep link, redirect to main app
    if (isLoggedIn && goingToAuthenticate) {
      _logRouteDebug(
        'redirect apply',
        'from=${state.uri} to=/tickets reason=already_logged_in_magic_link',
      );
      // Show a snackbar after the frame is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSnackBar(context: context, message: 'You are already logged in.');
      });
      return '/tickets';
    }

    // If logged in and going to login, redirect to main app
    if (isLoggedIn && goingToLoginFlow) {
      _logRouteDebug(
        'redirect apply',
        'from=${state.uri} to=/tickets reason=already_logged_in_login_flow',
      );
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

    _logRouteDebug(
      'onEnter',
      'fromUri=${currentState.uri} from=$currentLoc '
          'toUri=${nextState.uri} to=$nextLoc '
          'isLoggedIn=$isLoggedIn',
    );

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
      _logRouteDebug(
        'onEnter block',
        'toUri=${nextState.uri} to=$nextLoc reason=already_logged_in',
      );
      return Block.then(
        () => showSnackBar(
          context: context,
          message: 'You are already logged in.',
        ),
      );
    }
    // If the user is not logged in and trying to go to the main app area,
    // block the navigation and show a snackbar.
    if (!isLoggedIn && !goingToLoginFlow && !isStartingApp) {
      context.read<PendingLoginRedirectStore>().pendingRedirect = nextState.uri
          .toString();
      _logRouteDebug(
        'onEnter block',
        'toUri=${nextState.uri} to=$nextLoc reason=not_logged_in',
      );
      return Block.then(
        () => showSnackBar(
          context: context,
          message: 'Please log in to continue.',
        ),
      );
    }
    return const Allow();
  }
}

void _logRouteDebug(String event, String message) {
  if (!kDebugMode) {
    return;
  }
  debugPrint('[ROUTER][$event] $message');
}

class RouteDebugObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logRouteDebug(
      'didPush',
      '${route.settings.name ?? route.runtimeType} '
          'prev=${previousRoute?.settings.name ?? previousRoute?.runtimeType}',
    );
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logRouteDebug(
      'didReplace',
      '${oldRoute?.settings.name ?? oldRoute?.runtimeType} -> '
          '${newRoute?.settings.name ?? newRoute?.runtimeType}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logRouteDebug(
      'didPop',
      '${route.settings.name ?? route.runtimeType} '
          'next=${previousRoute?.settings.name ?? previousRoute?.runtimeType}',
    );
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logRouteDebug(
      'didRemove',
      '${route.settings.name ?? route.runtimeType} '
          'prev=${previousRoute?.settings.name ?? previousRoute?.runtimeType}',
    );
    super.didRemove(route, previousRoute);
  }
}
