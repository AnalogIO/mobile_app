import 'package:cafe_analog_app/features/receipts/data/data.dart';
import 'package:cafe_analog_app/features/receipts/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'receipts_state.dart';

/// Cubit responsible for managing the state of the user's receipts.
///
/// Receipts are fetched newest-first in pages. [loadReceipts] is both the
/// initial load and the refresh; [loadMoreReceipts] appends the next page.
class ReceiptsCubit extends Cubit<ReceiptsState> {
  new({required this._repository}) : super(const ReceiptsInitial());

  final ReceiptsRepository _repository;

  /// Loads the first page of receipts, or refreshes an already loaded list.
  Future<void> loadReceipts() async {
    final currentState = state;
    if (currentState is ReceiptsLoading ||
        currentState is ReceiptsRefreshing ||
        currentState is ReceiptsLoadingMore) {
      return;
    }

    if (currentState is ReceiptsLoaded) {
      emit(
        ReceiptsRefreshing(
          receipts: currentState.receipts,
          continuationToken: currentState.continuationToken,
          hasMore: currentState.hasMore,
        ),
      );
    } else {
      emit(const ReceiptsLoading());
    }

    await _repository
        .fetchReceipts(type: GetReceiptsType.all)
        .match(
          (failure) => emit(ReceiptsFailure(reason: failure.reason)),
          (batch) => emit(
            ReceiptsLoaded(
              receipts: batch.receipts,
              continuationToken: batch.continuationToken,
              hasMore: batch.hasMore,
            ),
          ),
        )
        .run();
  }

  /// Loads the next page and appends it to the receipts already on screen.
  ///
  /// A failed page keeps the current receipts visible and exposes
  /// [ReceiptsLoaded.loadMoreError] so the list can offer a retry.
  Future<void> loadMoreReceipts() async {
    final currentState = state;
    if (currentState is! ReceiptsLoaded ||
        currentState is ReceiptsRefreshing ||
        currentState is ReceiptsLoadingMore ||
        !currentState.hasMore) {
      return;
    }

    emit(
      ReceiptsLoadingMore(
        receipts: currentState.receipts,
        continuationToken: currentState.continuationToken,
        hasMore: currentState.hasMore,
      ),
    );

    await _repository
        .fetchReceipts(
          type: GetReceiptsType.all,
          continuationToken: currentState.continuationToken,
        )
        .match(
          (failure) => emit(
            ReceiptsLoaded(
              receipts: currentState.receipts,
              continuationToken: currentState.continuationToken,
              hasMore: currentState.hasMore,
              loadMoreError: failure.reason,
            ),
          ),
          (batch) => emit(
            ReceiptsLoaded(
              receipts: [...currentState.receipts, ...batch.receipts],
              continuationToken: batch.continuationToken,
              hasMore: batch.hasMore,
            ),
          ),
        )
        .run();
  }
}
