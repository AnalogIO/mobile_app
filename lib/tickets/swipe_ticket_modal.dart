import 'package:cafe_analog_app/tickets/swipe_ticket_card.dart';
import 'package:flutter/material.dart';

class SwipeTicketModal extends StatelessWidget {
  const SwipeTicketModal({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: SwipeTicketCard(
                  menuItemName: 'Latte',
                  ticketName: 'Fancy',
                  backgroundImage: 'assets/images/latteart.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
