import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'programmes_state.dart';

/// Cubit responsible for loading the list of available study programmes
/// (occupations) shown in the change-occupation screen.
class ProgrammesCubit extends Cubit<ProgrammesState> {
  new({required this._repository}) : super(const ProgrammesInitial());

  final SettingsRepository _repository;

  /// Loads the programmes, behaving as both an initial load and a refresh.
  Future<void> loadProgrammes() async {
    final currentState = state;
    if (currentState is ProgrammesLoading ||
        currentState is ProgrammesRefreshing) {
      return;
    }

    if (currentState is ProgrammesLoaded) {
      emit(ProgrammesRefreshing(currentState.programmes));
    } else {
      emit(const ProgrammesLoading());
    }

    await _repository
        .getProgrammes()
        .match(
          (failure) => emit(ProgrammesFailure(reason: failure.reason)),
          (programmes) => emit(ProgrammesLoaded(programmes)),
        )
        .run();
  }
}
