import 'package:flutter/material.dart';

class ListGroupTitle extends StatelessWidget {
  const ListGroupTitle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        textAlign: TextAlign.left,
      ),
    );
  }
}
