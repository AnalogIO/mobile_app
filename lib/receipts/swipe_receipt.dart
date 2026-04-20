import 'package:cafe_analog_app/core/responsive.dart';
import 'package:cafe_analog_app/core/time_since.dart';
import 'package:cafe_analog_app/core/widgets/always_light_theme.dart';
import 'package:cafe_analog_app/receipts/swipe_receipt_beans_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

final String Function(DateTime date) _formatDate = DateFormat(
  'EEE d MMM y HH:mm',
).format;

class SwipeReceipt extends StatelessWidget {
  const SwipeReceipt({
    required this.productName,
    required this.drinkName,
    required this.time,
    required this.isTestEnvironment,
    super.key,
  });

  final String productName;
  final String drinkName;
  final DateTime time;
  final bool isTestEnvironment;

  @override
  Widget build(BuildContext context) {
    final localTime = time.toLocal();
    return AlwaysLightTheme(
      builder: (context) {
        return IgnorePointer(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: isTestEnvironment
                  ? Theme.of(context).colorScheme.error.withAlpha(200)
                  : Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: SwipeReceiptBeansBackground(),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Swiped via $productName ticket'),
                          const Gap(16),
                          Text(
                            drinkName,
                            style: TextTheme.of(
                              context,
                            ).headlineLarge?.copyWith(fontWeight: .bold),
                            // style: AppTextStyle.ownedTicket,
                          ),
                          const Gap(12),
                          _TimeAgoText(localTime: localTime),
                          Text(
                            _formatDate(localTime),
                            style: TextTheme.of(context).bodyLarge,
                          ),
                        ],
                      ),
                      const Gap(120),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .end,
                        children: [
                          Flexible(
                            child: Text(
                              'This can be found again under Receipts.',
                              style: TextTheme.of(context).labelMedium,
                            ),
                          ),
                          Gap(deviceIsSmall(context) ? 24 : 48),
                          Image.asset('assets/images/logo-dark.png', width: 48),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A human-readable "time ago" text that updates in real time.
class _TimeAgoText extends StatelessWidget {
  const _TimeAgoText({required this.localTime});

  final DateTime localTime;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => DateTime.now(),
      ),
      initialData: DateTime.now(),
      builder: (context, snapshot) {
        final now = snapshot.data!;
        return Text(
          timeSince(localTime, now: now),
          style: TextTheme.of(context).bodyLarge?.copyWith(
            fontWeight: .bold,
          ),
        );
      },
    );
  }
}
