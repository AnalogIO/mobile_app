import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:cafe_analog_app/stats/view/leaderboard_chips.dart';
import 'package:cafe_analog_app/stats/view/leaderboard_list_entry.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      name: 'Statistics',
      children: [
        const SectionTitle('Quick stats'),
        Container(),
        const SectionTitle('Leaderboards'),
        const LeaderboardChips(selected: 0),
        // TODO(marfavi): Load actual leaderboard entries
        ...List.generate(
          10,
          (index) => LeaderboardListEntry(
            id: index,
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
