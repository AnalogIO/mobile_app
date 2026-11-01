// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Initialize a response with unused clips data
@_i2.immutable
class UnusedClipsResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UnusedClipsResponse({
    required this.productId,
    required this.productName,
    required this.ticketsLeft,
    required this.unusedPurchasesValue,
  });

  factory UnusedClipsResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {
        r'productId',
        r'productName',
        r'ticketsLeft',
        r'unusedPurchasesValue',
      },
      listKeys: {},
      context: r'UnusedClipsResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UnusedClipsResponse(
      productId: _$values[r'productId'].decodeSimpleInt(
        context: r'UnusedClipsResponse.productId',
      ),
      productName: _$values[r'productName'].decodeSimpleString(
        context: r'UnusedClipsResponse.productName',
      ),
      ticketsLeft: _$values[r'ticketsLeft'].decodeSimpleInt(
        context: r'UnusedClipsResponse.ticketsLeft',
      ),
      unusedPurchasesValue: _$values[r'unusedPurchasesValue']
          .decodeSimpleDouble(
            context: r'UnusedClipsResponse.unusedPurchasesValue',
          ),
    );
  }

  factory UnusedClipsResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UnusedClipsResponse');
    return UnusedClipsResponse(
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'UnusedClipsResponse.productId',
      ),
      productName: _$map[r'productName'].decodeJsonString(
        context: r'UnusedClipsResponse.productName',
      ),
      ticketsLeft: _$map[r'ticketsLeft'].decodeJsonInt(
        context: r'UnusedClipsResponse.ticketsLeft',
      ),
      unusedPurchasesValue: _$map[r'unusedPurchasesValue'].decodeJsonNum(
        context: r'UnusedClipsResponse.unusedPurchasesValue',
      ),
    );
  }

  factory UnusedClipsResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {
        r'productId',
        r'productName',
        r'ticketsLeft',
        r'unusedPurchasesValue',
      },
      listKeys: {},
      context: r'UnusedClipsResponse',
    );
    return UnusedClipsResponse(
      productId: _$values[r'productId'].decodeFormInt(
        context: r'UnusedClipsResponse.productId',
      ),
      productName: _$values[r'productName'].decodeFormString(
        context: r'UnusedClipsResponse.productName',
      ),
      ticketsLeft: _$values[r'ticketsLeft'].decodeFormInt(
        context: r'UnusedClipsResponse.ticketsLeft',
      ),
      unusedPurchasesValue: _$values[r'unusedPurchasesValue'].decodeFormDouble(
        context: r'UnusedClipsResponse.unusedPurchasesValue',
      ),
    );
  }

  /// The id of the product
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int productId;

  /// The name of the product
  ///
  /// **Example**:
  /// ```
  ///  Americano
  /// ```
  final _i3.String productName;

  /// The number of tickets unused in a purchase
  ///
  /// **Example**:
  /// ```json
  /// 8
  /// ```
  final _i3.int ticketsLeft;

  /// The value of the unused purchases of a given product
  ///
  /// **Example**:
  /// ```json
  /// 40.2
  /// ```
  final _i3.num unusedPurchasesValue;

  @_i3.override
  _i3.Object? toJson() => {
    r'productId': this.productId,
    r'productName': this.productName,
    r'ticketsLeft': this.ticketsLeft,
    r'unusedPurchasesValue': this.unusedPurchasesValue,
  };

  UnusedClipsResponse Function({
    _i3.int? productId,
    _i3.String? productName,
    _i3.int? ticketsLeft,
    _i3.num? unusedPurchasesValue,
  })
  get copyWith {
    return ({
      _i3.int? productId,
      _i3.String? productName,
      _i3.int? ticketsLeft,
      _i3.num? unusedPurchasesValue,
    }) => UnusedClipsResponse(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      ticketsLeft: ticketsLeft ?? this.ticketsLeft,
      unusedPurchasesValue: unusedPurchasesValue ?? this.unusedPurchasesValue,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UnusedClipsResponse &&
        other.productId == this.productId &&
        other.productName == this.productName &&
        other.ticketsLeft == this.ticketsLeft &&
        other.unusedPurchasesValue == this.unusedPurchasesValue;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.productId,
      this.productName,
      this.ticketsLeft,
      this.unusedPurchasesValue,
    ]);
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
    _$result[r'productName'] = _i1.PropertyValue.scalar(this.productName);
    _$result[r'ticketsLeft'] = _i1.PropertyValue.scalar(
      this.ticketsLeft.toString(),
    );
    _$result[r'unusedPurchasesValue'] = _i1.PropertyValue.scalar(
      this.unusedPurchasesValue.toString(),
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
      r'Cannot uriEncode UnusedClipsResponse: complex types cannot be URI-encoded',
    );
  }
}
