import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/choice_chips.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen.listView(
      name: 'Receipts',
      onRefresh: () => context.read<ReceiptsCubit>().refreshReceipts(),
      children: [
        BlocBuilder<ReceiptsCubit, ReceiptsState>(
          builder: (context, state) {
            return switch (state) {
              ReceiptsInitial() || ReceiptsLoading() => const Padding(
                padding: .all(32),
                child: Center(
                  child: AnalogCircularProgressIndicator(spinnerColor: .dark),
                ),
              ),
              ReceiptsFailure(:final reason) => FailureMessage(
                message: 'Failed to load receipts: $reason',
                onRetry: () => context.read<ReceiptsCubit>().refreshReceipts(),
              ),
              ReceiptsLoaded(:final receipts) => _ReceiptsContent(
                receipts: receipts,
              ),
            };
          },
        ),
      ],
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

    return Column(
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
