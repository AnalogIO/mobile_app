import 'dart:async';

import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/tickets/buy_tickets/bloc/buy_tickets_cubit.dart';
import 'package:cafe_analog_app/tickets/catalog/data/ticket_catalog_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BuyTicketsScreen extends StatelessWidget {
  const BuyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = BuyTicketsCubit(
          ticketCatalogRepository: context.read<TicketCatalogRepository>(),
        );
        unawaited(cubit.loadProducts());
        return cubit;
      },
      child: BlocBuilder<BuyTicketsCubit, BuyTicketsState>(
        builder: (context, state) {
          return switch (state) {
            BuyTicketsInitial() || BuyTicketsLoading() => const Screen.withBody(
              name: 'Buy tickets',
              body: Center(
                child: AnalogCircularProgressIndicator(spinnerColor: .dark),
              ),
            ),
            BuyTicketsFailure(:final reason) => Screen.withBody(
              name: 'Buy tickets',
              body: Center(child: Text('Failed to load products: $reason')),
            ),
            BuyTicketsLoaded(:final products) => Screen.listView(
              name: 'Buy tickets',
              children: products.map((product) {
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(
                    '${product.numberOfTickets} tickets'
                    ' • ${product.priceDKK} kr',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    unawaited(
                      context.push(
                        '/tickets/buy/ticket/${product.title}',
                        extra: product,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          };
        },
      ),
    );
  }
}
