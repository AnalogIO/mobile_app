// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/leaderboard_entry.dart' as _i2;
import 'package:meta/meta.dart' as _i1;

sealed class LeaderboardGetResponse {
  const LeaderboardGetResponse();
}

@_i1.immutable
class LeaderboardGetResponse200 extends LeaderboardGetResponse {
  const LeaderboardGetResponse200({required this.body});

  final _i2.LeaderboardEntry body;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is LeaderboardGetResponse200 && other.body == this.body;
  }

  @_i3.override
  _i3.int get hashCode => this.body.hashCode;
}

@_i1.immutable
class LeaderboardGetResponse401 extends LeaderboardGetResponse {
  const LeaderboardGetResponse401();

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is LeaderboardGetResponse401;
  }

  @_i3.override
  _i3.int get hashCode => this.runtimeType.hashCode;
}
