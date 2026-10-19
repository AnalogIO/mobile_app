import 'dart:async';

import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class YourProfileScreen extends StatelessWidget {
  const YourProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Your profile',
      onRefresh: () => context.read<ProfileCubit>().loadProfile(),
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return switch (state) {
              ProfileInitial() || ProfileLoading() => const Padding(
                padding: .all(32),
                child: Center(
                  child: AnalogCircularProgressIndicator(spinnerColor: .dark),
                ),
              ),
              ProfileFailure(:final reason) => FailureMessage(
                message: 'Failed to load profile: $reason',
                onRetry: () => context.read<ProfileCubit>().loadProfile(),
              ),
              ProfileLoaded(:final profile) ||
              ProfileRefreshing(:final profile) => _ProfileContent(
                profile: profile,
              ),
            };
          },
        ),
      ],
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: const Text('Name'),
          subtitle: Text(profile.name),
          onTap: () => context.go('/settings/change-name'),
        ),
        ListTile(
          title: const Text('Occupation'),
          subtitle: Text(
            profile.occupation.isEmpty ? 'Not set' : profile.occupation,
          ),
          onTap: () => context.go('/settings/change-occupation'),
        ),
        ListTile(
          title: const Text('Profile picture'),
          subtitle: const Text('Icon and background color'),
          onTap: () => context.go('/settings/change-profile-picture'),
        ),
        ListTile(
          title: const Text('Appear anonymous'),
          isThreeLine: true,
          subtitle: const Text(
            'When enabled, your name will be hidden from the leaderboard',
          ),
          trailing: Switch(
            value: profile.appearAnonymous,
            onChanged: (value) => _onToggleAnonymous(context, value),
          ),
        ),
      ],
    );
  }

  Future<void> _onToggleAnonymous(BuildContext context, bool value) async {
    final dismissLoadingOverlay = showLoadingOverlay(context);

    final result = await context.read<ProfileCubit>().updateAppearAnonymous(
      appearAnonymous: value,
    );
    if (!context.mounted) return;
    dismissLoadingOverlay(context);

    result.match(
      (failure) => showSnackBar(context: context, message: failure.reason),
      (_) {
        // The name is shown (or hidden) on the leaderboard, so refresh it.
        unawaited(context.read<LeaderboardCubit>().loadLeaderboard());
        showSnackBar(
          context: context,
          message: value
              ? 'You now appear anonymous'
              : 'You now appear by name',
        );
      },
    );
  }
}
