import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OpeningHoursScreen extends StatelessWidget {
  const OpeningHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final today = DateTime.now().weekday;

    return Screen.listView(
      name: 'Opening hours',
      children: [
        Padding(
          padding: const .all(16),
          child: Container(
            padding: const .all(24),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Open during ITU teaching periods, '
                  'closed during exam periods and holidays.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(24),
                for (final (index, weekday) in weekdayNames.keys.indexed) ...[
                  if (index > 0) const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        weekdayNames[weekday]!,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: weekday == today ? FontWeight.bold : null,
                        ),
                      ),
                      Text(
                        openingHoursLabel(weekday),
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: weekday == today ? FontWeight.bold : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
