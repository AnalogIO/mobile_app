import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/tickets/tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Tickets',
      onRefresh: () => context.read<OwnedTicketsCubit>().loadOwnedTickets(),
      children: [
        BlocBuilder<OwnedTicketsCubit, OwnedTicketsState>(
          builder: (context, state) {
            return switch (state) {
              OwnedTicketsInitial() => const SizedBox.shrink(),
              OwnedTicketsLoading() => const Padding(
                padding: .all(32),
                child: Center(
                  child: AnalogCircularProgressIndicator(spinnerColor: .dark),
                ),
              ),
              OwnedTicketsFailure(:final reason) => FailureMessage(
                message: 'Failed to load tickets: $reason',
                onRetry: () =>
                    context.read<OwnedTicketsCubit>().loadOwnedTickets(),
              ),
              OwnedTicketsLoaded(:final ownedGroups) => Column(
                children: [
                  MyTicketsSection(ownedTicketGroups: ownedGroups),
                  const BuyDrinkTicketsTile(),
                  const RedeemCodeTile(),
                ],
              ),
            };
          },
        ),
      ],
    );
  }
}
