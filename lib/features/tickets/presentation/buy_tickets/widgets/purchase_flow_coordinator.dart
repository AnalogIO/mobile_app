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
            final _ = context.read<OwnedTicketsCubit>().loadOwnedTickets();
          case PurchaseInitiating():
            _showOverlay();
          case PurchaseInitiated(:final initiatedPurchase):
            switch (initiatedPurchase) {
              case InitiatedMobilePayPayment(:final mobilePayRedirectUri):
                unawaited(
                  _launchMobilePay(mobilePayRedirectUri)
                      .mapLeft(
                        (failure) => _showDialog(
                          title: 'Could not launch MobilePay',
                          content: failure.reason,
                        ),
                      )
                      .run(),
                );
              case InitiatedNexiPayment(:final paymentUrl):
                unawaited(
                  _openNexiPayment(paymentUrl).match(
                    (failure) {
                      _hideOverlay();
                      return _showDialog(
                        title: 'Could not open Nexi payment',
                        content: failure.reason,
                      );
                    },
                    // We aren't told if the user closes the payment page
                    // without paying, so don't block the app while it is
                    // open.
                    (_) => _hideOverlay(),
                  ).run(),
                );
            }
          case PurchaseVerifying(:final initiatedPurchase):
            if (initiatedPurchase is InitiatedNexiPayment) {
              unawaited(closeInAppWebView());
              // The overlay was hidden while the payment page was open
              _showOverlay();
            }
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

  /// Opens Nexi's hosted payment page in an in-app browser (Custom Tabs on
  /// Android, SFSafariViewController on iOS), where Apple Pay and Google Pay
  /// work, unlike in a WebView.
  TaskEither<Failure, Unit> _openNexiPayment(Uri paymentUrl) {
    return TaskEither.tryCatch(
      () async {
        final didLaunch = await launchUrl(
          paymentUrl,
          mode: LaunchMode.inAppBrowserView,
        );
        if (!didLaunch) {
          throw Exception('Failed to open the payment page');
        }
        return unit;
      },
      (error, _) => UnexpectedFailure(error.toString()),
    );
  }
}
