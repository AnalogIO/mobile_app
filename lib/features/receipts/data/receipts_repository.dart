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

    return _receiptsApi.fetchReceiptsRaw(receiptType: receiptType).map((raw) {
      final receiptsList = (raw['receipts'] as List<dynamic>?) ?? <dynamic>[];
      final receipts = receiptsList
          .map((e) => e as Map<String, dynamic>)
          .where((json) {
            if (json['Type'] != 'Purchase') {
              return true;
            }

            final status = api.PurchaseReceipt.fromJson(json).status;
            return api.purchaseStatusFromJson(status) ==
                api.PurchaseStatus.completed;
          })
          .map(receiptFromJson)
          .toList();
      return receipts;
    });
  }
}
