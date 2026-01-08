import 'package:flutter/material.dart';

class TicketCardBase extends StatelessWidget {
  const TicketCardBase({
    required this.name,
    required this.backgroundImage,
    required this.children,
    this.id = 'Fancy',
    this.onTap,
    super.key,
  });

  final String id;
  final String name;
  final String backgroundImage;
  final List<Widget> children;
  final void Function()? onTap;

  static const double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'ticket_$id',
      child: _Tappable(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Stack(
            children: [
              // positioned.fill helps fit the container properly with background image
              Positioned.fill(
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient overlay
              // Positioned.fill(
              //   child: DecoratedBox(
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           Theme.of(context).colorScheme.secondary,
              //           Theme.of(context).colorScheme.secondary.withAlpha(165),
              //         ],
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //       ),
              //     ),
              //   ),
              // ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...children,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tappable extends StatelessWidget {
  const _Tappable({
    required this.child,
    required this.borderRadius,
    this.onTap,
  });

  final Widget child;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onSecondary = Theme.of(context).colorScheme.onSecondary;
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        overlayColor: WidgetStateProperty.fromMap({
          WidgetState.hovered: onSecondary.withAlpha(15),
          WidgetState.focused: onSecondary.withAlpha(20),
          WidgetState.pressed: onSecondary.withAlpha(30),
        }),
        child: child,
      ),
    );
  }
}
