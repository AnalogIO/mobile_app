import 'dart:async';

import 'package:cafe_analog_app/core/dialog.dart';
import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// Coordinates the purchase flow by listening to [PurchaseFlowCubit] state
/// changes and performing the necessary UI actions, such as showing loading
/// indicators, navigating, and showing dialogs or snackbars.
class PurchaseFlowCoordinator extends StatefulWidget {
  const PurchaseFlowCoordinator({required this.child, super.key});

  final Widget child;

  @override
  State<PurchaseFlowCoordinator> createState() =>
      _PurchaseFlowCoordinatorState();
}

class _PurchaseFlowCoordinatorState extends State<PurchaseFlowCoordinator> {
  void Function(BuildContext context)? _dismissLoadingOverlay;

  void _showOverlay() {
    setState(() => _dismissLoadingOverlay ??= showLoadingOverlay(context));
  }

  void _hideOverlay() {
    _dismissLoadingOverlay?.call(context);
    setState(() => _dismissLoadingOverlay = null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchaseFlowCubit, PurchaseFlowState>(
      listener: (context, state) async {
        switch (state) {
          case PurchaseFlowIdle():
            // This state is also emitted after a completed or failed purchase,
            // so we navigate back and refresh the owned tickets.
            context.go('/tickets/');
            final _ = context.read<OwnedTicketsCubit>().refreshOwnedTickets();
          case PurchaseInitiating():
            _showOverlay();
          case PurchaseInitiated(:final initiatedPurchase):
            unawaited(
              _launchMobilePay(initiatedPurchase.mobilePayRedirectUri)
                  .mapLeft(
                    (failure) => _showDialog(
                      title: 'Could not launch MobilePay',
                      content: failure.reason,
                    ),
                  )
                  .run(),
            );
          case PurchaseVerifying():
            // probably don't need to do anything here, but could show a
            // different loading indicator if desired
            break;
          case PurchaseCompleted(:final successfulPurchase):
            _hideOverlay();
            showSuccessSnackBar(
              context: context,
              message:
                  'Bought ${successfulPurchase.amountOfTickets} '
                  '${successfulPurchase.ticketName} tickets',
            );
          case PurchaseFailed(:final failure):
            _hideOverlay();
            if (failure is PurchaseCancelledByUser) {
              // user intentionally cancelled the purchase, so nothing went
              // wrong; just show a snackbar
              return showSnackBar(context: context, message: failure.reason);
            }
            // for other failure types, show a dialog with the failure reason
            final _ = _showDialog(
              title: 'Purchase failed',
              content: failure.reason,
            );
        }
      },
      child: widget.child,
    );
  }

  Future<void> _showDialog({required String title, required String content}) {
    return showAnalogDialog(context: context, title: title, content: content);
  }

  TaskEither<Failure, Unit> _launchMobilePay(Uri mobilePayRedirectUri) {
    // launchUrl can either return false or throw an exception if it fails.
    return TaskEither.tryCatch(
      () async {
        final didLaunch = await launchUrl(
          mobilePayRedirectUri,
          mode: LaunchMode.externalApplication,
        );
        if (!didLaunch) {
          throw Exception('Failed to launch MobilePay');
        }
        return unit;
      },
      (error, _) => UnexpectedFailure(error.toString()),
    );
  }
}
