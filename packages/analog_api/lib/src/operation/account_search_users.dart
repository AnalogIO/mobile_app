// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/api_error.dart' as _i8;
import 'package:analog_api/src/model/user_search_response.dart' as _i7;
import 'package:analog_api/src/operation/dio_operation.dart' as _i1;
import 'package:analog_api/src/response_wrapper/account_search_users_response.dart'
    as _i2;
import 'package:dio/dio.dart' as _i5;
import 'package:tonik_util/tonik_util.dart' as _i4;

final class AccountSearchUsers
    extends _i1.DioOperation<_i2.AccountSearchUsersResponse> {
  AccountSearchUsers(super.baseUrl, super.clientAccessor);

  static const _i3.String filterDefault = r'';

  static const _i3.int pageLengthDefault = 30;

  _i3.Future<
    _i4.TonikResult<_i2.AccountSearchUsersResponse, _i5.Response<_i3.Object?>>
  >
  call({
    _i3.int? pageNum,
    _i3.String filter = filterDefault,
    _i3.int pageLength = pageLengthDefault,
    _i4.TonikCancellation? cancellation,
  }) {
    return this.execute(
      cancellation: cancellation,
      prepare: () => _i1.DioOperationRequest(
        path: _path(),
        query: _queryParameters(
          pageNum: pageNum,
          filter: filter,
          pageLength: pageLength,
        ),
        data: _data(),
        options: _options(),
      ),
      decode: _parseResponse,
    );
  }

  _i3.List<_i3.String> _path() {
    return [r'api', r'v2', r'account', r'search'];
  }

  _i3.Object? _data() {
    return null;
  }

  _i3.String? _queryParameters({
    _i3.int? pageNum,
    _i3.String? filter,
    _i3.int? pageLength,
  }) {
    final _$entries = <_i4.ParameterEntry>[];
    if (pageNum != null) {
      _$entries.addAll(
        pageNum.toForm(
          r'pageNum',
          explode: true,
          allowEmpty: false,
          textEncoding: _i6.utf8,
        ),
      );
    }
    if (filter != null) {
      _$entries.addAll(
        filter.toForm(
          r'filter',
          explode: true,
          allowEmpty: false,
          textEncoding: _i6.utf8,
        ),
      );
    }
    if (pageLength != null) {
      _$entries.addAll(
        pageLength.toForm(
          r'pageLength',
          explode: true,
          allowEmpty: false,
          textEncoding: _i6.utf8,
        ),
      );
    }
    if (_$entries.isEmpty) {
      return null;
    }
    return _$entries
        .map((e) => e.name.isEmpty ? e.value : '${e.name}=${e.value}')
        .join('&');
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

  _i2.AccountSearchUsersResponse _parseResponse(
    _i5.Response<_i3.List<_i3.int>> response,
  ) {
    final _$mediaType = _i4.extractMediaType(
      response.headers.value('content-type'),
    );
    switch ((response.statusCode, _$mediaType)) {
      case (200, r'application/json'):
        final _$json = _i4.decodeResponseJson<_i3.Object?>(response.data);
        final _$body = _i7.UserSearchResponse.fromJson(_$json);
        return _i2.AccountSearchUsersResponse200(body: _$body);
      case (200, _):
        final _$content =
            response.headers.value('content-type') ?? 'not specified';
        final _$matched = _$mediaType ?? 'none';
        final _$status = response.statusCode;
        throw _i4.ResponseDecodingException(
          'Unexpected content type: ${_$content} (matched as: ${_$matched}) for status code: ${_$status}',
        );
      case (401, r'application/json'):
        final _$json = _i4.decodeResponseJson<_i3.Object?>(response.data);
        final _$body = _i8.ApiError.fromJson(_$json);
        return _i2.AccountSearchUsersResponse401(body: _$body);
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
