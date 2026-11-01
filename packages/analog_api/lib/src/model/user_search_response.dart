// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/simple_user_response.dart' as _i4;
import 'package:collection/collection.dart' as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents a search result
@_i2.immutable
class UserSearchResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UserSearchResponse({required this.totalUsers, required this.users});

  factory UserSearchResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    throw _i1.SimpleDecodingException(
      r'Simple encoding not supported for UserSearchResponse: contains complex types',
    );
  }

  factory UserSearchResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UserSearchResponse');
    return UserSearchResponse(
      totalUsers: _$map[r'totalUsers'].decodeJsonInt(
        context: r'UserSearchResponse.totalUsers',
      ),
      users: _$map[r'users']
          .decodeJsonList<_i3.Object?>(context: r'UserSearchResponse.users')
          .map(_i4.SimpleUserResponse.fromJson)
          .toList(),
    );
  }

  factory UserSearchResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    throw _i1.FormDecodingException(
      r'Form encoding not supported for UserSearchResponse: contains complex types',
    );
  }

  /// The number of users that match the query
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int totalUsers;

  /// The users that match the query
  ///
  /// **Example**:
  /// ```json
  /// [
  ///   {
  ///     "id": 12232,
  ///     "name": "John Doe",
  ///     "email": "johndoe@itu.dk",
  ///     "userGroup": "Barista",
  ///     "state": "Active"
  ///   }
  /// ]
  /// ```
  final _i3.List<_i4.SimpleUserResponse> users;

  @_i3.override
  _i3.Object? toJson() => {
    r'totalUsers': this.totalUsers,
    r'users': this.users.map((e) => e.toJson()).toList(),
  };

  UserSearchResponse Function({
    _i3.int? totalUsers,
    _i3.List<_i4.SimpleUserResponse>? users,
  })
  get copyWith {
    return ({_i3.int? totalUsers, _i3.List<_i4.SimpleUserResponse>? users}) =>
        UserSearchResponse(
          totalUsers: totalUsers ?? this.totalUsers,
          users: users ?? this.users,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    const _$deepEquals = _i5.DeepCollectionEquality();
    return other is UserSearchResponse &&
        other.totalUsers == this.totalUsers &&
        _$deepEquals.equals(other.users, this.users);
  }

  @_i3.override
  _i3.int get hashCode {
    const deepEquals = _i5.DeepCollectionEquality();
    return _i3.Object.hashAll([this.totalUsers, deepEquals.hash(this.users)]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) => throw _i1.EncodingException(
    r'parameterProperties not supported for UserSearchResponse: contains complex types',
  );

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode UserSearchResponse: complex types cannot be URI-encoded',
    );
  }
}
