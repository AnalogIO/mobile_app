import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(marfavi): Show the development team and AnalogIO info here.
    return Screen.listView(name: 'Credits', children: const []);
  }
}
