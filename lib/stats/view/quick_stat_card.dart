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

  static const double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3E6D9),
        borderRadius: BorderRadius.circular(_borderRadius),
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
          Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$number${ordinalSuffix ?? ''}',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
