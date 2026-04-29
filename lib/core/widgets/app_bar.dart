import 'package:cafe_analog_app/core/dialog.dart';
import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/features/login/data/authentication_token_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum _DebugAction { overlay, toggleTheme, invalidateJwt }

class AnalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalogAppBar({
    required this.title,
    this.onBrightnessChanged,
    super.key,
  });

  final String title;
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
      actions: [
        if (kDebugMode)
          PopupMenuButton<_DebugAction>(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Debug actions',
            onSelected: (action) async {
              switch (action) {
                case _DebugAction.overlay:
                  final dismissLoadingOverlay = showLoadingOverlay(context);
                  Future.delayed(const Duration(seconds: 1), () {
                    if (context.mounted) {
                      context.go('/settings');
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      if (context.mounted) {
                        context.go('/receipts/');
                      }
                      Future.delayed(const Duration(seconds: 1), () {
                        if (context.mounted) {
                          dismissLoadingOverlay(context);
                        }
                      });
                    });
                  });
                case _DebugAction.toggleTheme:
                  final newBrightness = isDark
                      ? Brightness.light
                      : Brightness.dark;
                  onBrightnessChanged?.call(newBrightness);
                case _DebugAction.invalidateJwt:
                  final invalidateRefreshToken = await showAnalogDialog<bool>(
                    context: context,
                    title: 'Invalidate tokens',
                    content:
                        'Do you want to invalidate only the JWT '
                        'or also the refresh token?',
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pop(false),
                        child: const Text('JWT only'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pop(true),
                        child: const Text('JWT + refresh'),
                      ),
                    ],
                  );

                  if (invalidateRefreshToken == null) return;
                  if (!context.mounted) return;

                  final result = await context
                      .read<AuthTokenRepository>()
                      .invalidateJwt(
                        invalidateRefreshToken: invalidateRefreshToken,
                      )
                      .run();

                  if (!context.mounted) return;

                  final message = result.match(
                    (failure) => 'Failed to invalidate JWT: ${failure.reason}',
                    (_) => invalidateRefreshToken
                        ? 'JWT and refresh token invalidated.'
                        : 'JWT invalidated (refresh token preserved).',
                  );

                  showSnackBar(context: context, message: message);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<_DebugAction>(
                value: _DebugAction.overlay,
                child: Row(
                  children: [
                    Icon(Icons.lan_rounded),
                    SizedBox(width: 12),
                    Text('Check loading overlay'),
                  ],
                ),
              ),
              PopupMenuItem<_DebugAction>(
                value: _DebugAction.toggleTheme,
                child: Row(
                  children: [
                    const Icon(Icons.brightness_6),
                    const SizedBox(width: 12),
                    Text(isDark ? 'Switch to light' : 'Switch to dark'),
                  ],
                ),
              ),
              const PopupMenuItem<_DebugAction>(
                value: _DebugAction.invalidateJwt,
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app_rounded),
                    SizedBox(width: 12),
                    Text('Invalidate JWT'),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
