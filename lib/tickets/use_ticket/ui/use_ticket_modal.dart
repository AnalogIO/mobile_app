import 'package:cafe_analog_app/core/widgets/delayed_fade_in.dart';
import 'package:cafe_analog_app/tickets/catalog/drink.dart';
import 'package:cafe_analog_app/tickets/use_ticket/ui/use_ticket_card.dart';
import 'package:flutter/material.dart';

class UseTicketModal extends StatefulWidget {
  const UseTicketModal({
    required this.ticketId,
    required this.ticketName,
    required this.backgroundImagePath,
    required this.eligibleDrinks,
    super.key,
  });

  final int ticketId;
  final String ticketName;
  final String backgroundImagePath;
  final List<Drink> eligibleDrinks;

  static Future<void> show({
    required BuildContext context,
    required int ticketId,
    required String ticketName,
    required String backgroundImagePath,
    required List<Drink> eligibleDrinks,
  }) async {
    final didUseTicket =
        await Navigator.of(context, rootNavigator: true).push(
          PageRouteBuilder<bool>(
            barrierDismissible: true,
            barrierLabel: 'Dismiss use ticket dialog',
            opaque: false,
            barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(225),
            pageBuilder: (_, _, _) => UseTicketModal(
              ticketId: ticketId,
              ticketName: ticketName,
              backgroundImagePath: backgroundImagePath,
              eligibleDrinks: eligibleDrinks,
            ),
          ),
        ) ??
        false;

    if (didUseTicket && context.mounted) {
      final colorScheme = Theme.of(context).colorScheme;
      await showDialog<void>(
        barrierColor: colorScheme.scrim.withAlpha(225),
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Ticket used!'),
            content: const Text(
              'Your ticket has been successfully used.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  State<UseTicketModal> createState() => _UseTicketModalState();
}

class _UseTicketModalState extends State<UseTicketModal> {
  bool _disableHero = false;

  void _onTicketUsed() {
    setState(() => _disableHero = true);
    Navigator.of(context, rootNavigator: true).pop(true);
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
            child: HeroMode(
              enabled: !_disableHero,
              child: UseTicketCard(
                // Absorb taps on the card so they don't close the modal
                ticketId: widget.ticketId,
                ticketName: widget.ticketName,
                backgroundImagePath: widget.backgroundImagePath,
                menuItems: widget.eligibleDrinks
                    .map((item) => item.name)
                    .toList(),
                onTicketUsed: _onTicketUsed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
