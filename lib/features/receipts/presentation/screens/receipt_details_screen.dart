import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

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
        :final ticketName,
        :final numberOfTickets,
        :final priceDKK,
        :final orderId,
        :final orderDate,
      ) =>
        [
          _Detail('Product', ticketName),
          _Detail('Quantity', '$numberOfTickets'),
          _Detail('Order Date',
                  DateFormat('dd.MM.yyyy HH:mm').format(orderDate),
                  ),
          _Detail('Total in DKK (incl. 25% VAT)', '$priceDKK DKK'),
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
            'Order Details',
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: .bold))
        ),
        for (final detail in details) ...[
          ListTile(
            title: Text(
              detail.label,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: .bold),
            ),
            subtitle: Text(detail.value),
          ),
          const Divider(),
        ],
        ListTile(
          title: Text(
            'Seller',
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: .bold)),
                subtitle: const Text('Cafe Analog\n' + 
                               'Rued Langgaards Vej 7\n' +
                               '2300 Copenhagen S\n' +
                               'CVR: 34657343\n\n' + 
                               'support@analog.dk\n' +
                               'www.cafeanalog.dk'), 
            ),
      ]
    );
  }
}

class _Detail {
  const new(this.label, this.value);

  final String label;
  final String value;
}
