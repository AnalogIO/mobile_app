import 'dart:async';

import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Screen displayed when the app is opened via a magic link.
///
/// Blank screen, only responsible for initiating the authentication
/// process using the provided magic link token.
class VerifyMagicLinkScreen extends StatefulWidget {
  const VerifyMagicLinkScreen({required this.magicLinkToken, super.key});

  final String magicLinkToken;

  @override
  State<VerifyMagicLinkScreen> createState() => _VerifyMagicLinkScreenState();
}

class _VerifyMagicLinkScreenState extends State<VerifyMagicLinkScreen> {
  @override
  void initState() {
    super.initState();

    // Start authentication process with the provided magic link token
    unawaited(
      context.read<AuthCubit>().authenticateWithToken(
        magicLinkToken: widget.magicLinkToken,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Prevent back navigation during the authentication process
    return const PopScope(
      canPop: false,
      child: Scaffold(),
    );
  }
}
import 'dart:async';

import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Screen displayed when the app is opened via a magic link.
///
/// Blank screen, only responsible for initiating the authentication
/// process using the provided magic link token.
class VerifyMagicLinkScreen extends StatefulWidget {
  const VerifyMagicLinkScreen({required this.magicLinkToken, super.key});

  final String magicLinkToken;

  @override
  State<VerifyMagicLinkScreen> createState() => _VerifyMagicLinkScreenState();
}

class _VerifyMagicLinkScreenState extends State<VerifyMagicLinkScreen> {
  @override
  void initState() {
    super.initState();

    // Start authentication process with the provided magic link token
    unawaited(
      context.read<AuthCubit>().authenticateWithToken(
        magicLinkToken: widget.magicLinkToken,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Prevent back navigation during the authentication process
    return const PopScope(
      canPop: false,
      child: Scaffold(),
    );
  }
}
