part of 'ticket_catalog_cubit.dart';

sealed class TicketCatalogState extends Equatable {
  const TicketCatalogState();
}

final class TicketCatalogInitial extends TicketCatalogState {
  const TicketCatalogInitial();

  @override
  List<Object?> get props => [];
}

final class LoadingTicketCatalog extends TicketCatalogState {
  const LoadingTicketCatalog();

  @override
  List<Object?> get props => [];
}

final class TicketCatalogLoaded extends TicketCatalogState {
  const TicketCatalogLoaded({required this.ticketGroups});

  final List<PurchasableTicketGroup> ticketGroups;

  @override
  List<Object?> get props => [ticketGroups];
}

final class TicketCatalogLoadFailure extends TicketCatalogState {
  const TicketCatalogLoadFailure({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
