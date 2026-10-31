// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/payment_type.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Payment details
@_i2.immutable
class PaymentDetails extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const PaymentDetails({
    required this.discriminator,
    required this.paymentType,
    required this.orderId,
  });

  factory PaymentDetails.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'discriminator', r'paymentType', r'orderId'},
      listKeys: {},
      context: r'PaymentDetails',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return PaymentDetails(
      discriminator: _$values[r'discriminator'].decodeSimpleString(
        context: r'PaymentDetails.discriminator',
      ),
      paymentType: _i4.PaymentType.fromSimple(
        _$values[r'paymentType'],
        explode: explode,
      ),
      orderId: _$values[r'orderId'].decodeSimpleString(
        context: r'PaymentDetails.orderId',
      ),
    );
  }

  factory PaymentDetails.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'PaymentDetails');
    return PaymentDetails(
      discriminator: _$map[r'discriminator'].decodeJsonString(
        context: r'PaymentDetails.discriminator',
      ),
      paymentType: _i4.PaymentType.fromJson(_$map[r'paymentType']),
      orderId: _$map[r'orderId'].decodeJsonString(
        context: r'PaymentDetails.orderId',
      ),
    );
  }

  factory PaymentDetails.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'discriminator', r'paymentType', r'orderId'},
      listKeys: {},
      context: r'PaymentDetails',
    );
    return PaymentDetails(
      discriminator: _$values[r'discriminator'].decodeFormString(
        context: r'PaymentDetails.discriminator',
      ),
      paymentType: _i4.PaymentType.fromForm(
        _$values[r'paymentType'],
        explode: explode,
      ),
      orderId: _$values[r'orderId'].decodeFormString(
        context: r'PaymentDetails.orderId',
      ),
    );
  }

  final _i3.String discriminator;

  final _i4.PaymentType paymentType;

  /// Order id of purchase
  ///
  /// **Example**:
  /// ```
  /// f5cb3e0f-3b9b-4f50-8c4f-a7450f300a5c
  /// ```
  final _i3.String orderId;

  @_i3.override
  _i3.Object? toJson() => {
    r'discriminator': this.discriminator,
    r'paymentType': this.paymentType.toJson(),
    r'orderId': this.orderId,
  };

  PaymentDetails Function({
    _i3.String? discriminator,
    _i4.PaymentType? paymentType,
    _i3.String? orderId,
  })
  get copyWith {
    return ({
      _i3.String? discriminator,
      _i4.PaymentType? paymentType,
      _i3.String? orderId,
    }) => PaymentDetails(
      discriminator: discriminator ?? this.discriminator,
      paymentType: paymentType ?? this.paymentType,
      orderId: orderId ?? this.orderId,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PaymentDetails &&
        other.discriminator == this.discriminator &&
        other.paymentType == this.paymentType &&
        other.orderId == this.orderId;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.discriminator,
      this.paymentType,
      this.orderId,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'discriminator'] = _i1.PropertyValue.scalar(this.discriminator);
    _$result[r'paymentType'] = _i1.PropertyValue.scalar(
      this.paymentType.toJson(),
    );
    _$result[r'orderId'] = _i1.PropertyValue.scalar(this.orderId);
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
      r'Cannot uriEncode PaymentDetails: complex types cannot be URI-encoded',
    );
  }
}
