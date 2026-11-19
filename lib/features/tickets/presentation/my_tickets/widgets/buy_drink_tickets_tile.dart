import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class BuyDrinkTicketsTile extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.local_cafe),
      title: const Text('Buy drink tickets'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/tickets/view-purchasable'),
    );
  }
}
