part of 'receipts_cubit.dart';

sealed class ReceiptsState extends Equatable {
  const ReceiptsState();

  @override
  List<Object?> get props => [];
}

final class ReceiptsInitial extends ReceiptsState {
  const ReceiptsInitial();
}

final class ReceiptsLoading extends ReceiptsState {
  const ReceiptsLoading();
}

final class ReceiptsLoaded extends ReceiptsState {
  const ReceiptsLoaded({
    required this.receipts,
    required this.continuationToken,
  });

  /// List of receipts (purchases, swipes, vouchers)
  /// sorted by date (newest first)
  final List<Receipt> receipts;

  /// Token for fetching the next batch of receipts (pagination)
  final String continuationToken;

  @override
  List<Object?> get props => [receipts, continuationToken];
}

final class ReceiptsRefreshing extends ReceiptsLoaded {
  const ReceiptsRefreshing({
    required super.receipts,
    required super.continuationToken,
  });
}

final class ReceiptsFailure extends ReceiptsState {
  const ReceiptsFailure({required this.reason});

  final String reason;

  @override
  List<Object?> get props => [reason];
}
