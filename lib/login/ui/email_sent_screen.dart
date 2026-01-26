import 'dart:async';

import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EmailSentScreen extends StatefulWidget {
  const EmailSentScreen({required this.email, super.key});

  final String email;

  @override
  State<EmailSentScreen> createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends State<EmailSentScreen> {
  int _cooldownSeconds = 60;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _cooldownSeconds = 60);

    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _cooldownSeconds -= 1;
        if (_cooldownSeconds <= 0) {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _resendEmail() async {
    await context.read<AuthCubit>().sendLoginLink(email: widget.email);
    _startCooldown();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Icon(
                  Icons.mark_email_read_outlined,
                  size: 80,
                  color: colorScheme.secondary,
                ),
                const Gap(24),
                Text(
                  'Check your email',
                  style: textTheme.headlineMedium?.copyWith(fontWeight: .bold),
                  textAlign: .center,
                ),
                const Gap(12),
                Text(
                  'We sent a magic link to',
                  style: textTheme.bodyLarge,
                  textAlign: .center,
                ),
                const Gap(4),
                Text(
                  widget.email,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: .bold,
                    color: colorScheme.primary,
                  ),
                  textAlign: .center,
                ),
                const Gap(8),
                Text(
                  'Click the link in the email to continue',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap(48),
                FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    foregroundColor: colorScheme.onSecondary,
                    backgroundColor: colorScheme.secondary,
                  ),
                  onPressed: _cooldownSeconds > 0 ? null : _resendEmail,
                  child: Text(
                    _cooldownSeconds > 0
                        ? 'Resend email ($_cooldownSeconds)'
                        : 'Resend email',
                  ),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colorScheme.primary),
                  ),
                  onPressed: () => context.go('/login'),
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Change email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
