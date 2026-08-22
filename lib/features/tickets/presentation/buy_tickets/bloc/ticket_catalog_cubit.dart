import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_catalog_state.dart';

class TicketCatalogCubit extends Cubit<TicketCatalogState> {
  TicketCatalogCubit({required this._repository})
    : super(const TicketCatalogInitial());

  final TicketsRepository _repository;

  Future<void> loadProducts() async {
    if (state is LoadingTicketCatalog || state is TicketCatalogLoaded) {
      return;
    }
    emit(const LoadingTicketCatalog());
    return _repository
        .getPurchasableTickets()
        .match(
          (failure) => TicketCatalogLoadFailure(reason: failure.reason),
          (ticketGroups) => TicketCatalogLoaded(ticketGroups: ticketGroups),
        )
        .map(emit)
        .run();
  }
}
