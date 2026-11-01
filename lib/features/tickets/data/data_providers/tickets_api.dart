import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

class TicketsApi {
  const new({required this._executor});

  final NetworkRequestExecutor _executor;

  /// Fetches the list of owned tickets for the current user.
  TaskEither<Failure, List<GroupedTicketsResponse>> fetchOwnedTickets() {
    return _executor.run(
      (api) => api.tickets.ticketsGetGroupedOwnedTickets(),
      (response) => switch (response) {
        TicketsGetGroupedOwnedTicketsResponse200(:final body) => body,
        TicketsGetGroupedOwnedTicketsResponse401() => throwTonikHttp(401),
      },
    );
  }

  /// Fetches products available for the user.
  TaskEither<Failure, List<ProductResponse>> fetchPurchasableTickets() {
    return _executor.run(
      (api) => api.products.productsGetProducts(),
      (response) => switch (response) {
        ProductsGetProductsResponse200(:final body) => body,
        ProductsGetProductsResponse401() => throwTonikHttp(401),
      },
    );
  }

  /// Fetches all menu items available for the user.
  TaskEither<Failure, List<MenuItemResponse>> fetchMenuItems() {
    return _executor.run(
      (api) => api.menuItems.menuItemsGetAllMenuItems(),
      (response) => switch (response) {
        MenuItemsGetAllMenuItemsResponse200(:final body) => body,
        MenuItemsGetAllMenuItemsResponse401() => throwTonikHttp(401),
        MenuItemsGetAllMenuItemsResponse403() => throwTonikHttp(403),
      },
    );
  }

  /// Spend a ticket with the given [ticketId] on a drink with the given
  /// [drinkId].
  TaskEither<Failure, UsedTicketResponse> useTicket({
    required int ticketId,
    required int drinkId,
  }) {
    return _executor.run(
      (api) => api.tickets.ticketsUseTicket(
        body: UseTicketRequest(productId: ticketId, menuItemId: drinkId),
      ),
      (response) => switch (response) {
        TicketsUseTicketResponse200(:final body) => body,
        TicketsUseTicketResponse401() => throwTonikHttp(401),
        TicketsUseTicketResponse403(:final body) => throwTonikHttp(
          403,
          body.message,
        ),
        TicketsUseTicketResponse404(:final body) => throwTonikHttp(
          404,
          body.message,
        ),
      },
    );
  }

  /// Redeem a voucher code that will grant some tickets to the user.
  TaskEither<Failure, SimplePurchaseResponse> redeemVoucher({
    required String voucherCode,
  }) {
    return _executor.run(
      (api) => api.vouchers.vouchersRedeemVoucher(voucherCode: voucherCode),
      (response) => switch (response) {
        VouchersRedeemVoucherResponse200(:final body) => body,
        VouchersRedeemVoucherResponse400(:final body) => throwTonikHttp(
          400,
          body.message,
        ),
        VouchersRedeemVoucherResponse401() => throwTonikHttp(401),
        VouchersRedeemVoucherResponse404(:final body) => throwTonikHttp(
          404,
          body.message,
        ),
      },
    );
  }

  /// Initiate a purchase flow for a purchasable ticket group.
  TaskEither<Failure, InitiatePurchaseResponse> initiateMobilePayPurchase({
    required int ticketGroupId,
  }) {
    return _executor.run(
      (api) => api.purchases.purchasesInitiatePurchase(
        body: InitiatePurchaseRequest(
          productId: ticketGroupId,
          paymentType: PaymentType.mobilePay,
        ),
      ),
      (response) => switch (response) {
        PurchasesInitiatePurchaseResponse200(:final body) => body,
        PurchasesInitiatePurchaseResponse401() => throwTonikHttp(401),
        PurchasesInitiatePurchaseResponse403() => throwTonikHttp(403),
      },
    );
  }

  /// Verify the status of a purchase flow for a ticket group.
  TaskEither<Failure, SinglePurchaseResponse> verifyPurchase({
    required int orderId,
  }) {
    return _executor.run(
      (api) => api.purchases.purchasesGetPurchase(id: orderId),
      (response) => switch (response) {
        PurchasesGetPurchaseResponse200(:final body) => body,
        PurchasesGetPurchaseResponse401() => throwTonikHttp(401),
        PurchasesGetPurchaseResponse404(:final body) => throwTonikHttp(
          404,
          body.message,
        ),
      },
    );
  }
}
