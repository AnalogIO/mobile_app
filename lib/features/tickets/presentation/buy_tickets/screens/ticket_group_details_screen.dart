import 'dart:async';

import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Screen that shows details about a [PurchasableTicketGroup], including a
/// button to purchase it.
///
/// This screen, unlike most other screens in the app, uses a
/// [CustomScrollView] with slivers to achieve the large app bar with the
/// background graphic.
class TicketGroupDetailsScreen extends StatelessWidget {
  const TicketGroupDetailsScreen({required this.ticketGroup, super.key});

  final PurchasableTicketGroup ticketGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _TicketGroupDetailsContent(ticketGroup: ticketGroup),
    );
  }
}

class _TicketGroupDetailsContent extends StatelessWidget {
  const _TicketGroupDetailsContent({required this.ticketGroup});

  final PurchasableTicketGroup ticketGroup;

  Future<void> _onBuyPressed(BuildContext context) async {
    final errorReason = await context.read<BuyTicketsCubit>().buyTicketGroup(
      ticketGroup,
    );

    if (!context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    if (errorReason == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Purchase flow started.')),
      );
      return;
    }

    messenger.showSnackBar(
      SnackBar(content: Text('Could not start purchase: $errorReason')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final eligibleDrinksText = ticketGroup.eligibleDrinks
        .map((drink) => drink.name)
        .join(', ');

    final buyButtonLabel =
        'Buy ${ticketGroup.numberOfTickets} tickets '
        'for ${ticketGroup.priceDKK} kr';

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _TicketGroupHeader(title: ticketGroup.title),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticketGroup.description,
                  style: textTheme.bodyLarge,
                ),
                if (ticketGroup.eligibleDrinks.isNotEmpty) ...[
                  const Gap(24),
                  Text(
                    'This ticket can be spent on the following drinks:\n'
                    '$eligibleDrinksText',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ),
        _PurchaseButtonSection(
          label: buyButtonLabel,
          onPressed: () => unawaited(_onBuyPressed(context)),
        ),
      ],
    );
  }
}

class _TicketGroupHeader extends StatelessWidget {
  const _TicketGroupHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar.large(
      // Addresses a bug in go_router where the back button doesn't appear
      // on some screens (https://github.com/flutter/flutter/issues/144687).
      leading: BackButton(onPressed: context.pop),
      expandedHeight: 220,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: ColorFiltered(
          colorFilter: ColorFilter.mode(
            colorScheme.secondary.withAlpha(15),
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
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 48),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 36,
                height: 1,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PurchaseButtonSection extends StatelessWidget {
  const _PurchaseButtonSection({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Fill the remaining space with empty space, with the button at the bottom.
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                foregroundColor: colorScheme.onSecondary,
              ),
              child: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}
