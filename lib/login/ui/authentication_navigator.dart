import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// A widget that listens to authentication state changes from [AuthCubit]
/// and performs app-wide navigation and UI side effects:
///   - shows/hides a loading overlay while [AuthLoading] is emitted
///   - navigates to `/tickets`, `/login/email-sent`, or `/login` based on state
///   - displays a [SnackBar] when [AuthFailure] occurs with the failure reason
class AuthNavigator extends StatefulWidget {
  const AuthNavigator({required this.child, super.key});

  final Widget child;

  @override
  State<AuthNavigator> createState() => _AuthNavigatorState();
}

class _AuthNavigatorState extends State<AuthNavigator> {
  var _overlayVisible = false;

  void _showOverlay() {
    if (!_overlayVisible) {
      _overlayVisible = true;
      showLoadingOverlay(context);
    }
  }

  void _hideOverlay() {
    if (_overlayVisible &&
        Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
      _overlayVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Manage loading overlay reactively
        if (state is AuthLoading) {
          _showOverlay();
        } else {
          _hideOverlay();
        }

        switch (state) {
          case AuthAuthenticated():
            context.go('/tickets');
          case AuthEmailSent():
            context.go('/login/email-sent?email=${state.email}');
          case AuthUnauthenticated():
            context.go('/login');
          case AuthFailure():
            context.go('/login');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Authentication failed: ${state.reason}'),
              ),
            );
          case AuthLoading() || AuthInitial():
            // Do nothing
            return;
        }
      },
      child: widget.child,
    );
  }
}
