import 'package:cafe_analog_app/features/receipts/data/data.dart';
import 'package:cafe_analog_app/features/receipts/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'receipts_state.dart';

/// Cubit responsible for managing the state of the user's receipts.
///
/// This includes fetching receipts from the API, handling loading
/// and error states, and managing pagination using continuation tokens.
class ReceiptsCubit extends Cubit<ReceiptsState> {
  ReceiptsCubit({required this._repository}) : super(const ReceiptsInitial());

  final ReceiptsRepository _repository;

  /// Fetches receipts when they are not already loaded.
  ///
  /// Does nothing if receipts are already loaded or loading.
  Future<void> getReceipts({
    String? type,
    int? batchSize,
  }) async {
    final currentState = state;
    if (currentState is ReceiptsLoading || currentState is ReceiptsLoaded) {
      return;
    }

    emit(const ReceiptsLoading());
    return _repository
        .fetchReceipts(type: GetReceiptsType.all)
        .match(
          (failure) => ReceiptsFailure(reason: failure.reason),
          (receipts) => ReceiptsLoaded(
            receipts: receipts,
            continuationToken: '', // We'll get this from the API response later
          ),
        )
        .map(emit)
        .run();
  }

  /// Refreshes the receipts by fetching the latest data from the API.
  Future<void> refreshReceipts({
    String? type,
    int? batchSize,
  }) async {
    final currentState = state;
    if (currentState is ReceiptsLoaded) {
      emit(
        ReceiptsRefreshing(
          receipts: currentState.receipts,
          continuationToken: currentState.continuationToken,
        ),
      );
    } else {
      emit(const ReceiptsLoading());
    }

    return _repository
        .fetchReceipts(type: GetReceiptsType.all)
        .match(
          (failure) => ReceiptsFailure(reason: failure.reason),
          (receipts) => ReceiptsLoaded(
            receipts: receipts,
            continuationToken: '', // We'll get this from the API response later
          ),
        )
        .map(emit)
        .run();
  }

  // /// Loads the next batch of receipts using the continuation token.
  // Future<void> loadMoreReceipts({
  //   String? type,
  //   int? batchSize,
  // }) async {
  //   final currentState = state;
  //   if (currentState is! ReceiptsLoaded) {
  //     return;
  //   }

  //   if (currentState.continuationToken.isEmpty) {
  //     // No more receipts to load
  //     return;
  //   }

  //   return _repository
  //       .fetchReceipts(
  //         type: type,
  //         batchSize: batchSize,
  //         continuationToken: currentState.continuationToken,
  //       )
  //       .match(
  //         (failure) => ReceiptsFailure(reason: failure.reason),
  //         (newReceipts) => ReceiptsLoaded(
  //           receipts: [...currentState.receipts, ...newReceipts],
  //           continuationToken: '', // We'll get this from the API response later
  //         ),
  //       )
  //       .map(emit)
  //       .run();
  // }
}
