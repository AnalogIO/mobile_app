import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class RedeemCodeTile extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.card_giftcard),
      title: const Text('Redeem a code'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/tickets/redeem-voucher'),
    );
  }
}
