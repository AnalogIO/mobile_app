import 'package:flutter/material.dart';

enum SpinnerColor { light, dark }

class AnalogCircularProgressIndicator extends StatelessWidget {
  const AnalogCircularProgressIndicator({
    required this.spinnerColor,
    super.key,
  });

  final SpinnerColor spinnerColor;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      semanticsLabel: 'Loading',
      strokeWidth: 10,
      strokeCap: .round,
      color: spinnerColor == .dark
          ? Theme.of(context).colorScheme.onSurface
          : Colors.white,
    );
  }
}
