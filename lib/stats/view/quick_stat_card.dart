import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuickStatCard extends StatelessWidget {
  const QuickStatCard({
    required this.description,
    required this.number,
    super.key,
    this.ordinalSuffix,
  });

  final String description;
  final int number;
  final String? ordinalSuffix;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                number.toString(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (ordinalSuffix != null) const SizedBox(width: 1),
              if (ordinalSuffix != null)
                Text(
                  ordinalSuffix!,
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
