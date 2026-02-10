import 'dart:async';

import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/tickets/my_tickets/bloc/owned_tickets_cubit.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_ticket.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_local_data_provider.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_remote_data_provider.dart';
import 'package:cafe_analog_app/tickets/my_tickets/data/owned_tickets_repository.dart';
import 'package:cafe_analog_app/tickets/my_tickets/ui/my_tickets_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _OwnedTicketsCubitProvider(
      child: BlocBuilder<OwnedTicketsCubit, OwnedTicketsState>(
        builder: (context, state) {
          return switch (state) {
            OwnedTicketsInitial() => const Scaffold(),
            OwnedTicketsLoading() => const _LoadingScreen(),
            OwnedTicketsFailure(:final reason) => _FailureScreen(reason),
            OwnedTicketsLoaded(:final ownedTickets) => _SuccessScreen(
              ownedTickets,
            ),
          };
        },
      ),
    );
  }
}

class _SuccessScreen extends StatelessWidget {
  const _SuccessScreen(this.ownedTickets);

  final List<OwnedTicket> ownedTickets;

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Tickets',
      onRefresh: context.read<OwnedTicketsCubit>().refreshOwnedTickets,
      children: [
        MyTicketsSection(ownedTickets: ownedTickets),
        const _BuyDrinkTicketsTile(),
        const _RedeemCodeTile(),
      ],
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Screen.withBody(
      name: 'Tickets',
      body: Center(child: AnalogCircularProgressIndicator(spinnerColor: .dark)),
    );
  }
}

class _FailureScreen extends StatelessWidget {
  const _FailureScreen(this.reason);

  final String reason;

  @override
  Widget build(BuildContext context) {
    return Screen.withBody(
      name: 'Tickets',
      body: Center(child: Text('Error loading tickets: $reason')),
    );
  }
}

class _OwnedTicketsCubitProvider extends StatelessWidget {
  const _OwnedTicketsCubitProvider({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = OwnedTicketsCubit(
          ownedTicketsRepository: OwnedTicketsRepository(
            remoteDataProvider: OwnedTicketsRemoteDataProvider(
              executor: context.read(),
            ),
            localDataProvider: OwnedTicketsLocalDataProvider(
              localStorage: context.read(),
            ),
          ),
        );
        unawaited(cubit.getOwnedTickets());
        return cubit;
      },
      child: child,
    );
  }
}

class _BuyDrinkTicketsTile extends StatelessWidget {
  const _BuyDrinkTicketsTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.local_cafe),
      title: const Text('Buy drink tickets'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/tickets/buy'),
    );
  }
}

class _RedeemCodeTile extends StatelessWidget {
  const _RedeemCodeTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.card_giftcard),
      title: const Text('Redeem a code'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/tickets/redeem_voucher'),
    );
  }
}
