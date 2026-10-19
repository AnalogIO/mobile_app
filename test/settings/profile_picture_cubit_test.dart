import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/settings/data/settings_repository.dart';
import 'package:cafe_analog_app/features/settings/models/profile_picture.dart';
import 'package:cafe_analog_app/features/settings/presentation/bloc/profile_picture_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockSettingsRepository extends Mock implements SettingsRepository;

const _picture = ProfilePicture(iconId: 3, backgroundColorId: 5);

void main() {
  late _MockSettingsRepository repository;

  setUp(() {
    repository = _MockSettingsRepository();
  });

  group('ProfilePictureCubit', () {
    blocTest<ProfilePictureCubit, ProfilePictureState>(
      'loadProfilePicture: emits loading then loaded',
      build: () {
        when(() => repository.getProfilePicture())
            .thenAnswer((_) => TaskEither.right(some(_picture)));
        return ProfilePictureCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProfilePicture(),
      expect: () => [
        isA<ProfilePictureLoading>(),
        isA<ProfilePictureLoaded>().having(
          (s) => s.picture.toNullable(),
          'picture',
          _picture,
        ),
      ],
    );

    blocTest<ProfilePictureCubit, ProfilePictureState>(
      'loadProfilePicture: emits failure on error',
      build: () {
        when(
          () => repository.getProfilePicture(),
        ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('boom')));
        return ProfilePictureCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProfilePicture(),
      expect: () => [
        isA<ProfilePictureLoading>(),
        isA<ProfilePictureFailure>().having((s) => s.reason, 'reason', 'boom'),
      ],
    );

    blocTest<ProfilePictureCubit, ProfilePictureState>(
      'setProfilePicture: emits loaded with the new picture',
      build: () {
        when(() => repository.saveProfilePicture(_picture))
            .thenAnswer((_) => TaskEither.right(unit));
        return ProfilePictureCubit(repository: repository);
      },
      act: (cubit) => cubit.setProfilePicture(_picture),
      expect: () => [
        isA<ProfilePictureLoaded>().having(
          (s) => s.picture.toNullable(),
          'picture',
          _picture,
        ),
      ],
    );

    test(
      'setProfilePicture: returns the failure and emits nothing on error',
      () async {
        when(
          () => repository.saveProfilePicture(_picture),
        ).thenAnswer((_) => TaskEither.left(const UnexpectedFailure('boom')));

        final cubit = ProfilePictureCubit(repository: repository);
        final states = <ProfilePictureState>[];
        final subscription = cubit.stream.listen(states.add);
        addTearDown(subscription.cancel);
        addTearDown(cubit.close);

        final result = await cubit.setProfilePicture(_picture);

        expect(result.isLeft(), isTrue);
        result.match(
          (failure) => expect(failure.reason, 'boom'),
          (_) => fail('Expected a failure, got success'),
        );
        expect(states, isEmpty);
      },
    );
  });
}
