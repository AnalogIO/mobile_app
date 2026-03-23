part of 'use_ticket_cubit.dart';

sealed class UseTicketState extends Equatable {
  const UseTicketState();

  @override
  List<Object> get props => [];
}

final class UseTicketInitial extends UseTicketState {}

final class UseTicketLoading extends UseTicketState {}

final class UseTicketSuccess extends UseTicketState {
  const UseTicketSuccess({
    required this.drinkName,
    required this.ticketName,
    required this.usedAt,
  });

  final String drinkName;
  final String ticketName;
  final DateTime usedAt;

  @override
  List<Object> get props => [drinkName, ticketName, usedAt];
}

final class UseTicketFailure extends UseTicketState {
  const UseTicketFailure({required this.reason});

  final String reason;

  @override
  List<Object> get props => [reason];
}
