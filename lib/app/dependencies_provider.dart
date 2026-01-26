import 'dart:async';

import 'package:cafe_analog_app/core/http_client.dart';
import 'package:cafe_analog_app/core/network_request_executor.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/login/data/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

/// Provides the dependencies required throughout the app.
class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({required this.child, super.key});

  final MaterialApp child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => const FlutterSecureStorage()),
        RepositoryProvider.value(value: apiV1),
        RepositoryProvider.value(value: apiV2),
        RepositoryProvider(create: (_) => Logger()),
        RepositoryProvider(
          create: (context) => NetworkRequestExecutor(logger: context.read()),
        ),
        RepositoryProvider(
          create: (context) =>
              LoginRepository(apiV2: context.read(), executor: context.read()),
        ),
        RepositoryProvider(
          create: (context) =>
              AuthTokenRepository(secureStorage: context.read()),
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
              return authCubit;
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
import 'dart:async';

import 'package:cafe_analog_app/core/http_client.dart';
import 'package:cafe_analog_app/core/network_request_executor.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/data/authentication_repository.dart';
import 'package:cafe_analog_app/login/data/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

/// Provides the dependencies required throughout the app.
class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({required this.child, super.key});

  final MaterialApp child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => const FlutterSecureStorage()),
        RepositoryProvider.value(value: apiV1),
        RepositoryProvider.value(value: apiV2),
        RepositoryProvider(create: (_) => Logger()),
        RepositoryProvider(
          create: (context) => NetworkRequestExecutor(logger: context.read()),
        ),
        RepositoryProvider(
          create: (context) =>
              LoginRepository(apiV2: context.read(), executor: context.read()),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(secureStorage: context.read()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final authCubit = AuthCubit(
                authRepository: context.read(),
                loginRepository: context.read(),
              );
              unawaited(authCubit.start());
              return authCubit;
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
