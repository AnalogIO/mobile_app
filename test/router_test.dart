import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/app/router.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/http/http.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:cafe_analog_app/login/ui/authentication_navigator.dart';
import 'package:chopper/chopper.dart' show Response;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockAuthCubit extends Mock implements AuthCubit {}

class _MockExecutor extends Mock implements NetworkRequestExecutor {
  @override
  TaskEither<Failure, B> run<B>(Future<Response<B>> Function(ApiClients _) _) =>
      TaskEither.left(const ConnectionFailure());
}

class _MockSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache {}

void main() {
  late _MockAuthCubit mockAuthCubit;
  late _MockExecutor mockExecutor;
  late _MockSharedPreferencesWithCache mockLocalStorage;
  late final goRouter = AnalogGoRouter.instance.goRouter;

  setUpAll(() {
    registerFallbackValue(const AuthInitial());
  });

  setUp(() {
    mockAuthCubit = _MockAuthCubit();
    mockExecutor = _MockExecutor();
    mockLocalStorage = _MockSharedPreferencesWithCache();
  });

  tearDown(() {
    goRouter.go('/');
  });

  /// Wraps the widget tree with the repository and bloc providers needed by
  /// the singleton [goRouter] (whose indexed-stack may materialise
  /// TicketsScreen).
  Widget buildApp({required GoRouter router}) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NetworkRequestExecutor>.value(value: mockExecutor),
        RepositoryProvider<SharedPreferencesWithCache>.value(
          value: mockLocalStorage,
        ),
      ],
      child: BlocProvider<AuthCubit>.value(
        value: mockAuthCubit,
        child: MaterialApp.router(
          routerConfig: router,
          builder: (context, child) =>
              Scaffold(body: child ?? const SizedBox()),
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

  testWidgets(
    'shows and hides loading overlay based on AuthLoading',
    (tester) async {
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

      final postModalCount = tester
          .widgetList(find.byType(ModalBarrier))
          .length;
      final postIndicatorCount = tester
          .widgetList(find.byType(AnalogCircularProgressIndicator))
          .length;

      expect(postModalCount, greaterThan(preModalCount));
      expect(postIndicatorCount, greaterThan(preIndicatorCount));

      ctl.add(const AuthUnauthenticated());
      await pumpNavigation(tester);

      final finalModalCount = tester
          .widgetList(find.byType(ModalBarrier))
          .length;
      final finalIndicatorCount = tester
          .widgetList(find.byType(AnalogCircularProgressIndicator))
          .length;

      expect(finalIndicatorCount, lessThan(postIndicatorCount));
      expect(finalModalCount, greaterThanOrEqualTo(preModalCount));

      await ctl.close();
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets('shows snackbar on AuthFailure', (tester) async {
    when(() => mockAuthCubit.state).thenReturn(const AuthInitial());
    whenListen(
      mockAuthCubit,
      Stream.fromIterable([
        const AuthInitial(),
        const AuthFailure(reason: 'bad'),
      ]),
      initialState: const AuthInitial(),
    );

    await tester.pumpWidget(buildApp(router: goRouter));
    await pumpNavigation(tester);

    expect(find.text('Authentication failed: bad'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets(
    'navigates to email-sent when AuthEmailSent is emitted',
    (tester) async {
      when(() => mockAuthCubit.state).thenReturn(const AuthInitial());
      whenListen(
        mockAuthCubit,
        Stream.fromIterable([
          const AuthInitial(),
          const AuthEmailSent(email: 'user@example.com'),
        ]),
        initialState: const AuthInitial(),
      );

      await tester.pumpWidget(buildApp(router: goRouter));
      await pumpNavigation(tester);

      expect(find.text('Check your email'), findsOneWidget);
      expect(find.text('user@example.com'), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));
    },
  );
}
