import 'package:cafe_analog_app/app/app_brightness_provider.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthCubit extends Mock implements AuthCubit;

class _MockSettingsRepository extends Mock implements SettingsRepository;

void main() {
  testWidgets('renders the registration form', (tester) async {
    final authCubit = _MockAuthCubit();
    final settingsRepository = _MockSettingsRepository();
    when(settingsRepository.getProgrammes)
        .thenAnswer((_) => TaskEither.right(const <Programme>[]));

    final programmesCubit = ProgrammesCubit(repository: settingsRepository);
    addTearDown(programmesCubit.close);
    await programmesCubit.loadProgrammes();

    await tester.pumpWidget(
      MaterialApp(
        home: AppBrightnessProvider(
          onBrightnessChanged: (_) {},
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>.value(value: authCubit),
              BlocProvider<ProgrammesCubit>.value(value: programmesCubit),
            ],
            child: const RegisterScreen(registrationToken: 'token'),
          ),
        ),
      ),
    );

    expect(find.text('Welcome to Analog!'), findsOneWidget);
    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Study programme'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });
}
