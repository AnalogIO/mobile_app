// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/unused_clips_request.dart' as _i7;
import 'package:analog_api/src/operation/admin_statistics_get_unused_clips.dart'
    as _i2;
import 'package:analog_api/src/response_wrapper/admin_statistics_get_unused_clips_response.dart'
    as _i5;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i6;
import 'package:tonik_util/tonik_util.dart' as _i4;

class AdminStatisticsApi {
  AdminStatisticsApi(_i1.Server server)
    : _adminStatisticsGetUnusedClips = _i2.AdminStatisticsGetUnusedClips(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.AdminStatisticsGetUnusedClips _adminStatisticsGetUnusedClips;

  /// Sum unused clip cards within a given period per productId
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i3.Future<
    _i4.TonikResult<
      _i5.AdminStatisticsGetUnusedClipsResponse,
      _i6.Response<_i3.Object?>
    >
  >
  adminStatisticsGetUnusedClips({
    required _i7.UnusedClipsRequest body,
    _i4.TonikCancellation? cancellation,
  }) async => this._adminStatisticsGetUnusedClips(
    body: body,
    cancellation: cancellation,
  );
}
