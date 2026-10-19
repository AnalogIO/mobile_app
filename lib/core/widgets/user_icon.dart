import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon.large({
    required this.id,
    this.icon,
    this.background,
    super.key,
  }) : size = 100;

  const UserIcon.small({
    required this.id,
    this.icon,
    this.background,
    super.key,
  }) : size = 40;

  /// The palette of profile picture background colors.
  static const colors = [
    Color(0xffedd8e9), // lavender
    Color(0xfff3c9c2), // blush
    Color(0xffdce0c7), // sage
    Color(0xffcbc7eb), // lilac
    Color(0xffd5b6a8), // tan
    Color(0xffa0dab5), // mint
    Color(0xffb9e0d8), // teal
    Color(0xffF4E7B8), // pastel yellow
    Color(0xff9fcee8), // sky blue
    Color(0xffb9c8e8), // periwinkle
  ];

  /// Number of available profile picture icons.
  static const iconCount = 10;

  final int id;

  /// The user's chosen profile picture icon, or null to derive one from [id].
  final int? icon;

  /// The user's chosen background color index, or null to derive it from [id].
  final int? background;

  final double size;

  @override
  Widget build(BuildContext context) {
    final image = icon ?? id % iconCount;
    final color = colors[(background ?? id) % colors.length];

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        CoffeeImage.fromId(image: image, size: size),
      ],
    );
  }
}

class CoffeeImage extends StatelessWidget {
  const CoffeeImage.fromId({
    required this.image,
    required this.size,
    super.key,
  });

  final int image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: Image.asset('assets/profile_icons/coffee$image.png'),
    );
  }
}
