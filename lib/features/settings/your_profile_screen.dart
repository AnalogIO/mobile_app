import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:flutter/material.dart';

class YourProfileScreen extends StatelessWidget {
  const YourProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Your profile',
      children: [
        ListTile(
          title: const Text('Name'),
          subtitle: const Text('Monir'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Occupation'),
          subtitle: const Text('BSWU'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Appear anonymous'),
          isThreeLine: true,
          subtitle: const Text(
            'When enabled, your name will hidden from the leaderboard',
          ),
          trailing: Switch(
            value: false,
            onChanged: (value) {},
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
