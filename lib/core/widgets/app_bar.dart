import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalogAppBar({
    required this.title,
    this.onBrightnessChanged,
    super.key,
  });

  final String title;
  final void Function(Brightness)? onBrightnessChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 25,
      ),
      centerTitle: false,
      actions: [
        if (kDebugMode)
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final newBrightness = isDark ? Brightness.light : Brightness.dark;
              onBrightnessChanged?.call(newBrightness);
            },
          ),
      ],
    );
  }
}
