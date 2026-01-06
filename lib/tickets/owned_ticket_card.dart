import 'package:cafe_analog_app/tickets/ticket_card_base.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OwnedTicketCard extends StatelessWidget {
  const OwnedTicketCard({
    required this.name,
    required this.clipsLeft,
    required this.backgroundImage,
    required this.onTap,
    super.key,
  });

  final String name;
  final int clipsLeft;
  final String backgroundImage;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TicketCardBase(
      name: name,
      backgroundImage: backgroundImage,
      onTap: onTap,
      children: [
        const Gap(48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.local_cafe,
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
