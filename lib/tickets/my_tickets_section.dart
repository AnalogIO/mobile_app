import 'package:cafe_analog_app/tickets/owned_ticket_card.dart';
import 'package:cafe_analog_app/tickets/use_ticket_modal.dart';
import 'package:flutter/material.dart';

// TODO(monir): add placeholder when user doesn't have any tickets.
class MyTicketsSection extends StatelessWidget {
  const MyTicketsSection({super.key});

  void _showTicketModal(
    BuildContext context,
    String name,
    int clipsLeft,
    String backgroundImage,
  ) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(200),
        pageBuilder: (context, animation, secondaryAnimation) => UseTicketModal(
          name: name,
          clipsLeft: clipsLeft,
          backgroundImage: backgroundImage,
        ),
      ),
    );
  }

  // TODO(marfavi): hent data fra backend
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          OwnedTicketCard(
            id: 'Fancy',
            name: 'Fancy',
            icon: Icons.local_cafe,
            clipsLeft: 4,
            backgroundImage: 'assets/images/latteart.png',
            onTap: () => _showTicketModal(
              context,
              'Fancy',
              4,
              'assets/images/latteart.png',
            ),
          ),
          OwnedTicketCard(
            id: 'f',
            name: 'Filter',
            icon: Icons.coffee_maker,
            clipsLeft: 1,
            backgroundImage: 'assets/images/beans.png',
            onTap: () => _showTicketModal(
              context,
              'Filter',
              1,
              'assets/images/beans.png',
            ),
          ),
          // const TicketCardBase(
          //   name: "Can't tap this TicketCardBase",
          //   backgroundImage: 'assets/images/ticket_filter.png',
          //   children: [
          //     // SlideAction(text: 'Swipe to use'),
          //   ],
          // ),
          // const SelectMenuItemTicketCard(
          //   name: 'Small',
          //   menuItems: ['Espresso', 'Latte', 'Cappuccino'],
          //   backgroundImage: 'assets/images/ticket_filter.png',
          // ),
          // const SwipeTicketCard(
          //   ticketName: 'Large',
          //   menuItemName: 'Chai latte',
          //   backgroundImage: 'backgroundImage',
          // ),
        ],
      ),
    );
  }
}
