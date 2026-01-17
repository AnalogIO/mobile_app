import 'package:cafe_analog_app/tickets/my_tickets/ticket_card_base.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A card shown when the user has run out of tickets of a specific type.
///
/// Displays a message prompting the user to buy more tickets or dismiss.
/// Uses [TicketCardBase] with muted colors for a less prominent appearance.
class NoTicketsLeftCard extends StatelessWidget {
  const NoTicketsLeftCard({
    required this.id,
    required this.ticketName,
    required this.backgroundImagePath,
    required this.onBuyMore,
    required this.onDismiss,
    super.key,
  });

  /// Unique identifier, used for Hero animation tag.
  final int id;

  /// The name of the ticket type that has run out.
  final String ticketName;

  /// Asset path for the background graphic.
  final String backgroundImagePath;

  /// Called when the user taps "Buy more".
  final VoidCallback onBuyMore;

  /// Called when the user taps "Dismiss".
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TicketCardBase(
      id: id,
      title: Text(
        "You've run out of $ticketName tickets",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      backgroundImagePath: backgroundImagePath,
      backgroundColor: colorScheme.surfaceContainerHighest,
      foregroundColor: colorScheme.onSurfaceVariant,
      backgroundGraphicOpacity: 0.3,
      children: [
        const Gap(36),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 8,
          children: [
            TextButton(
              onPressed: onDismiss,
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Dismiss',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ),
            FilledButton(
              onPressed: onBuyMore,
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                foregroundColor: colorScheme.onSecondary,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Buy more'),
            ),
          ],
        ),
      ],
    );
  }
}
