import 'package:cafe_analog_app/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SecretScreen extends StatelessWidget {
  const SecretScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnalogAppBar(title: 'OMG'),
      body: Center(child: Text('SECRET PAGE!!! $id')),
    );
  }
}
