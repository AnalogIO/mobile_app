import 'dart:async';

import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:cafe_analog_app/login/bloc/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part 'profile_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Settings',
      children: [
        const _ProfileCard(
          name: 'Monir',
          occupation: 'BSWU',
        ),
        const SectionTitle('Account'),
        ListTile(
          leading: const Icon(Icons.email_outlined),
          title: const Text('Email'),
          subtitle: const Text('monir@example.com'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.badge_outlined),
          title: const Text('User ID'),
          subtitle: const Text('1234'),
          trailing: const Icon(Icons.copy, size: 20),
          onTap: () {
            unawaited(Clipboard.setData(const ClipboardData(text: '1234')));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User ID copied to clipboard')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text('Log out'),
          onTap: () => _onLogOutTap(context),
        ),
        const Gap(24),
        const SectionTitle('About'),
        ListTile(
          leading: const Icon(Icons.storefront_outlined),
          title: const Text('Opening hours'),
          subtitle: const Text('Mondays: 08:00-15:30'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Frequently Asked Questions'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.chat_outlined),
          title: const Text('Contact us'),
          subtitle: const Text('Report a bug or give us feedback'),
          onTap: () {},
        ),
        const Gap(24),
        const SectionTitle('Legal'),
        ListTile(
          leading: const Icon(Icons.article_outlined),
          title: const Text('Privacy policy'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.code_outlined),
          title: const Text('Credits and licenses'),
          onTap: () {},
        ),
        const Gap(24),
        const SectionTitle('Danger zone'),
        ListTile(
          leading: const Icon(Icons.delete_outline),
          title: const Text('Delete my account'),
          iconColor: Theme.of(context).colorScheme.error,
          textColor: Theme.of(context).colorScheme.error,
          onTap: () {},
        ),
      ],
    );
  }

  Future<void> _onLogOutTap(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Log out',
          style: TextStyle(fontWeight: .bold),
        ),
        content: const Text('Are you sure you want to log out?'),
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
      ),
    );
    if (confirm != true) return;
    if (!context.mounted) return;
    await context.read<AuthCubit>().logOut();
  }

  Future<void> _onLogOutTap(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Log out',
          style: TextStyle(fontWeight: .bold),
        ),
        content: const Text('Are you sure you want to log out?'),
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
      ),
    );
    if (confirm != true) return;
    if (!context.mounted) return;
    await context.read<AuthCubit>().logOut();
  }
}
