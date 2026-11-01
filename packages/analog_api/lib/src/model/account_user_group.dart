// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/user_group.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents an account user group update
@_i2.immutable
class AccountUserGroup extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const AccountUserGroup({required this.accountId, required this.userGroup});

  factory AccountUserGroup.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'accountId', r'userGroup'},
      listKeys: {},
      context: r'AccountUserGroup',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return AccountUserGroup(
      accountId: _$values[r'accountId'].decodeSimpleInt(
        context: r'AccountUserGroup.accountId',
      ),
      userGroup: _i4.UserGroup.fromSimple(
        _$values[r'userGroup'],
        explode: explode,
      ),
    );
  }

  factory AccountUserGroup.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'AccountUserGroup');
    return AccountUserGroup(
      accountId: _$map[r'accountId'].decodeJsonInt(
        context: r'AccountUserGroup.accountId',
      ),
      userGroup: _i4.UserGroup.fromJson(_$map[r'userGroup']),
    );
  }

  factory AccountUserGroup.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'accountId', r'userGroup'},
      listKeys: {},
      context: r'AccountUserGroup',
    );
    return AccountUserGroup(
      accountId: _$values[r'accountId'].decodeFormInt(
        context: r'AccountUserGroup.accountId',
      ),
      userGroup: _i4.UserGroup.fromForm(
        _$values[r'userGroup'],
        explode: explode,
      ),
    );
  }

  /// The account id
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int accountId;

  final _i4.UserGroup userGroup;

  @_i3.override
  _i3.Object? toJson() => {
    r'accountId': this.accountId,
    r'userGroup': this.userGroup.toJson(),
  };

  AccountUserGroup Function({_i3.int? accountId, _i4.UserGroup? userGroup})
  get copyWith {
    return ({_i3.int? accountId, _i4.UserGroup? userGroup}) => AccountUserGroup(
      accountId: accountId ?? this.accountId,
      userGroup: userGroup ?? this.userGroup,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AccountUserGroup &&
        other.accountId == this.accountId &&
        other.userGroup == this.userGroup;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.accountId, this.userGroup]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'accountId'] = _i1.PropertyValue.scalar(
      this.accountId.toString(),
    );
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
      r'Cannot uriEncode AccountUserGroup: complex types cannot be URI-encoded',
    );
  }
}
