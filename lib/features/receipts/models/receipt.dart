import 'package:equatable/equatable.dart';

/// Base class for all receipt types.
sealed class Receipt extends Equatable {
  const Receipt({required this.ticketName});

  final String ticketName;

  @override
  List<Object?> get props => [ticketName];
}

/// Receipt for a purchase of tickets.
final class PurchaseReceipt extends Receipt {
  const PurchaseReceipt({
    required super.ticketName,
    required this.numberOfTickets,
    required this.status,
    required this.priceDKK,
    required this.orderDate,
    required this.orderId,
  });

  /// The amount of tickets issued by the purchase.
  final int numberOfTickets;

  /// The status of the purchase.
  final String status;

  /// The total price of the purchase in kr.
  final int priceDKK;

  /// The date and time when the order was placed.
  final DateTime orderDate;

  /// The unique identifier of the order associated with the purchase.
  final String orderId;

  @override
  List<Object?> get props => [
    ticketName,
    numberOfTickets,
    status,
    orderDate,
    priceDKK,
    orderId,
  ];
}

/// Receipt for a voucher redemption.
final class VoucherReceipt extends Receipt {
  const VoucherReceipt({
    required super.ticketName,
    required this.redeemDate,
    required this.numberOfTickets,
  });

  /// The date and time when the voucher was redeemed.
  final DateTime redeemDate;

  /// The amount of tickets issued by the voucher.
  final int numberOfTickets;

  @override
  List<Object?> get props => [ticketName, redeemDate, numberOfTickets];
}

/// Receipt for a ticket that has been used/swiped.
final class UsedTicketReceipt extends Receipt {
  const UsedTicketReceipt({
    required super.ticketName,
    required this.drinkName,
    required this.swipeDate,
  });

  /// The name of the drink that the ticket was used for.
  final String drinkName;

  /// The date and time when the ticket was swiped.
  final DateTime swipeDate;

  @override
  List<Object?> get props => [ticketName, drinkName, swipeDate];
}
