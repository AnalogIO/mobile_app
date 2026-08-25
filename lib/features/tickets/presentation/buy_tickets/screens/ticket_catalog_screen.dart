import 'dart:async';

import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TicketCatalogScreen extends StatelessWidget {
  const TicketCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Buy tickets',
      onRefresh: () => context.read<TicketCatalogCubit>().loadProducts(),
      children: [
        BlocBuilder<TicketCatalogCubit, TicketCatalogState>(
          builder: (context, state) {
            return switch (state) {
              TicketCatalogInitial() || TicketCatalogLoading() => const Padding(
                padding: .all(32),
                child: Center(
                  child: AnalogCircularProgressIndicator(spinnerColor: .dark),
                ),
              ),
              TicketCatalogFailure(:final reason) => FailureMessage(
                message: 'Failed to load products: $reason',
                onRetry: () =>
                    context.read<TicketCatalogCubit>().loadProducts(),
              ),
              TicketCatalogLoaded(:final ticketGroups) => Column(
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
        ),
      ],
    );
  }
}
