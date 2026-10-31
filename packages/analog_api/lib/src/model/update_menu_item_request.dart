// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Initiate an update product request.
@_i2.immutable
class UpdateMenuItemRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UpdateMenuItemRequest({required this.name, required this.active});

  factory UpdateMenuItemRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'name', r'active'},
      listKeys: {},
      context: r'UpdateMenuItemRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UpdateMenuItemRequest(
      name: _$values[r'name'].decodeSimpleString(
        context: r'UpdateMenuItemRequest.name',
      ),
      active: _$values[r'active'].decodeSimpleBool(
        context: r'UpdateMenuItemRequest.active',
      ),
    );
  }

  factory UpdateMenuItemRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UpdateMenuItemRequest');
    return UpdateMenuItemRequest(
      name: _$map[r'name'].decodeJsonString(
        context: r'UpdateMenuItemRequest.name',
      ),
      active: _$map[r'active'].decodeJsonBool(
        context: r'UpdateMenuItemRequest.active',
      ),
    );
  }

  factory UpdateMenuItemRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'name', r'active'},
      listKeys: {},
      context: r'UpdateMenuItemRequest',
    );
    return UpdateMenuItemRequest(
      name: _$values[r'name'].decodeFormString(
        context: r'UpdateMenuItemRequest.name',
      ),
      active: _$values[r'active'].decodeFormBool(
        context: r'UpdateMenuItemRequest.active',
      ),
    );
  }

  /// Gets or sets the updated name of the product.
  ///
  /// **Example**:
  /// ```
  /// Espresso
  /// ```
  final _i3.String name;

  /// Gets or sets the updated active status of the product.
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool active;

  @_i3.override
  _i3.Object? toJson() => {r'name': this.name, r'active': this.active};

  UpdateMenuItemRequest Function({_i3.String? name, _i3.bool? active})
  get copyWith {
    return ({_i3.String? name, _i3.bool? active}) => UpdateMenuItemRequest(
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UpdateMenuItemRequest &&
        other.name == this.name &&
        other.active == this.active;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.name, this.active]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
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
      r'Cannot uriEncode UpdateMenuItemRequest: complex types cannot be URI-encoded',
    );
  }
}
