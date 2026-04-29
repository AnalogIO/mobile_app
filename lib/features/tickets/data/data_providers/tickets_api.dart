import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

class TicketsApi {
  const TicketsApi({required NetworkRequestExecutor executor})
    : _executor = executor;

  final NetworkRequestExecutor _executor;

  /// Fetches the list of owned tickets for the current user.
  TaskEither<Failure, List<GroupedTicketsResponse>> fetchOwnedTickets() {
    return _executor.run((api) => api.v2.ticketsGroupedGet());
  }

  /// Fetches products available for the user.
  TaskEither<Failure, List<ProductResponse>> fetchPurchasableTickets() {
    return _executor.run((api) => api.v2.productsGet());
  }

  /// Fetches all menu items available for the user.
  TaskEither<Failure, List<MenuItemResponse>> fetchMenuItems() {
    return _executor.run((api) => api.v2.menuitemsGet());
  }

  /// Spend a ticket with the given [ticketId]
  /// on a drink with the given [drinkId].
  TaskEither<Failure, UsedTicketResponse> useTicket({
    required int ticketId,
    required int drinkId,
  }) {
    return _executor.run(
      (api) => api.v2.ticketsUsePost(
        body: UseTicketRequest(productId: ticketId, menuItemId: drinkId),
      ),
    );
  }

  /// Redeem a voucher code that will grant some tickets to the user.
  TaskEither<Failure, SimplePurchaseResponse> redeemVoucher({
    required String voucherCode,
  }) {
    return _executor.run(
      (api) => api.v2.vouchersVoucherCodeRedeemPost(voucherCode: voucherCode),
    );
  }

  /// Initiate a purchase flow for a purchasable ticket group.
  TaskEither<Failure, InitiatePurchaseResponse> initiateMobilePayPurchase({
    required int ticketGroupId,
  }) {
    return _executor.run(
      (api) => api.v2.purchasesPost(
        body: InitiatePurchaseRequest(
          productId: ticketGroupId,
          paymentType: PaymentType.mobilepay.value,
        ),
      ),
    );
  }

  /// Verify the status of a purchase flow for a ticket group.
  TaskEither<Failure, SinglePurchaseResponse> verifyPurchase({
    required int orderId,
  }) {
    return _executor.run(
      (api) => api.v2.purchasesIdGet(id: orderId),
    );
  }
}
