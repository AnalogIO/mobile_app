import 'dart:async';

import 'package:cafe_analog_app/core/widgets/analog_circular_progress_indicator.dart';
import 'package:cafe_analog_app/core/widgets/choice_chips.dart';
import 'package:cafe_analog_app/core/widgets/failure_message.dart';
import 'package:cafe_analog_app/core/widgets/screen.dart';
import 'package:cafe_analog_app/features/receipts/receipts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReceiptsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // Prefetch the next page shortly before the end of the list. The cubit
        // guards against overlapping requests and against calling this when
        // there is no next page.
        final state = context.read<ReceiptsCubit>().state;
        if (notification.metrics.extentAfter < 300 &&
            state is ReceiptsLoaded &&
            state.hasMore &&
            state.loadMoreError == null &&
            state is! ReceiptsRefreshing) {
          unawaited(context.read<ReceiptsCubit>().loadMoreReceipts());
        }
        return false;
      },
      child: Screen.listView(
        name: 'Receipts',
        onRefresh: () => context.read<ReceiptsCubit>().loadReceipts(),
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
                  onRetry: () => context.read<ReceiptsCubit>().loadReceipts(),
                ),
                ReceiptsLoadingMore(:final receipts) => _ReceiptsContent(
                  receipts: receipts,
                  hasMore: true,
                  isLoadingMore: true,
                  loadMoreError: null,
                  onRetryLoadMore: null,
                ),
                ReceiptsLoaded(
                  :final receipts,
                  :final hasMore,
                  :final loadMoreError,
                ) =>
                  _ReceiptsContent(
                    receipts: receipts,
                    hasMore: hasMore,
                    isLoadingMore: false,
                    loadMoreError: loadMoreError,
                    onRetryLoadMore: () =>
                        context.read<ReceiptsCubit>().loadMoreReceipts(),
                  ),
              };
            },
          ),
        ],
      ),
    );
  }
}

class _ReceiptsContent extends StatefulWidget {
  const new({
    required this.receipts,
    required this.hasMore,
    required this.isLoadingMore,
    required this.loadMoreError,
    required this.onRetryLoadMore,
  });

  final List<Receipt> receipts;
  final bool hasMore;
  final bool isLoadingMore;
  final String? loadMoreError;
  final VoidCallback? onRetryLoadMore;

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
        if (filteredReceipts.isEmpty && !widget.isLoadingMore)
          const Padding(padding: .all(32), child: Text('No receipts to show.')),
        ...filteredReceipts.map(
          (receipt) => ReceiptsListEntry(
            receipt: receipt,
            onTap: () => context.push('/receipts/details', extra: receipt),
          ),
        ),
        if (widget.isLoadingMore)
          const Padding(
            padding: .all(16),
            child: Center(
              child: AnalogCircularProgressIndicator(spinnerColor: .dark),
            ),
          )
        else if (widget.loadMoreError case final error?)
          Padding(
            padding: const .symmetric(vertical: 8),
            child: Column(
              children: [
                Text(
                  'Failed to load more receipts: $error',
                  textAlign: .center,
                ),
                TextButton(
                  onPressed: widget.onRetryLoadMore,
                  child: const Text('Try again'),
                ),
              ],
            ),
          )
        else if (!widget.hasMore && widget.receipts.isNotEmpty)
          const Padding(padding: .all(16), child: Text('No more receipts.')),
        const Gap(16),
      ],
    );
  }
}
