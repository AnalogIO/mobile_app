// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/webhook_update_user_group_request.dart'
    as _i7;
import 'package:analog_api/src/operation/webhooks_update_user_groups.dart'
    as _i2;
import 'package:analog_api/src/response_wrapper/webhooks_update_user_groups_response.dart'
    as _i5;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i6;
import 'package:tonik_util/tonik_util.dart' as _i4;

class WebhooksApi {
  WebhooksApi(_i1.Server server)
    : _webhooksUpdateUserGroups = _i2.WebhooksUpdateUserGroups(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.WebhooksUpdateUserGroups _webhooksUpdateUserGroups;

  /// Update user groups in bulk
  ///
  /// Security:
  /// - API Key (header): Api Key used for health endpoints
  _i3.Future<
    _i4.TonikResult<
      _i5.WebhooksUpdateUserGroupsResponse,
      _i6.Response<_i3.Object?>
    >
  >
  webhooksUpdateUserGroups({
    required _i7.WebhookUpdateUserGroupRequest body,
    _i4.TonikCancellation? cancellation,
  }) async =>
      this._webhooksUpdateUserGroups(body: body, cancellation: cancellation);
}
