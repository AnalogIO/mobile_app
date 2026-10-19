import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;

/// Convert a raw JSON map (as received from the API) into a domain [Receipt].
/// This bypasses generated polymorphic decoding which currently loses
/// concrete fields when decoding into `ReceiptBase`.
Receipt receiptFromJson(Map<String, dynamic> json) {
  switch (api.receiptTypeFromJson(json['Type'])) {
    case api.ReceiptType.purchase:
      final purchase = api.PurchaseReceipt.fromJson(json);
      final status = api.purchaseStatusFromJson(purchase.status);
      return PurchaseReceipt(
        ticketName: purchase.productName,
        numberOfTickets: purchase.quantity,
        // TODO(marfavi): The status should be a domain-level enum,
        // not the generated `api.PurchaseStatus` and not a String. Left as a
        // String while the receipts feature is in development.
        // See CONTRIBUTING.md for how API enums should be handled.
        status: status.value ?? status.name,
        orderDate: purchase.orderDate,
        priceDKK: purchase.price,
        orderId: purchase.orderId,
      );
    case api.ReceiptType.voucher:
      final voucher = api.VoucherReceipt.fromJson(json);
      return VoucherReceipt(
        ticketName: voucher.productName,
        redeemDate: voucher.redeemDate,
        numberOfTickets: voucher.quantity,
      );
    case api.ReceiptType.usedticket:
      final usedTicket = api.UsedTicketReceipt.fromJson(json);
      return UsedTicketReceipt(
        ticketName: usedTicket.productName,
        drinkName: usedTicket.menuItemName,
        swipeDate: usedTicket.swipeDate,
      );
    case api.ReceiptType.all:
    case api.ReceiptType.swaggerGeneratedUnknown:
      // The generated `receiptTypeFromJson` returns `swaggerGeneratedUnknown`
      // (rather than null) for unrecognized values. ReceiptsRepository catches
      // this exception and turns it into a failure state instead of crashing.
      // See CONTRIBUTING.md.
      throw FormatException('Unknown receipt type: ${json['Type']}');
  }
}
