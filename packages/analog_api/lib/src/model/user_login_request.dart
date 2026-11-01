// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/login_type.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// User login request object
@_i2.immutable
class UserLoginRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UserLoginRequest({required this.email, required this.loginType});

  factory UserLoginRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'email', r'loginType'},
      listKeys: {},
      context: r'UserLoginRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UserLoginRequest(
      email: _$values[r'email'].decodeSimpleString(
        context: r'UserLoginRequest.email',
      ),
      loginType: _i4.LoginType.fromSimple(
        _$values[r'loginType'],
        explode: explode,
      ),
    );
  }

  factory UserLoginRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UserLoginRequest');
    return UserLoginRequest(
      email: _$map[r'email'].decodeJsonString(
        context: r'UserLoginRequest.email',
      ),
      loginType: _i4.LoginType.fromJson(_$map[r'loginType']),
    );
  }

  factory UserLoginRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'email', r'loginType'},
      listKeys: {},
      context: r'UserLoginRequest',
    );
    return UserLoginRequest(
      email: _$values[r'email'].decodeFormString(
        context: r'UserLoginRequest.email',
      ),
      loginType: _i4.LoginType.fromForm(
        _$values[r'loginType'],
        explode: explode,
      ),
    );
  }

  /// Email of user
  ///
  /// **Example**:
  /// ```
  /// john@doe.com
  /// ```
  final _i3.String email;

  final _i4.LoginType loginType;

  @_i3.override
  _i3.Object? toJson() => {
    r'email': this.email,
    r'loginType': this.loginType.toJson(),
  };

  UserLoginRequest Function({_i3.String? email, _i4.LoginType? loginType})
  get copyWith {
    return ({_i3.String? email, _i4.LoginType? loginType}) => UserLoginRequest(
      email: email ?? this.email,
      loginType: loginType ?? this.loginType,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UserLoginRequest &&
        other.email == this.email &&
        other.loginType == this.loginType;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.email, this.loginType]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'email'] = _i1.PropertyValue.scalar(this.email);
    _$result[r'loginType'] = _i1.PropertyValue.scalar(this.loginType.toJson());
    return _$result;
  }

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i5.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode UserLoginRequest: complex types cannot be URI-encoded',
    );
  }
}
