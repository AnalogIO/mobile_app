import 'package:bloc/bloc.dart';
import 'package:cafe_analog_app/features/tickets/data/tickets_repository.dart';
import 'package:equatable/equatable.dart';

part 'use_ticket_state.dart';

class UseTicketCubit extends Cubit<UseTicketState> {
  UseTicketCubit({required TicketsRepository repository})
    : _repository = repository,
      super(UseTicketInitial());

  final TicketsRepository _repository;

  Future<void> useTicket({required int ticketId, required int drinkId}) async {
    emit(UseTicketLoading());

    return _repository
        .spendTicket(ticketId: ticketId, drinkId: drinkId)
        .match(
          (failure) => UseTicketFailure(reason: failure.reason),
          (spentTicketInfo) => UseTicketSuccess(
            drinkName: spentTicketInfo.drinkName,
            ticketName: spentTicketInfo.ticketName,
            usedAt: spentTicketInfo.usedAt,
          ),
        )
        .map(emit)
        .run();
  }
}
