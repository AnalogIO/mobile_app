// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/api_error.dart' as _i7;
import 'package:analog_api/src/model/simple_purchase_response.dart' as _i6;
import 'package:analog_api/src/operation/dio_operation.dart' as _i1;
import 'package:analog_api/src/response_wrapper/purchases_get_all_purchases_for_user_response.dart'
    as _i2;
import 'package:dio/dio.dart' as _i5;
import 'package:tonik_util/tonik_util.dart' as _i4;

final class PurchasesGetAllPurchasesForUser
    extends _i1.DioOperation<_i2.PurchasesGetAllPurchasesForUserResponse> {
  PurchasesGetAllPurchasesForUser(super.baseUrl, super.clientAccessor);

  _i3.Future<
    _i4.TonikResult<
      _i2.PurchasesGetAllPurchasesForUserResponse,
      _i5.Response<_i3.Object?>
    >
  >
  call({required _i3.int userId, _i4.TonikCancellation? cancellation}) {
    return this.execute(
      cancellation: cancellation,
      prepare: () => _i1.DioOperationRequest(
        path: _path(userId: userId),
        query: null,
        data: _data(),
        options: _options(),
      ),
      decode: _parseResponse,
    );
  }

  _i3.List<_i3.String> _path({required _i3.int userId}) {
    return [
      r'api',
      r'v2',
      r'purchases',
      r'user',
      userId.toSimple(explode: false, allowEmpty: false),
    ];
  }

  _i3.Object? _data() {
    return null;
  }

  _i5.Options _options() {
    final _$headers = <_i3.String, _i3.dynamic>{};
    _$headers['Accept'] = r'application/json';
    return _i5.Options(
      method: 'GET',
      headers: _$headers,
      responseType: _i5.ResponseType.bytes,
      validateStatus: (_) => true,
    );
  }

  _i2.PurchasesGetAllPurchasesForUserResponse _parseResponse(
    _i5.Response<_i3.List<_i3.int>> response,
  ) {
    final _$mediaType = _i4.extractMediaType(
      response.headers.value('content-type'),
    );
    switch ((response.statusCode, _$mediaType)) {
      case (200, r'application/json'):
        final _$json = _i4.decodeResponseJson<_i3.Object?>(response.data);
        final _$body = _$json
            .decodeJsonList<_i3.Object?>()
            .map(_i6.SimplePurchaseResponse.fromJson)
            .toList();
        return _i2.PurchasesGetAllPurchasesForUserResponse200(body: _$body);
      case (200, _):
        final _$content =
            response.headers.value('content-type') ?? 'not specified';
        final _$matched = _$mediaType ?? 'none';
        final _$status = response.statusCode;
        throw _i4.ResponseDecodingException(
          'Unexpected content type: ${_$content} (matched as: ${_$matched}) for status code: ${_$status}',
        );
      case (401, _):
        return _i2.PurchasesGetAllPurchasesForUserResponse401();
      case (403, _):
        return _i2.PurchasesGetAllPurchasesForUserResponse403();
      case (404, r'application/json'):
        final _$json = _i4.decodeResponseJson<_i3.Object?>(response.data);
        final _$body = _i7.ApiError.fromJson(_$json);
        return _i2.PurchasesGetAllPurchasesForUserResponse404(body: _$body);
      default:
        final _$content =
            response.headers.value('content-type') ?? 'not specified';
        final _$matched = _$mediaType ?? 'none';
        final _$status = response.statusCode;
        throw _i4.ResponseDecodingException(
          'Unexpected content type: ${_$content} (matched as: ${_$matched}) for status code: ${_$status}',
        );
    }
  }
}
