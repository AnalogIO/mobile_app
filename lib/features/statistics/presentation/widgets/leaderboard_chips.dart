import 'package:cafe_analog_app/core/widgets/choice_chips.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardChips extends StatelessWidget {
  const LeaderboardChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        return AnalogChoiceChips(
          labels: LeaderboardFilter.values.map((e) => e.label).toList(),
          selected: state.filter.index,
          onChange: (index) {
            final selectedFilter = LeaderboardFilter.values[index];
            context.read<LeaderboardCubit>().setFilter(selectedFilter).ignore();
          },
        );
      },
    );
  }
}
