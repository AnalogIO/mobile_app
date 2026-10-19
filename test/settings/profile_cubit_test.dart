import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/settings/data/settings_repository.dart';
import 'package:cafe_analog_app/features/settings/models/user_profile.dart';
import 'package:cafe_analog_app/features/settings/presentation/bloc/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockSettingsRepository extends Mock implements SettingsRepository;

UserProfile _profile({
  int id = 1,
  String name = 'Monir',
  String email = 'monir@example.com',
  String occupation = 'Software Development',
  int? programmeId = 1,
  bool appearAnonymous = false,
}) {
  return UserProfile(
    id: id,
    name: name,
    email: email,
    occupation: occupation,
    programmeId: programmeId,
    appearAnonymous: appearAnonymous,
  );
}

void main() {
  late _MockSettingsRepository repository;

  setUp(() {
    repository = _MockSettingsRepository();
  });

  group('ProfileCubit', () {
    blocTest<ProfileCubit, ProfileState>(
      'loadProfile: emits loading then loaded',
      build: () {
        when(() => repository.getProfile())
            .thenAnswer((_) => TaskEither.right(_profile()));
        return ProfileCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileLoaded>().having((s) => s.profile.name, 'name', 'Monir'),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'loadProfile: emits failure on error',
      build: () {
        when(
          () => repository.getProfile(),
        ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('boom')));
        return ProfileCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileFailure>().having((s) => s.reason, 'reason', 'boom'),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'updateName: emits loaded with the new name',
      build: () {
        when(() => repository.updateName(any()))
            .thenAnswer((_) => TaskEither.right(_profile(name: 'New Name')));
        return ProfileCubit(repository: repository);
      },
      act: (cubit) => cubit.updateName('New Name'),
      expect: () => [
        isA<ProfileLoaded>().having((s) => s.profile.name, 'name', 'New Name'),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'updateAppearAnonymous: emits loaded with the new flag',
      build: () {
        when(
          () => repository.updateAppearAnonymous(appearAnonymous: true),
        ).thenAnswer((_) => TaskEither.right(_profile(appearAnonymous: true)));
        return ProfileCubit(repository: repository);
      },
      act: (cubit) => cubit.updateAppearAnonymous(appearAnonymous: true),
      expect: () => [
        isA<ProfileLoaded>().having(
          (s) => s.profile.appearAnonymous,
          'appearAnonymous',
          isTrue,
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'updateEmail: emits loaded with the new email',
      build: () {
        when(() => repository.updateEmail(any())).thenAnswer(
          (_) => TaskEither.right(_profile(email: 'new@example.com')),
        );
        return ProfileCubit(repository: repository);
      },
      act: (cubit) => cubit.updateEmail('new@example.com'),
      expect: () => [
        isA<ProfileLoaded>().having(
          (s) => s.profile.email,
          'email',
          'new@example.com',
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'updateOccupation: emits loaded with the new programme',
      build: () {
        when(() => repository.updateProgramme(2)).thenAnswer(
          (_) => TaskEither.right(
            _profile(occupation: 'Computer Science', programmeId: 2),
          ),
        );
        return ProfileCubit(repository: repository);
      },
      act: (cubit) => cubit.updateOccupation(2),
      expect: () => [
        isA<ProfileLoaded>()
            .having((s) => s.profile.programmeId, 'programmeId', 2)
            .having(
              (s) => s.profile.occupation,
              'occupation',
              'Computer Science',
            ),
      ],
    );

    group('update failures', () {
      test(
        'updateName: keeps the loaded state and returns the failure',
        () async {
          when(() => repository.getProfile())
              .thenAnswer((_) => TaskEither.right(_profile()));
          when(
            () => repository.updateName(any()),
          ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('boom')));

          final cubit = ProfileCubit(repository: repository);
          addTearDown(cubit.close);
          await cubit.loadProfile();

          final result = await cubit.updateName('New Name');

          expect(result.isLeft(), isTrue);
          result.match(
            (failure) => expect(failure.reason, 'boom'),
            (_) => fail('Expected a failure, got a profile'),
          );
          expect(cubit.state, ProfileLoaded(_profile()));
        },
      );

      test(
        'updateEmail: keeps the loaded state and returns the failure',
        () async {
          when(() => repository.getProfile())
              .thenAnswer((_) => TaskEither.right(_profile()));
          when(
            () => repository.updateEmail(any()),
          ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('boom')));

          final cubit = ProfileCubit(repository: repository);
          addTearDown(cubit.close);
          await cubit.loadProfile();

          final result = await cubit.updateEmail('new@example.com');

          expect(result.isLeft(), isTrue);
          result.match(
            (failure) => expect(failure.reason, 'boom'),
            (_) => fail('Expected a failure, got a profile'),
          );
          expect(cubit.state, ProfileLoaded(_profile()));
        },
      );

      test(
        'updateAppearAnonymous: keeps the loaded state and returns the failure',
        () async {
          when(() => repository.getProfile())
              .thenAnswer((_) => TaskEither.right(_profile()));
          when(
            () => repository.updateAppearAnonymous(appearAnonymous: true),
          ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('boom')));

          final cubit = ProfileCubit(repository: repository);
          addTearDown(cubit.close);
          await cubit.loadProfile();

          final result = await cubit.updateAppearAnonymous(
            appearAnonymous: true,
          );

          expect(result.isLeft(), isTrue);
          result.match(
            (failure) => expect(failure.reason, 'boom'),
            (_) => fail('Expected a failure, got a profile'),
          );
          expect(cubit.state, ProfileLoaded(_profile()));
        },
      );

      test(
        'updateOccupation: keeps the loaded state and returns the failure',
        () async {
          when(() => repository.getProfile())
              .thenAnswer((_) => TaskEither.right(_profile()));
          when(
            () => repository.updateProgramme(2),
          ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('boom')));

          final cubit = ProfileCubit(repository: repository);
          addTearDown(cubit.close);
          await cubit.loadProfile();

          final result = await cubit.updateOccupation(2);

          expect(result.isLeft(), isTrue);
          result.match(
            (failure) => expect(failure.reason, 'boom'),
            (_) => fail('Expected a failure, got a profile'),
          );
          expect(cubit.state, ProfileLoaded(_profile()));
        },
      );

      group('requestAccountDeletion', () {
        test('returns right and emits nothing on success', () async {
          when(() => repository.requestAccountDeletion())
              .thenAnswer((_) => TaskEither.right(unit));

          final cubit = ProfileCubit(repository: repository);
          final states = <ProfileState>[];
          final subscription = cubit.stream.listen(states.add);
          addTearDown(subscription.cancel);
          addTearDown(cubit.close);

          final result = await cubit.requestAccountDeletion();

          expect(result.isRight(), isTrue);
          expect(states, isEmpty);
        });

        test('returns the failure and emits nothing on error', () async {
          when(
            () => repository.requestAccountDeletion(),
          ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('boom')));

          final cubit = ProfileCubit(repository: repository);
          final states = <ProfileState>[];
          final subscription = cubit.stream.listen(states.add);
          addTearDown(subscription.cancel);
          addTearDown(cubit.close);

          final result = await cubit.requestAccountDeletion();

          expect(result.isLeft(), isTrue);
          result.match(
            (failure) => expect(failure.reason, 'boom'),
            (_) => fail('Expected a failure, got success'),
          );
          expect(states, isEmpty);
        });
      });
    });
  });
}
