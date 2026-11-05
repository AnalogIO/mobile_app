import 'package:cafe_analog_app/core/widgets/user_icon.dart';
import 'package:cafe_analog_app/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileCard extends StatelessWidget {
  const new({required this.profile, super.key});

  final UserProfile profile;

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
          child: UserIcon.small(
            id: profile.id,
            icon: profile.profilePicture.iconId,
            background: profile.profilePicture.backgroundColorId,
          ),
        ),
        title: Text(
          profile.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          profile.occupation.isEmpty ? profile.email : profile.occupation,
        ),
        trailing: const Text('Edit profile'),
        onTap: () => context.go('/settings/your-profile'),
      ),
    );
  }
}
