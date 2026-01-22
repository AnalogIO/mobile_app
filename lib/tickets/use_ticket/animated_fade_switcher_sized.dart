import 'dart:async';

import 'package:flutter/material.dart';

/// A widget that fades between two children while maintaining
/// the height of the tallest child.
///
/// Unlike [AnimatedCrossFade], this widget doesn't animate size changes -
/// it always uses the maximum height of both children.
///
/// Set [showSecond] to control which child is visible:
/// - false = [firstChild] fully visible
/// - true = [secondChild] fully visible
class AnimatedFadeSwitcherSized extends StatefulWidget {
  const AnimatedFadeSwitcherSized({
    required this.showSecond,
    required this.firstChild,
    required this.secondChild,
    super.key,
  });

  /// Whether to show the second child.
  /// When false, [firstChild] is shown. When true, [secondChild] is shown.
  final bool showSecond;

  /// The widget shown when [showSecond] is false.
  final Widget firstChild;

  /// The widget shown when [showSecond] is true.
  final Widget secondChild;

  @override
  State<AnimatedFadeSwitcherSized> createState() =>
      _AnimatedFadeSwitcherSizedState();
}

class _AnimatedFadeSwitcherSizedState extends State<AnimatedFadeSwitcherSized>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const _duration = Duration(milliseconds: 400);
  static const _fadeOutInterval = Interval(0, 0.4, curve: Curves.easeOut);
  static const _fadeInInterval = Interval(0.6, 1, curve: Curves.easeIn);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
      value: widget.showSecond ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(AnimatedFadeSwitcherSized oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showSecond != oldWidget.showSecond) {
      if (widget.showSecond) {
        unawaited(_controller.forward());
      } else {
        unawaited(_controller.reverse());
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          // Second child (fades in)
          _AnimatedFadeChild(
            animation: _controller,
            interval: _fadeInInterval,
            child: widget.secondChild,
          ),
          // First child (fades out)
          _AnimatedFadeChild(
            animation: _controller,
            interval: _fadeOutInterval,
            invert: true,
            child: widget.firstChild,
          ),
        ],
      ),
    );
  }
}

class _AnimatedFadeChild extends StatelessWidget {
  const _AnimatedFadeChild({
    required this.animation,
    required this.interval,
    required this.child,
    this.invert = false,
  });

  final Animation<double> animation;
  final Interval interval;
  final bool invert;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final opacity = interval.transform(animation.value);
        final effectiveOpacity = switch (invert) {
          true => 1.0 - opacity,
          false => opacity,
        };

        return IgnorePointer(
          ignoring: effectiveOpacity < 0.5,
          child: Opacity(
            opacity: effectiveOpacity,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
