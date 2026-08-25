part of 'ticket_catalog_cubit.dart';

sealed class TicketCatalogState extends Equatable {
  const TicketCatalogState();

  @override
  List<Object?> get props => [];
}

final class TicketCatalogInitial extends TicketCatalogState {
  const TicketCatalogInitial();
}

final class TicketCatalogLoading extends TicketCatalogState {
  const TicketCatalogLoading();
}

final class TicketCatalogLoaded extends TicketCatalogState {
  const TicketCatalogLoaded({required this.ticketGroups});

  final List<PurchasableTicketGroup> ticketGroups;

  @override
  List<Object?> get props => [ticketGroups];
}

final class TicketCatalogRefreshing extends TicketCatalogLoaded {
  const TicketCatalogRefreshing({required super.ticketGroups});
}

final class TicketCatalogFailure extends TicketCatalogState {
  const TicketCatalogFailure({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
