import 'package:flutter/material.dart';

class AnalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalogAppBar({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      centerTitle: false,
    );
  }
}
