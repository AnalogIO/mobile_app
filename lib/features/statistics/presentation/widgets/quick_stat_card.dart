import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuickStatCard extends StatelessWidget {
  const QuickStatCard({
    required this.description,
    required this.number,
    this.extraText,
    super.key,
  });

  final String description;
  final int number;
  final String? extraText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
          ),
          const Gap(24),
          if (extraText != null)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                extraText!,
                textAlign: TextAlign.right,
                style: theme.textTheme.titleMedium,
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              number.toString(),
              textAlign: TextAlign.right,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
