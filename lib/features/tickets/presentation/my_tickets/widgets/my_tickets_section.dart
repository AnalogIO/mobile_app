import 'dart:async';

import 'package:cafe_analog_app/core/snackbar.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTicketsSection extends StatelessWidget {
  const MyTicketsSection({required this.ownedTicketGroups, super.key});

  final List<OwnedTicketGroup> ownedTicketGroups;

  Widget buildTicketCard(OwnedTicketGroup ticketGroup) {
    return Container(
      // key is required for ReorderableListView to track items when reordering
      key: ValueKey(ticketGroup.productId),
      margin: const EdgeInsets.only(bottom: 16),
      child: !ticketGroup.isDepleted
          ? OwnedTicketCard(ownedGroup: ticketGroup)
          : DepletedTicketCard(depletedGroup: ticketGroup),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnedTicketsCubit, OwnedTicketsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ownedTicketGroups.isEmpty
              ? const NoTicketsPlaceholder()
              : ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  onReorderStart: (_) {
                    showSnackBar(
                      context: context,
                      message: 'Hold and drag to reorder your tickets',
                    );
                    unawaited(HapticFeedback.mediumImpact());
                  },
                  onReorderItem: context
                      .read<OwnedTicketsCubit>()
                      .reorderTickets,
                  // By default the ProxyDecorator adds a drop shadow to the
                  // item being dragged, which we don't want because it exposes
                  // the card's rounded corners and bottom padding poorly
                  // against the background. We override it to display no shadow
                  proxyDecorator: (child, index, animation) => child,
                  children: ownedTicketGroups.map(buildTicketCard).toList(),
                ),
        );
      },
    );
  }
}
