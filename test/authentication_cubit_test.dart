import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthTokenRepository {}

class _MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late _MockAuthRepository authTokenRepository;
  late _MockLoginRepository loginRepository;
  late int clearUserContextCalls;

  setUp(() {
    authTokenRepository = _MockAuthRepository();
    loginRepository = _MockLoginRepository();
    clearUserContextCalls = 0;
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
          clearAuthenticatedUserContext: () async {
            clearUserContextCalls += 1;
          },
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
          clearAuthenticatedUserContext: () async {
            clearUserContextCalls += 1;
          },
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
        clearAuthenticatedUserContext: () async {
          clearUserContextCalls += 1;
        },
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
        expect(clearUserContextCalls, 1);
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
          clearAuthenticatedUserContext: () async {
            clearUserContextCalls += 1;
          },
        );
      },
      act: (cubit) => cubit.logOut(),
      verify: (_) {
        verify(() => authTokenRepository.clearTokens()).called(1);
        expect(clearUserContextCalls, 1);
      },
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthUnauthenticated>(),
      ],
    );

    group('refreshSession', () {
      test('emits nothing and returns true when refresh succeeds', () async {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(
          TaskEither.right(
            some(const AuthTokens(jwt: 'OLD-JWT', refreshToken: 'REF')),
          ),
        );
        when(
          () => loginRepository.authenticateWithMagicLinkToken('REF'),
        ).thenReturn(
          TaskEither.right(
            const AuthTokens(jwt: 'NEW-JWT', refreshToken: 'NEW-REF'),
          ),
        );
        when(
          () => authTokenRepository.saveTokens(
            const AuthTokens(jwt: 'NEW-JWT', refreshToken: 'NEW-REF'),
          ),
        ).thenReturn(
          TaskEither.right(
            const AuthTokens(jwt: 'NEW-JWT', refreshToken: 'NEW-REF'),
          ),
        );

        final cubit = AuthCubit(
          authTokenRepository: authTokenRepository,
          loginRepository: loginRepository,
          clearAuthenticatedUserContext: () async {},
        );
        final states = <AuthState>[];
        final subscription = cubit.stream.listen(states.add);
        addTearDown(subscription.cancel);
        addTearDown(cubit.close);

        final result = await cubit.refreshSession();

        expect(result, isTrue);
        expect(states, isEmpty);
        verify(() => loginRepository.authenticateWithMagicLinkToken('REF'))
            .called(1);
        verify(
          () => authTokenRepository.saveTokens(
            const AuthTokens(jwt: 'NEW-JWT', refreshToken: 'NEW-REF'),
          ),
        ).called(1);
      });

      test('returns false when no tokens are stored', () async {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(TaskEither.right(none()));

        final cubit = AuthCubit(
          authTokenRepository: authTokenRepository,
          loginRepository: loginRepository,
          clearAuthenticatedUserContext: () async {},
        );
        final states = <AuthState>[];
        final subscription = cubit.stream.listen(states.add);
        addTearDown(subscription.cancel);
        addTearDown(cubit.close);

        final result = await cubit.refreshSession();

        expect(result, isFalse);
        expect(states, isEmpty);
        verifyNever(
          () => loginRepository.authenticateWithMagicLinkToken(any()),
        );
      });

      test('returns false when the token exchange fails', () async {
        when(
          () => authTokenRepository.getTokens(),
        ).thenReturn(
          TaskEither.right(
            some(const AuthTokens(jwt: 'OLD-JWT', refreshToken: 'REF')),
          ),
        );
        when(
          () => loginRepository.authenticateWithMagicLinkToken('REF'),
        ).thenReturn(TaskEither.left(const UnexpectedFailure('boom')));

        final cubit = AuthCubit(
          authTokenRepository: authTokenRepository,
          loginRepository: loginRepository,
          clearAuthenticatedUserContext: () async {},
        );
        final states = <AuthState>[];
        final subscription = cubit.stream.listen(states.add);
        addTearDown(subscription.cancel);
        addTearDown(cubit.close);

        final result = await cubit.refreshSession();

        expect(result, isFalse);
        expect(states, isEmpty);
      });
    });
  });
}
