// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// User login response object
@_i2.immutable
class UserLoginResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UserLoginResponse({required this.jwt, required this.refreshToken});

  factory UserLoginResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'jwt', r'refreshToken'},
      listKeys: {},
      context: r'UserLoginResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UserLoginResponse(
      jwt: _$values[r'jwt'].decodeSimpleString(
        context: r'UserLoginResponse.jwt',
      ),
      refreshToken: _$values[r'refreshToken'].decodeSimpleString(
        context: r'UserLoginResponse.refreshToken',
      ),
    );
  }

  factory UserLoginResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UserLoginResponse');
    return UserLoginResponse(
      jwt: _$map[r'jwt'].decodeJsonString(context: r'UserLoginResponse.jwt'),
      refreshToken: _$map[r'refreshToken'].decodeJsonString(
        context: r'UserLoginResponse.refreshToken',
      ),
    );
  }

  factory UserLoginResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'jwt', r'refreshToken'},
      listKeys: {},
      context: r'UserLoginResponse',
    );
    return UserLoginResponse(
      jwt: _$values[r'jwt'].decodeFormString(context: r'UserLoginResponse.jwt'),
      refreshToken: _$values[r'refreshToken'].decodeFormString(
        context: r'UserLoginResponse.refreshToken',
      ),
    );
  }

  /// JSON Web Token with claims for the user logging in
  final _i3.String jwt;

  /// Token used to obtain a new JWT token on expiration
  final _i3.String refreshToken;

  @_i3.override
  _i3.Object? toJson() => {
    r'jwt': this.jwt,
    r'refreshToken': this.refreshToken,
  };

  UserLoginResponse Function({_i3.String? jwt, _i3.String? refreshToken})
  get copyWith {
    return ({_i3.String? jwt, _i3.String? refreshToken}) => UserLoginResponse(
      jwt: jwt ?? this.jwt,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UserLoginResponse &&
        other.jwt == this.jwt &&
        other.refreshToken == this.refreshToken;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.jwt, this.refreshToken]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'jwt'] = _i1.PropertyValue.scalar(this.jwt);
    _$result[r'refreshToken'] = _i1.PropertyValue.scalar(this.refreshToken);
    return _$result;
  }

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i4.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode UserLoginResponse: complex types cannot be URI-encoded',
    );
  }
}
