import 'package:flutter/material.dart';

class UseTicketFailedScreen extends StatelessWidget {
  const UseTicketFailedScreen({required this.reason, super.key});

  final String reason;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('An error occurred'),
      content: Text(reason),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
