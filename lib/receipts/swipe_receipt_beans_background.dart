import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class SwipeReceiptBeansBackground extends StatelessWidget {
  const SwipeReceiptBeansBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!constraints.hasBoundedWidth || !constraints.hasBoundedHeight) {
          return const SizedBox.shrink();
        }

        final cardSize = constraints.biggest;
        final cardDiagonal = math.sqrt(
          (cardSize.width * cardSize.width) +
              (cardSize.height * cardSize.height),
        );

        // Centering a diameter of 2 * diagonal on the bottom-right corner
        // guarantees the decoration can cover the full card area.
        final decorationSize = cardDiagonal * 2;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -decorationSize / 2,
              bottom: -decorationSize / 2,
              child: _RotatingBeansDecoration(size: decorationSize),
            ),
          ],
        );
      },
    );
  }
}

class _RotatingBeansDecoration extends StatefulWidget {
  const _RotatingBeansDecoration({required this.size});

  final double size;

  @override
  State<_RotatingBeansDecoration> createState() =>
      _RotatingBeansDecorationState();
}

class _RotatingBeansDecorationState extends State<_RotatingBeansDecoration>
    with SingleTickerProviderStateMixin {
  static const _rotationDuration = Duration(seconds: 48);
  static const _opacity = 0.05;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _rotationDuration);
    unawaited(_controller.repeat());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: ClipOval(
        child: Opacity(
          opacity: _opacity,
          child: RotationTransition(
            turns: _controller,
            child: Image.asset(
              'assets/images/beans_half.png',
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
          ),
        ),
      ),
    );
  }
}
