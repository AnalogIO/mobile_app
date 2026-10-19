import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Show a simple snackbar with the given message.
void showSnackBar({required BuildContext context, required String message}) {
  return _showSnackBar(context: context, content: Text(message));
}

/// Show a snackbar with a success icon and the given message.
void showSuccessSnackBar({
  required BuildContext context,
  required String message,
}) {
  return _showSnackBar(
    context: context,
    content: Row(
      children: [
        Icon(
          Icons.check_circle_outlined,
          color: Theme.of(context).colorScheme.onInverseSurface,
        ),
        const Gap(12),
        Text(message),
      ],
    ),
  );
}

void _showSnackBar({required BuildContext context, required Widget content}) {
  // avoid having a queue of snackbars because it is ugly
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      content: content,
    ),
  );
}
