// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents a menu item that can be redeemed with a ticket
@_i2.immutable
class MenuItemResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const MenuItemResponse({
    required this.id,
    required this.name,
    required this.active,
  });

  factory MenuItemResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'id', r'name', r'active'},
      listKeys: {},
      context: r'MenuItemResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return MenuItemResponse(
      id: _$values[r'id'].decodeSimpleInt(context: r'MenuItemResponse.id'),
      name: _$values[r'name'].decodeSimpleString(
        context: r'MenuItemResponse.name',
      ),
      active: _$values[r'active'].decodeSimpleBool(
        context: r'MenuItemResponse.active',
      ),
    );
  }

  factory MenuItemResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'MenuItemResponse');
    return MenuItemResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'MenuItemResponse.id'),
      name: _$map[r'name'].decodeJsonString(context: r'MenuItemResponse.name'),
      active: _$map[r'active'].decodeJsonBool(
        context: r'MenuItemResponse.active',
      ),
    );
  }

  factory MenuItemResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'id', r'name', r'active'},
      listKeys: {},
      context: r'MenuItemResponse',
    );
    return MenuItemResponse(
      id: _$values[r'id'].decodeFormInt(context: r'MenuItemResponse.id'),
      name: _$values[r'name'].decodeFormString(
        context: r'MenuItemResponse.name',
      ),
      active: _$values[r'active'].decodeFormBool(
        context: r'MenuItemResponse.active',
      ),
    );
  }

  /// Id of menu item
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int id;

  /// Name of menu item
  ///
  /// **Example**:
  /// ```
  /// Cappuccino
  /// ```
  final _i3.String name;

  /// Whether or not this menu item is active
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool active;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'name': this.name,
    r'active': this.active,
  };

  MenuItemResponse Function({_i3.int? id, _i3.String? name, _i3.bool? active})
  get copyWith {
    return ({_i3.int? id, _i3.String? name, _i3.bool? active}) =>
        MenuItemResponse(
          id: id ?? this.id,
          name: name ?? this.name,
          active: active ?? this.active,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MenuItemResponse &&
        other.id == this.id &&
        other.name == this.name &&
        other.active == this.active;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.id, this.name, this.active]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'id'] = _i1.PropertyValue.scalar(this.id.toString());
    _$result[r'name'] = _i1.PropertyValue.scalar(this.name);
    _$result[r'active'] = _i1.PropertyValue.scalar(this.active.toString());
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
      r'Cannot uriEncode MenuItemResponse: complex types cannot be URI-encoded',
    );
  }
}
