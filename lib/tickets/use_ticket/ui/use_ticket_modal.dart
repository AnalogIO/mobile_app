import 'package:cafe_analog_app/core/widgets/delayed_fade_in.dart';
import 'package:cafe_analog_app/tickets/use_ticket/ui/use_ticket_card.dart';
import 'package:flutter/material.dart';

class UseTicketModal extends StatelessWidget {
  const UseTicketModal({
    required this.ticketId,
    required this.ticketName,
    required this.backgroundImagePath,
    super.key,
  });

  final int ticketId;
  final String ticketName;
  final String backgroundImagePath;

  static Future<void> show({
    required BuildContext context,
    required int ticketId,
    required String ticketName,
    required String backgroundImagePath,
  }) async {
    await Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder<void>(
        barrierDismissible: true,
        barrierLabel: 'Dismiss use ticket dialog',
        opaque: false,
        barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(225),
        pageBuilder: (context, animation, secondaryAnimation) => UseTicketModal(
          ticketId: ticketId,
          ticketName: ticketName,
          backgroundImagePath: backgroundImagePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DelayedFadeIn(
            child: Text(
              'Confirm use of ticket\nTap outside this card to cancel',
              semanticsLabel:
                  'Confirm use of ticket. '
                  'Tap outside this card to cancel.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            // Absorb taps on the card so they don't close the modal
            child: UseTicketCard(
              ticketId: ticketId,
              ticketName: ticketName,
              backgroundImagePath: backgroundImagePath,
              // TODO(marfavi): get menu items from backend
              menuItems: const ['Espresso', 'Latte', 'Cappuccino'],
            ),
          ),
        ],
      ),
    );
  }
}
