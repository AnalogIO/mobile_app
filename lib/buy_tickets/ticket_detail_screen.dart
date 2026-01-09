import 'package:cafe_analog_app/buy_tickets/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            expandedHeight: 220,
            collapsedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Image.asset(
                'assets/images/latteart.png',
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.3),
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                product.title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 36,
                  height: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (product.eligibleMenuItems != null) ...[
                    const Gap(24),
                    Text(
                      'This ticket can be spent on following products:\n'
                      '${product.eligibleMenuItems!.join(', ')}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
          // TODO(marfavi): This can proabbly be simplified
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onSecondary,
                    ),
                    child: Text(
                      'Buy ${product.numberOfTickets} tickets '
                      'for ${product.priceDKK} kr',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _GridPatternPainter extends CustomPainter {
//   const _GridPatternPainter({required this.lineColor});

//   final Color lineColor;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = lineColor.withAlpha(25)
//       ..strokeWidth = 1
//       ..style = PaintingStyle.stroke;

//     const gridSize = 40.0;

//     // Draw vertical lines
//     for (double x = 0; x <= size.width; x += gridSize) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
//     }

//     // Draw horizontal lines
//     for (double y = 0; y <= size.height; y += gridSize) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
