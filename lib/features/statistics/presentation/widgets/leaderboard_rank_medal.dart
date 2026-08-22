import 'package:flutter/material.dart';

class LeaderboardRankMedal extends StatelessWidget {
  const LeaderboardRankMedal(this.rank, {super.key});

  final int rank;

  String get rankString => rank == 0 ? '-' : '$rank';

  Color get _fillColor {
    if (rank == 1) return const Color(0xffFFD91D);
    if (rank == 2) return const Color(0xffC2C2C2);
    if (rank == 3) return const Color(0xffD9A169);
    return Colors.transparent;
  }

  Color get _borderColor {
    if (rank == 1) return const Color(0xffB3980E);
    if (rank == 2) return const Color(0xff767676);
    if (rank == 3) return const Color(0xff7A4C1F);
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 19,
          height: 19,
          decoration: BoxDecoration(
            color: _fillColor,
            shape: BoxShape.circle,
            border: Border.all(width: 1.5, color: _borderColor),
          ),
        ),
        Text(
          rankString,
          style: TextStyle(
            color: switch (rank) {
              1 || 2 || 3 => Colors.black,
              _ => Theme.of(context).colorScheme.onSurface,
            },
          ),
        ),
      ],
    );
  }
}
