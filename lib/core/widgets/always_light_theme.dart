import 'package:flutter/material.dart';

/// Forces a widget subtree to resolve theme-dependent values using light mode.
class AlwaysLightTheme extends StatelessWidget {
  const AlwaysLightTheme({required this.builder, super.key});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      useMaterial3: Theme.of(context).useMaterial3,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF785B38),
      ),
    );

    return Theme(
      data: lightTheme,
      child: Builder(
        builder: (context) {
          return DefaultTextStyle(
            style: TextTheme.of(context).bodyMedium ?? const TextStyle(),
            child: builder(context),
          );
        },
      ),
    );
  }
}
