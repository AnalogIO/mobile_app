// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/operation/statistics_get_quick_stats.dart'
    as _i2;
import 'package:analog_api/src/response_wrapper/statistics_get_quick_stats_response.dart'
    as _i5;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i6;
import 'package:tonik_util/tonik_util.dart' as _i4;

class StatisticsApi {
  StatisticsApi(_i1.Server server)
    : _statisticsGetQuickStats = _i2.StatisticsGetQuickStats(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.StatisticsGetQuickStats _statisticsGetQuickStats;

  /// Get some quick stats about the user and general drink consumption at ITU.
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i3.Future<
    _i4.TonikResult<
      _i5.StatisticsGetQuickStatsResponse,
      _i6.Response<_i3.Object?>
    >
  >
  statisticsGetQuickStats({_i4.TonikCancellation? cancellation}) async =>
      this._statisticsGetQuickStats(cancellation: cancellation);
}
