import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

/// A placeholder widget that mimics the structure of the
/// leaderboard while data is loading.
class LeaderboardLoadingPlaceholder extends StatelessWidget {
  const LeaderboardLoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(children: List.generate(10, (_) => const ListTile())),
        Positioned.fill(
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surface.withAlpha(200),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(64),
          child: Center(
            child: AnalogCircularProgressIndicator(spinnerColor: .dark),
          ),
        ),
      ],
    );
  }
}
