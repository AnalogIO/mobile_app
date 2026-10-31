// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/user_group.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Update the UserGroup property of a user
@_i2.immutable
class UpdateUserGroupRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UpdateUserGroupRequest({required this.userGroup});

  factory UpdateUserGroupRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'userGroup'},
      listKeys: {},
      context: r'UpdateUserGroupRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UpdateUserGroupRequest(
      userGroup: _i4.UserGroup.fromSimple(
        _$values[r'userGroup'],
        explode: explode,
      ),
    );
  }

  factory UpdateUserGroupRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UpdateUserGroupRequest');
    return UpdateUserGroupRequest(
      userGroup: _i4.UserGroup.fromJson(_$map[r'userGroup']),
    );
  }

  factory UpdateUserGroupRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'userGroup'},
      listKeys: {},
      context: r'UpdateUserGroupRequest',
    );
    return UpdateUserGroupRequest(
      userGroup: _i4.UserGroup.fromForm(
        _$values[r'userGroup'],
        explode: explode,
      ),
    );
  }

  final _i4.UserGroup userGroup;

  @_i3.override
  _i3.Object? toJson() => {r'userGroup': this.userGroup.toJson()};

  UpdateUserGroupRequest Function({_i4.UserGroup? userGroup}) get copyWith {
    return ({_i4.UserGroup? userGroup}) =>
        UpdateUserGroupRequest(userGroup: userGroup ?? this.userGroup);
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UpdateUserGroupRequest && other.userGroup == this.userGroup;
  }

  @_i3.override
  _i3.int get hashCode => this.userGroup.hashCode;

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'userGroup'] = _i1.PropertyValue.scalar(this.userGroup.toJson());
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
      r'Cannot uriEncode UpdateUserGroupRequest: complex types cannot be URI-encoded',
    );
  }
}
