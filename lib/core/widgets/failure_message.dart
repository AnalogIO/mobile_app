import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// A standard widget for displaying failure states across the app.
///
/// Every feature that fetches data should render its `<Feature>Failure` state
/// with this widget so that failure states look and behave consistently.
///
/// Shows the given [message] and, when [onRetry] is provided, a retry button
/// that re-invokes the failed action. Screens with pull-to-refresh can recover
/// from failure states without a retry button, in which case [onRetry] can be
/// omitted.
///
/// See `CONTRIBUTING.md` for the conventions on failure states.
class FailureMessage extends StatelessWidget {
  const FailureMessage({required this.message, this.onRetry, super.key});

  final String message;

  /// Callback for retrying the failed action.
  /// When `null`, no retry button is shown.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const .all(32),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 40, color: colorScheme.error),
            const Gap(12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const Gap(16),
              FilledButton.tonal(
                onPressed: onRetry,
                child: const Text('Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
