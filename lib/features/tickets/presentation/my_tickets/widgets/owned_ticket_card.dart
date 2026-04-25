import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OwnedTicketCard extends StatelessWidget {
  const OwnedTicketCard({required this.ownedGroup, super.key});

  final OwnedTicketGroup ownedGroup;

  String get backgroundImagePath {
    return ownedGroup.ticketName.toLowerCase().contains('filter')
        ? 'assets/images/beans_cropped.png'
        : 'assets/images/latteart_cropped.png';
  }

  @override
  Widget build(BuildContext context) {
    final ticketsLeft = ownedGroup.ticketsLeft;
    const icon = Icons.coffee;

    return TicketCardBase(
      id: ownedGroup.productId,
      title: Text(ownedGroup.ticketName),
      backgroundImagePath: backgroundImagePath,
      onTap: () => UseTicketScreen.show(
        context: context,
        ticket: ownedGroup,
        onTicketUsedSuccessfully: () =>
            context.read<OwnedTicketsCubit>().refreshOwnedTickets(),
      ),
      children: [
        const Gap(48),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.onSecondary),
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
