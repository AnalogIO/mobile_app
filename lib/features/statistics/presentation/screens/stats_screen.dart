import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Statistics',
      onRefresh: () => Future.wait<void>([
        context.read<QuickStatsCubit>().loadQuickStats(),
        context.read<LeaderboardCubit>().loadLeaderboard(),
      ]),
      children: const [
        QuickStatsSection(),
        Gap(16),
        LeaderboardSection(),
      ],
    );
  }
}
