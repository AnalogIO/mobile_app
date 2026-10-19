part of 'receipts_cubit.dart';

sealed class ReceiptsState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class ReceiptsInitial extends ReceiptsState {
  const new();
}

final class ReceiptsLoading extends ReceiptsState {
  const new();
}

final class ReceiptsLoaded extends ReceiptsState {
  const new({
    required this.receipts,
    required this.continuationToken,
    required this.hasMore,
    this.loadMoreError,
  });

  /// List of receipts (purchases, swipes, vouchers), newest first.
  final List<Receipt> receipts;

  /// Token for fetching the next batch of receipts (pagination).
  final String continuationToken;

  /// Whether the API returned a non-empty page, i.e. there may be more.
  final bool hasMore;

  /// Set when loading the next page failed. The already loaded receipts are
  /// kept on screen so the user can retry.
  final String? loadMoreError;

  @override
  List<Object?> get props => [
    receipts,
    continuationToken,
    hasMore,
    loadMoreError,
  ];
}

final class ReceiptsRefreshing extends ReceiptsLoaded {
  const new({
    required super.receipts,
    required super.continuationToken,
    required super.hasMore,
  });
}

final class ReceiptsLoadingMore extends ReceiptsLoaded {
  const new({
    required super.receipts,
    required super.continuationToken,
    required super.hasMore,
  });
}

final class ReceiptsFailure extends ReceiptsState {
  const new({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
