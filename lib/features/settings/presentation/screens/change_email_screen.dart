import 'dart:async';

import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/form.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.withBody(
      name: 'Change email',
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return switch (state) {
            ProfileInitial() || ProfileLoading() => const Center(
              child: AnalogCircularProgressIndicator(spinnerColor: .dark),
            ),
            ProfileFailure(:final reason) => FailureMessage(
              message: 'Failed to load profile: $reason',
              onRetry: () => context.read<ProfileCubit>().loadProfile(),
            ),
            ProfileLoaded(:final profile) ||
            ProfileRefreshing(:final profile) => AnalogForm(
              inputType: FormInputType.email,
              labelText: 'Your email',
              submitText: 'Save',
              errorMessage: 'Enter a valid email',
              initialValue: profile.email,
              onSubmit: (email, setError) async {
                if (email == profile.email) {
                  showSnackBar(
                    context: context,
                    message: 'That was already your email.',
                  );
                  context.pop();
                  return;
                }

                final dismissLoadingOverlay = showLoadingOverlay(context);

                final result = await context.read<ProfileCubit>().updateEmail(
                  email,
                );
                if (!context.mounted) return;

                result.match(
                  (failure) {
                    dismissLoadingOverlay(context);
                    setError(failure.reason);
                  },
                  (_) => unawaited(
                    _onEmailUpdated(context, dismissLoadingOverlay),
                  ),
                );
              },
            ),
          };
        },
      ),
    );
  }

  /// Reacts to a successful email update.
  ///
  /// The backend resolves the account from the JWT's email claim, so the
  /// token pair must be renewed to carry the new email. If renewal fails the
  /// session is unrecoverable, so the user is logged out and asked to log in
  /// again with the new email.
  Future<void> _onEmailUpdated(
    BuildContext context,
    void Function(BuildContext context) dismissLoadingOverlay,
  ) async {
    final sessionRefreshed = await context.read<AuthCubit>().refreshSession();
    if (!context.mounted) return;
    dismissLoadingOverlay(context);

    if (sessionRefreshed) {
      showSuccessSnackBar(context: context, message: 'Email updated');
      context.pop();
      return;
    }

    showSnackBar(
      context: context,
      message: 'Email updated. Please log in again.',
    );
    await context.read<AuthCubit>().logOut();
  }
}
