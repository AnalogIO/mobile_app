import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class QuickStatsSection extends StatelessWidget {
  const QuickStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuickStatsCubit, QuickStatsState>(
      builder: (context, state) {
        return switch (state) {
          QuickStatsInitial() || QuickStatsLoading() => const Padding(
            padding: EdgeInsets.all(32),
            child: Center(
              child: AnalogCircularProgressIndicator(spinnerColor: .dark),
            ),
          ),
          QuickStatsFailure(:final reason) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Center(child: Text('Failed to load quick stats: $reason')),
          ),
          QuickStatsLoaded(:final quickStats) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: QuickStatCard(
                          description: 'Total cups drunk by you',
                          number: quickStats.allTimeDrinksConsumed,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: QuickStatCard(
                          description: 'Cups drunk by ITU today',
                          number: quickStats.todayDrinksConsumedITU,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: QuickStatCard(
                          description: 'Your favourite drink',
                          number: quickStats.allTimeFavouriteDrink.$1,
                          extraText: quickStats.allTimeFavouriteDrink.$2,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: QuickStatCard(
                          description: 'Your cups drunk this week',
                          number: quickStats.weekDrinksConsumed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        };
      },
    );
  }
}
