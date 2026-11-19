import 'dart:core';
import 'dart:ui';

import 'package:cafe_analog_app/core/responsive.dart';
import 'package:cafe_analog_app/core/time_since.dart';
import 'package:cafe_analog_app/core/widgets/always_light_theme.dart';
import 'package:cafe_analog_app/features/tickets/presentation/use_ticket/widgets/rotating_beans_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

final String Function(DateTime date) _formatDate = DateFormat(
  'EEE d MMM y HH:mm',
).format;

/// A receipt that is shown when a ticket is swiped.
class SwipedTicketReceipt extends StatefulWidget {
  const new({
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
  State<SwipedTicketReceipt> createState() => _SwipedTicketReceiptState();
}

class _SwipedTicketReceiptState extends State<SwipedTicketReceipt> {
  double textShadowOpacity = 0;

  @override
  Widget build(BuildContext context) {
    final localTime = widget.time.toLocal();
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: AlwaysLightTheme(
        builder: (context) {
          return Tilt(
            fps: 150,
            onGestureMove: (model, _) {
              if (model.angle.dx.abs() > 1 || model.angle.dy.abs() > 1) {
                setState(() {
                  textShadowOpacity = 0.3;
                });
              } else {
                setState(() {
                  textShadowOpacity = 0;
                });
              }
            },
            tiltConfig: const TiltConfig(
              enableReverse: true,
              leaveCurve: Curves.easeInOutCubicEmphasized,
              leaveDuration: Duration(milliseconds: 100),
            ),
            child: TiltBaseContainer(
              lightConfig: const LightConfig(disable: true),
              shadowConfig: const ShadowBaseConfig(
                color: Colors.black,
                maxBlurRadius: 24,
              ),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: widget.isTestEnvironment
                      ? Theme.of(context).colorScheme.error.withAlpha(200)
                      : Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: TiltParallax(
                        filterQuality: FilterQuality.low,
                        offset: Offset(-20, -30),
                        child: RotatingBeansBackground(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Swiped via ${widget.productName} ticket'),
                              const Gap(16),
                              Stack(
                                children: [
                                  TiltParallax(
                                    offset: const Offset(-1, -1),
                                    child: AnimatedOpacity(
                                      opacity: textShadowOpacity,
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                          sigmaX: 3,
                                          sigmaY: 3,
                                        ),
                                        child: Text(
                                          widget.drinkName,
                                          style: TextTheme.of(context)
                                              .headlineLarge
                                              ?.copyWith(
                                                fontWeight: .bold,
                                                color: Colors.black,
                                              ),
                                          // style: AppTextStyle.ownedTicket,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TiltParallax(
                                    offset: const Offset(3, 3),
                                    child: Text(
                                      widget.drinkName,
                                      style: TextTheme.of(context).headlineLarge
                                          ?.copyWith(fontWeight: .bold),
                                      // style: AppTextStyle.ownedTicket,
                                    ),
                                  ),
                                ],
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
                              Image.asset(
                                'assets/images/logo-dark.png',
                                width: 48,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A human-readable "time ago" text that updates in real time.
class _TimeAgoText extends StatelessWidget {
  const new({required this.localTime});

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
          style: TextTheme.of(context).bodyLarge?.copyWith(fontWeight: .bold),
        );
      },
    );
  }
}
