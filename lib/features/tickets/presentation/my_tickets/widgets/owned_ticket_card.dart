import 'package:cafe_analog_app/features/tickets/models/owned_ticket_group.dart';
import 'package:cafe_analog_app/features/tickets/presentation/my_tickets/bloc/owned_tickets_cubit.dart';
import 'package:cafe_analog_app/features/tickets/presentation/my_tickets/widgets/ticket_card_base.dart';
import 'package:cafe_analog_app/features/tickets/presentation/use_ticket/screens/use_ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OwnedTicketCard extends StatelessWidget {
  const OwnedTicketCard({required this.ticket, super.key});

  final OwnedTicketGroup ticket;

  @override
  Widget build(BuildContext context) {
    final ticketsLeft = ticket.ticketsLeft;
    const icon = Icons.coffee;

    return TicketCardBase(
      id: ticket.productId,
      title: Text(ticket.ticketName),
      backgroundImagePath: ticket.backgroundImagePath,
      onTap: () => UseTicketScreen.show(
        context: context,
        ticket: ticket,
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
