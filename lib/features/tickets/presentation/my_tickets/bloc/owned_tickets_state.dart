part of 'owned_tickets_cubit.dart';

sealed class OwnedTicketsState extends Equatable {
  const OwnedTicketsState();

  @override
  List<Object> get props => [];
}

final class OwnedTicketsInitial extends OwnedTicketsState {}

final class OwnedTicketsLoading extends OwnedTicketsState {}

final class OwnedTicketsLoaded extends OwnedTicketsState {
  const OwnedTicketsLoaded({required this.ownedGroups});

  final List<OwnedTicketGroup> ownedGroups;

  @override
  List<Object> get props => [ownedGroups];
}

final class OwnedTicketsRefreshing extends OwnedTicketsLoaded {
  const OwnedTicketsRefreshing({required super.ownedGroups});
}

final class OwnedTicketsFailure extends OwnedTicketsState {
  const OwnedTicketsFailure({required this.reason});

  final String reason;

  @override
  List<Object> get props => [reason];
}
