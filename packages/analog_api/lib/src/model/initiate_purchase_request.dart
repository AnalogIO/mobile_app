// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/payment_type.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Initiate a new purchase request
@_i2.immutable
class InitiatePurchaseRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const InitiatePurchaseRequest({
    required this.productId,
    required this.paymentType,
  });

  factory InitiatePurchaseRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'productId', r'paymentType'},
      listKeys: {},
      context: r'InitiatePurchaseRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return InitiatePurchaseRequest(
      productId: _$values[r'productId'].decodeSimpleInt(
        context: r'InitiatePurchaseRequest.productId',
      ),
      paymentType: _i4.PaymentType.fromSimple(
        _$values[r'paymentType'],
        explode: explode,
      ),
    );
  }

  factory InitiatePurchaseRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'InitiatePurchaseRequest');
    return InitiatePurchaseRequest(
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'InitiatePurchaseRequest.productId',
      ),
      paymentType: _i4.PaymentType.fromJson(_$map[r'paymentType']),
    );
  }

  factory InitiatePurchaseRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'productId', r'paymentType'},
      listKeys: {},
      context: r'InitiatePurchaseRequest',
    );
    return InitiatePurchaseRequest(
      productId: _$values[r'productId'].decodeFormInt(
        context: r'InitiatePurchaseRequest.productId',
      ),
      paymentType: _i4.PaymentType.fromForm(
        _$values[r'paymentType'],
        explode: explode,
      ),
    );
  }

  /// Id of product to be purchased
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int productId;

  final _i4.PaymentType paymentType;

  @_i3.override
  _i3.Object? toJson() => {
    r'productId': this.productId,
    r'paymentType': this.paymentType.toJson(),
  };

  InitiatePurchaseRequest Function({
    _i3.int? productId,
    _i4.PaymentType? paymentType,
  })
  get copyWith {
    return ({_i3.int? productId, _i4.PaymentType? paymentType}) =>
        InitiatePurchaseRequest(
          productId: productId ?? this.productId,
          paymentType: paymentType ?? this.paymentType,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is InitiatePurchaseRequest &&
        other.productId == this.productId &&
        other.paymentType == this.paymentType;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.productId, this.paymentType]);
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
    _$result[r'paymentType'] = _i1.PropertyValue.scalar(
      this.paymentType.toJson(),
    );
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
      r'Cannot uriEncode InitiatePurchaseRequest: complex types cannot be URI-encoded',
    );
  }
}
