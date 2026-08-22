import 'dart:async';

import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/choice_chips.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ReceiptsCubitProvider(
      child: BlocBuilder<ReceiptsCubit, ReceiptsState>(
        builder: (context, state) {
          return switch (state) {
            ReceiptsLoading() => const Screen.withBody(
              name: 'Receipts',
              body: Center(
                child: AnalogCircularProgressIndicator(spinnerColor: .dark),
              ),
            ),
            ReceiptsFailure(:final reason) => Screen.listView(
              name: 'Receipts',
              children: [
                const Gap(16),
                Center(child: Text('Error loading receipts: $reason')),
              ],
            ),
            ReceiptsLoaded(:final receipts) => _ReceiptsContent(
              receipts: receipts,
            ),
            ReceiptsInitial() || ReceiptsRefreshing() => Screen.listView(
              name: 'Receipts',
              children: const [
                Gap(16),
                Center(
                  child: AnalogCircularProgressIndicator(spinnerColor: .dark),
                ),
              ],
            ),
          };
        },
      ),
    );
  }
}

class _ReceiptsContent extends StatefulWidget {
  const _ReceiptsContent({required this.receipts});

  final List<Receipt> receipts;

  @override
  State<_ReceiptsContent> createState() => _ReceiptsContentState();
}

class _ReceiptsContentState extends State<_ReceiptsContent> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    // Filter receipts based on selected filter
    final filteredReceipts = switch (_selectedFilter) {
      0 => widget.receipts, // Show all
      1 =>
        widget.receipts
            .whereType<UsedTicketReceipt>()
            .toList(), // Ticket swipes
      2 => widget.receipts.whereType<PurchaseReceipt>().toList(), // Purchases
      3 => widget.receipts.whereType<VoucherReceipt>().toList(), // Vouchers
      _ => widget.receipts, // Show all
    };

    return Screen.listView(
      name: 'Receipts',
      onRefresh: context.read<ReceiptsCubit>().refreshReceipts,
      children: [
        AnalogChoiceChips(
          labels: const ['Show all', 'Ticket swipes', 'Purchases', 'Vouchers'],
          selected: _selectedFilter,
          onChange: (newindex) {
            setState(() {
              _selectedFilter = newindex;
            });
          },
        ),
        ...filteredReceipts.map(
          (receipt) => ReceiptsListEntry(receipt: receipt),
        ),
        const Gap(16),
      ],
    );
  }
}

class _ReceiptsCubitProvider extends StatelessWidget {
  const _ReceiptsCubitProvider({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ReceiptsRepository(
        receiptsApi: ReceiptsApi(executor: context.read()),
      ),
      child: BlocProvider(
        create: (context) {
          final cubit = ReceiptsCubit(repository: context.read());
          unawaited(cubit.getReceipts());
          return cubit;
        },
        child: child,
      ),
    );
  }
}
