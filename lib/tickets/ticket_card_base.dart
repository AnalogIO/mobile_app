import 'package:flutter/material.dart';

class TicketCardBase extends StatelessWidget {
  const TicketCardBase({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.children,
    this.onTap,
    super.key,
  });

  /// Ticket id. Is the unique identifier for Hero animations
  final int id;
  final String name;
  final String backgroundImage;
  final List<Widget> children;
  final void Function()? onTap;

  static const double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Hero(
      tag: 'ticket_$id',
      child: _Tappable(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Stack(
            children: [
              // Background graphic
              Positioned.fill(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    // darkened version of the secondary color
                    Color.alphaBlend(
                      Colors.black.withAlpha(150),
                      colorScheme.secondary,
                    ),
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient overlay to increase contrast for "X tickets left" text
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.secondary,
                        colorScheme.secondary.withAlpha(0),
                      ],
                      stops: const [0.3, 1],
                      begin: Alignment.bottomRight,
                      end: const Alignment(0.6, -1),
                    ),
                  ),
                ),
              ),
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
                        color: colorScheme.onSecondary,
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
