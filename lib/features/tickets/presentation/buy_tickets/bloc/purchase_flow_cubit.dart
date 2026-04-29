import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'purchase_flow_state.dart';

class PurchaseFlowCubit extends Cubit<PurchaseFlowState> {
  PurchaseFlowCubit({required TicketsRepository repository})
    : _repository = repository,
      super(const PurchaseFlowIdle());

  final TicketsRepository _repository;

  /// Initiates purchase for the selected [ticketGroup].
  Future<void> initiatePurchase(PurchasableTicketGroup ticketGroup) async {
    emit(const PurchaseInitiating());
    return _repository
        .initiatePurchase(ticketGroupId: ticketGroup.id)
        .match(
          (failure) => emit(CouldNotInitiatePurchase(failure: failure)),
          (initiatedPayment) =>
              emit(PurchaseInitiated(initiatedPurchase: initiatedPayment)),
        )
        .run();
  }

  Future<void> verifyPendingPurchase() async {
    final state = this.state;
    if (state is! PurchaseInitiated) {
      emit(
        const CouldNotVerifyPurchase(
          failure: PurchaseUnexpectedFailure('No pending purchase to verify'),
        ),
      );
      emit(const PurchaseFlowIdle());
      return;
    }

    final pendingPurchase = state.initiatedPurchase;
    emit(PurchaseVerifying(initiatedPurchase: pendingPurchase));

    return _repository
        .verifyPurchase(orderId: pendingPurchase.orderId)
        .match(
          (failure) => emit(CouldNotVerifyPurchase(failure: failure)),
          (successfulPurchase) =>
              emit(PurchaseCompleted(successfulPurchase: successfulPurchase)),
        )
        // finish with resetting to idle state
        .map((_) => emit(const PurchaseFlowIdle()))
        .run();
  }
}
