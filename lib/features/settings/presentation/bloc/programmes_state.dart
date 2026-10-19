part of 'programmes_cubit.dart';

sealed class ProgrammesState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class ProgrammesInitial extends ProgrammesState {
  const new();
}

final class ProgrammesLoading extends ProgrammesState {
  const new();
}

final class ProgrammesLoaded extends ProgrammesState {
  const new(this.programmes);

  final List<Programme> programmes;

  @override
  List<Object?> get props => [programmes];
}

final class ProgrammesRefreshing extends ProgrammesLoaded {
  const new(super.programmes);
}

final class ProgrammesFailure extends ProgrammesState {
  const new({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
