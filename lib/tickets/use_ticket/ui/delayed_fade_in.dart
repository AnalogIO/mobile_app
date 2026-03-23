import 'package:flutter/material.dart';

/// A widget that fades in its child after a specified delay.
class DelayedFadeIn extends StatefulWidget {
  const DelayedFadeIn({
    required this.child,
    this.delay = const Duration(milliseconds: 250),
    super.key,
  });

  final Widget child;
  final Duration delay;

  @override
  State<DelayedFadeIn> createState() => _DelayedFadeInState();
}

class _DelayedFadeInState extends State<DelayedFadeIn> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      child: widget.child,
    );
  }
}
