import 'package:bloc/bloc.dart';
import 'package:cafe_analog_app/tickets/use_ticket/data/use_ticket_repository.dart';
import 'package:equatable/equatable.dart';

part 'use_ticket_state.dart';

class UseTicketCubit extends Cubit<UseTicketState> {
  UseTicketCubit({required UseTicketRepository repository})
    : _repository = repository,
      super(UseTicketInitial());

  final UseTicketRepository _repository;

  Future<void> useTicket({required int ticketId, required int drinkId}) async {
    emit(UseTicketLoading());

    return _repository
        .spend(ticketId: ticketId, drinkId: drinkId)
        .match(
          (failure) => UseTicketFailure(reason: failure.reason),
          (usedTicketInfo) => UseTicketSuccess(
            drinkName: usedTicketInfo.drinkName,
            ticketName: usedTicketInfo.ticketName,
            usedAt: usedTicketInfo.usedAt,
          ),
        )
        .map(emit)
        .run();
  }
}
