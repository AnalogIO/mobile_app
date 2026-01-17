import 'package:cafe_analog_app/buy_tickets/products.dart';
import 'package:cafe_analog_app/tickets/my_tickets/no_tickets_left_card.dart';
import 'package:cafe_analog_app/tickets/my_tickets/owned_ticket_card.dart';
import 'package:cafe_analog_app/tickets/use_ticket/use_ticket_modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// TODO(monir): add placeholder when user doesn't have any tickets.
class MyTicketsSection extends StatelessWidget {
  const MyTicketsSection({super.key});

  // TODO(marfavi): hent data fra backend
  @override
  Widget build(BuildContext context) {
    final dummyEmptyProduct = products[1];

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
              ticketId: 0,
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
              ticketId: 1,
              ticketName: 'Filter',
              backgroundImagePath: 'assets/images/beans.png',
            ),
          ),
          // Sample NoTicketsLeftCard widget
          NoTicketsLeftCard(
            id: 2,
            ticketName: dummyEmptyProduct.title,
            backgroundImagePath: 'assets/images/latteart.png',
            onBuyMore: () {
              context.push(
                '/tickets/buy/ticket/${dummyEmptyProduct.title}',
                extra: dummyEmptyProduct,
              );
            },
            onDismiss: () {
              // TODO(marfavi): Remove this card from the list
            },
          ),
        ],
      ),
    );
  }
}
