import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Statistics',
      children: const [
        QuickStatsSection(),
        Gap(16),
        LeaderboardSection(),
      ],
    );
  }
}
