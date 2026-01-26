import 'package:flutter/material.dart';

class AppBrightnessProvider extends InheritedWidget {
  const AppBrightnessProvider({
    required this.onBrightnessChanged,
    required super.child,
    super.key,
  });

  final void Function(Brightness) onBrightnessChanged;

  static AppBrightnessProvider of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<AppBrightnessProvider>();
    assert(result != null, 'No AppBrightnessProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppBrightnessProvider oldWidget) {
    return onBrightnessChanged != oldWidget.onBrightnessChanged;
  }
}
