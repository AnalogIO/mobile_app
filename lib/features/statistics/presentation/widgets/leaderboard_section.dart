import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gap/gap.dart';

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const SectionTitle('Leaderboards'),
        const LeaderboardChips(),
        _LeaderboardListEntries(),
      ],
    );
  }
}

class _LeaderboardListEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        return switch (state) {
          LeaderboardInitial() ||
          LeaderboardLoading() => const LeaderboardLoadingPlaceholder(),
          LeaderboardLoaded(:final leaderboard) => Column(
            children: leaderboard
                .map<Widget>((entry) => LeaderboardListEntry(entry: entry))
                .append(const Gap(16))
                .toList(),
          ),
          LeaderboardFailure(:final reason) => FailureMessage(
            message: 'Failed to load leaderboard: $reason',
            onRetry: () => context.read<LeaderboardCubit>().loadLeaderboard(),
          ),
        };
      },
    );
  }
}
