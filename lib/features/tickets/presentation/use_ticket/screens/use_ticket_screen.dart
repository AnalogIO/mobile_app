import 'dart:async';

import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shown when the user is confirming the user of a ticket.
///
/// This screen is shown as a modal on top of the owned tickets screen when the
/// user taps on a ticket they own to use it.
class UseTicketScreen extends StatelessWidget {
  /// Private constructor. Use the static method [show] to show this screen.
  const UseTicketScreen._({
    required this.ticket,
    required this.onTicketUsedSuccessfully,
  });

  final OwnedTicketGroup ticket;
  final Future<void> Function() onTicketUsedSuccessfully;

  /// Shows the use ticket modal for the given ticket.
  static Future<void> show({
    required BuildContext context,
    required OwnedTicketGroup ticket,
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
        pageBuilder: (_, _, _) => RepositoryProvider<TicketsRepository>.value(
          // Important that we use the context from the parameter of the
          // `show` method here, and not the one from the `pageBuilder`, since
          // the latter is a new context that doesn't have access to the
          // TicketsRepository provided higher up in the widget tree.
          value: context.read(),
          child: UseTicketScreen._(
            ticket: ticket,
            onTicketUsedSuccessfully: onTicketUsedSuccessfully,
          ),
        ),
        // Transition related stuff below
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
      create: (_) => UseTicketCubit(repository: context.read()),
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
              UseTicketInitial() => UseTicketSelectDrinkScreen(ticket: ticket),
              UseTicketLoading() => const UseTicketLoadingScreen(),
              UseTicketFailure(:final reason) => UseTicketFailedScreen(
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
