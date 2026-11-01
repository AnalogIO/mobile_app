// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Register a new user
@_i2.immutable
class RegisterAccountRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const RegisterAccountRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.programmeId,
  });

  factory RegisterAccountRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'name', r'email', r'password', r'programmeId'},
      listKeys: {},
      context: r'RegisterAccountRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return RegisterAccountRequest(
      name: _$values[r'name'].decodeSimpleString(
        context: r'RegisterAccountRequest.name',
      ),
      email: _$values[r'email'].decodeSimpleString(
        context: r'RegisterAccountRequest.email',
      ),
      password: _$values[r'password'].decodeSimpleString(
        context: r'RegisterAccountRequest.password',
      ),
      programmeId: _$values[r'programmeId'].decodeSimpleInt(
        context: r'RegisterAccountRequest.programmeId',
      ),
    );
  }

  factory RegisterAccountRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'RegisterAccountRequest');
    return RegisterAccountRequest(
      name: _$map[r'name'].decodeJsonString(
        context: r'RegisterAccountRequest.name',
      ),
      email: _$map[r'email'].decodeJsonString(
        context: r'RegisterAccountRequest.email',
      ),
      password: _$map[r'password'].decodeJsonString(
        context: r'RegisterAccountRequest.password',
      ),
      programmeId: _$map[r'programmeId'].decodeJsonInt(
        context: r'RegisterAccountRequest.programmeId',
      ),
    );
  }

  factory RegisterAccountRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'name', r'email', r'password', r'programmeId'},
      listKeys: {},
      context: r'RegisterAccountRequest',
    );
    return RegisterAccountRequest(
      name: _$values[r'name'].decodeFormString(
        context: r'RegisterAccountRequest.name',
      ),
      email: _$values[r'email'].decodeFormString(
        context: r'RegisterAccountRequest.email',
      ),
      password: _$values[r'password'].decodeFormString(
        context: r'RegisterAccountRequest.password',
      ),
      programmeId: _$values[r'programmeId'].decodeFormInt(
        context: r'RegisterAccountRequest.programmeId',
      ),
    );
  }

  /// Full Name of user
  ///
  /// **Example**:
  /// ```
  /// John Doe
  /// ```
  final _i3.String name;

  /// Email Address of user
  ///
  /// **Example**:
  /// ```
  /// john@doe.com
  /// ```
  final _i3.String email;

  /// Pin Code as first UTF8 encoded, then SHA256 hashed, and then Base64 encoded string
  ///
  /// **Example**:
  /// ```
  /// [no example provided]
  /// ```
  final _i3.String password;

  /// Programme of user
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int programmeId;

  @_i3.override
  _i3.Object? toJson() => {
    r'name': this.name,
    r'email': this.email,
    r'password': this.password,
    r'programmeId': this.programmeId,
  };

  RegisterAccountRequest Function({
    _i3.String? name,
    _i3.String? email,
    _i3.String? password,
    _i3.int? programmeId,
  })
  get copyWith {
    return ({
      _i3.String? name,
      _i3.String? email,
      _i3.String? password,
      _i3.int? programmeId,
    }) => RegisterAccountRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      programmeId: programmeId ?? this.programmeId,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is RegisterAccountRequest &&
        other.name == this.name &&
        other.email == this.email &&
        other.password == this.password &&
        other.programmeId == this.programmeId;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.name,
      this.email,
      this.password,
      this.programmeId,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'name'] = _i1.PropertyValue.scalar(this.name);
    _$result[r'email'] = _i1.PropertyValue.scalar(this.email);
    _$result[r'password'] = _i1.PropertyValue.scalar(this.password);
    _$result[r'programmeId'] = _i1.PropertyValue.scalar(
      this.programmeId.toString(),
    );
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
      r'Cannot uriEncode RegisterAccountRequest: complex types cannot be URI-encoded',
    );
  }
}
