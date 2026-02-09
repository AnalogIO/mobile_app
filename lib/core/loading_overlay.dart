import 'dart:async';

import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/delayed_fade_in.dart';
import 'package:flutter/material.dart';

/// Shows a loading overlay dialog.
///
/// The dialog can be dismissed by popping the navigator, e.g. `context.pop()`.
void showLoadingOverlay(BuildContext context) {
  unawaited(
    showDialog<void>(
      context: context,
      barrierColor: Theme.of(context).colorScheme.surface.withAlpha(225),
      barrierDismissible: false,
      builder: (_) => const Center(
        child: DelayedFadeIn(
          child: AnalogCircularProgressIndicator(spinnerColor: .dark),
        ),
      ),
    ),
  );
}
