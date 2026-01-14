import 'package:cafe_analog_app/tickets/use_ticket/use_ticket_card.dart';
import 'package:flutter/material.dart';

class UseTicketModal extends StatelessWidget {
  const UseTicketModal({
    required this.ticketName,
    required this.backgroundImagePath,
    super.key,
  });

  final String ticketName;
  final String backgroundImagePath;

  static void show({
    required BuildContext context,
    required String ticketName,
    required String backgroundImagePath,
  }) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(200),
        pageBuilder: (context, animation, secondaryAnimation) => UseTicketModal(
          ticketName: ticketName,
          backgroundImagePath: backgroundImagePath,
        ),
      ),
    );
  }

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
                    ticketName: ticketName,
                    backgroundImagePath: backgroundImagePath,
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
