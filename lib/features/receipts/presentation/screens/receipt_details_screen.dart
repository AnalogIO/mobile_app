import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:gap/gap.dart';
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
          _Detail('Total in DKK (incl. 25% VAT)', 'DKK $priceDKK,-'),
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
      name: 'Purchase receipt',
      children: [
        ListTile(
          title: Text(
            'Order details',
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: .bold))
        ),
        for (final detail in details) ...[
          ListTile(
            visualDensity: .compact,
            title: Text(
              detail.label,
            ),
            subtitle: Text(detail.value),
          ),
          const Divider(),
        ],
        const Gap(16),
        const SectionTitle('Seller'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: ListTile( 
                subtitle: Text(
                'Cafe Analog\n'
                'Rued Langgaards Vej 7\n'
                '2300 Copenhagen S\n'
                'CVR: 34657343\n\n'
                'support@analog.dk\n'
                'www.cafeanalog.dk',
              ),)
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 10),
              child: Image.asset('assets/images/logo-dark.png', width: 67),// 67 lets goo
            ),
          ],
        )
      ]
    );
  }
}

class _Detail {
  const new(this.label, this.value);

  final String label;
  final String value;
}
