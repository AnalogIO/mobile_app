import 'package:cafe_analog_app/tickets/buy_tickets/product.dart';
import 'package:cafe_analog_app/tickets/my_tickets/bloc/owned_tickets_cubit.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/ui/depleted_ticket_card.dart';
import 'package:cafe_analog_app/tickets/my_tickets/ui/no_tickets_placeholder.dart';
import 'package:cafe_analog_app/tickets/my_tickets/ui/owned_ticket_card.dart';
import 'package:cafe_analog_app/tickets/use_ticket/ui/use_ticket_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyTicketsSection extends StatelessWidget {
  const MyTicketsSection({required this.ownedTickets, super.key});

  final List<OwnedTicket> ownedTickets;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnedTicketsCubit, OwnedTicketsState>(
      builder: (context, state) {
        final cubit = context.read<OwnedTicketsCubit>();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: ownedTickets.isEmpty
              ? const NoTicketsPlaceholder()
              : ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  onReorderStart: (_) => HapticFeedback.mediumImpact(),
                  onReorder: cubit.reorderTickets,
                  // By default the ProxyDecorator adds a drop shadow to the
                  // item being dragged, which we don't want because it exposes
                  // the card's rounded corners and bottom padding poorly
                  // against the background. We override it to display no shadow
                  proxyDecorator: (child, index, animation) => child,
                  itemCount: ownedTickets.length,
                  itemBuilder: (context, index) {
                    // A ticket that a user owns or has owned in the past.
                    final ticket = ownedTickets[index];

                    return Container(
                      key: ValueKey(ticket.productId),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: !ticket.isDepleted
                          ? OwnedTicketCard.fromOwnedTicket(
                              ticket: ticket,
                              onTap: () => UseTicketModal.show(
                                context: context,
                                ticketId: ticket.productId,
                                ticketName: ticket.ticketName,
                                backgroundImagePath: ticket.backgroundImagePath,
                              ),
                            )
                          : DepletedTicketCard(
                              id: ticket.productId,
                              ticketName: ticket.ticketName,
                              backgroundImagePath:
                                  'assets/images/beans_cropped.png',
                              onBuyMore: (productId) => context.push(
                                '/tickets/buy/ticket/$productId',
                                // FIXME(marfavi): Don't pass extra data;
                                //  the route should get the product info itself
                                extra: const Product(
                                  title: '',
                                  description: '',
                                  numberOfTickets: 0,
                                  priceDKK: 0,
                                  eligibleMenuItems: ['Nothing'],
                                ),
                              ),
                              onDismiss: cubit.dismissDepletedTicket,
                            ),
                    );
                  },
                ),
        );
      },
    );
  }
}
