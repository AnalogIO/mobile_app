import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/app/pending_login_redirect_store.dart';
import 'package:cafe_analog_app/app/router.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart'
    hide PurchaseReceipt, PurchaseStatus;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockAuthCubit extends Mock implements AuthCubit;

class _MockExecutor extends Mock implements NetworkRequestExecutor;

class _MockTicketsRepository extends Mock implements TicketsRepository;

class _MockStatisticsRepository extends Mock implements StatisticsRepository;

class _MockReceiptsRepository extends Mock implements ReceiptsRepository;

class _MockPurchaseFlowCubit extends Mock implements PurchaseFlowCubit;

class _MockSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache;

void main() {
  late _MockAuthCubit mockAuthCubit;
  late _MockExecutor mockExecutor;
  late _MockTicketsRepository mockTicketsRepository;
  late _MockStatisticsRepository mockStatisticsRepository;
  late _MockReceiptsRepository mockReceiptsRepository;
  late _MockPurchaseFlowCubit mockPurchaseFlowCubit;
  late _MockSharedPreferencesWithCache mockLocalStorage;
  late GoRouter goRouter;

  setUpAll(() {
    registerFallbackValue(const AuthInitial());
  });

  setUp(() {
    mockAuthCubit = _MockAuthCubit();
    mockExecutor = _MockExecutor();
    mockTicketsRepository = _MockTicketsRepository();
    mockStatisticsRepository = _MockStatisticsRepository();
    mockReceiptsRepository = _MockReceiptsRepository();
    mockPurchaseFlowCubit = _MockPurchaseFlowCubit();
    mockLocalStorage = _MockSharedPreferencesWithCache();

    when(() => mockTicketsRepository.getOwnedTickets())
        .thenAnswer((_) => Stream.value(const Right(<OwnedTicketGroup>[])));
    when(() => mockTicketsRepository.getPurchasableTickets())
        .thenAnswer((_) => TaskEither.right(<PurchasableTicketGroup>[]));
    when(
      () => mockTicketsRepository.refreshOwnedTickets(
        preferredOrder: any(named: 'preferredOrder'),
      ),
    ).thenAnswer((_) => TaskEither.right(<OwnedTicketGroup>[]));
    when(
      () => mockTicketsRepository.saveOwnedTicketsOrder(
        any<List<OwnedTicketGroup>>(),
      ),
    ).thenAnswer((_) => TaskEither.right(unit));

    when(() => mockStatisticsRepository.getQuickStats()).thenAnswer(
      (_) => TaskEither<Failure, QuickStats>.left(const ConnectionFailure()),
    );
    when(
      () => mockStatisticsRepository.getLeaderboard(
        filter: LeaderboardFilter.month,
      ),
    ).thenAnswer(
      (_) => TaskEither<Failure, List<LeaderboardUserEntry>>.left(
        const ConnectionFailure(),
      ),
    );
    when(
      () => mockReceiptsRepository.fetchReceipts(type: GetReceiptsType.all),
    ).thenAnswer(
      (_) => TaskEither<Failure, ReceiptsBatch>.left(const ConnectionFailure()),
    );

    whenListen(
      mockPurchaseFlowCubit,
      const Stream<PurchaseFlowState>.empty(),
      initialState: const PurchaseFlowIdle(),
    );

    goRouter = AnalogGoRouter.instance.createRouter();
  });

  tearDown(() {
    goRouter.dispose();
  });

  /// Wraps the widget tree with the repository and bloc providers needed by
  /// the test [goRouter] (whose indexed-stack may materialise TicketsScreen).
  Widget buildApp({required GoRouter router}) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => PendingLoginRedirectStore()),
        RepositoryProvider<NetworkRequestExecutor>.value(value: mockExecutor),
        RepositoryProvider<TicketsRepository>.value(
          value: mockTicketsRepository,
        ),
        RepositoryProvider<StatisticsRepository>.value(
          value: mockStatisticsRepository,
        ),
        RepositoryProvider<ReceiptsRepository>.value(
          value: mockReceiptsRepository,
        ),
        RepositoryProvider<SharedPreferencesWithCache>.value(
          value: mockLocalStorage,
        ),
      ],
      child: BlocProvider<AuthCubit>.value(
        value: mockAuthCubit,
        child: BlocProvider<PurchaseFlowCubit>.value(
          value: mockPurchaseFlowCubit,
          child: MaterialApp.router(
            routerConfig: router,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      ),
    );
  }

  /// Pumps enough frames for navigation, route transitions, and
  /// post-frame callbacks to complete without relying on [pumpAndSettle]
  /// (which times out when indeterminate animations or periodic timers
  /// are running).
  Future<void> pumpNavigation(WidgetTester tester) async {
    await tester.pump(); // schedule microtasks / post-frame callbacks
    await tester.pump(const Duration(milliseconds: 100)); // let transitions run
  }

  testWidgets('redirects to /login when not logged in', (tester) async {
    when(() => mockAuthCubit.state).thenReturn(const AuthUnauthenticated());
    whenListen(
      mockAuthCubit,
      Stream.value(const AuthUnauthenticated()),
      initialState: const AuthUnauthenticated(),
    );

    await tester.pumpWidget(buildApp(router: goRouter));

    goRouter.go('/tickets');
    await pumpNavigation(tester);

    expect(find.text('Please log in to continue.'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('resumes redeem voucher deep link after successful login', (
    tester,
  ) async {
    final ctl = StreamController<AuthState>();
    when(() => mockAuthCubit.state).thenReturn(const AuthUnauthenticated());
    whenListen(
      mockAuthCubit,
      ctl.stream,
      initialState: const AuthUnauthenticated(),
    );

    await tester.pumpWidget(buildApp(router: goRouter));

    goRouter.go('/tickets/redeem-voucher/OMM-QPY7EQUQ');
    await pumpNavigation(tester);

    expect(find.text('Please log in to continue.'), findsOneWidget);

    ctl.add(
      const AuthAuthenticated(
        tokens: AuthTokens(jwt: 'j', refreshToken: 'r'),
      ),
    );
    await pumpNavigation(tester);

    expect(find.text('Redeem voucher?'), findsOneWidget);
    expect(
      find.text('Confirm to redeem voucher with code "OMM-QPY7EQUQ"'),
      findsOneWidget,
    );

    await ctl.close();
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets(
    'blocks navigation to /login when already logged in and in main area',
    (tester) async {
      when(() => mockAuthCubit.state).thenReturn(
        const AuthAuthenticated(
          tokens: AuthTokens(jwt: 'j', refreshToken: 'r'),
        ),
      );
      whenListen(
        mockAuthCubit,
        Stream.value(mockAuthCubit.state),
        initialState: mockAuthCubit.state,
      );

      await tester.pumpWidget(buildApp(router: goRouter));

      goRouter.go('/tickets');
      await pumpNavigation(tester);

      goRouter.go('/login');
      await pumpNavigation(tester);

      expect(find.text('Tickets'), findsWidgets);
      expect(find.text('You are already logged in.'), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets('shows and hides loading overlay based on AuthLoading', (
    tester,
  ) async {
    when(() => mockAuthCubit.state).thenReturn(const AuthInitial());

    final ctl = StreamController<AuthState>();
    whenListen(mockAuthCubit, ctl.stream, initialState: const AuthInitial());

    // Use a fresh local GoRouter so AuthNavigator can call context.go
    // without side-effects from the singleton's indexed-stack.
    final testRouter = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const AuthNavigator(child: SizedBox()),
        ),
        GoRoute(path: '/login', builder: (_, _) => const SizedBox()),
        GoRoute(path: '/tickets', builder: (_, _) => const SizedBox()),
      ],
    );

    await tester.pumpWidget(buildApp(router: testRouter));
    await pumpNavigation(tester);

    final preModalCount = tester.widgetList(find.byType(ModalBarrier)).length;
    final preIndicatorCount = tester
        .widgetList(find.byType(AnalogCircularProgressIndicator))
        .length;

    ctl.add(const AuthLoading());
    await pumpNavigation(tester);

    final postModalCount = tester.widgetList(find.byType(ModalBarrier)).length;
    final postIndicatorCount = tester
        .widgetList(find.byType(AnalogCircularProgressIndicator))
        .length;

    expect(postModalCount, greaterThan(preModalCount));
    expect(postIndicatorCount, greaterThan(preIndicatorCount));

    ctl.add(const AuthUnauthenticated());
    await pumpNavigation(tester);

    final finalModalCount = tester.widgetList(find.byType(ModalBarrier)).length;
    final finalIndicatorCount = tester
        .widgetList(find.byType(AnalogCircularProgressIndicator))
        .length;

    expect(finalIndicatorCount, lessThan(postIndicatorCount));
    expect(finalModalCount, greaterThanOrEqualTo(preModalCount));

    await ctl.close();
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('shows snackbar on AuthFailure', (tester) async {
    final ctl = StreamController<AuthState>();
    when(() => mockAuthCubit.state).thenReturn(const AuthInitial());
    whenListen(mockAuthCubit, ctl.stream, initialState: const AuthInitial());

    await tester.pumpWidget(buildApp(router: goRouter));
    await tester.pump();

    ctl.add(const AuthFailure(reason: 'bad'));
    await pumpNavigation(tester);

    expect(find.text('Authentication failed: bad'), findsOneWidget);

    await ctl.close();
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('navigates to email-sent when AuthEmailSent is emitted', (
    tester,
  ) async {
    final ctl = StreamController<AuthState>();
    when(() => mockAuthCubit.state).thenReturn(const AuthInitial());
    whenListen(mockAuthCubit, ctl.stream, initialState: const AuthInitial());

    await tester.pumpWidget(buildApp(router: goRouter));
    await tester.pump();

    ctl.add(const AuthEmailSent(email: 'user@example.com'));
    await pumpNavigation(tester);

    expect(find.text('Check your email'), findsOneWidget);
    expect(find.text('user@example.com'), findsOneWidget);

    await ctl.close();
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('owns the session cubits in the authenticated shell', (
    tester,
  ) async {
    final ctl = StreamController<AuthState>();
    when(() => mockAuthCubit.state).thenReturn(const AuthUnauthenticated());
    whenListen(
      mockAuthCubit,
      ctl.stream,
      initialState: const AuthUnauthenticated(),
    );

    // The router reads the current auth state from [AuthCubit.state] while
    // [AuthNavigator] reacts to the emitted states, so keep both in sync.
    Future<void> signIn(AuthTokens tokens) async {
      when(() => mockAuthCubit.state)
          .thenReturn(AuthAuthenticated(tokens: tokens));
      ctl.add(AuthAuthenticated(tokens: tokens));
      await pumpNavigation(tester);
    }

    Future<void> signOut() async {
      when(() => mockAuthCubit.state).thenReturn(const AuthUnauthenticated());
      ctl.add(const AuthUnauthenticated());
      await pumpNavigation(tester);
      // Let the page transition finish so the authenticated shell, and with it
      // the cubits it owns, is actually disposed.
      await tester.pump(const Duration(seconds: 1));
    }

    // Give each session its own receipt, so stale data would be visible.
    var receiptsLoaded = 0;
    when(() => mockReceiptsRepository.fetchReceipts(type: GetReceiptsType.all))
        .thenAnswer((_) {
          receiptsLoaded++;
          return TaskEither<Failure, ReceiptsBatch>.right(
            ReceiptsBatch(
              receipts: [
                PurchaseReceipt(
                  ticketName: 'Session $receiptsLoaded',
                  numberOfTickets: 1,
                  status: PurchaseStatus.completed,
                  priceDKK: 20,
                  orderDate: DateTime(2026, 1, receiptsLoaded),
                  orderId: 'order-$receiptsLoaded',
                ),
              ],
              continuationToken: '',
              hasMore: false,
            ),
          );
        });

    await tester.pumpWidget(buildApp(router: goRouter));

    // Nothing user-scoped is loaded while signed out.
    verifyNever(() => mockStatisticsRepository.getQuickStats());
    verifyNever(
      () => mockReceiptsRepository.fetchReceipts(type: GetReceiptsType.all),
    );

    await signIn(const AuthTokens(jwt: 'j', refreshToken: 'r'));
    goRouter.go('/tickets');
    await pumpNavigation(tester);

    // The cubits belong to the shell, above the branches, so any branch can
    // read them. Using a ticket and renaming both refresh data owned by other
    // branches, which would throw if the cubits were scoped to /stats.
    final ticketsContext = tester.element(find.byType(TicketsScreen));
    expect(() => ticketsContext.read<LeaderboardCubit>(), returnsNormally);
    verify(
      () => mockStatisticsRepository.getLeaderboard(
        filter: LeaderboardFilter.month,
      ),
    ).called(1);

    // Visiting the branch that renders the leaderboard reuses the cubit
    // instead of creating and reloading another one.
    goRouter.go('/stats');
    await pumpNavigation(tester);
    verify(() => mockStatisticsRepository.getQuickStats()).called(1);
    verifyNever(
      () => mockStatisticsRepository.getLeaderboard(
        filter: LeaderboardFilter.month,
      ),
    );

    goRouter.go('/receipts');
    await pumpNavigation(tester);
    verify(
      () => mockReceiptsRepository.fetchReceipts(type: GetReceiptsType.all),
    ).called(1);
    expect(find.text('Purchased 1 Session 1 tickets'), findsOneWidget);

    // Logging out leaves the shell, so the next session gets fresh cubits and
    // refetches instead of reusing the previous account's data.
    await signOut();
    await signIn(const AuthTokens(jwt: 'j2', refreshToken: 'r2'));

    goRouter.go('/stats');
    await pumpNavigation(tester);

    verify(() => mockStatisticsRepository.getQuickStats()).called(1);
    verify(
      () => mockStatisticsRepository.getLeaderboard(
        filter: LeaderboardFilter.month,
      ),
    ).called(1);

    goRouter.go('/receipts');
    await pumpNavigation(tester);

    verify(
      () => mockReceiptsRepository.fetchReceipts(type: GetReceiptsType.all),
    ).called(1);
    expect(find.text('Purchased 1 Session 2 tickets'), findsOneWidget);
    expect(find.text('Purchased 1 Session 1 tickets'), findsNothing);

    await ctl.close();
    await tester.pump(const Duration(seconds: 1));
  });
}
