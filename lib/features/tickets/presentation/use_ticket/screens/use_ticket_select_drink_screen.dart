import 'dart:async';
import 'package:cafe_analog_app/core/widgets/delayed_fade_in.dart';
import 'package:cafe_analog_app/features/tickets/models/models.dart';
import 'package:cafe_analog_app/features/tickets/presentation/use_ticket/bloc/use_ticket_cubit.dart';
import 'package:cafe_analog_app/features/tickets/presentation/use_ticket/widgets/use_ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UseTicketSelectDrinkScreen extends StatelessWidget {
  UseTicketSelectDrinkScreen({required OwnedTicketGroup ticket, super.key})
    : ticketId = ticket.productId,
      ticketName = ticket.ticketName,
      eligibleDrinks = ticket.eligibleDrinks;

  final int ticketId;
  final String ticketName;
  final List<Drink> eligibleDrinks;

  void onTicketUsed(BuildContext context, Drink drink) {
    unawaited(
      context.read<UseTicketCubit>().useTicket(
        ticketId: ticketId,
        drinkId: drink.id,
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
            child: UseTicketCard(
              ticketId: ticketId,
              ticketName: ticketName,
              eligibleDrinks: eligibleDrinks,
              onTicketUsed: (drink) => onTicketUsed(context, drink),
            ),
          ),
        ],
      ),
    );
  }
}
