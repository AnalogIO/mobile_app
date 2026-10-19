import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UseTicketSuccessScreen extends StatelessWidget {
  const UseTicketSuccessScreen({
    required this.drinkName,
    required this.ticketName,
    required this.usedAt,
    super.key,
  });

  final String drinkName;
  final String ticketName;
  final DateTime usedAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SwipedTicketReceipt(
            productName: ticketName,
            drinkName: drinkName,
            time: usedAt,
            isTestEnvironment: false,
          ),
        ),
        const Gap(24),
        Text(
          'Tap anywhere to dismiss',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
