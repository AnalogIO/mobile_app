// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i7;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/api_error.dart' as _i8;
import 'package:analog_api/src/model/update_user_group_request.dart' as _i6;
import 'package:analog_api/src/operation/dio_operation.dart' as _i1;
import 'package:analog_api/src/response_wrapper/account_update_account_user_group_response.dart'
    as _i2;
import 'package:dio/dio.dart' as _i5;
import 'package:tonik_util/tonik_util.dart' as _i4;

final class AccountUpdateAccountUserGroup
    extends _i1.DioOperation<_i2.AccountUpdateAccountUserGroupResponse> {
  AccountUpdateAccountUserGroup(super.baseUrl, super.clientAccessor);

  _i3.Future<
    _i4.TonikResult<
      _i2.AccountUpdateAccountUserGroupResponse,
      _i5.Response<_i3.Object?>
    >
  >
  call({
    required _i6.UpdateUserGroupRequest body,
    required _i3.int id,
    _i4.TonikCancellation? cancellation,
  }) {
    return this.execute(
      cancellation: cancellation,
      prepare: () => _i1.DioOperationRequest(
        path: _path(id: id),
        query: null,
        data: _data(body: body),
        options: _options(),
      ),
      decode: _parseResponse,
    );
  }

  _i3.List<_i3.String> _path({required _i3.int id}) {
    return [
      r'api',
      r'v2',
      r'account',
      id.toSimple(explode: false, allowEmpty: false),
      r'user-group',
    ];
  }

  _i3.Object? _data({required _i6.UpdateUserGroupRequest body}) {
    return _i7.jsonEncode(body.toJson());
  }

  _i5.Options _options() {
    final _$headers = <_i3.String, _i3.dynamic>{};
    _$headers['Accept'] = r'application/json';
    return _i5.Options(
      method: 'PATCH',
      headers: _$headers,
      contentType: r'application/json',
      responseType: _i5.ResponseType.bytes,
      validateStatus: (_) => true,
    );
  }

  _i2.AccountUpdateAccountUserGroupResponse _parseResponse(
    _i5.Response<_i3.List<_i3.int>> response,
  ) {
    final _$mediaType = _i4.extractMediaType(
      response.headers.value('content-type'),
    );
    switch ((response.statusCode, _$mediaType)) {
      case (204, _):
        return _i2.AccountUpdateAccountUserGroupResponse204();
      case (401, r'application/json'):
        final _$json = _i4.decodeResponseJson<_i3.Object?>(response.data);
        final _$body = _i8.ApiError.fromJson(_$json);
        return _i2.AccountUpdateAccountUserGroupResponse401(body: _$body);
      case (401, _):
        final _$content =
            response.headers.value('content-type') ?? 'not specified';
        final _$matched = _$mediaType ?? 'none';
        final _$status = response.statusCode;
        throw _i4.ResponseDecodingException(
          'Unexpected content type: ${_$content} (matched as: ${_$matched}) for status code: ${_$status}',
        );
      case (404, r'application/json'):
        final _$json = _i4.decodeResponseJson<_i3.Object?>(response.data);
        final _$body = _i8.ApiError.fromJson(_$json);
        return _i2.AccountUpdateAccountUserGroupResponse404(body: _$body);
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
