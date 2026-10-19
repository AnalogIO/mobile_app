import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Read-only details for a receipt selected from the receipts list.
///
/// Receipts do not have a backend identifier, so the screen is always opened
/// with the already-loaded [Receipt] as route `extra`.
class ReceiptDetailsScreen extends StatelessWidget {
  const new({required this.receipt, super.key});

  final Receipt receipt;

  @override
  Widget build(BuildContext context) {
    final details = switch (receipt) {
      PurchaseReceipt(
        :final numberOfTickets,
        :final priceDKK,
        :final status,
        :final orderId,
      ) =>
        [
          _Detail('Tickets', '$numberOfTickets'),
          _Detail('Price', '$priceDKK DKK'),
          _Detail('Status', status.label),
          _Detail('Order ID', orderId),
        ],
      VoucherReceipt(:final numberOfTickets) => [
        _Detail('Tickets', '$numberOfTickets'),
      ],
      UsedTicketReceipt(:final drinkName) => [_Detail('Drink', drinkName)],
    };

    final date = switch (receipt) {
      PurchaseReceipt(:final orderDate) => orderDate,
      VoucherReceipt(:final redeemDate) => redeemDate,
      UsedTicketReceipt(:final swipeDate) => swipeDate,
    };

    return Screen.listView(
      name: 'Receipt',
      children: [
        ListTile(
          title: Text(
            receipt.ticketName,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: .bold),
          ),
          subtitle: Text(DateFormat('dd.MM.yyyy HH:mm').format(date)),
        ),
        const Divider(),
        for (final detail in details)
          ListTile(title: Text(detail.label), trailing: Text(detail.value)),
      ],
    );
  }
}

class _Detail {
  const new(this.label, this.value);

  final String label;
  final String value;
}
