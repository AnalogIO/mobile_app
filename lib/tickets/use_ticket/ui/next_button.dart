// Modified version of https://github.com/imtoori/flutter-slide-to-act

import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton.filledTonal(
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        foregroundColor: theme.colorScheme.onSurface,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
      ),
      iconSize: 36,
      onPressed: onPressed,
      icon: const Icon(Icons.chevron_right),
    );
  }
}
