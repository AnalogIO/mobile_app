part of 'use_ticket_card.dart';

/// Content shown when the user can swipe to use the ticket.
class _SwipeTicketContent extends StatelessWidget {
  const _SwipeTicketContent({
    required this.ticketName,
  });

  final String ticketName;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(4),
        Text(
          'Claiming via ticket: $ticketName',
          style: TextStyle(color: colorScheme.onSecondary),
        ),
        const Gap(24),
        SlideAction(
          text: 'Use ticket',
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          outerColor: colorScheme.onSurface,
          innerColor: colorScheme.surfaceContainer,
        ),
      ],
    );
  }
}
