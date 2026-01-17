import 'package:cafe_analog_app/core/http_client.dart';
import 'package:cafe_analog_app/core/widgets/app_bar.dart';
import 'package:cafe_analog_app/http/generated_client/coffeecard_api_v2.models.swagger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnalogAppBar(title: 'Login'),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AnalogTextFormField(
                label: 'Email',
                textInputType: TextInputType.emailAddress,
                controller: textEditingController,
              ),
              const Gap(8),
              FilledButton.icon(
                label: const Text('Continue'),
                icon: const Icon(Icons.navigate_next),
                iconAlignment: IconAlignment.end,
                onPressed: () async {
                  final email = textEditingController.text;

                  if (kDebugMode) {
                    print('Trying to log in with $email...');
                  }

                  final response = await apiV2.accountLoginPost(
                    body: UserLoginRequest(
                      email: email,
                      loginType: 'shifty',
                    ),
                  );

                  if (context.mounted) {
                    if (response.isSuccessful) {
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('EMAIL SENT'),
                            actions: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('cool'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('ERROR'),
                            content: Text(response.error.toString()),
                            actions: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('når ok'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
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
    required this.controller,
    super.key,
  });

  final String label;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(filled: true, labelText: label),
      keyboardType: textInputType,
      controller: controller,
    );
  }
}
