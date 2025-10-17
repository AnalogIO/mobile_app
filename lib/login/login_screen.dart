import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:router_test_app/core/widgets/analog_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AnalogAppBar(title: 'Login'),
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AnalogTextFormField(
                label: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              Gap(8),
              AnalogTextFormField(
                label: 'Passcode',
                textInputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalogTextFormField extends StatelessWidget {
  const AnalogTextFormField({
    required this.label,
    required this.textInputType,
    super.key,
  });

  final String label;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(filled: true, labelText: label),
      keyboardType: textInputType,
    );
  }
}
