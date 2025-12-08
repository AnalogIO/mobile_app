import 'package:cafe_analog_app/buy_tickets/product.dart';
import 'package:flutter/material.dart';

class ReceiptsListEntry extends StatelessWidget {
  const ReceiptsListEntry({
    required this.product,
    required this.date,
    required this.isSwipe,
    super.key,
  });

  final Product product;
  final String date;
  final bool isSwipe;

  @override
  Widget build(BuildContext context) {
    final title = isSwipe
        ? 'Swiped a ${product.title}'
        : 'Purchased ${product.noTickets} ${product.title}';

    final trailing = isSwipe
        ? null
        : Text(
            '${product.priceDKK} DKK',
            style: Theme.of(context).textTheme.bodySmall,
          );

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isSwipe
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : Theme.of(context).colorScheme.tertiaryContainer,
        child: Icon(
          isSwipe ? Icons.coffee : Icons.credit_card,
          color: isSwipe
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onTertiaryContainer,
        ),
      ),
      title: Text(title),
      subtitle: Text(
        date,
        // TODO(marfavi): Use monospaced font
        style: const TextStyle(fontFamily: 'monospace'),
      ),
      trailing: trailing,
    );
  }
}
