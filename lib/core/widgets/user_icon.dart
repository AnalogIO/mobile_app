import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon.large({required this.id, super.key}) : size = 100;
  const UserIcon.small({required this.id, super.key}) : size = 40;

  final int id;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xffedd8e9),
      const Color(0xffbde7c6),
      const Color(0xffdce0c7),
      const Color(0xffcbc7eb),
      const Color(0xffc19b94),
      const Color(0xffa0dab5),
      const Color(0xfff8d9da),
      const Color(0xffCDFCF6),
      const Color(0xff92BA92),
      const Color(0xff86b4c3),
    ];
    final images = [0, 1, 2, 3, 4, 5, 6, 7, 8];

    final image = id % images.length;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors[id % colors.length],
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
      // TODO(marfavi): Add coffee images assets and uncomment below
      // child: Image.asset('assets/profile_icons/coffee$image.png'),
    );
  }
}
