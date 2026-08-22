import 'package:cafe_analog_app/features/receipts/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptsListEntry extends StatelessWidget {
  const ReceiptsListEntry({
    required this.receipt,
    super.key,
  });

  final Receipt receipt;

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }

  (String title, IconData icon, Color? backgroundColor, Color? iconColor)
  _getTitleAndIcon(BuildContext context) {
    return switch (receipt) {
      UsedTicketReceipt(:final drinkName) => (
        'Swiped a $drinkName',
        Icons.coffee,
        Theme.of(context).colorScheme.surfaceContainerHighest,
        Theme.of(context).colorScheme.onSurface,
      ),
      PurchaseReceipt(:final numberOfTickets) => (
        'Purchased $numberOfTickets ${receipt.ticketName} tickets',
        Icons.credit_card,
        Theme.of(context).colorScheme.tertiaryContainer,
        Theme.of(context).colorScheme.onTertiaryContainer,
      ),
      VoucherReceipt(:final numberOfTickets) => (
        'Redeemed $numberOfTickets '
            '${receipt.ticketName}${numberOfTickets != 1 ? 's' : ''} '
            'with voucher',
        Icons.card_giftcard,
        Theme.of(context).colorScheme.secondaryContainer,
        Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    };
  }

  String? _getTrailingText(BuildContext context) {
    return switch (receipt) {
      PurchaseReceipt(priceDKK: final price) => '$price DKK',
      _ => null,
    };
  }

  DateTime _getDate() {
    return switch (receipt) {
      UsedTicketReceipt(:final swipeDate) => swipeDate,
      PurchaseReceipt(:final orderDate) => orderDate,
      VoucherReceipt(:final redeemDate) => redeemDate,
    };
  }

  @override
  Widget build(BuildContext context) {
    final (title, icon, backgroundColor, iconColor) = _getTitleAndIcon(context);
    final trailingText = _getTrailingText(context);
    final date = _getDate();

    final trailing = trailingText != null
        ? Text(
            trailingText,
            style: Theme.of(context).textTheme.bodySmall,
          )
        : null;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: backgroundColor,
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      subtitle: Text(
        _formatDate(date),
        style: const TextStyle(fontFamily: 'monospace'),
      ),
      trailing: trailing,
    );
  }
}
