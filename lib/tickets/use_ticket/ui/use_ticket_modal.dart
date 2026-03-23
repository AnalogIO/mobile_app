import 'dart:async';

import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/widgets/delayed_fade_in.dart';
import 'package:cafe_analog_app/tickets/catalog/drink.dart';
import 'package:cafe_analog_app/tickets/use_ticket/bloc/use_ticket_cubit.dart';
import 'package:cafe_analog_app/tickets/use_ticket/data/use_ticket_remote_data_provider.dart';
import 'package:cafe_analog_app/tickets/use_ticket/data/use_ticket_repository.dart';
import 'package:cafe_analog_app/tickets/use_ticket/ui/use_ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final outcome = await Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder<_UseTicketModalOutcome>(
        barrierDismissible: true,
        barrierLabel: 'Dismiss use ticket dialog',
        opaque: false,
        barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(225),
        pageBuilder: (_, _, _) => BlocProvider(
          create: (context) => UseTicketCubit(
            repository: UseTicketRepository(
              remoteDataProvider: UseTicketRemoteDataProvider(
                executor: context.read(),
              ),
            ),
          ),
          child: UseTicketCubitListener(
            child: UseTicketModal(
              ticketId: ticketId,
              ticketName: ticketName,
              backgroundImagePath: backgroundImagePath,
              eligibleDrinks: eligibleDrinks,
            ),
          ),
        ),
      ),
    );

    if (!context.mounted || outcome == null) {
      return;
    }

    final colorScheme = Theme.of(context).colorScheme;
    switch (outcome) {
      case _UseTicketModalSuccess():
        await showDialog<void>(
          barrierColor: colorScheme.scrim.withAlpha(225),
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: const Text('Ticket used!'),
              content: const Text('Your ticket has been successfully used.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      case _UseTicketModalFailure(:final reason):
        await showDialog<void>(
          barrierColor: colorScheme.scrim.withAlpha(225),
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: const Text('Could not use ticket'),
              content: Text(reason),
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
  /// Whether to enable the hero animation for the ticket card.
  /// We disable it when the ticket is used to avoid jank from the hero
  /// animation playing at the same time as the loading overlay and success
  /// dialog animations.
  bool _enableHeroAnimation = true;
  void _onTicketUsed(Drink drink) {
    setState(() => _enableHeroAnimation = false);
    unawaited(
      context.read<UseTicketCubit>().useTicket(
        ticketId: widget.ticketId,
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
            child: HeroMode(
              enabled: _enableHeroAnimation,
              child: UseTicketCard(
                // Absorb taps on the card so they don't close the modal
                ticketId: widget.ticketId,
                ticketName: widget.ticketName,
                backgroundImagePath: widget.backgroundImagePath,
                eligibleDrinks: widget.eligibleDrinks,
                onTicketUsed: _onTicketUsed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

sealed class _UseTicketModalOutcome {}

final class _UseTicketModalSuccess extends _UseTicketModalOutcome {}

final class _UseTicketModalFailure extends _UseTicketModalOutcome {
  _UseTicketModalFailure({required this.reason});

  final String reason;
}

class UseTicketCubitListener extends StatefulWidget {
  const UseTicketCubitListener({required this.child, super.key});

  final Widget child;

  @override
  State<UseTicketCubitListener> createState() => _UseTicketCubitListenerState();
}

class _UseTicketCubitListenerState extends State<UseTicketCubitListener> {
  var _overlayVisible = false;

  void _showOverlay() {
    if (!_overlayVisible) {
      _overlayVisible = true;
      showLoadingOverlay(context);
    }
  }

  void _hideOverlay() {
    if (_overlayVisible &&
        Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
      _overlayVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UseTicketCubit, UseTicketState>(
      listener: (context, state) {
        if (state is UseTicketLoading) {
          _showOverlay();
          return;
        }

        _hideOverlay();

        switch (state) {
          case UseTicketSuccess():
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop(_UseTicketModalSuccess());
          case UseTicketFailure(:final reason):
            Navigator.of(context, rootNavigator: true).pop(
              _UseTicketModalFailure(reason: reason),
            );
          case UseTicketInitial() || UseTicketLoading():
            return;
        }
      },
      child: widget.child,
    );
  }
}
