import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/tickets/my_tickets/my_tickets_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  Future<void> _refreshTickets() async {
    // TODO(marfavi): Add actual refresh logic
    await Future<void>.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Tickets',
      onRefresh: _refreshTickets,
      children: [
        const MyTicketsSection(),
        ListTile(
          leading: const Icon(Icons.local_cafe),
          title: const Text('Buy drink tickets'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/tickets/buy'),
        ),
        ListTile(
          leading: const Icon(Icons.card_giftcard),
          title: const Text('Redeem a code'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/tickets/redeem_voucher'),
        ),
      ],
    );
  }
}
