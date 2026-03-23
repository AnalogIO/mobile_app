import 'package:cafe_analog_app/tickets/buy_tickets/product.dart';
import 'package:cafe_analog_app/tickets/catalog/data/ticket_catalog_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buy_tickets_state.dart';

class BuyTicketsCubit extends Cubit<BuyTicketsState> {
  BuyTicketsCubit({
    required TicketCatalogRepository ticketCatalogRepository,
  }) : _ticketCatalogRepository = ticketCatalogRepository,
       super(BuyTicketsInitial());

  final TicketCatalogRepository _ticketCatalogRepository;

  Future<void> loadProducts() async {
    final state = this.state;
    if (state is BuyTicketsLoading || state is BuyTicketsLoaded) {
      return;
    }

    emit(BuyTicketsLoading());
    final nextState = await _ticketCatalogRepository
        .fetchBuyableProducts()
        .match(
          (failure) => BuyTicketsFailure(reason: failure.reason),
          (products) => BuyTicketsLoaded(products: products),
        )
        .run();
    emit(nextState);
  }
}
