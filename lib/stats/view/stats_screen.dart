import 'package:cafe_analog_app/core/widgets/choice_chips.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:cafe_analog_app/stats/view/leaderboard_list_entry.dart';
import 'package:cafe_analog_app/stats/view/quick_stat_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Statistics',
      children: [
        const SectionTitle('Quick stats'),
        const Gap(12),
        const _QuickStats(
          children: [
            // TODO(marfavi): Load actual stats
            // For now, using placeholder values
            QuickStatCard(
              description: 'Drinks purchased',
              number: 42,
            ),
            QuickStatCard(
              description: 'Rank in cafe',
              number: 7,
              ordinalSuffix: 'th',
            ),
            QuickStatCard(
              description: 'Your rank this week (vs ITU)',
              number: 125,
              ordinalSuffix: 'th',
            ),
            QuickStatCard(
              description: 'Your rank this week (vs BSWU)',
              number: 62,
              ordinalSuffix: 'nd',
            ),
          ],
        ),
        const Gap(16),
        const SectionTitle('Leaderboards'),
        AnalogChoiceChips(
          labels: const ['This month', 'This semester', 'All time'],
          selected: 0,
          onChange: (_) {},
        ),
        // TODO(marfavi): Load actual leaderboard entries
        ...List.generate(
          // note: the three dots before List.generate
          // are the spread operator, which "spreads" the resulting
          // list into the surrounding list
          // example: [1, 2, ...[3, 4]] == [1, 2, 3, 4]
          10,
          (index) => LeaderboardListEntry(
            userId: index,
            name: [
              'Monir',
              'Omid',
              'Tobias',
              'Josefine',
              'Signe',
              'Edith',
              'Zacharias',
              'Esra',
              'Jaden',
              'Vahab',
            ][index],
            score: (10 - index) * 3,
            rank: index + 1,
            isYou: index == 0,
          ),
        ),
        const Gap(16),
      ],
    );
  }
}

class _QuickStats extends StatelessWidget {
  const _QuickStats({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(child: children[0]),
                const Gap(10),
                Expanded(child: children[1]),
              ],
            ),
          ),
          const Gap(10),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(child: children[2]),
                const Gap(10),
                Expanded(child: children[3]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
