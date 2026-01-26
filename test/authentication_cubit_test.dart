import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/data/authentication_repository.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:cafe_analog_app/login/data/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late _MockAuthRepository authRepository;
  late _MockLoginRepository loginRepository;

  setUp(() {
    authRepository = _MockAuthRepository();
    loginRepository = _MockLoginRepository();
  });

  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'emits [LoadInProgress, Authenticated] when started '
      'and AuthRepository reports logged in',
      build: () {
        when(() => authRepository.getTokens()).thenReturn(
          TaskEither.right(
            some(const AuthTokens(jwt: 'JWT-TOKEN', refreshToken: 'REF')),
          ),
        );
        return AuthCubit(
          authRepository: authRepository,
          loginRepository: loginRepository,
        );
      },
      act: (cubit) => cubit.start(),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthAuthenticated>().having(
          (s) => s.tokens.jwt,
          'jwt',
          'JWT-TOKEN',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [LoadInProgress, Unauthenticated] when started and not logged in',
      build: () {
        when(
          () => authRepository.getTokens(),
        ).thenReturn(TaskEither.right(none()));
        return AuthCubit(
          authRepository: authRepository,
          loginRepository: loginRepository,
        );
      },
      act: (cubit) => cubit.start(),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthUnauthenticated>(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [LoadInProgress, Authenticated] when authorizeWithToken succeeds',
      setUp: () {
        when(() => loginRepository.authorizeWithToken('TOKEN')).thenReturn(
          TaskEither.right(
            const AuthTokens(jwt: 'PROVIDED-JWT', refreshToken: 'REF'),
          ),
        );
        when(
          () => authRepository.saveTokens(
            const AuthTokens(jwt: 'PROVIDED-JWT', refreshToken: 'REF'),
          ),
        ).thenReturn(
          TaskEither.right(
            const AuthTokens(jwt: 'PROVIDED-JWT', refreshToken: 'REF'),
          ),
        );
      },
      build: () => AuthCubit(
        authRepository: authRepository,
        loginRepository: loginRepository,
      ),
      act: (cubit) => cubit.authorizeWithToken(magicLinkToken: 'TOKEN'),
      verify: (_) {
        verify(() => loginRepository.authorizeWithToken('TOKEN')).called(1);
        verify(
          () => authRepository.saveTokens(
            const AuthTokens(jwt: 'PROVIDED-JWT', refreshToken: 'REF'),
          ),
        ).called(1);
      },
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthAuthenticated>().having(
          (s) => s.tokens.jwt,
          'jwt',
          'PROVIDED-JWT',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [LoadInProgress, Unauthenticated] when logged out '
      'and clears tokens',
      build: () {
        when(
          () => authRepository.clearTokens(),
        ).thenReturn(TaskEither.right(unit));
        return AuthCubit(
          authRepository: authRepository,
          loginRepository: loginRepository,
        );
      },
      act: (cubit) => cubit.logOut(),
      verify: (_) {
        verify(() => authRepository.clearTokens()).called(1);
      },
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthUnauthenticated>(),
      ],
    );
  });
}
import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/data/authentication_token_repository.dart';
import 'package:cafe_analog_app/login/data/authentication_tokens.dart';
import 'package:cafe_analog_app/login/data/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthTokenRepository {}

class _MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late _MockAuthRepository authTokenRepository;
  late _MockLoginRepository loginRepository;

  setUp(() {
    authTokenRepository = _MockAuthRepository();
    loginRepository = _MockLoginRepository();
  });

  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'emits [Loading, Authenticated] when started '
      'and AuthRepository reports logged in',
      build: () {
        when(() => authTokenRepository.getTokens()).thenReturn(
          TaskEither.right(
            some(const AuthTokens(jwt: 'JWT-TOKEN', refreshToken: 'REF')),
          ),
        );
        return AuthCubit(
          authTokenRepository: authTokenRepository,
          loginRepository: loginRepository,
        );
      },
      act: (cubit) => cubit.start(),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthAuthenticated>().having(
          (s) => s.tokens.jwt,
          'jwt',
          'JWT-TOKEN',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [Loading, Unauthenticated] when started and not logged in',
      build: () {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(TaskEither.right(none()));
        return AuthCubit(
          authTokenRepository: authTokenRepository,
          loginRepository: loginRepository,
        );
      },
      act: (cubit) => cubit.start(),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthUnauthenticated>(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [Loading, Authenticated] '
      'when authenticateWithMagicLinkToken succeeds',
      setUp: () {
        when(
          () => loginRepository.authenticateWithMagicLinkToken('TOKEN'),
        ).thenReturn(
          TaskEither.right(
            const AuthTokens(jwt: 'PROVIDED-JWT', refreshToken: 'REF'),
          ),
        );
        when(
          () => authTokenRepository.saveTokens(
            const AuthTokens(jwt: 'PROVIDED-JWT', refreshToken: 'REF'),
          ),
        ).thenReturn(
          TaskEither.right(
            const AuthTokens(jwt: 'PROVIDED-JWT', refreshToken: 'REF'),
          ),
        );
      },
      build: () => AuthCubit(
        authTokenRepository: authTokenRepository,
        loginRepository: loginRepository,
      ),
      act: (cubit) => cubit.authenticateWithToken(magicLinkToken: 'TOKEN'),
      verify: (_) {
        verify(
          () => loginRepository.authenticateWithMagicLinkToken('TOKEN'),
        ).called(1);
        verify(
          () => authTokenRepository.saveTokens(
            const AuthTokens(jwt: 'PROVIDED-JWT', refreshToken: 'REF'),
          ),
        ).called(1);
      },
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthAuthenticated>().having(
          (s) => s.tokens.jwt,
          'jwt',
          'PROVIDED-JWT',
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [Loading, Unauthenticated] when logged out '
      'and clears tokens',
      build: () {
        when(
          () => authTokenRepository.clearTokens(),
        ).thenReturn(TaskEither.right(unit));
        return AuthCubit(
          authTokenRepository: authTokenRepository,
          loginRepository: loginRepository,
        );
      },
      act: (cubit) => cubit.logOut(),
      verify: (_) {
        verify(() => authTokenRepository.clearTokens()).called(1);
      },
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthUnauthenticated>(),
      ],
    );
  });
}
