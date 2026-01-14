import 'package:cafe_analog_app/tickets/select_menu_item_ticket_card.dart';
import 'package:flutter/material.dart';

class UseTicketModal extends StatelessWidget {
  const UseTicketModal({
    required this.name,
    required this.clipsLeft,
    required this.backgroundImage,
    super.key,
  });

  final String name;
  final int clipsLeft;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                // Absorb taps on the card so they don't close the modal
                child: GestureDetector(
                  excludeFromSemantics: true,
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: UseTicketCard(
                    ticketName: name,
                    backgroundImage: backgroundImage,
                    menuItems: const ['Espresso', 'Latte', 'Cappuccino'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
