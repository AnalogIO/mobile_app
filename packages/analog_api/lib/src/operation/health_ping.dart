// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i2;

import 'package:analog_api/src/operation/dio_operation.dart' as _i1;
import 'package:dio/dio.dart' as _i4;
import 'package:tonik_util/tonik_util.dart' as _i3;

final class HealthPing extends _i1.DioOperation<_i2.String> {
  HealthPing(super.baseUrl, super.clientAccessor);

  _i2.Future<_i3.TonikResult<_i2.String, _i4.Response<_i2.Object?>>> call({
    _i3.TonikCancellation? cancellation,
  }) {
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
    return [r'api', r'v2', r'health', r'ping'];
  }

  _i2.Object? _data() {
    return null;
  }

  _i4.Options _options() {
    final _$headers = <_i2.String, _i2.dynamic>{};
    _$headers['Accept'] = r'text/plain';
    return _i4.Options(
      method: 'GET',
      headers: _$headers,
      responseType: _i4.ResponseType.bytes,
      validateStatus: (_) => true,
    );
  }

  _i2.String _parseResponse(_i4.Response<_i2.List<_i2.int>> response) {
    final _$mediaType = _i3.extractMediaType(
      response.headers.value('content-type'),
    );
    switch ((response.statusCode, _$mediaType)) {
      case (200, r'text/plain'):
        final _$body = _i3.decodeResponseText(
          response.data,
          contentType: response.headers.value('content-type'),
        );
        return _$body;
      default:
        final _$content =
            response.headers.value('content-type') ?? 'not specified';
        final _$matched = _$mediaType ?? 'none';
        final _$status = response.statusCode;
        throw _i3.ResponseDecodingException(
          'Unexpected content type: ${_$content} (matched as: ${_$matched}) for status code: ${_$status}',
        );
    }
  }
}
