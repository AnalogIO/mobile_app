import 'package:bloc_test/bloc_test.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/settings/data/settings_repository.dart';
import 'package:cafe_analog_app/features/settings/models/programme.dart';
import 'package:cafe_analog_app/features/settings/presentation/bloc/programmes_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late _MockSettingsRepository repository;

  setUp(() {
    repository = _MockSettingsRepository();
  });

  group('ProgrammesCubit', () {
    blocTest<ProgrammesCubit, ProgrammesState>(
      'loadProgrammes: emits loading then loaded',
      build: () {
        when(() => repository.getProgrammes()).thenAnswer(
          (_) => TaskEither.right(const [
            Programme(
              id: 1,
              shortName: 'SWU',
              fullName: 'Software Development',
            ),
            Programme(id: 2, shortName: 'CS', fullName: 'Computer Science'),
          ]),
        );
        return ProgrammesCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProgrammes(),
      expect: () => [
        isA<ProgrammesLoading>(),
        isA<ProgrammesLoaded>()
            .having((s) => s.programmes.length, 'count', 2)
            .having(
              (s) => s.programmes.first.fullName,
              'first full name',
              'Software Development',
            ),
      ],
    );

    blocTest<ProgrammesCubit, ProgrammesState>(
      'loadProgrammes: emits failure on error',
      build: () {
        when(() => repository.getProgrammes()).thenAnswer(
          (_) => TaskEither.left(const UnexpectedFailure('boom')),
        );
        return ProgrammesCubit(repository: repository);
      },
      act: (cubit) => cubit.loadProgrammes(),
      expect: () => [
        isA<ProgrammesLoading>(),
        isA<ProgrammesFailure>().having((s) => s.reason, 'reason', 'boom'),
      ],
    );
  });
}
