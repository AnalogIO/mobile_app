import 'dart:async';

import 'package:cafe_analog_app/core/responsive.dart';
import 'package:cafe_analog_app/core/time_since.dart';
import 'package:cafe_analog_app/core/widgets/always_light_theme.dart';
import 'package:cafe_analog_app/features/tickets/presentation/use_ticket/widgets/rotating_beans_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  GyroscopeEvent? _gyroscopeEvent;
  double _smoothX = 0;
  double _smoothY = 0;

  @override
  Widget build(BuildContext context) {
    final localTime = widget.time.toLocal();

    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateX(_smoothX * -0.1)
      ..rotateY(_smoothY * -0.1);

    return AlwaysLightTheme(
      builder: (context) {
        return IgnorePointer(
          child: Transform(
            alignment: Alignment.center,
            transform: transform,
            child: Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: widget.isTestEnvironment
                        ? Theme.of(context).colorScheme.error.withAlpha(200)
                        : Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      const Positioned.fill(child: RotatingBeansBackground()),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Swiped via ${widget.productName} ticket'),
                                Text(
                                  _smoothX.toStringAsFixed(2) +
                                      ' ' +
                                      _smoothY.toStringAsFixed(2),
                                ),
                                const Gap(16),
                                Text(
                                  widget.drinkName,
                                  style: TextTheme.of(context).headlineLarge
                                      ?.copyWith(fontWeight: .bold),
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
                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment(
                            -1 + (_smoothY * -1),
                            -1 - (_smoothX * -1),
                          ),
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.7),
                            Colors.white.withValues(alpha: 0),
                          ],
                          stops: const [0, 0.6],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      gyroscopeEventStream().listen((event) {
        setState(() {
          _gyroscopeEvent = event;
          _smoothX += (event.x - _smoothX) * 0.15;
          _smoothY += (event.y - _smoothY) * 0.15;
        });
      }, cancelOnError: true),
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
