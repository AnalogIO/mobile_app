import 'package:cafe_analog_app/tickets/ticket_card_base.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OwnedTicketCard extends StatelessWidget {
  const OwnedTicketCard({
    required this.icon,
    required this.id,
    required this.name,
    required this.clipsLeft,
    required this.backgroundImage,
    required this.onTap,
    super.key,
  });

  final int id;
  final String name;
  final int clipsLeft;
  final String backgroundImage;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TicketCardBase(
      id: id,
      title: name,
      backgroundImagePath: backgroundImage,
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
              '$clipsLeft ticket${clipsLeft == 1 ? '' : 's'} left',
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
