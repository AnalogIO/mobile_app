import 'dart:async';

import 'package:flutter/material.dart';

/// Shows a loading overlay dialog.
///
/// The dialog can be dismissed by popping the navigator, e.g. `context.pop()`.
void showLoadingOverlay(BuildContext context) {
  unawaited(
    showDialog<void>(
      context: context,
      barrierColor: Theme.of(context).colorScheme.scrim.withAlpha(225),
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          strokeCap: .round,
          strokeWidth: 10,
          color: Colors.white,
        ),
      ),
    ),
  );
}
