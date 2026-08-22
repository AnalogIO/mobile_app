import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<void> redeemVoucher({
  required BuildContext context,
  required String voucherCode,
  required void Function(String) onFailure,
}) async {
  final dismissLoadingOverlay = showLoadingOverlay(context);

  final result = await context
      .read<TicketsRepository>()
      .redeemVoucher(voucherCode: voucherCode)
      // FIXME: Remove the following mock result
      .pure(
        const OwnedTicketGroup(
          productId: 0,
          ticketName: 'ticketName',
          ticketsLeft: 0,
          eligibleDrinks: [],
        ),
      )
      .delay(const Duration(seconds: 1))
      .run();

  if (context.mounted) {
    dismissLoadingOverlay(context);
  }

  result.match(
    (failure) => onFailure(failure.reason),
    (redeemedTicketGroup) => _showRedeemedVoucherDialog(
      context: context,
      redeemedTicketGroup: redeemedTicketGroup,
    ),
  );
}

void _showRedeemedVoucherDialog({
  required BuildContext context,
  required OwnedTicketGroup redeemedTicketGroup,
}) {
  final ticketName = redeemedTicketGroup.ticketName;
  final numberOfTickets = redeemedTicketGroup.ticketsLeft;

  final _ = context.read<OwnedTicketsCubit>().refreshOwnedTickets();
  final _ = showDialog<void>(
    context: context,
    builder: (context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          AlertDialog(
            title: const Text(
              'Voucher redeemed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'You redeemed ${numberOfTickets}x $ticketName '
              'ticket${numberOfTickets != 1 ? 's' : ''}.',
            ),
            actions: [
              TextButton(
                onPressed: () => context
                  ..pop()
                  ..go('/tickets'),
                child: const Text('Back to Tickets'),
              ),
            ],
          ),
          // 🎉
          _confettiWidget,
        ],
      );
    },
  );
}

ConfettiWidget get _confettiWidget => ConfettiWidget(
  confettiController: ConfettiController(duration: const Duration(seconds: 1))
    ..play(),
  blastDirectionality: BlastDirectionality.explosive,
  numberOfParticles: 30,
  colors: const [
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.purple,
  ],
  // Offset confetti to appear 100 device pixels above the center of screen
  child: const SizedBox(height: 200),
);
