import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/delayed_fade_in.dart';
import 'package:flutter/material.dart';

/// Shows a loading overlay dialog.
///
/// The dialog should be dismissed by calling the returned callback.
///
/// Example:
/// ```dart
/// final dismissLoadingOverlay = showLoadingOverlay(context);
/// // Do some work while the loading overlay is shown...
/// if (context.mounted) {
///   dismissLoadingOverlay(context);
/// }
/// ```
void Function(BuildContext context) showLoadingOverlay(BuildContext context) {
  final _ = showDialog<void>(
    context: context,
    barrierColor: Theme.of(context).colorScheme.surface.withAlpha(225),
    barrierDismissible: false,
    builder: (_) => const Center(
      child: DelayedFadeIn(
        child: AnalogCircularProgressIndicator(spinnerColor: .dark),
      ),
    ),
  );

  void dismissCallback(BuildContext context) {
    // We need to use the root navigator here, otherwise our router's
    // redirect handlers will show a 'Please login to continue' snackbar after
    // logging out, and a 'You are already logged in' snackbar after logging in.
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  return dismissCallback;
}
