import 'package:cafe_analog_app/core/widgets/form.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: Image.asset('assets/images/beans_half.png', fit: .cover),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                Flexible(
                  child: Center(
                    child: FittedBox(
                      fit: .scaleDown,
                      child: Column(
                        mainAxisSize: .min,
                        children: [
                          Text(
                            'Café Analog',
                            style: textTheme.headlineLarge?.copyWith(
                              fontWeight: .w900,
                            ),
                          ),
                          Text(
                            'Enter your email to continue',
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnalogForm(
                  inputType: .email,
                  labelText: 'Your email',
                  submitText: 'Continue',
                  errorMessage: 'Enter a valid email',
                  onSubmit: (email) async {
                    await context.read<AuthCubit>().sendLoginLink(email: email);
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
