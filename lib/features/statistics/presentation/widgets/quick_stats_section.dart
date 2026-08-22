import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuickStatsSection extends StatelessWidget {
  const QuickStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // FIXME(marfavi): load actual quick stats
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: QuickStatCard(
                    description: 'Your rank this week (vs BSWU)',
                    number: 62,
                    ordinalSuffix: 'nd',
                  ),
                ),
                Gap(10),
                Expanded(
                  child: QuickStatCard(
                    description: 'Cups consumed this week',
                    number: 5,
                  ),
                ),
              ],
            ),
          ),
          Gap(10),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: QuickStatCard(
                    description: 'Drinks purchased',
                    number: 42,
                  ),
                ),
                Gap(10),
                Expanded(
                  child: QuickStatCard(
                    description: 'Rank in cafe',
                    number: 7,
                    ordinalSuffix: 'th',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
