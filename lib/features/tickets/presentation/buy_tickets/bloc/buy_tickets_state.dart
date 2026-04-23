part of 'buy_tickets_cubit.dart';

sealed class BuyTicketsState extends Equatable {
  const BuyTicketsState();

  @override
  List<Object?> get props => [];
}

final class BuyTicketsInitial extends BuyTicketsState {}

final class BuyTicketsLoading extends BuyTicketsState {}

final class BuyTicketsLoaded extends BuyTicketsState {
  const BuyTicketsLoaded({required this.products});

  final List<PurchasableTicketGroup> products;

  @override
  List<Object?> get props => [products];
}

final class BuyTicketsFailure extends BuyTicketsState {
  const BuyTicketsFailure({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
