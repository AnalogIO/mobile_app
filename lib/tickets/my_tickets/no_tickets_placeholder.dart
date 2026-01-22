import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class NoTicketsPlaceholder extends StatelessWidget {
  const NoTicketsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: colorScheme.onSurfaceVariant,
        strokeWidth: 2,
        dashPattern: const [6, 4],
        radius: const Radius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
        child: Center(
          child: Text(
            'Tickets you buy will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
