import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Screen shown when a new user opens the registration link from the
/// "Welcome to Analog" email.
///
/// The email address is not asked for here: the backend reads it from the
/// single-use [registrationToken].
class RegisterScreen extends StatefulWidget {
  const new({required this.registrationToken, super.key});

  final String registrationToken;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  int? _programmeId;
  bool _submitting = false;
  String? _error;

  bool get _canSubmit =>
      !_submitting &&
      _nameController.text.trim().isNotEmpty &&
      _programmeId != null;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;

    setState(() {
      _submitting = true;
      _error = null;
    });

    final result = await context.read<AuthCubit>().completeRegistration(
      registrationToken: widget.registrationToken,
      name: _nameController.text.trim(),
      programmeId: _programmeId!,
    );

    if (!mounted) return;
    setState(() => _submitting = false);

    result.match(
      (failure) => setState(() => _error = failure.reason),
      // AuthNavigator navigates to the app when AuthAuthenticated is emitted.
      (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Screen.withBody(
      name: 'Complete registration',
      body: ListView(
        padding: const .all(24),
        children: [
          Text(
            'Welcome to Analog!',
            style: textTheme.headlineMedium?.copyWith(fontWeight: .bold),
            textAlign: .center,
          ),
          const Gap(8),
          Text(
            'Choose your name and study programme to finish creating your '
            'account.',
            style: textTheme.bodyMedium,
            textAlign: .center,
          ),
          const Gap(32),
          TextField(
            controller: _nameController,
            textCapitalization: .words,
            textInputAction: .next,
            decoration: const InputDecoration(
              labelText: 'Full name',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const Gap(16),
          BlocBuilder<ProgrammesCubit, ProgrammesState>(
            builder: (context, state) {
              return switch (state) {
                ProgrammesInitial() || ProgrammesLoading() => const Padding(
                  padding: .symmetric(vertical: 16),
                  child: Center(
                    child: AnalogCircularProgressIndicator(spinnerColor: .dark),
                  ),
                ),
                ProgrammesFailure(:final reason) => FailureMessage(
                  message: 'Failed to load programmes: $reason',
                  onRetry: () =>
                      context.read<ProgrammesCubit>().loadProgrammes(),
                ),
                ProgrammesLoaded(:final programmes) ||
                ProgrammesRefreshing(:final programmes) => _ProgrammeDropdown(
                  programmes: programmes,
                  programmeId: _programmeId,
                  onChanged: (programmeId) {
                    setState(() => _programmeId = programmeId);
                  },
                ),
              };
            },
          ),
          if (_error case final error?) ...[
            const Gap(16),
            Text(
              error,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
              textAlign: .center,
            ),
          ],
          const Gap(32),
          FilledButton(
            onPressed: _canSubmit ? _submit : null,
            child: _submitting
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Create account'),
          ),
          const Gap(8),
          TextButton(
            onPressed: () => context.go('/login'),
            child: const Text('Back to login'),
          ),
        ],
      ),
    );
  }
}

class _ProgrammeDropdown extends StatelessWidget {
  const new({
    required this.programmes,
    required this.programmeId,
    required this.onChanged,
  });

  final List<Programme> programmes;
  final int? programmeId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final sorted = [...programmes]
      ..sort((a, b) => a.fullName.compareTo(b.fullName));

    return DropdownButtonFormField<int>(
      initialValue: programmeId,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Study programme',
        border: OutlineInputBorder(),
      ),
      items: sorted
          .map(
            (programme) => DropdownMenuItem(
              value: programme.id,
              child: Text(
                '${programme.fullName} (${programme.shortName})',
                overflow: .ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
