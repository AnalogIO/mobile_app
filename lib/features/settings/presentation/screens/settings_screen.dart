import 'dart:async';

import 'package:cafe_analog_app/core/dialog.dart';
import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:cafe_analog_app/features/login/login.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// Legal documents are hosted on the Café Analog website (single source of
/// truth, also referenced from App Store Connect / Play Console).
const _privacyPolicyUrl = 'https://www.cafeanalog.dk/privacy-policy';
const _termsOfServiceUrl = 'https://www.cafeanalog.dk/terms';

class SettingsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Settings',
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
              ProfileFailure(:final reason) => _SettingsFailure(reason: reason),
              ProfileLoaded(:final profile) ||
              ProfileRefreshing(
                :final profile,
              ) => _SettingsContent(profile: profile),
            };
          },
        ),
      ],
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const new({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileCard(profile: profile),
        const SectionTitle('Account'),
        ListTile(
          leading: const Icon(Icons.email_outlined),
          title: const Text('Email'),
          subtitle: Text(profile.email),
          onTap: () => context.go('/settings/change-email'),
        ),
        ListTile(
          leading: const Icon(Icons.badge_outlined),
          title: const Text('User ID'),
          subtitle: Text('${profile.id}'),
          trailing: const Icon(Icons.copy, size: 20),
          onTap: () => _onCopyUserIdTap(context),
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text('Log out'),
          onTap: () => _confirmLogOut(context),
        ),
        const Gap(24),
        const SectionTitle('About'),
        ListTile(
          leading: const Icon(Icons.storefront_outlined),
          title: const Text('Opening hours'),
          subtitle: Text(
            '${weekdayNames[DateTime.now().weekday]}: '
            '${openingHoursLabel(DateTime.now().weekday)}',
          ),
          onTap: () => context.go('/settings/opening-hours'),
        ),
        const ListTile(
          leading: Icon(Icons.chat_outlined),
          title: Text('Contact us'),
          subtitle: Text('Report a bug or give us feedback'),
        ),
        ListTile(
          leading: const Icon(Icons.favorite_outline),
          title: const Text('Credits'),
          onTap: () => context.go('/settings/credits'),
        ),
        const Gap(24),
        const SectionTitle('Legal'),
        ListTile(
          leading: const Icon(Icons.article_outlined),
          title: const Text('Privacy policy'),
          onTap: () => _openLegalPage(
            context,
            url: _privacyPolicyUrl,
            documentName: 'privacy policy',
          ),
        ),
        ListTile(
          leading: const Icon(Icons.gavel_outlined),
          title: const Text('Terms of service'),
          onTap: () => _openLegalPage(
            context,
            url: _termsOfServiceUrl,
            documentName: 'terms of service',
          ),
        ),
        ListTile(
          leading: const Icon(Icons.code_outlined),
          title: const Text('Licenses'),
          onTap: () => context.go('/settings/licenses'),
        ),
        const Gap(24),
        const SectionTitle('Danger zone'),
        ListTile(
          leading: const Icon(Icons.delete_outline),
          title: const Text('Delete my account'),
          iconColor: Theme.of(context).colorScheme.error,
          textColor: Theme.of(context).colorScheme.error,
          onTap: () => _onDeleteAccountTap(context),
        ),
      ],
    );
  }

  Future<void> _onCopyUserIdTap(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: '${profile.id}'));
    if (!context.mounted) return;
    showSnackBar(context: context, message: 'User ID copied to clipboard');
  }

  Future<void> _openLegalPage(
    BuildContext context, {
    required String url,
    required String documentName,
  }) async {
    final launched = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppBrowserView,
    );
    if (!launched && context.mounted) {
      showSnackBar(
        context: context,
        message: 'Could not open the $documentName',
      );
    }
  }

  Future<void> _onDeleteAccountTap(BuildContext context) async {
    final confirm = await showAnalogDialog<bool>(
      context: context,
      title: 'Delete account',
      content:
          'Performing this action will delete your account and any tickets '
          'you own.\n\nThis cannot be undone.\n\nAre you sure you want to '
          'proceed?',
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: const Text('Delete'),
        ),
      ],
    );
    if (confirm != true) return;
    if (!context.mounted) return;

    final dismissLoadingOverlay = showLoadingOverlay(context);

    final result = await context.read<ProfileCubit>().requestAccountDeletion();
    if (!context.mounted) return;
    dismissLoadingOverlay(context);

    result.match(
      (failure) => showSnackBar(context: context, message: failure.reason),
      (_) => _showDeletionRequestedDialog(context, profile.email),
    );
  }

  Future<void> _showDeletionRequestedDialog(
    BuildContext context,
    String email,
  ) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Delete account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'We have sent a verification link to $email.\n\n'
          'Please confirm your request to delete your account using the '
          'provided link.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;
    await context.read<AuthCubit>().logOut();
  }
}

/// Shown when the profile fails to load.
///
/// Keeps "Log out" reachable so a broken session (e.g. a stale JWT after an
/// email change) can always recover by logging in again.
class _SettingsFailure extends StatelessWidget {
  const new({required this.reason});

  final String reason;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FailureMessage(
          message: 'Failed to load profile: $reason',
          onRetry: () => context.read<ProfileCubit>().loadProfile(),
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text('Log out'),
          onTap: () => _confirmLogOut(context),
        ),
      ],
    );
  }
}

Future<void> _confirmLogOut(BuildContext context) async {
  final confirm = await showAnalogDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    actions: [
      TextButton(
        onPressed: () => context.pop(false),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => context.pop(true),
        child: const Text('Log out'),
      ),
    ],
  );
  if (confirm != true) return;
  if (!context.mounted) return;
  await context.read<AuthCubit>().logOut();
}
