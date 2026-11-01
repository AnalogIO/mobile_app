// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/receipt_response.dart' as _i5;
import 'package:analog_api/src/model/receipt_type.dart' as _i7;
import 'package:analog_api/src/operation/receipt_get_receipts.dart' as _i2;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i6;
import 'package:tonik_util/tonik_util.dart' as _i4;

class ReceiptApi {
  ReceiptApi(_i1.Server server)
    : _receiptGetReceipts = _i2.ReceiptGetReceipts(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.ReceiptGetReceipts _receiptGetReceipts;

  /// Retrieve all receipts for the authenticated user
  /// This includes all purchases, swiped tickets, and used vouchers
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i3.Future<_i4.TonikResult<_i5.ReceiptResponse, _i6.Response<_i3.Object?>>>
  receiptGetReceipts({
    required _i7.ReceiptType $type,
    _i3.int? batchSize,
    _i3.String? continuationToken,
    _i4.TonikCancellation? cancellation,
  }) async => this._receiptGetReceipts(
    $type: $type,
    batchSize: batchSize,
    continuationToken: continuationToken,
    cancellation: cancellation,
  );
}
