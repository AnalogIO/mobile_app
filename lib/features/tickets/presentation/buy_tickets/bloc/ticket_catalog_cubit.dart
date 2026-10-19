import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_catalog_state.dart';

class TicketCatalogCubit extends Cubit<TicketCatalogState> {
  TicketCatalogCubit({required this._repository})
    : super(const TicketCatalogInitial());

  final TicketsRepository _repository;

  /// Loads the purchasable ticket groups.
  ///
  /// Behaves as both an initial load and a refresh: if products are already
  /// loaded, they are kept on screen while fresh data is fetched.
  Future<void> loadProducts() async {
    final currentState = state;
    if (currentState is TicketCatalogLoading ||
        currentState is TicketCatalogRefreshing) {
      return;
    }

    if (currentState is TicketCatalogLoaded) {
      emit(TicketCatalogRefreshing(ticketGroups: currentState.ticketGroups));
    } else {
      emit(const TicketCatalogLoading());
    }

    return _repository
        .getPurchasableTickets()
        .match(
          (failure) => TicketCatalogFailure(reason: failure.reason),
          (ticketGroups) => TicketCatalogLoaded(ticketGroups: ticketGroups),
        )
        .map(emit)
        .run();
  }
}
