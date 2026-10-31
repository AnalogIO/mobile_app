// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Initiate a new menuitem add request.
@_i2.immutable
class AddMenuItemRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const AddMenuItemRequest({required this.name});

  factory AddMenuItemRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'name'},
      listKeys: {},
      context: r'AddMenuItemRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return AddMenuItemRequest(
      name: _$values[r'name'].decodeSimpleString(
        context: r'AddMenuItemRequest.name',
      ),
    );
  }

  factory AddMenuItemRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'AddMenuItemRequest');
    return AddMenuItemRequest(
      name: _$map[r'name'].decodeJsonString(
        context: r'AddMenuItemRequest.name',
      ),
    );
  }

  factory AddMenuItemRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'name'},
      listKeys: {},
      context: r'AddMenuItemRequest',
    );
    return AddMenuItemRequest(
      name: _$values[r'name'].decodeFormString(
        context: r'AddMenuItemRequest.name',
      ),
    );
  }

  /// Gets or sets the name of the product.
  ///
  /// **Example**:
  /// ```
  /// Latte
  /// ```
  final _i3.String name;

  @_i3.override
  _i3.Object? toJson() => {r'name': this.name};

  AddMenuItemRequest Function({_i3.String? name}) get copyWith {
    return ({_i3.String? name}) => AddMenuItemRequest(name: name ?? this.name);
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AddMenuItemRequest && other.name == this.name;
  }

  @_i3.override
  _i3.int get hashCode => this.name.hashCode;

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'name'] = _i1.PropertyValue.scalar(this.name);
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
      r'Cannot uriEncode AddMenuItemRequest: complex types cannot be URI-encoded',
    );
  }
}
