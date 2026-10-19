part of 'programmes_cubit.dart';

sealed class ProgrammesState extends Equatable {
  const ProgrammesState();

  @override
  List<Object?> get props => [];
}

final class ProgrammesInitial extends ProgrammesState {
  const ProgrammesInitial();
}

final class ProgrammesLoading extends ProgrammesState {
  const ProgrammesLoading();
}

final class ProgrammesLoaded extends ProgrammesState {
  const ProgrammesLoaded(this.programmes);

  final List<Programme> programmes;

  @override
  List<Object?> get props => [programmes];
}

final class ProgrammesRefreshing extends ProgrammesLoaded {
  const ProgrammesRefreshing(super.programmes);
}

final class ProgrammesFailure extends ProgrammesState {
  const ProgrammesFailure({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
