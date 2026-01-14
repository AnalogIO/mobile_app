import 'package:cafe_analog_app/tickets/owned_ticket_card.dart';
import 'package:cafe_analog_app/tickets/use_ticket/use_ticket_modal.dart';
import 'package:flutter/material.dart';

// TODO(monir): add placeholder when user doesn't have any tickets.
class MyTicketsSection extends StatelessWidget {
  const MyTicketsSection({super.key});

  // TODO(marfavi): hent data fra backend
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          OwnedTicketCard(
            id: 0,
            ticketName: 'Fancy',
            icon: Icons.local_cafe,
            ticketsLeft: 4,
            backgroundImagePath: 'assets/images/latteart.png',
            onTap: () => UseTicketModal.show(
              context: context,
              ticketName: 'Fancy',
              backgroundImagePath: 'assets/images/latteart.png',
            ),
          ),
          OwnedTicketCard(
            id: 1,
            ticketName: 'Filter',
            icon: Icons.coffee_maker,
            ticketsLeft: 1,
            backgroundImagePath: 'assets/images/beans.png',
            onTap: () => UseTicketModal.show(
              context: context,
              ticketName: 'Filter',
              backgroundImagePath: 'assets/images/beans.png',
            ),
          ),
        ],
      ),
    );
  }
}
