import 'package:flutter/material.dart';

/// A simple wrapper around [showDialog] to show a basic dialog with a title,
/// content, and actions, with some default styling.
///
/// If no [actions] are provided, a single "OK" button is shown that dismisses
/// the dialog.
Future<T?> showAnalogDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  List<Widget>? actions,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(content),
        actions:
            actions ??
            [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
      );
    },
  );
}
