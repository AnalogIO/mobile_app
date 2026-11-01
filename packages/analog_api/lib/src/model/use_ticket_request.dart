// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents a request to use a ticket.
@_i2.immutable
class UseTicketRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UseTicketRequest({required this.productId, required this.menuItemId});

  factory UseTicketRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'productId', r'menuItemId'},
      listKeys: {},
      context: r'UseTicketRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UseTicketRequest(
      productId: _$values[r'productId'].decodeSimpleInt(
        context: r'UseTicketRequest.productId',
      ),
      menuItemId: _$values[r'menuItemId'].decodeSimpleInt(
        context: r'UseTicketRequest.menuItemId',
      ),
    );
  }

  factory UseTicketRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UseTicketRequest');
    return UseTicketRequest(
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'UseTicketRequest.productId',
      ),
      menuItemId: _$map[r'menuItemId'].decodeJsonInt(
        context: r'UseTicketRequest.menuItemId',
      ),
    );
  }

  factory UseTicketRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'productId', r'menuItemId'},
      listKeys: {},
      context: r'UseTicketRequest',
    );
    return UseTicketRequest(
      productId: _$values[r'productId'].decodeFormInt(
        context: r'UseTicketRequest.productId',
      ),
      menuItemId: _$values[r'menuItemId'].decodeFormInt(
        context: r'UseTicketRequest.menuItemId',
      ),
    );
  }

  /// The id of the product the ticket is for.
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int productId;

  /// The id of the menu item to use the ticket on.
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int menuItemId;

  @_i3.override
  _i3.Object? toJson() => {
    r'productId': this.productId,
    r'menuItemId': this.menuItemId,
  };

  UseTicketRequest Function({_i3.int? productId, _i3.int? menuItemId})
  get copyWith {
    return ({_i3.int? productId, _i3.int? menuItemId}) => UseTicketRequest(
      productId: productId ?? this.productId,
      menuItemId: menuItemId ?? this.menuItemId,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UseTicketRequest &&
        other.productId == this.productId &&
        other.menuItemId == this.menuItemId;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.productId, this.menuItemId]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'productId'] = _i1.PropertyValue.scalar(
      this.productId.toString(),
    );
    _$result[r'menuItemId'] = _i1.PropertyValue.scalar(
      this.menuItemId.toString(),
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
      r'Cannot uriEncode UseTicketRequest: complex types cannot be URI-encoded',
    );
  }
}
