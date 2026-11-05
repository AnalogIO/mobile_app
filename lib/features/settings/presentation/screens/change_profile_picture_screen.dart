import 'dart:async';

import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:cafe_analog_app/core/widgets/user_icon.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:cafe_analog_app/features/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ChangeProfilePictureScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Change profile picture',
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
                message: 'Failed to load profile picture: $reason',
                onRetry: () => context.read<ProfileCubit>().loadProfile(),
              ),
              ProfileLoaded(:final profile) => _ProfilePicturePicker(
                profile: profile,
              ),
            };
          },
        ),
      ],
    );
  }
}

class _ProfilePicturePicker extends StatefulWidget {
  const new({required this.profile});

  final UserProfile profile;

  @override
  State<_ProfilePicturePicker> createState() => _ProfilePicturePickerState();
}

class _ProfilePicturePickerState extends State<_ProfilePicturePicker> {
  late int _iconId;
  late int _backgroundColorId;

  @override
  void initState() {
    super.initState();
    _iconId = widget.profile.profilePicture.iconId;
    _backgroundColorId = widget.profile.profilePicture.backgroundColorId;
  }

  bool get _hasChanges {
    return widget.profile.profilePicture.iconId != _iconId ||
        widget.profile.profilePicture.backgroundColorId != _backgroundColorId;
  }

  Future<void> _onSave() async {
    final dismissLoadingOverlay = showLoadingOverlay(context);

    final result = await context.read<ProfileCubit>().updateProfilePicture(
      ProfilePicture(iconId: _iconId, backgroundColorId: _backgroundColorId),
    );
    if (!mounted) return;
    dismissLoadingOverlay(context);

    result.match(
      (failure) => showSnackBar(context: context, message: failure.reason),
      (_) {
        // The leaderboard renders the same picture, so refresh it.
        unawaited(context.read<LeaderboardCubit>().loadLeaderboard());
        showSuccessSnackBar(
          context: context,
          message: 'Profile picture updated',
        );
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(8),
        Center(
          child: UserIcon.large(
            id: widget.profile.id,
            icon: _iconId,
            background: _backgroundColorId,
          ),
        ),
        const Gap(24),
        const SectionTitle('Choose icon'),
        const Gap(16),
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (var iconId = 0; iconId < UserIcon.iconCount; iconId++)
                _IconChoice(
                  iconId: iconId,
                  selected: _iconId == iconId,
                  onTap: () => setState(() => _iconId = iconId),
                ),
            ],
          ),
        ),
        const Gap(24),
        const SectionTitle('Choose color'),
        const Gap(16),
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (var colorId = 0; colorId < UserIcon.colors.length; colorId++)
                _ColorChoice(
                  colorId: colorId,
                  selected: _backgroundColorId == colorId,
                  onTap: () => setState(() => _backgroundColorId = colorId),
                ),
            ],
          ),
        ),
        const Gap(24),
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.secondary,
            ),
            onPressed: _hasChanges ? _onSave : null,
            child: const Text('Save'),
          ),
        ),
        const Gap(24),
      ],
    );
  }
}

class _IconChoice extends StatelessWidget {
  const new({
    required this.iconId,
    required this.selected,
    required this.onTap,
  });

  final int iconId;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? colorScheme.primary : Colors.transparent,
            width: 3,
          ),
        ),
        child: Center(child: CoffeeImage.fromId(image: iconId, size: 40)),
      ),
    );
  }
}

class _ColorChoice extends StatelessWidget {
  const new({
    required this.colorId,
    required this.selected,
    required this.onTap,
  });

  final int colorId;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: UserIcon.colors[colorId],
            border: Border.all(
              color: selected ? colorScheme.primary : Colors.transparent,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
