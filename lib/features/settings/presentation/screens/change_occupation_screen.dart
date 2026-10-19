import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeOccupationScreen extends StatelessWidget {
  const ChangeOccupationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Change occupation',
      onRefresh: () => context.read<ProgrammesCubit>().loadProgrammes(),
      children: [
        BlocBuilder<ProgrammesCubit, ProgrammesState>(
          builder: (context, state) {
            return switch (state) {
              ProgrammesInitial() || ProgrammesLoading() => const Padding(
                padding: .all(32),
                child: Center(
                  child: AnalogCircularProgressIndicator(spinnerColor: .dark),
                ),
              ),
              ProgrammesFailure(:final reason) => FailureMessage(
                message: 'Failed to load occupations: $reason',
                onRetry: () => context.read<ProgrammesCubit>().loadProgrammes(),
              ),
              ProgrammesLoaded(:final programmes) ||
              ProgrammesRefreshing(:final programmes) => _OccupationSelection(
                programmes: programmes,
              ),
            };
          },
        ),
      ],
    );
  }
}

class _OccupationSelection extends StatelessWidget {
  const _OccupationSelection({required this.programmes});

  final List<Programme> programmes;

  @override
  Widget build(BuildContext context) {
    final currentProgrammeId = switch (context.watch<ProfileCubit>().state) {
      ProfileLoaded(:final profile) ||
      ProfileRefreshing(:final profile) => profile.programmeId,
      _ => null,
    };

    final sorted = [...programmes]
      ..sort((a, b) => a.fullName.compareTo(b.fullName));

    return Padding(
      padding: const .only(left: 16, right: 16, top: 8),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: RadioGroup<int?>(
          groupValue: currentProgrammeId,
          // Tap is handled by the whole list entry.
          onChanged: (_) {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (index, programme) in sorted.indexed) ...[
                if (index > 0) const Divider(height: 1),
                ListTile(
                  title: Text(
                    '${programme.fullName} (${programme.shortName})',
                  ),
                  trailing: IgnorePointer(
                    child: Radio<int?>(
                      value: programme.id,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  onTap: () => _onSelect(context, programme),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSelect(BuildContext context, Programme programme) async {
    final currentProgrammeId = switch (context.read<ProfileCubit>().state) {
      ProfileLoaded(:final profile) ||
      ProfileRefreshing(:final profile) => profile.programmeId,
      _ => null,
    };

    if (programme.id == currentProgrammeId) {
      showSnackBar(
        context: context,
        message: 'That was already your occupation.',
      );
      context.pop();
      return;
    }

    final dismissLoadingOverlay = showLoadingOverlay(context);

    final result = await context.read<ProfileCubit>().updateOccupation(
      programme.id,
    );
    if (!context.mounted) return;
    dismissLoadingOverlay(context);

    result.match(
      (failure) => showSnackBar(context: context, message: failure.reason),
      (_) {
        showSuccessSnackBar(context: context, message: 'Occupation updated');
        context.pop();
      },
    );
  }
}
