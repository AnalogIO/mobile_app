// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:analog_api/src/model/product_response.dart' as _i3;
import 'package:analog_api/src/operation/dio_operation.dart' as _i1;
import 'package:dio/dio.dart' as _i5;
import 'package:tonik_util/tonik_util.dart' as _i4;

final class ProductsGetAllProducts
    extends _i1.DioOperation<_i2.List<_i3.ProductResponse>> {
  ProductsGetAllProducts(super.baseUrl, super.clientAccessor);

  _i2.Future<
    _i4.TonikResult<_i2.List<_i3.ProductResponse>, _i5.Response<_i2.Object?>>
  >
  call({_i4.TonikCancellation? cancellation}) {
    return this.execute(
      cancellation: cancellation,
      prepare: () => _i1.DioOperationRequest(
        path: _path(),
        query: null,
        data: _data(),
        options: _options(),
      ),
      decode: _parseResponse,
    );
  }

  _i2.List<_i2.String> _path() {
    return [r'api', r'v2', r'products', r'all'];
  }

  _i2.Object? _data() {
    return null;
  }

  _i5.Options _options() {
    final _$headers = <_i2.String, _i2.dynamic>{};
    _$headers['Accept'] = r'application/json';
    return _i5.Options(
      method: 'GET',
      headers: _$headers,
      responseType: _i5.ResponseType.bytes,
      validateStatus: (_) => true,
    );
  }

  _i2.List<_i3.ProductResponse> _parseResponse(
    _i5.Response<_i2.List<_i2.int>> response,
  ) {
    final _$mediaType = _i4.extractMediaType(
      response.headers.value('content-type'),
    );
    switch ((response.statusCode, _$mediaType)) {
      case (200, r'application/json'):
        final _$json = _i4.decodeResponseJson<_i2.Object?>(response.data);
        final _$body = _$json
            .decodeJsonList<_i2.Object?>()
            .map(_i3.ProductResponse.fromJson)
            .toList();
        return _$body;
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
