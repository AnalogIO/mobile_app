import 'package:flutter/material.dart';

class LeaderboardChips extends StatelessWidget {
  const LeaderboardChips({required this.selected, super.key});

  final int selected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          3,
          (index) => Padding(
            padding: EdgeInsets.only(right: index < 2 ? 4 : 0),
            child: ChoiceChip(
              showCheckmark: false,
              label: Text(
                ['This month', 'This semester', 'All time'][index],
              ),
              selected: selected == index,
              onSelected: (bool selected) {
                return;
              },
            ),
          ),
        ),
      ),
    );
  }
}
