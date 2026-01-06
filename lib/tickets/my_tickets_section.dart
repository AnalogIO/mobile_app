import 'package:cafe_analog_app/tickets/ticket_card.dart';
import 'package:cafe_analog_app/tickets/use_ticket_modal.dart';
import 'package:flutter/material.dart';

class MyTicketsSection extends StatelessWidget {
  const MyTicketsSection({super.key});

  void _showTicketModal(BuildContext context, String name, int clipsLeft) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(200),
        pageBuilder: (context, animation, secondaryAnimation) => UseTicketModal(
          name: name,
          clipsLeft: clipsLeft,
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
          TicketCard(
            name: 'Fancy',
            clipsLeft: 4,
            backgroundImage: 'assets/images/ticket_fancy.png',
            onTap: () => _showTicketModal(context, 'Fancy', 4),
          ),
          TicketCard(
            name: 'Filter',
            clipsLeft: 1,
            backgroundImage: 'assets/images/ticket_filter.png',
            onTap: () => _showTicketModal(context, 'Filter', 1),
          ),
        ],
      ),
    );
  }
}
