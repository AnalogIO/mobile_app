import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;

/// Convert a raw JSON map (as received from the API) into a domain [Receipt].
/// This bypasses generated polymorphic decoding which currently loses
/// concrete fields when decoding into `ReceiptBase`.
Receipt receiptFromJson(Map<String, dynamic> json) {
  final type = json['Type'] as String?;

  switch (type) {
    case 'Purchase':
      final purchase = api.PurchaseReceipt.fromJson(json);
      return PurchaseReceipt(
        ticketName: purchase.productName,
        numberOfTickets: purchase.quantity,
        status: purchase.status.toString().split('.').last,
        orderDate: purchase.orderDate,
        priceDKK: purchase.price,
        orderId: purchase.orderId,
      );
    case 'Voucher':
      final voucher = api.VoucherReceipt.fromJson(json);
      return VoucherReceipt(
        ticketName: voucher.productName,
        redeemDate: voucher.redeemDate,
        numberOfTickets: voucher.quantity,
      );
    case 'UsedTicket':
      final usedTicket = api.UsedTicketReceipt.fromJson(json);
      return UsedTicketReceipt(
        ticketName: usedTicket.productName,
        drinkName: usedTicket.menuItemName,
        swipeDate: usedTicket.swipeDate,
      );
    default:
      throw UnsupportedError('Unknown receipt type: $type');
  }
}
