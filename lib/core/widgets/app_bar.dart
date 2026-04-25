import 'package:cafe_analog_app/features/login/data/authentication_token_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalogAppBar({
    required this.title,
    required this.forceShowBackButton,
    this.onBrightnessChanged,
    super.key,
  });

  final String title;
  final bool forceShowBackButton;
  final void Function(Brightness)? onBrightnessChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 25,
      ),
      centerTitle: false,
      // Addresses a bug in go_router where the back button doesn't appear
      // on some screens (https://github.com/flutter/flutter/issues/144687).
      // TODO(marfavi): Create GitHub issue to track this and remove this
      //  workaround if/when it's fixed.
      leading: forceShowBackButton ? BackButton(onPressed: context.pop) : null,
      actions: [
        if (kDebugMode)
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final newBrightness = isDark ? Brightness.light : Brightness.dark;
              onBrightnessChanged?.call(newBrightness);
            },
          ),
        if (kDebugMode)
          IconButton(
            icon: const Icon(Icons.construction_rounded),
            tooltip: 'Invalidate JWT',
            onPressed: () async {
              final invalidateRefreshToken = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Invalidate tokens'),
                  content: const Text(
                    'Do you want to invalidate only the JWT '
                    'or also the refresh token?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      child: const Text('JWT only'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: const Text('JWT + refresh'),
                    ),
                  ],
                ),
              );

              if (invalidateRefreshToken == null) return;
              if (!context.mounted) return;

              final result = await context
                  .read<AuthTokenRepository>()
                  .invalidateJwt(invalidateRefreshToken: invalidateRefreshToken)
                  .run();

              if (!context.mounted) return;

              final message = result.match(
                (failure) => 'Failed to invalidate JWT: ${failure.reason}',
                (_) => invalidateRefreshToken
                    ? 'JWT and refresh token invalidated.'
                    : 'JWT invalidated (refresh token preserved).',
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          ),
      ],
    );
  }
}
