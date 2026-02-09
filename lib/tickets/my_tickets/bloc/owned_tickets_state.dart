part of 'owned_tickets_cubit.dart';

sealed class OwnedTicketsState extends Equatable {
  const OwnedTicketsState();

  @override
  List<Object> get props => [];
}

final class OwnedTicketsInitial extends OwnedTicketsState {}

final class OwnedTicketsLoading extends OwnedTicketsState {}

final class OwnedTicketsLoaded extends OwnedTicketsState {
  const OwnedTicketsLoaded({required this.ownedTickets});

  final List<OwnedTicket> ownedTickets;

  @override
  List<Object> get props => [ownedTickets];
}

final class OwnedTicketsFailure extends OwnedTicketsState {
  const OwnedTicketsFailure({required this.reason});

  final String reason;

  @override
  List<Object> get props => [reason];
}
