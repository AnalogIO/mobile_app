import 'package:cafe_analog_app/core/widgets/user_icon.dart';
import 'package:cafe_analog_app/stats/view/leaderboard_rank_medal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LeaderboardListEntry extends StatelessWidget {
  const LeaderboardListEntry({
    required this.userId,
    required this.name,
    required this.score,
    required this.rank,
    required this.isYou,
    super.key,
  });

  final int userId;
  final String name;
  final int score;
  final int rank;
  final bool isYou;

  String get _scoreText => '$score ${score != 1 ? 'cups' : 'cup'}';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isYou
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : null,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LeaderboardRankMedal(rank),
          const Gap(16),
          UserIcon.small(id: userId),
        ],
      ),
      title: Text(
        isYou ? '$name (you)' : name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: isYou ? const TextStyle(fontWeight: FontWeight.bold) : null,
      ),
      trailing: Text(_scoreText),
    );
  }
}
