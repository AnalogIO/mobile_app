import 'package:cafe_analog_app/features/tickets/data/tickets_repository.dart';
import 'package:cafe_analog_app/features/tickets/models/purchasable_ticket_group.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buy_tickets_state.dart';

class BuyTicketsCubit extends Cubit<BuyTicketsState> {
  BuyTicketsCubit({required TicketsRepository repository})
    : _repository = repository,
      super(BuyTicketsInitial());

  final TicketsRepository _repository;

  Future<void> loadProducts() async {
    if (state is BuyTicketsLoading || state is BuyTicketsLoaded) {
      return;
    }

    emit(BuyTicketsLoading());
    final nextState = await _repository
        .getPurchasableTickets()
        .match(
          (failure) => BuyTicketsFailure(reason: failure.reason),
          (products) => BuyTicketsLoaded(products: products),
        )
        .run();
    emit(nextState);
  }
}
