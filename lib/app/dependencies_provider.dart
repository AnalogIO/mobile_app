import 'dart:async';

import 'package:cafe_analog_app/http/http.dart';
import 'package:cafe_analog_app/login/bloc/auth_cubit_handle.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/data/auth_token_store.dart';
import 'package:cafe_analog_app/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/login/data/login_repository.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides the dependencies required throughout the app.
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

        // Auth/login repositories
        RepositoryProvider(
          create: (context) => LoginRepository(executor: context.read()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final authCubit = AuthCubit(
                authTokenRepository: context.read(),
                loginRepository: context.read(),
              );
              unawaited(authCubit.start());
              context.read<AuthCubitHandle>().bind(authCubit);
              return authCubit;
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
