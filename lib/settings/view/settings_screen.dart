import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/core/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Settings',
      children: [
        const SectionTitle('Account'),
        ListTile(
          leading: const Icon(Icons.password),
          title: const Text('Passcode'),
          subtitle: const Text('Tap to change'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('User ID'),
          subtitle: const Text('1234'),
          trailing: const Icon(Icons.copy, size: 20),
          onTap: () {
            Clipboard.setData(const ClipboardData(text: '1234'));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User ID copied to clipboard')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.card_giftcard),
          title: const Text('Redeem voucher'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text('Log out'),
          onTap: () {},
        ),
        const Gap(24),
        const SectionTitle('About'),
        ListTile(
          leading: const Icon(Icons.storefront_outlined),
          title: const Text('Opening hours'),
          subtitle: const Text('Mondays: 08:00-16:00'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.question_mark_outlined),
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
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy policy'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.code),
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
}
