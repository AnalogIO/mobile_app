import 'dart:async';

import 'package:cafe_analog_app/app/pending_login_redirect_store.dart';
import 'package:cafe_analog_app/app/user_context_cleaner.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the top-level dependencies required throughout the app.
class DependenciesProvider extends StatelessWidget {
  const new({required this.localStorage, required this.child, super.key});

  final SharedPreferencesWithCache localStorage;
  final MaterialApp child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Persistence
        RepositoryProvider.value(value: localStorage),
        RepositoryProvider(create: (_) => const FlutterSecureStorage()),
        RepositoryProvider(create: (_) => AuthTokenStore()),
        RepositoryProvider(create: (_) => AuthCubitHandle()),
        RepositoryProvider(create: (_) => PendingLoginRedirectStore()),
        RepositoryProvider(
          create: (context) => AuthTokenRepository(
            secureStorage: context.read(),
            authTokenStore: context.read(),
          ),
        ),

        // Http
        RepositoryProvider(create: makeApiClient),
        RepositoryProvider(create: (_) => Logger()),
        RepositoryProvider(
          create: (context) => NetworkRequestExecutor(
            logger: context.read(),
            api: context.read<TonikApiClient>(),
          ),
        ),

        // Login repository
        RepositoryProvider(
          create: (context) => LoginRepository(executor: context.read()),
        ),

        // Tickets repository
        RepositoryProvider(
          create: (context) => TicketsRepository(
            ticketsApi: TicketsApi(executor: context.read()),
            ownedTicketsLocalStore: OwnedTicketsLocalStore(
              store: context.read(),
            ),
            drinksLocalStore: DrinksLocalStore(),
            purchasableTicketsLocalStore: PurchasableTicketsLocalStore(),
            rememberedTicketDrinkLocalStore: RememberedTicketDrinkLocalStore(
              store: context.read(),
            ),
          ),
        ),

        // Statistics repository
        RepositoryProvider(
          create: (context) => StatisticsRepository(
            leaderboardApi: LeaderboardApi(executor: context.read()),
            quickStatsApi: QuickStatsApi(executor: context.read()),
          ),
        ),

        // Receipts repository
        RepositoryProvider(
          create: (context) => ReceiptsRepository(
            receiptsApi: ReceiptsApi(executor: context.read()),
          ),
        ),

        // Settings repository
        RepositoryProvider(
          create: (context) => SettingsRepository(
            accountApi: AccountApi(executor: context.read()),
            programmesApi: ProgrammesApi(executor: context.read()),
            profilePictureLocalStore: ProfilePictureLocalStore(
              store: context.read(),
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Authentication cubit
          BlocProvider(
            create: (context) {
              final authCubit = AuthCubit(
                authTokenRepository: context.read(),
                loginRepository: context.read(),
                clearAuthenticatedUserContext: UserContextCleaner(
                  localStorage: localStorage,
                ).clear,
              );
              unawaited(authCubit.start());
              context.read<AuthCubitHandle>().bind(authCubit);
              return authCubit;
            },
          ),
          // Purchase flow cubit
          BlocProvider(
            create: (context) => PurchaseFlowCubit(repository: context.read()),
          ),
          // Statistics cubits
          BlocProvider(
            create: (context) =>
                LeaderboardCubit(repository: context.read())
                  ..loadLeaderboard().ignore(),
          ),
          BlocProvider(
            create: (context) =>
                QuickStatsCubit(repository: context.read())
                  ..loadQuickStats().ignore(),
          ),
          // Receipts cubit
          BlocProvider(
            create: (context) =>
                ReceiptsCubit(repository: context.read())
                  ..loadReceipts().ignore(),
          ),
        ],
        child: child,
      ),
    );
  }
}
