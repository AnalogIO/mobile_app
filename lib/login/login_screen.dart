import 'dart:async';

import 'package:cafe_analog_app/core/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          // Subtle background graphic
          Positioned.fill(
            child: Opacity(
              opacity: 0.075,
              child: Image.asset(
                'assets/images/beans_half.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Text(
                  'Analog',
                  style: textTheme.headlineLarge?.copyWith(fontWeight: .bold),
                ),
                Text(
                  'Enter your email to continue',
                  style: textTheme.bodyMedium,
                ),
                const Spacer(),
                AnalogForm(
                  inputType: .email,
                  labelText: 'Your email',
                  submitText: 'Continue',
                  errorMessage: 'Enter a valid email',
                  onSubmit: (email) async {
                    // Show loading overlay
                    unawaited(
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );

                    // Simulate network request for 2s
                    await Future<void>.delayed(const Duration(seconds: 2));

                    // Dismiss loading overlay and navigate
                    if (context.mounted) {
                      Navigator.of(context).pop(); // dismiss dialog
                      context.go('/tickets');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
