import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/features/receipts/data/data_providers/data_providers.dart';
import 'package:cafe_analog_app/features/receipts/models/models.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart' as api;
import 'package:fpdart/fpdart.dart';

class ReceiptsRepository {
  const ReceiptsRepository({required this._receiptsApi});

  final ReceiptsApi _receiptsApi;

  /// Fetches all receipts for the authenticated user.
  ///
  /// This method retrieves receipts including:
  /// - Purchases (tickets bought)
  /// - Swiped tickets (tickets used on products)
  /// - Redeemed vouchers
  ///
  /// Returns a [TaskEither<Failure, List<Receipt>>] representing:
  /// - Right: list of receipts sorted by date (newest first)
  /// - Left: a [Failure] if the request fails
  TaskEither<Failure, List<Receipt>> fetchReceipts({
    required GetReceiptsType type,
    // int? batchSize,
    // String? continuationToken,
  }) {
    final receiptType = switch (type) {
      GetReceiptsType.ticketSwipes => api.ReceiptType.usedticket,
      GetReceiptsType.purchases => api.ReceiptType.purchase,
      GetReceiptsType.vouchers => api.ReceiptType.voucher,
      GetReceiptsType.all => api.ReceiptType.all,
    };

    return _receiptsApi.fetchReceiptsRaw(receiptType: receiptType).flatMap(
      (raw) {
        final receiptsList = (raw['receipts'] as List<dynamic>?) ?? <dynamic>[];
        try {
          final receipts = receiptsList
              .map((e) => e as Map<String, dynamic>)
              .where(_isCompletedPurchaseReceipt)
              .map(receiptFromJson)
              .toList();
          return TaskEither.right(receipts);
        } on FormatException catch (error) {
          // The generated enum decoders (e.g. `receiptTypeFromJson`) return
          // `swaggerGeneratedUnknown` for unrecognized values instead of null.
          // Receipt decoding throws when it encounters one; converting that
          // into a Failure makes the cubit emit a failure state instead of
          // the app crashing. See CONTRIBUTING.md.
          return TaskEither.left(
            UnexpectedFailure(error.message),
          );
        }
      },
    );
  }

  /// Whether the given receipt JSON should be included in the list.
  ///
  /// Only completed purchases are included; other receipt types are always
  /// included. Throws an [UnsupportedError] for unrecognized purchase
  /// statuses, which [fetchReceipts] converts into a failure.
  bool _isCompletedPurchaseReceipt(Map<String, dynamic> json) {
    if (api.receiptTypeFromJson(json['Type']) != api.ReceiptType.purchase) {
      return true;
    }

    final status = api.purchaseStatusFromJson(
      api.PurchaseReceipt.fromJson(json).status,
    );
    if (status == api.PurchaseStatus.completed) {
      return true;
    }
    if (status == api.PurchaseStatus.swaggerGeneratedUnknown) {
      throw FormatException('Unknown purchase status: ${json['status']}');
    }
    return false;
  }
}
