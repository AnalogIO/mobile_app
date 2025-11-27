import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:flutter/material.dart';

class BuyTicketsScreen extends StatelessWidget {
  const BuyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      name: 'Buy tickets',
      children: [
        ListTile(
          leading: const Icon(Icons.local_cafe),
          title: const Text('Fancy'),
          subtitle: const Text('5 tickets • 150 kr'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.local_cafe),
          title: const Text('Large'),
          subtitle: const Text('5 tickets • 100 kr'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.local_cafe),
          title: const Text('Small'),
          subtitle: const Text('5 tickets • 50 kr'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.local_cafe),
          title: const Text('Filter'),
          subtitle: const Text('10 tickets • 110 kr'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.local_cafe),
          title: const Text('Tea'),
          subtitle: const Text('10 tickets • 100 kr'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ],
    );
  }
}
