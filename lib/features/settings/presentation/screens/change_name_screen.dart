import 'dart:async';

import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/form.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.withBody(
      name: 'Change name',
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
              labelText: 'Your name',
              submitText: 'Save',
              errorMessage: 'Enter your name',
              initialValue: profile.name,
              onSubmit: (name, setError) async {
                if (name == profile.name) {
                  showSnackBar(
                    context: context,
                    message: 'That was already your name.',
                  );
                  context.pop();
                  return;
                }

                final dismissLoadingOverlay = showLoadingOverlay(context);

                final result = await context.read<ProfileCubit>().updateName(
                  name,
                );
                if (!context.mounted) return;
                dismissLoadingOverlay(context);

                result.match(
                  (failure) => setError(failure.reason),
                  (_) {
                    // The name is shown on the leaderboard, so refresh it.
                    unawaited(
                      context.read<LeaderboardCubit>().loadLeaderboard(),
                    );
                    showSuccessSnackBar(
                      context: context,
                      message: 'Name updated',
                    );
                    context.pop();
                  },
                );
              },
            ),
          };
        },
      ),
    );
  }
}
