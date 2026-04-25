import 'package:cafe_analog_app/features/tickets/tickets.dart';
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
    return _repository
        .getPurchasableTickets()
        .match(
          (failure) => BuyTicketsFailure(reason: failure.reason),
          (ticketGroups) => BuyTicketsLoaded(ticketGroups: ticketGroups),
        )
        .map(emit)
        .run();
  }

  /// Initiates purchase for the selected [ticketGroup].
  ///
  /// Returns null on success, otherwise a user-visible error reason.
  Future<String?> buyTicketGroup(PurchasableTicketGroup ticketGroup) async {
    throw UnimplementedError();
    final result = await _repository
        .buyTicketGroup(ticketGroupId: ticketGroup.id)
        .run();

    return result.match((failure) => failure.reason, (_) => null);
  }
}
