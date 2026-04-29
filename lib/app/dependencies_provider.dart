import 'dart:async';

import 'package:cafe_analog_app/app/pending_login_redirect_store.dart';
import 'package:cafe_analog_app/features/login/bloc/auth_cubit_handle.dart';
import 'package:cafe_analog_app/features/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/features/login/data/auth_token_store.dart';
import 'package:cafe_analog_app/features/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/features/login/data/login_repository.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the top-level dependencies required throughout the app.
class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({
    required this.localStorage,
    required this.child,
    super.key,
  });

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
        RepositoryProvider(create: makeHttpClient),
        RepositoryProvider(
          create: (context) =>
              context.read<ChopperClient>().getService<CoffeecardApiV1>(),
        ),
        RepositoryProvider(
          create: (context) =>
              context.read<ChopperClient>().getService<CoffeecardApiV2>(),
        ),
        RepositoryProvider(create: (_) => Logger()),
        RepositoryProvider(
          create: (context) => NetworkRequestExecutor(
            logger: context.read(),
            apiV1: context.read(),
            apiV2: context.read(),
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
      ],
      child: MultiBlocProvider(
        providers: [
          // Authentication cubit
          BlocProvider(
            create: (context) {
              final authCubit = AuthCubit(
                authTokenRepository: context.read(),
                loginRepository: context.read(),
                clearAuthenticatedUserContext: () async {
                  await RememberedTicketDrinkLocalStore(
                    store: localStorage,
                  ).clear().run();
                },
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
        ],
        child: child,
      ),
    );
  }
}
