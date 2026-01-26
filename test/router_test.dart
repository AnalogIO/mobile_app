import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/app/router.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:cafe_analog_app/login/ui/auth_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  late _MockAuthCubit mockAuth;
  late final goRouter = AnalogGoRouter.instance.goRouter;

  setUpAll(() {
    registerFallbackValue(const AuthInitial());
  });

  setUp(() {
    mockAuth = _MockAuthCubit();
  });

  tearDown(() {
    // reset router back to root to avoid leaking state between tests
    goRouter.go('/');
  });

  testWidgets(
    'redirects to /login when not logged in',
    (tester) async {
      when(() => mockAuth.state).thenReturn(const AuthUnauthenticated());
      whenListen(
        mockAuth,
        Stream.value(const AuthUnauthenticated()),
        initialState: const AuthUnauthenticated(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: goRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      // Try to navigate to a protected route
      goRouter.go('/tickets');
      // Allow one frame for onEnter to run and show SnackBar without waiting
      // for its duration
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Navigation is blocked by onEnter; ensure snackbar is shown
      expect(find.text('Please log in to continue.'), findsOneWidget);

      // allow any pending timers to clean up
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'blocks navigation to /login when already logged in and in main area',
    (tester) async {
      when(() => mockAuth.state).thenReturn(
        const AuthAuthenticated(
          tokens: AuthTokens(jwt: 'j', refreshToken: 'r'),
        ),
      );
      whenListen(
        mockAuth,
        Stream.value(mockAuth.state),
        initialState: mockAuth.state,
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: goRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      // start at /tickets
      goRouter.go('/tickets');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // attempt to navigate into login
      goRouter.go('/login');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tickets screen should still be visible and SnackBar shown
      expect(find.text('Tickets'), findsWidgets);
      expect(find.text('You are already logged in.'), findsOneWidget);

      // allow any pending timers to clean up
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'shows and hides loading overlay based on AuthLoading',
    (tester) async {
      when(() => mockAuth.state).thenReturn(const AuthInitial());

      // Stream controller lets us emit states with precise timing.
      final ctl = StreamController<AuthState>();
      whenListen(
        mockAuth,
        ctl.stream,
        initialState: const AuthInitial(),
      );

      // Use a fresh local GoRouter so AuthNavigator can call context.go safely
      final testRouter = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const AuthNavigator(child: SizedBox()),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: '/tickets',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: testRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      // Let initial frame build
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Count existing modal barriers and indicators
      final preModalCount = tester.widgetList(find.byType(ModalBarrier)).length;
      final preIndicatorCount = tester
          .widgetList(find.byType(AnalogCircularProgressIndicator))
          .length;

      // Emit loading, wait a frame for the dialog to be shown
      ctl.add(const AuthLoading());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Loading overlay should have added at least one modal barrier/indicator
      final postModalCount = tester
          .widgetList(find.byType(ModalBarrier))
          .length;
      final postIndicatorCount = tester
          .widgetList(find.byType(AnalogCircularProgressIndicator))
          .length;

      expect(postModalCount, greaterThan(preModalCount));
      expect(postIndicatorCount, greaterThan(preIndicatorCount));

      // Emit a non-loading state to dismiss the overlay
      ctl.add(const AuthUnauthenticated());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final finalModalCount = tester
          .widgetList(find.byType(ModalBarrier))
          .length;
      final finalIndicatorCount = tester
          .widgetList(find.byType(AnalogCircularProgressIndicator))
          .length;

      // The modal count might not return exactly to preModalCount due to other
      // modals, but the number of indicators should drop compared to when
      // loading was shown.
      expect(finalIndicatorCount, lessThan(postIndicatorCount));
      expect(finalModalCount, greaterThanOrEqualTo(preModalCount));
      await ctl.close();

      // allow any pending timers (e.g., DelayedFadeIn) to finish
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'shows snackbar on AuthFailure',
    (tester) async {
      when(() => mockAuth.state).thenReturn(const AuthInitial());
      whenListen(
        mockAuth,
        Stream.fromIterable([
          const AuthInitial(),
          const AuthFailure(reason: 'bad'),
        ]),
        initialState: const AuthInitial(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: goRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Authentication failed: bad'), findsOneWidget);

      // Allow any delayed timers (e.g., DelayedFadeIn) to finish
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'navigates to email-sent when AuthEmailSent is emitted',
    (tester) async {
      when(() => mockAuth.state).thenReturn(const AuthInitial());
      whenListen(
        mockAuth,
        Stream.fromIterable([
          const AuthInitial(),
          const AuthEmailSent(email: 'user@example.com'),
        ]),
        initialState: const AuthInitial(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: goRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      // Wait for navigation and the screen to settle
      await tester.pumpAndSettle();

      // Verify the EmailSentScreen content is shown
      expect(find.text('Check your email'), findsOneWidget);
      expect(find.text('user@example.com'), findsOneWidget);

      // Allow any timers (cooldown) to start/finish
      await tester.pump(const Duration(seconds: 1));
    },
  );
}
import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/app/router.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:cafe_analog_app/login/ui/authentication_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthCubit extends Mock implements AuthCubit {}

void main() {
  late _MockAuthCubit mockAuth;
  late final goRouter = AnalogGoRouter.instance.goRouter;

  setUpAll(() {
    registerFallbackValue(const AuthInitial());
  });

  setUp(() {
    mockAuth = _MockAuthCubit();
  });

  tearDown(() {
    // reset router back to root to avoid leaking state between tests
    goRouter.go('/');
  });

  testWidgets(
    'redirects to /login when not logged in',
    (tester) async {
      when(() => mockAuth.state).thenReturn(const AuthUnauthenticated());
      whenListen(
        mockAuth,
        Stream.value(const AuthUnauthenticated()),
        initialState: const AuthUnauthenticated(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: goRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      // Try to navigate to a protected route
      goRouter.go('/tickets');
      // Allow one frame for onEnter to run and show SnackBar without waiting
      // for its duration
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Navigation is blocked by onEnter; ensure snackbar is shown
      expect(find.text('Please log in to continue.'), findsOneWidget);

      // allow any pending timers to clean up
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'blocks navigation to /login when already logged in and in main area',
    (tester) async {
      when(() => mockAuth.state).thenReturn(
        const AuthAuthenticated(
          tokens: AuthTokens(jwt: 'j', refreshToken: 'r'),
        ),
      );
      whenListen(
        mockAuth,
        Stream.value(mockAuth.state),
        initialState: mockAuth.state,
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: goRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      // start at /tickets
      goRouter.go('/tickets');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // attempt to navigate into login
      goRouter.go('/login');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Tickets screen should still be visible and SnackBar shown
      expect(find.text('Tickets'), findsWidgets);
      expect(find.text('You are already logged in.'), findsOneWidget);

      // allow any pending timers to clean up
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'shows and hides loading overlay based on AuthLoading',
    (tester) async {
      when(() => mockAuth.state).thenReturn(const AuthInitial());

      // Stream controller lets us emit states with precise timing.
      final ctl = StreamController<AuthState>();
      whenListen(
        mockAuth,
        ctl.stream,
        initialState: const AuthInitial(),
      );

      // Use a fresh local GoRouter so AuthNavigator can call context.go safely
      final testRouter = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const AuthNavigator(child: SizedBox()),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: '/tickets',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: testRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      // Let initial frame build
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Count existing modal barriers and indicators
      final preModalCount = tester.widgetList(find.byType(ModalBarrier)).length;
      final preIndicatorCount = tester
          .widgetList(find.byType(AnalogCircularProgressIndicator))
          .length;

      // Emit loading, wait a frame for the dialog to be shown
      ctl.add(const AuthLoading());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Loading overlay should have added at least one modal barrier/indicator
      final postModalCount = tester
          .widgetList(find.byType(ModalBarrier))
          .length;
      final postIndicatorCount = tester
          .widgetList(find.byType(AnalogCircularProgressIndicator))
          .length;

      expect(postModalCount, greaterThan(preModalCount));
      expect(postIndicatorCount, greaterThan(preIndicatorCount));

      // Emit a non-loading state to dismiss the overlay
      ctl.add(const AuthUnauthenticated());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final finalModalCount = tester
          .widgetList(find.byType(ModalBarrier))
          .length;
      final finalIndicatorCount = tester
          .widgetList(find.byType(AnalogCircularProgressIndicator))
          .length;

      // The modal count might not return exactly to preModalCount due to other
      // modals, but the number of indicators should drop compared to when
      // loading was shown.
      expect(finalIndicatorCount, lessThan(postIndicatorCount));
      expect(finalModalCount, greaterThanOrEqualTo(preModalCount));
      await ctl.close();

      // allow any pending timers (e.g., DelayedFadeIn) to finish
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'shows snackbar on AuthFailure',
    (tester) async {
      when(() => mockAuth.state).thenReturn(const AuthInitial());
      whenListen(
        mockAuth,
        Stream.fromIterable([
          const AuthInitial(),
          const AuthFailure(reason: 'bad'),
        ]),
        initialState: const AuthInitial(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: goRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Authentication failed: bad'), findsOneWidget);

      // Allow any delayed timers (e.g., DelayedFadeIn) to finish
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'navigates to email-sent when AuthEmailSent is emitted',
    (tester) async {
      when(() => mockAuth.state).thenReturn(const AuthInitial());
      whenListen(
        mockAuth,
        Stream.fromIterable([
          const AuthInitial(),
          const AuthEmailSent(email: 'user@example.com'),
        ]),
        initialState: const AuthInitial(),
      );

      await tester.pumpWidget(
        BlocProvider<AuthCubit>.value(
          value: mockAuth,
          child: MaterialApp.router(
            routerConfig: goRouter,
            builder: (context, child) =>
                Scaffold(body: child ?? const SizedBox()),
          ),
        ),
      );

      // Wait for navigation and the screen to settle
      await tester.pumpAndSettle();

      // Verify the EmailSentScreen content is shown
      expect(find.text('Check your email'), findsOneWidget);
      expect(find.text('user@example.com'), findsOneWidget);

      // Allow any timers (cooldown) to start/finish
      await tester.pump(const Duration(seconds: 1));
    },
  );
}
