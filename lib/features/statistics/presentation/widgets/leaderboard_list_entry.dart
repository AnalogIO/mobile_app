import 'package:cafe_analog_app/core/widgets/user_icon.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LeaderboardListEntry extends StatelessWidget {
  const LeaderboardListEntry({required this.entry, super.key});

  final LeaderboardUserEntry entry;

  String get _scoreText =>
      '${entry.drinksConsumed} ${entry.drinksConsumed != 1 ? 'cups' : 'cup'}';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: entry.isCurrentUser
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : null,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LeaderboardRankMedal(entry.rank),
          const Gap(16),
          UserIcon.small(id: entry.userId),
        ],
      ),
      title: Text(
        entry.isCurrentUser ? '${entry.name} (you)' : entry.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: entry.isCurrentUser
            ? const TextStyle(fontWeight: FontWeight.bold)
            : null,
      ),
      trailing: Text(_scoreText),
    );
  }
}
