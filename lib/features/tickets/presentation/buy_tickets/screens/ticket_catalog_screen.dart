import 'dart:async';

import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TicketCatalogScreen extends StatelessWidget {
  const TicketCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCatalogCubit, TicketCatalogState>(
      builder: (context, state) {
        return switch (state) {
          TicketCatalogInitial() ||
          LoadingTicketCatalog() => const Screen.withBody(
            name: 'Buy tickets',
            body: Center(
              child: AnalogCircularProgressIndicator(spinnerColor: .dark),
            ),
          ),
          TicketCatalogLoadFailure(:final reason) => Screen.withBody(
            name: 'Buy tickets',
            body: Center(child: Text('Failed to load products: $reason')),
            // FIXME: Add retry button
          ),
          TicketCatalogLoaded(:final ticketGroups) => Screen.listView(
            name: 'Buy tickets',
            children: ticketGroups.map((ticketGroup) {
              return ListTile(
                title: Text(ticketGroup.title),
                subtitle: Text(
                  '${ticketGroup.numberOfTickets} tickets'
                  ' • ${ticketGroup.priceDKK} kr',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  final id = ticketGroup.id;
                  unawaited(
                    context.push(
                      '/tickets/view-purchasable/$id',
                      extra: ticketGroup,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        };
      },
    );
  }
}
