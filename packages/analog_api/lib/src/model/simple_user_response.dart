// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/user_group.dart' as _i4;
import 'package:analog_api/src/model/user_state.dart' as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Basic User details
@_i2.immutable
class SimpleUserResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const SimpleUserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.userGroup,
    required this.state,
  });

  factory SimpleUserResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'id', r'name', r'email', r'userGroup', r'state'},
      listKeys: {},
      context: r'SimpleUserResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return SimpleUserResponse(
      id: _$values[r'id'].decodeSimpleInt(context: r'SimpleUserResponse.id'),
      name: _$values[r'name'].decodeSimpleString(
        context: r'SimpleUserResponse.name',
      ),
      email: _$values[r'email'].decodeSimpleString(
        context: r'SimpleUserResponse.email',
      ),
      userGroup: _i4.UserGroup.fromSimple(
        _$values[r'userGroup'],
        explode: explode,
      ),
      state: _i5.UserState.fromSimple(_$values[r'state'], explode: explode),
    );
  }

  factory SimpleUserResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'SimpleUserResponse');
    return SimpleUserResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'SimpleUserResponse.id'),
      name: _$map[r'name'].decodeJsonString(
        context: r'SimpleUserResponse.name',
      ),
      email: _$map[r'email'].decodeJsonString(
        context: r'SimpleUserResponse.email',
      ),
      userGroup: _i4.UserGroup.fromJson(_$map[r'userGroup']),
      state: _i5.UserState.fromJson(_$map[r'state']),
    );
  }

  factory SimpleUserResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'id', r'name', r'email', r'userGroup', r'state'},
      listKeys: {},
      context: r'SimpleUserResponse',
    );
    return SimpleUserResponse(
      id: _$values[r'id'].decodeFormInt(context: r'SimpleUserResponse.id'),
      name: _$values[r'name'].decodeFormString(
        context: r'SimpleUserResponse.name',
      ),
      email: _$values[r'email'].decodeFormString(
        context: r'SimpleUserResponse.email',
      ),
      userGroup: _i4.UserGroup.fromForm(
        _$values[r'userGroup'],
        explode: explode,
      ),
      state: _i5.UserState.fromForm(_$values[r'state'], explode: explode),
    );
  }

  /// User Id
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int id;

  /// User's Display Name
  ///
  /// **Example**:
  /// ```
  /// Name
  /// ```
  final _i3.String name;

  /// User's Email
  ///
  /// **Example**:
  /// ```
  /// john@doe.test
  /// ```
  final _i3.String email;

  final _i4.UserGroup userGroup;

  final _i5.UserState state;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'name': this.name,
    r'email': this.email,
    r'userGroup': this.userGroup.toJson(),
    r'state': this.state.toJson(),
  };

  SimpleUserResponse Function({
    _i3.int? id,
    _i3.String? name,
    _i3.String? email,
    _i4.UserGroup? userGroup,
    _i5.UserState? state,
  })
  get copyWith {
    return ({
      _i3.int? id,
      _i3.String? name,
      _i3.String? email,
      _i4.UserGroup? userGroup,
      _i5.UserState? state,
    }) => SimpleUserResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      userGroup: userGroup ?? this.userGroup,
      state: state ?? this.state,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is SimpleUserResponse &&
        other.id == this.id &&
        other.name == this.name &&
        other.email == this.email &&
        other.userGroup == this.userGroup &&
        other.state == this.state;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.id,
      this.name,
      this.email,
      this.userGroup,
      this.state,
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
    _$result[r'email'] = _i1.PropertyValue.scalar(this.email);
    _$result[r'userGroup'] = _i1.PropertyValue.scalar(this.userGroup.toJson());
    _$result[r'state'] = _i1.PropertyValue.scalar(this.state.toJson());
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
      r'Cannot uriEncode SimpleUserResponse: complex types cannot be URI-encoded',
    );
  }
}
