import 'dart:async';

import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/delayed_fade_in.dart';
import 'package:cafe_analog_app/receipts/swipe_receipt.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/drink.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/use_ticket/bloc/use_ticket_cubit.dart';
import 'package:cafe_analog_app/tickets/use_ticket/data/use_ticket_remote_data_provider.dart';
import 'package:cafe_analog_app/tickets/use_ticket/data/use_ticket_repository.dart';
import 'package:cafe_analog_app/tickets/use_ticket/ui/use_ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// The modal that is shown when a user taps on a ticket they own to use it.
///
/// This modal is shown by calling the static method [UseTicketModal.show],
/// which pushes a new route with a fade transition.
class UseTicketModal extends StatelessWidget {
  const UseTicketModal._({
    required this.ticket,
    required this.onTicketUsedSuccessfully,
  });

  final OwnedTicket ticket;
  final Future<void> Function() onTicketUsedSuccessfully;

  /// Shows the use ticket modal for the given ticket.
  static Future<void> show({
    required BuildContext context,
    required OwnedTicket ticket,
    required Future<void> Function() onTicketUsedSuccessfully,
  }) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder<void>(
        // Whether the route is actually dismissable is determined by the
        // PopScope in the route's content (see build method).
        barrierDismissible: true,
        barrierLabel: 'Dismiss use ticket dialog',
        opaque: false,
        barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(225),
        pageBuilder: (_, _, _) => UseTicketModal._(
          ticket: ticket,
          onTicketUsedSuccessfully: onTicketUsedSuccessfully,
        ),
        // Transition related
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
              reverseCurve: Curves.fastEaseInToSlowEaseOut,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UseTicketCubit(
        repository: UseTicketRepository(
          remoteDataProvider: UseTicketRemoteDataProvider(
            executor: context.read(),
          ),
        ),
      ),
      child: BlocConsumer<UseTicketCubit, UseTicketState>(
        listener: (context, state) {
          // Reload the owned tickets after a ticket has been used, to reflect
          // the updated number of tickets left (or the ticket being depleted)
          if (state is UseTicketSuccess) {
            unawaited(onTicketUsedSuccessfully());
          }
        },
        builder: (context, state) {
          // PopScope prevents dismissing the modal while a ticket is being used
          return PopScope(
            canPop: state is! UseTicketLoading,
            child: switch (state) {
              UseTicketInitial() => UseTicketScreen(ticket: ticket),
              UseTicketLoading() => const UseTicketLoadingScreen(),
              UseTicketFailure(:final reason) => UseTicketFailureScreen(
                reason: reason,
              ),
              final UseTicketSuccess success => UseTicketSuccessScreen(
                drinkName: success.drinkName,
                ticketName: success.ticketName,
                usedAt: success.usedAt,
              ),
            },
          );
        },
      ),
    );
  }
}

class UseTicketLoadingScreen extends StatelessWidget {
  const UseTicketLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const AnalogCircularProgressIndicator(spinnerColor: .light),
          const Gap(24),
          DelayedFadeIn(
            delay: const Duration(milliseconds: 500),
            child: Text(
              'Using ticket... Please wait.',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UseTicketFailureScreen extends StatelessWidget {
  const UseTicketFailureScreen({required this.reason, super.key});

  final String reason;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('An error occurred'),
      content: Text(reason),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

// FIXME(marfavi): Implement proper receipt screen with used ticket info
//  instead of this placeholder success screen that just shows a success message
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
          child: SwipeReceipt(
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

class UseTicketScreen extends StatelessWidget {
  UseTicketScreen({required OwnedTicket ticket, super.key})
    : ticketId = ticket.productId,
      ticketName = ticket.ticketName,
      backgroundImagePath = ticket.backgroundImagePath,
      eligibleDrinks = ticket.eligibleDrinks;

  final int ticketId;
  final String ticketName;
  final String backgroundImagePath;
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
              backgroundImagePath: backgroundImagePath,
              eligibleDrinks: eligibleDrinks,
              onTicketUsed: (drink) => onTicketUsed(context, drink),
            ),
          ),
        ],
      ),
    );
  }
}
