import 'package:cafe_analog_app/tickets/ticket_card_base.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OwnedTicketCard extends StatelessWidget {
  const OwnedTicketCard({
    required this.icon,
    required this.id,
    required this.ticketName,
    required this.ticketsLeft,
    required this.backgroundImagePath,
    required this.onTap,
    super.key,
  });

  final int id;
  final String ticketName;
  final int ticketsLeft;
  final String backgroundImagePath;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TicketCardBase(
      id: id,
      title: ticketName,
      backgroundImagePath: backgroundImagePath,
      onTap: onTap,
      children: [
        const Gap(48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            Text(
              '$ticketsLeft ticket${ticketsLeft == 1 ? '' : 's'} left',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
