import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenWithNextPage extends StatelessWidget {
  const ScreenWithNextPage({
    required this.label,
    String? nextPagePath,
    super.key,
  }) : _nextPagePath = nextPagePath;

  final String label;
  final String? _nextPagePath;

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
            if (_nextPagePath != null)
              TextButton(
                onPressed: () => context.go(_nextPagePath),
                child: const Text('Next page'),
              ),
          ],
        ),
      ),
    );
  }
}
