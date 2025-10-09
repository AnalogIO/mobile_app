import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenWithNextPage extends StatelessWidget {
  const ScreenWithNextPage({
    required this.label,
    required this.nextPagePath,
    super.key,
  });

  final String label;
  final String nextPagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab root - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Screen $label',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            TextButton(
              onPressed: () => context.go(nextPagePath),
              child: const Text('Next page'),
            ),
          ],
        ),
      ),
    );
  }
}
