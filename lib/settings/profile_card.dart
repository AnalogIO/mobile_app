part of 'settings_screen.dart';

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.name,
    required this.occupation,
  });

  final String name;
  final String occupation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const .only(left: 16, right: 16, bottom: 24, top: 8),
      child: ListTile(
        tileColor: colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(borderRadius: .circular(24)),
        visualDensity: .compact,
        leading: CircleAvatar(
          backgroundColor: colorScheme.surfaceContainerLow,
          child: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
        ),
        title: Text(name, style: const TextStyle(fontWeight: .bold)),
        subtitle: Text(occupation),
        trailing: const Text('Edit profile'),
        onTap: () => context.go('/settings/your-profile'),
      ),
    );
  }
}
