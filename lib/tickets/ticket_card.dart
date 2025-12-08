import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    required this.name,
    required this.clipsLeft,
    required this.backgroundImage,
    this.onTap,
    super.key,
  });

  final String name;
  final int clipsLeft;
  final String backgroundImage;
  final void Function()? onTap;

  static const double _cardHeight = 150;
  static const double _borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'ticket_$name',
      child: _Tappable(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Stack(
            children: [
              // Background grid pattern
              CustomPaint(
                size: const Size(double.infinity, _cardHeight),
                painter: _TicketBackgroundPainter(
                  color: Theme.of(context).colorScheme.scrim,
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.secondary.withAlpha(165),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              // Content
              Container(
                padding: const EdgeInsets.all(24),
                height: _cardHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.local_cafe,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        Text(
                          '$clipsLeft ticket${clipsLeft == 1 ? '' : 's'} left',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
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

class _TicketBackgroundPainter extends CustomPainter {
  _TicketBackgroundPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const gridSize = 30.0;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_TicketBackgroundPainter oldDelegate) => false;
}
