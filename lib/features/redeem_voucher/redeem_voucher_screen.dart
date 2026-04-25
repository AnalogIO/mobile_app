import 'package:cafe_analog_app/core/loading_overlay.dart';
import 'package:cafe_analog_app/core/widgets/form.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/tickets/data/data.dart';
import 'package:cafe_analog_app/features/tickets/presentation/my_tickets/bloc/owned_tickets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RedeemVoucherScreen extends StatelessWidget {
  const RedeemVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.withBody(
      name: 'Redeem voucher',
      body: AnalogForm(
        labelText: 'Voucher code',
        submitText: 'Redeem',
        errorMessage: 'Please enter a voucher code',
        onSubmit: (voucherCode, setError) async {
          showLoadingOverlay(context);

          final result = await context
              .read<TicketsRepository>()
              .redeemVoucher(voucherCode: voucherCode)
              .run();

          // Dismiss the loading overlay
          if (context.mounted) context.pop();

          result.match(
            (failure) => setError(failure.reason),
            (redeemedTicketGroup) {
              final _ = context.read<OwnedTicketsCubit>().refreshOwnedTickets();
              // TODO(marfavi): Can we do it prettier?
              // TODO(marfavi): Time to make a custom showDialog?
              final _ = showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Voucher redeemed successfully!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      'You have redeemed ${redeemedTicketGroup.ticketsLeft}x '
                      '${redeemedTicketGroup.ticketName} ticket(s).',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => context
                          ..pop()
                          ..go('/tickets'),
                        child: const Text('Back to Tickets'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
