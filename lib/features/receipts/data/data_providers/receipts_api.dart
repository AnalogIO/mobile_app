import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:chopper/chopper.dart' show Request;
import 'package:fpdart/fpdart.dart';

typedef Json = Map<String, dynamic>;

class ReceiptsApi {
  const ReceiptsApi({required this._executor});

  final NetworkRequestExecutor _executor;

  /// Fetches all receipts for the authenticated user.
  /// Receipts include purchases, swiped tickets, and used vouchers.
  ///
  /// Returns the response which contains:
  /// - receipts: list of receipt items
  /// - continuationToken: for pagination (to fetch older receipts)
  ///
  /// ---
  ///
  /// **Short-term fix**: fetch raw JSON for receipts and return the decoded map
  /// - this preserves concrete receipt fields which get lost when the
  /// generated client decodes directly into `ReceiptBase`.
  TaskEither<Failure, Json> fetchReceiptsRaw({
    required ReceiptType receiptType,
    String? continuationToken,
  }) {
    return _executor.run<Json>((api) {
      final client = api.v2.client;
      final url = Uri.parse('/api/v2/receipts');
      final params = <String, dynamic>{
        'Type': receiptType.value?.toString(),
        'BatchSize': 30,
        'ContinuationToken': continuationToken,
      };

      final request = Request(
        'GET',
        url,
        client.baseUrl,
        parameters: params,
      );

      return client.send<Json, Json>(request);
    });
  }

  TaskEither<Failure, ReceiptResponse> fetchReceipts({
    required ReceiptType receiptType,
    String? continuationToken,
  }) {
    return _executor.run(
      (api) => api.v2.receiptsGet(
        type: receiptType,
        continuationToken: continuationToken,
      ),
    );
  }
}
