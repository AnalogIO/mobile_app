// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i4;

import 'package:analog_api/src/model/leaderboard_entry.dart' as _i6;
import 'package:analog_api/src/model/leaderboard_preset.dart' as _i8;
import 'package:analog_api/src/operation/leaderboard_get.dart' as _i3;
import 'package:analog_api/src/operation/leaderboard_get_top_entries.dart'
    as _i2;
import 'package:analog_api/src/response_wrapper/leaderboard_get_response.dart'
    as _i9;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i7;
import 'package:tonik_util/tonik_util.dart' as _i5;

class LeaderboardApi {
  LeaderboardApi(_i1.Server server)
    : _leaderboardGetTopEntries = _i2.LeaderboardGetTopEntries(
        server.baseUrl,
        () => server.dio,
      ),
      _leaderboardGet = _i3.LeaderboardGet(server.baseUrl, () => server.dio);

  final _i2.LeaderboardGetTopEntries _leaderboardGetTopEntries;

  final _i3.LeaderboardGet _leaderboardGet;

  /// Gets the top leaderboard by the specified preset
  _i4.Future<
    _i5.TonikResult<_i4.List<_i6.LeaderboardEntry>, _i7.Response<_i4.Object?>>
  >
  leaderboardGetTopEntries({
    _i8.LeaderboardPreset? preset,
    _i4.int top = _i2.LeaderboardGetTopEntries.topDefault,
    _i5.TonikCancellation? cancellation,
  }) async => this._leaderboardGetTopEntries(
    preset: preset,
    top: top,
    cancellation: cancellation,
  );

  /// Get leaderboard stats for authenticated user. A user will have rank 0 if they do not have any valid swipes
  ///
  /// Security:
  /// - HTTP Bearer: JWT Bearer token
  _i4.Future<
    _i5.TonikResult<_i9.LeaderboardGetResponse, _i7.Response<_i4.Object?>>
  >
  leaderboardGet({
    _i8.LeaderboardPreset? preset,
    _i5.TonikCancellation? cancellation,
  }) async => this._leaderboardGet(preset: preset, cancellation: cancellation);
}
