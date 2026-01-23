import 'package:cafe_analog_app/tickets/buy_tickets/product.dart';
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
              background: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary.withAlpha(15),
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'assets/images/latteart_cropped.png',
                  fit: BoxFit.cover,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              // FittedBox and Padding prevents overflow when title is too long
              // (or more realistically, when accessibility font size is used)
              title: FittedBox(
                fit: .scaleDown,
                child: Padding(
                  padding: const .only(right: 16, top: 48),
                  child: Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: .w800,
                      fontSize: 36,
                      height: 1,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
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
