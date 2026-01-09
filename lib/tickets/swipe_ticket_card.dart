import 'package:cafe_analog_app/tickets/slide_action.dart';
import 'package:cafe_analog_app/tickets/ticket_card_base.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SwipeTicketCard extends StatelessWidget {
  const SwipeTicketCard({
    required this.menuItemName,
    required this.ticketName,
    required this.backgroundImage,
    super.key,
  });

  final String menuItemName;
  final String ticketName;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TicketCardBase(
      id: 0,
      title: menuItemName,
      backgroundImagePath: backgroundImage,
      children: [
        Text(
          'Claiming via ticket: $ticketName',
          style: TextStyle(color: colorScheme.onSecondary),
        ),
        const Gap(36),
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
