import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuickStatCard extends StatelessWidget {
  new({required this.description, required int number, super.key})
    : count = number.toString(),
      extraText = null;

  /// Hides the [count] and [extraText] when [number] is zero.
  new favouriteDrink({
    required this.description,
    required int number,
    required String extraText,
    super.key,
  }) : extraText = number == 0 ? '' : extraText,
       count = number == 0 ? '-' : number.toString();

  final String description;
  final String count;
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
              count,
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
