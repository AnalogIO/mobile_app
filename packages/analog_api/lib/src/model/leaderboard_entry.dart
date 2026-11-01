// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/profile_background_color.dart' as _i5;
import 'package:analog_api/src/model/profile_icon.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// A user on the leaderboard
@_i2.immutable
class LeaderboardEntry extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const LeaderboardEntry({
    required this.id,
    required this.name,
    required this.rank,
    required this.profileIcon,
    required this.profileBackgroundColor,
    required this.score,
  });

  factory LeaderboardEntry.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {
        r'id',
        r'name',
        r'rank',
        r'profileIcon',
        r'profileBackgroundColor',
        r'score',
      },
      listKeys: {},
      context: r'LeaderboardEntry',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return LeaderboardEntry(
      id: _$values[r'id'].decodeSimpleInt(context: r'LeaderboardEntry.id'),
      name: _$values[r'name'].decodeSimpleString(
        context: r'LeaderboardEntry.name',
      ),
      rank: _$values[r'rank'].decodeSimpleInt(
        context: r'LeaderboardEntry.rank',
      ),
      profileIcon: _i4.ProfileIcon.fromSimple(
        _$values[r'profileIcon'],
        explode: explode,
      ),
      profileBackgroundColor: _i5.ProfileBackgroundColor.fromSimple(
        _$values[r'profileBackgroundColor'],
        explode: explode,
      ),
      score: _$values[r'score'].decodeSimpleInt(
        context: r'LeaderboardEntry.score',
      ),
    );
  }

  factory LeaderboardEntry.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'LeaderboardEntry');
    return LeaderboardEntry(
      id: _$map[r'id'].decodeJsonInt(context: r'LeaderboardEntry.id'),
      name: _$map[r'name'].decodeJsonString(context: r'LeaderboardEntry.name'),
      rank: _$map[r'rank'].decodeJsonInt(context: r'LeaderboardEntry.rank'),
      profileIcon: _i4.ProfileIcon.fromJson(_$map[r'profileIcon']),
      profileBackgroundColor: _i5.ProfileBackgroundColor.fromJson(
        _$map[r'profileBackgroundColor'],
      ),
      score: _$map[r'score'].decodeJsonInt(context: r'LeaderboardEntry.score'),
    );
  }

  factory LeaderboardEntry.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {
        r'id',
        r'name',
        r'rank',
        r'profileIcon',
        r'profileBackgroundColor',
        r'score',
      },
      listKeys: {},
      context: r'LeaderboardEntry',
    );
    return LeaderboardEntry(
      id: _$values[r'id'].decodeFormInt(context: r'LeaderboardEntry.id'),
      name: _$values[r'name'].decodeFormString(
        context: r'LeaderboardEntry.name',
      ),
      rank: _$values[r'rank'].decodeFormInt(context: r'LeaderboardEntry.rank'),
      profileIcon: _i4.ProfileIcon.fromForm(
        _$values[r'profileIcon'],
        explode: explode,
      ),
      profileBackgroundColor: _i5.ProfileBackgroundColor.fromForm(
        _$values[r'profileBackgroundColor'],
        explode: explode,
      ),
      score: _$values[r'score'].decodeFormInt(
        context: r'LeaderboardEntry.score',
      ),
    );
  }

  /// Account Id
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int id;

  /// Account name
  ///
  /// **Example**:
  /// ```
  /// John Doe
  /// ```
  final _i3.String name;

  /// Leaderboard rank
  ///
  /// **Example**:
  /// ```json
  /// 2
  /// ```
  final _i3.int rank;

  final _i4.ProfileIcon profileIcon;

  final _i5.ProfileBackgroundColor profileBackgroundColor;

  /// Account score
  ///
  /// **Example**:
  /// ```json
  /// 25
  /// ```
  final _i3.int score;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'name': this.name,
    r'rank': this.rank,
    r'profileIcon': this.profileIcon.toJson(),
    r'profileBackgroundColor': this.profileBackgroundColor.toJson(),
    r'score': this.score,
  };

  LeaderboardEntry Function({
    _i3.int? id,
    _i3.String? name,
    _i3.int? rank,
    _i4.ProfileIcon? profileIcon,
    _i5.ProfileBackgroundColor? profileBackgroundColor,
    _i3.int? score,
  })
  get copyWith {
    return ({
      _i3.int? id,
      _i3.String? name,
      _i3.int? rank,
      _i4.ProfileIcon? profileIcon,
      _i5.ProfileBackgroundColor? profileBackgroundColor,
      _i3.int? score,
    }) => LeaderboardEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      rank: rank ?? this.rank,
      profileIcon: profileIcon ?? this.profileIcon,
      profileBackgroundColor:
          profileBackgroundColor ?? this.profileBackgroundColor,
      score: score ?? this.score,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is LeaderboardEntry &&
        other.id == this.id &&
        other.name == this.name &&
        other.rank == this.rank &&
        other.profileIcon == this.profileIcon &&
        other.profileBackgroundColor == this.profileBackgroundColor &&
        other.score == this.score;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.id,
      this.name,
      this.rank,
      this.profileIcon,
      this.profileBackgroundColor,
      this.score,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'id'] = _i1.PropertyValue.scalar(this.id.toString());
    _$result[r'name'] = _i1.PropertyValue.scalar(this.name);
    _$result[r'rank'] = _i1.PropertyValue.scalar(this.rank.toString());
    _$result[r'profileIcon'] = _i1.PropertyValue.scalar(
      this.profileIcon.toJson(),
    );
    _$result[r'profileBackgroundColor'] = _i1.PropertyValue.scalar(
      this.profileBackgroundColor.toJson(),
    );
    _$result[r'score'] = _i1.PropertyValue.scalar(this.score.toString());
    return _$result;
  }

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode LeaderboardEntry: complex types cannot be URI-encoded',
    );
  }
}
