// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i8;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/profile_background_color.dart' as _i7;
import 'package:analog_api/src/model/profile_icon.dart' as _i6;
import 'package:analog_api/src/model/programme_response.dart' as _i5;
import 'package:analog_api/src/model/user_role.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// User information
@_i2.immutable
class UserResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.privacyActivated,
    required this.role,
    required this.programme,
    required this.rankAllTime,
    required this.rankSemester,
    required this.rankMonth,
    required this.profileIcon,
    required this.profileBackgroundColor,
  });

  factory UserResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    throw _i1.SimpleDecodingException(
      r'Simple encoding not supported for UserResponse: contains complex types',
    );
  }

  factory UserResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UserResponse');
    return UserResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'UserResponse.id'),
      name: _$map[r'name'].decodeJsonString(context: r'UserResponse.name'),
      email: _$map[r'email'].decodeJsonString(context: r'UserResponse.email'),
      privacyActivated: _$map[r'privacyActivated'].decodeJsonBool(
        context: r'UserResponse.privacyActivated',
      ),
      role: _i4.UserRole.fromJson(_$map[r'role']),
      programme: _i5.ProgrammeResponse.fromJson(_$map[r'programme']),
      rankAllTime: _$map[r'rankAllTime'].decodeJsonInt(
        context: r'UserResponse.rankAllTime',
      ),
      rankSemester: _$map[r'rankSemester'].decodeJsonInt(
        context: r'UserResponse.rankSemester',
      ),
      rankMonth: _$map[r'rankMonth'].decodeJsonInt(
        context: r'UserResponse.rankMonth',
      ),
      profileIcon: _i6.ProfileIcon.fromJson(_$map[r'profileIcon']),
      profileBackgroundColor: _i7.ProfileBackgroundColor.fromJson(
        _$map[r'profileBackgroundColor'],
      ),
    );
  }

  factory UserResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    throw _i1.FormDecodingException(
      r'Form encoding not supported for UserResponse: contains complex types',
    );
  }

  /// User Id
  ///
  /// **Example**:
  /// ```json
  /// 123
  /// ```
  final _i3.int id;

  /// Full Name of user
  ///
  /// **Example**:
  /// ```
  /// John Doe
  /// ```
  final _i3.String name;

  /// Email of user
  ///
  /// **Example**:
  /// ```
  /// john@doe.com
  /// ```
  final _i3.String email;

  /// Privacy Activated
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool privacyActivated;

  final _i4.UserRole role;

  final _i5.ProgrammeResponse programme;

  /// User's Rank all time
  ///
  /// **Example**:
  /// ```json
  /// 15
  /// ```
  final _i3.int rankAllTime;

  /// User's rank current semester
  ///
  /// **Example**:
  /// ```json
  /// 4
  /// ```
  final _i3.int rankSemester;

  /// User's rank current month
  ///
  /// **Example**:
  /// ```json
  /// 5
  /// ```
  final _i3.int rankMonth;

  final _i6.ProfileIcon profileIcon;

  final _i7.ProfileBackgroundColor profileBackgroundColor;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'name': this.name,
    r'email': this.email,
    r'privacyActivated': this.privacyActivated,
    r'role': this.role.toJson(),
    r'programme': this.programme.toJson(),
    r'rankAllTime': this.rankAllTime,
    r'rankSemester': this.rankSemester,
    r'rankMonth': this.rankMonth,
    r'profileIcon': this.profileIcon.toJson(),
    r'profileBackgroundColor': this.profileBackgroundColor.toJson(),
  };

  UserResponse Function({
    _i3.int? id,
    _i3.String? name,
    _i3.String? email,
    _i3.bool? privacyActivated,
    _i4.UserRole? role,
    _i5.ProgrammeResponse? programme,
    _i3.int? rankAllTime,
    _i3.int? rankSemester,
    _i3.int? rankMonth,
    _i6.ProfileIcon? profileIcon,
    _i7.ProfileBackgroundColor? profileBackgroundColor,
  })
  get copyWith {
    return ({
      _i3.int? id,
      _i3.String? name,
      _i3.String? email,
      _i3.bool? privacyActivated,
      _i4.UserRole? role,
      _i5.ProgrammeResponse? programme,
      _i3.int? rankAllTime,
      _i3.int? rankSemester,
      _i3.int? rankMonth,
      _i6.ProfileIcon? profileIcon,
      _i7.ProfileBackgroundColor? profileBackgroundColor,
    }) => UserResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      privacyActivated: privacyActivated ?? this.privacyActivated,
      role: role ?? this.role,
      programme: programme ?? this.programme,
      rankAllTime: rankAllTime ?? this.rankAllTime,
      rankSemester: rankSemester ?? this.rankSemester,
      rankMonth: rankMonth ?? this.rankMonth,
      profileIcon: profileIcon ?? this.profileIcon,
      profileBackgroundColor:
          profileBackgroundColor ?? this.profileBackgroundColor,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UserResponse &&
        other.id == this.id &&
        other.name == this.name &&
        other.email == this.email &&
        other.privacyActivated == this.privacyActivated &&
        other.role == this.role &&
        other.programme == this.programme &&
        other.rankAllTime == this.rankAllTime &&
        other.rankSemester == this.rankSemester &&
        other.rankMonth == this.rankMonth &&
        other.profileIcon == this.profileIcon &&
        other.profileBackgroundColor == this.profileBackgroundColor;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.id,
      this.name,
      this.email,
      this.privacyActivated,
      this.role,
      this.programme,
      this.rankAllTime,
      this.rankSemester,
      this.rankMonth,
      this.profileIcon,
      this.profileBackgroundColor,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) => throw _i1.EncodingException(
    r'parameterProperties not supported for UserResponse: contains complex types',
  );

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i8.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode UserResponse: complex types cannot be URI-encoded',
    );
  }
}
