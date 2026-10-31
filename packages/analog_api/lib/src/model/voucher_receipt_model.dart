// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

@_i2.immutable
class VoucherReceiptModel extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const VoucherReceiptModel({
    required this.code,
    required this.redeemDate,
    required this.quantity,
  });

  factory VoucherReceiptModel.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'code', r'redeemDate', r'quantity'},
      listKeys: {},
      context: r'VoucherReceiptModel',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return VoucherReceiptModel(
      code: _$values[r'code'].decodeSimpleString(
        context: r'VoucherReceiptModel.code',
      ),
      redeemDate: _$values[r'redeemDate'].decodeSimpleDateTime(
        context: r'VoucherReceiptModel.redeemDate',
      ),
      quantity: _$values[r'quantity'].decodeSimpleInt(
        context: r'VoucherReceiptModel.quantity',
      ),
    );
  }

  factory VoucherReceiptModel.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'VoucherReceiptModel');
    return VoucherReceiptModel(
      code: _$map[r'code'].decodeJsonString(
        context: r'VoucherReceiptModel.code',
      ),
      redeemDate: _$map[r'redeemDate'].decodeJsonDateTime(
        context: r'VoucherReceiptModel.redeemDate',
      ),
      quantity: _$map[r'quantity'].decodeJsonInt(
        context: r'VoucherReceiptModel.quantity',
      ),
    );
  }

  factory VoucherReceiptModel.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'code', r'redeemDate', r'quantity'},
      listKeys: {},
      context: r'VoucherReceiptModel',
    );
    return VoucherReceiptModel(
      code: _$values[r'code'].decodeFormString(
        context: r'VoucherReceiptModel.code',
      ),
      redeemDate: _$values[r'redeemDate'].decodeFormDateTime(
        context: r'VoucherReceiptModel.redeemDate',
      ),
      quantity: _$values[r'quantity'].decodeFormInt(
        context: r'VoucherReceiptModel.quantity',
      ),
    );
  }

  /// The code of the voucher.
  final _i3.String code;

  final _i3.DateTime redeemDate;

  /// The amount of tickets issued by the purchase.
  final _i3.int quantity;

  @_i3.override
  _i3.Object? toJson() => {
    r'code': this.code,
    r'redeemDate': this.redeemDate.toTimeZonedIso8601String(),
    r'quantity': this.quantity,
  };

  VoucherReceiptModel Function({
    _i3.String? code,
    _i3.DateTime? redeemDate,
    _i3.int? quantity,
  })
  get copyWith {
    return ({_i3.String? code, _i3.DateTime? redeemDate, _i3.int? quantity}) =>
        VoucherReceiptModel(
          code: code ?? this.code,
          redeemDate: redeemDate ?? this.redeemDate,
          quantity: quantity ?? this.quantity,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is VoucherReceiptModel &&
        other.code == this.code &&
        other.redeemDate == this.redeemDate &&
        other.quantity == this.quantity;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.code, this.redeemDate, this.quantity]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'code'] = _i1.PropertyValue.scalar(this.code);
    _$result[r'redeemDate'] = _i1.PropertyValue.scalar(
      this.redeemDate.toTimeZonedIso8601String(),
    );
    _$result[r'quantity'] = _i1.PropertyValue.scalar(this.quantity.toString());
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
      r'Cannot uriEncode VoucherReceiptModel: complex types cannot be URI-encoded',
    );
  }
}
