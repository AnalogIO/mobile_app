import 'package:flutter/material.dart';

/// A card displaying a ticket with a background graphic, title, and content.
///
/// Uses [Hero] animations with a unique tag based on [id].
class TicketCardBase extends StatelessWidget {
  const TicketCardBase({
    required this.id,
    required this.title,
    required this.backgroundImagePath,
    required this.children,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundGraphicOpacity = 1.0,
    this.onTap,
    super.key,
  });

  /// Unique identifier, used for Hero animation tag.
  final int id;

  /// The widget displayed at the top; the ticket or menu item name.
  final Widget title;

  /// Asset path for the background graphic.
  final String backgroundImagePath;

  /// Content widgets displayed below the name.
  final List<Widget> children;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Optional background color. Defaults to [ColorScheme.secondary].
  final Color? backgroundColor;

  /// Optional foreground color. Defaults to [ColorScheme.onSecondary].
  final Color? foregroundColor;

  /// Opacity for the background graphic. Defaults to 1.0 (fully visible).
  /// Use a lower value (e.g. 0.3) for a more subtle effect.
  final double backgroundGraphicOpacity;

  static const double _borderRadius = 24;

  WidgetStateProperty<Color?> _buildOverlayColor(Color baseColor) {
    return WidgetStateProperty.fromMap({
      WidgetState.hovered: baseColor.withAlpha(15),
      WidgetState.focused: baseColor.withAlpha(20),
      WidgetState.pressed: baseColor.withAlpha(30),
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = backgroundColor ?? colorScheme.secondary;
    final fgColor = foregroundColor ?? colorScheme.onSecondary;

    return Hero(
      tag: 'ticket_$id',
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            _BackgroundGraphic(
              imagePath: backgroundImagePath,
              color: bgColor,
              opacity: backgroundGraphicOpacity,
            ),
            _GradientOverlay(color: bgColor),
            _Content(
              titleWidget: title,
              foregroundColor: fgColor,
              children: children,
            ),
            // InkWell on top so splash appears above background
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  overlayColor: _buildOverlayColor(fgColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays the background image with a darkened tint.
///
/// Uses [ColorFiltered] to apply the card's color to the image shape,
/// creating a subtle branded graphic effect.
class _BackgroundGraphic extends StatelessWidget {
  const _BackgroundGraphic({
    required this.imagePath,
    required this.color,
    required this.opacity,
  });

  final String imagePath;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    // Darken the base color for a subtle background effect
    final darkenedColor = Color.alphaBlend(Colors.black.withAlpha(30), color);

    return Positioned.fill(
      child: Opacity(
        opacity: opacity,
        child: ColorFiltered(
          // srcIn: uses the image's shape (alpha) and fills it with our color
          colorFilter: ColorFilter.mode(darkenedColor, BlendMode.srcIn),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

/// A gradient overlay that improves text readability in the bottom-right.
///
/// This is done using a linear gradient that uses the card's color at the
/// bottom-right and fades to transparent towards the top-left.
class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withAlpha(0)],
            stops: const [0.3, 1],
            begin: Alignment.bottomRight,
            end: const Alignment(0.6, -1),
          ),
        ),
      ),
    );
  }
}

/// The card's text content: title and children.
class _Content extends StatelessWidget {
  const _Content({
    required this.titleWidget,
    required this.foregroundColor,
    required this.children,
  });

  final Widget titleWidget;
  final Color foregroundColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultTextStyle(
            style: TextStyle(
              color: foregroundColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            child: titleWidget,
          ),
          ...children,
        ],
      ),
    );
  }
}
