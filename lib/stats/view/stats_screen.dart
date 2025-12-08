import 'package:cafe_analog_app/core/widgets/choice_chips.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:cafe_analog_app/stats/view/leaderboard_list_entry.dart';
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
              'Alice',
              'Bob',
              'Charlie',
              'David',
              'Eve',
              'Frank',
              'Grace',
              'Heidi',
              'Ivan',
              'Judy',
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
