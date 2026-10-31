// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i7;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/webhook_update_user_group_request.dart'
    as _i6;
import 'package:analog_api/src/operation/dio_operation.dart' as _i1;
import 'package:analog_api/src/response_wrapper/webhooks_update_user_groups_response.dart'
    as _i2;
import 'package:dio/dio.dart' as _i5;
import 'package:tonik_util/tonik_util.dart' as _i4;

final class WebhooksUpdateUserGroups
    extends _i1.DioOperation<_i2.WebhooksUpdateUserGroupsResponse> {
  WebhooksUpdateUserGroups(super.baseUrl, super.clientAccessor);

  _i3.Future<
    _i4.TonikResult<
      _i2.WebhooksUpdateUserGroupsResponse,
      _i5.Response<_i3.Object?>
    >
  >
  call({
    required _i6.WebhookUpdateUserGroupRequest body,
    _i4.TonikCancellation? cancellation,
  }) {
    return this.execute(
      cancellation: cancellation,
      prepare: () => _i1.DioOperationRequest(
        path: _path(),
        query: null,
        data: _data(body: body),
        options: _options(),
      ),
      decode: _parseResponse,
    );
  }

  _i3.List<_i3.String> _path() {
    return [r'api', r'v2', r'webhooks', r'accounts', r'user-group'];
  }

  _i3.Object? _data({required _i6.WebhookUpdateUserGroupRequest body}) {
    return _i7.jsonEncode(body.toJson());
  }

  _i5.Options _options() {
    final _$headers = <_i3.String, _i3.dynamic>{};
    _$headers['Accept'] = r'*/*';
    return _i5.Options(
      method: 'PUT',
      headers: _$headers,
      contentType: r'application/json',
      responseType: _i5.ResponseType.bytes,
      validateStatus: (_) => true,
    );
  }

  _i2.WebhooksUpdateUserGroupsResponse _parseResponse(
    _i5.Response<_i3.List<_i3.int>> response,
  ) {
    final _$mediaType = _i4.extractMediaType(
      response.headers.value('content-type'),
    );
    switch ((response.statusCode, _$mediaType)) {
      case (204, _):
        return _i2.WebhooksUpdateUserGroupsResponse204();
      case (400, _):
        return _i2.WebhooksUpdateUserGroupsResponse400();
      case (401, _):
        return _i2.WebhooksUpdateUserGroupsResponse401();
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
