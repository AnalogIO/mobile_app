import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/receipts/data/data_providers/data_providers.dart';
import 'package:cafe_analog_app/features/receipts/models/models.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;
import 'package:fpdart/fpdart.dart';

class ReceiptsRepository {
  const new({required this._receiptsApi});

  final ReceiptsApi _receiptsApi;

  /// Fetches one page of receipts for the authenticated user.
  ///
  /// Receipts include purchases, swiped tickets and redeemed vouchers. Pass
  /// [continuationToken] from a previous [ReceiptsBatch] to load older entries.
  ///
  /// Returns a [TaskEither<Failure, ReceiptsBatch>] with the receipts sorted
  /// newest first and the token for the next page.
  TaskEither<Failure, ReceiptsBatch> fetchReceipts({
    required GetReceiptsType type,
    String? continuationToken,
  }) {
    final receiptType = switch (type) {
      GetReceiptsType.ticketSwipes => api.ReceiptType.usedTicket,
      GetReceiptsType.purchases => api.ReceiptType.purchase,
      GetReceiptsType.vouchers => api.ReceiptType.voucher,
      GetReceiptsType.all => api.ReceiptType.all,
    };

    return _receiptsApi
        .fetchReceipts(
          receiptType: receiptType,
          continuationToken: continuationToken,
        )
        .map(
          (response) => ReceiptsBatch(
            receipts: response.receipts
                .map(_toDomainReceipt)
                .whereType<Receipt>()
                .toList(),
            continuationToken: response.continuationToken,
            hasMore: response.receipts.isNotEmpty,
          ),
        );
  }

  /// Maps a generated receipt union variant to the domain model.
  ///
  /// Non-completed purchases are excluded, matching the old receipts list.
  Receipt? _toDomainReceipt(
    api.ReceiptResponseReceiptsArrayOneOfModel receipt,
  ) {
    return switch (receipt) {
      api.ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(:final value)
          when value.purchaseReceiptModel.status ==
              api.PurchaseStatus.completed =>
        PurchaseReceipt(
          ticketName: value.receiptBase.productName,
          numberOfTickets: value.purchaseReceiptModel.quantity,
          status: purchaseStatusFrom(value.purchaseReceiptModel.status),
          orderDate: value.purchaseReceiptModel.orderDate,
          priceDKK: value.purchaseReceiptModel.price,
          orderId: value.purchaseReceiptModel.orderId,
        ),
      api.ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt() => null,
      api.ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(:final value) =>
        VoucherReceipt(
          ticketName: value.receiptBase.productName,
          redeemDate: value.voucherReceiptModel.redeemDate,
          numberOfTickets: value.voucherReceiptModel.quantity,
        ),
      api.ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(
        :final value,
      ) =>
        UsedTicketReceipt(
          ticketName: value.receiptBase.productName,
          drinkName: value.usedTicketReceiptModel.menuItemName,
          swipeDate: value.usedTicketReceiptModel.swipeDate,
        ),
    };
  }
}

PurchaseStatus purchaseStatusFrom(api.PurchaseStatus status) {
  return switch (status) {
    api.PurchaseStatus.completed => PurchaseStatus.completed,
    api.PurchaseStatus.cancelled => PurchaseStatus.cancelled,
    api.PurchaseStatus.pendingPayment => PurchaseStatus.pendingPayment,
    api.PurchaseStatus.refunded => PurchaseStatus.refunded,
    api.PurchaseStatus.expired => PurchaseStatus.expired,
  };
}
