import 'package:cafe_analog_app/core/failures.dart';
import 'package:cafe_analog_app/infrastructure/http/http.dart';
import 'package:fpdart/fpdart.dart';

class ReceiptsApi {
  const new({required this._executor});

  final NetworkRequestExecutor _executor;

  /// Fetches one page of receipts for the authenticated user.
  TaskEither<Failure, ReceiptResponse> fetchReceipts({
    required ReceiptType receiptType,
    String? continuationToken,
  }) {
    return _executor.run(
      (api) => api.receipts.receiptGetReceipts(
        $type: receiptType,
        batchSize: 30,
        continuationToken: continuationToken,
      ),
      (response) => response,
    );
  }
}
