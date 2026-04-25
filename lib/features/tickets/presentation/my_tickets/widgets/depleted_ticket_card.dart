import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// A card shown when the user has run out of tickets of a specific type.
///
/// Displays a message prompting the user to buy more tickets or dismiss.
/// Uses [TicketCardBase] with muted colors for a less prominent appearance.
class DepletedTicketCard extends StatelessWidget {
  const DepletedTicketCard({required this.depletedGroup, super.key});

  final OwnedTicketGroup depletedGroup;

  String get backgroundImagePath {
    return depletedGroup.ticketName.toLowerCase().contains('filter')
        ? 'assets/images/beans_cropped.png'
        : 'assets/images/latteart_cropped.png';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TicketCardBase(
      id: depletedGroup.productId,
      title: Text(
        "You've run out of ${depletedGroup.ticketName} tickets",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      // choose background based on some rudimentary logic
      backgroundImagePath: backgroundImagePath,
      backgroundColor: colorScheme.surfaceContainerHighest,
      foregroundColor: colorScheme.onSurfaceVariant,
      backgroundGraphicOpacity: 0.5,
      children: [
        const Gap(36),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 8,
          children: [
            TextButton(
              onPressed: () => context
                  .read<OwnedTicketsCubit>()
                  .dismissDepletedTicket(depletedGroup.productId),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Dismiss',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ),
            _BuyMoreButton(
              depletedTicketGroup: depletedGroup,
            ),
          ],
        ),
      ],
    );
  }
}

class _BuyMoreButton extends StatelessWidget {
  const _BuyMoreButton({required this.depletedTicketGroup});

  final OwnedTicketGroup depletedTicketGroup;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<BuyTicketsCubit, BuyTicketsState>(
      builder: (context, state) {
        if (state is BuyTicketsLoaded) {
          final purchasableGroup = state.ticketGroups.firstWhereOrNull(
            (group) => group.id == depletedTicketGroup.productId,
          );
          // Show a "Buy more" button if the ticket group is
          // currently available for purchase
          if (purchasableGroup != null) {
            return FilledButton(
              onPressed: () => context.push(
                '/tickets/view-purchasable/${purchasableGroup.id}',
                extra: purchasableGroup,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                foregroundColor: colorScheme.onSecondary,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Buy more'),
            );
          }
        }
        // Show no button if the ticket group isn't currently purchasable or
        // if the purchase data hasn't loaded yet
        return const SizedBox.shrink();
      },
    );
  }
}
