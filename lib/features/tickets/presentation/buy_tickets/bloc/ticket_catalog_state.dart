part of 'ticket_catalog_cubit.dart';

sealed class TicketCatalogState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class TicketCatalogInitial extends TicketCatalogState {
  const new();
}

final class TicketCatalogLoading extends TicketCatalogState {
  const new();
}

final class TicketCatalogLoaded extends TicketCatalogState {
  const new({required this.ticketGroups});

  final List<PurchasableTicketGroup> ticketGroups;

  @override
  List<Object?> get props => [ticketGroups];
}

final class TicketCatalogRefreshing extends TicketCatalogLoaded {
  const new({required super.ticketGroups});
}

final class TicketCatalogFailure extends TicketCatalogState {
  const new({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
