import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    required this.name,
    required this.clipsLeft,
    required this.backgroundImage,
    super.key,
  });

  final String name;
  final int clipsLeft;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          image: DecorationImage(
            // TODO(marfavi): Load actual image
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                  Text(
                    '$clipsLeft clips left',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    Icons.local_cafe,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
