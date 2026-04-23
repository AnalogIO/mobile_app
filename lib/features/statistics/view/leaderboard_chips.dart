import 'package:cafe_analog_app/core/widgets/choice_chips.dart';
import 'package:flutter/material.dart';

class LeaderboardChips extends StatelessWidget {
  const LeaderboardChips({required this.selected, super.key});

  final int selected;

  @override
  Widget build(BuildContext context) {
    return AnalogChoiceChips(
      labels: const ['This month', 'This semester', 'All time'],
      selected: selected,
      onChange: (_) {
        return;
      },
    );
  }
}
