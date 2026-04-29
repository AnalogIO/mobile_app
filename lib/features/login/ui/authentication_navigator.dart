import 'package:cafe_analog_app/app/pending_login_redirect_store.dart';
import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/features/login/bloc/authentication_cubit.dart';
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
  void Function(BuildContext context)? _dismissLoadingOverlay;

  void _showLoadingOverlay() {
    // Only show the loading overlay if it's not already shown
    setState(() => _dismissLoadingOverlay ??= showLoadingOverlay(context));
  }

  void _hideLoadingOverlay() {
    _dismissLoadingOverlay?.call(context);
    setState(() => _dismissLoadingOverlay = null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Manage loading overlay reactively
        if (state is AuthLoading) {
          _showLoadingOverlay();
        } else {
          _hideLoadingOverlay();
        }

        switch (state) {
          case AuthAuthenticated():
            final redirect = context
                .read<PendingLoginRedirectStore>()
                .pendingRedirect;
            context.go(redirect ?? '/tickets');
          case AuthEmailSent():
            context.go('/login/email-sent?email=${state.email}');
          case AuthUnauthenticated():
            context.go('/login');
          case AuthFailure():
            context.go('/login');
            showSnackBar(
              context: context,
              message: 'Authentication failed: ${state.reason}',
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
