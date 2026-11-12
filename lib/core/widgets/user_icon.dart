import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const new large({required this.id, this.icon, this.background, super.key})
    : size = 100;

  const new small({required this.id, this.icon, this.background, super.key})
    : size = 40;

  /// The palette of profile picture background colors, in the same order as
  /// the backend's `ProfileBackgroundColor` enum.
  static const colors = [
    Color(0xffedd8e9), // LavenderPink
    Color(0xffbde7c6), // MintGreen
    Color(0xffdce0c7), // SageGreen
    Color(0xffcbc7eb), // Periwinkle
    Color(0xffc19b94), // DustyRose
    Color(0xffa0dab5), // Seafoam
    Color(0xfff8d9da), // BlushPink
    Color(0xffCDFCF6), // Aqua
    Color(0xff92BA92), // MossGreen
    Color(0xff86b4c3), // SteelBlue
  ];

  /// Number of available profile picture icons, in the same order as the
  /// backend's `ProfileIcon` enum and the `coffee<id>.png` assets.
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
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        CoffeeImage.fromId(image: image, size: size),
      ],
    );
  }
}

class CoffeeImage extends StatelessWidget {
  const new fromId({required this.image, required this.size, super.key});

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
