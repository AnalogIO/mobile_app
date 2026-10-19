import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/delayed_fade_in.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UseTicketLoadingScreen extends StatelessWidget {
  const UseTicketLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const AnalogCircularProgressIndicator(spinnerColor: .light),
          const Gap(24),
          DelayedFadeIn(
            delay: const Duration(milliseconds: 500),
            child: Text(
              'Using ticket... Please wait.',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
