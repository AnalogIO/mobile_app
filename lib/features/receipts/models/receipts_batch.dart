import 'package:cafe_analog_app/features/receipts/models/receipt.dart';
import 'package:equatable/equatable.dart';

/// One page of receipts returned by the API.
class ReceiptsBatch extends Equatable {
  const new({
    required this.receipts,
    required this.continuationToken,
    required this.hasMore,
  });

  final List<Receipt> receipts;

  /// Token to pass to the next request. The backend currently always returns
  /// a token, so [hasMore] is the reliable indicator of whether another page
  /// exists.
  final String continuationToken;

  /// Whether the API returned any raw receipts for this page. A page can be
  /// non-empty at the API level while [receipts] is empty after filtering out
  /// non-completed purchases.
  final bool hasMore;

  @override
  List<Object?> get props => [receipts, continuationToken, hasMore];
}
