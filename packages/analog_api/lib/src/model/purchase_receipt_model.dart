// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/purchase_status.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

@_i2.immutable
class PurchaseReceiptModel extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const PurchaseReceiptModel({
    required this.quantity,
    required this.status,
    required this.orderDate,
    required this.price,
    required this.orderId,
  });

  factory PurchaseReceiptModel.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {
        r'quantity',
        r'status',
        r'orderDate',
        r'price',
        r'orderId',
      },
      listKeys: {},
      context: r'PurchaseReceiptModel',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return PurchaseReceiptModel(
      quantity: _$values[r'quantity'].decodeSimpleInt(
        context: r'PurchaseReceiptModel.quantity',
      ),
      status: _i4.PurchaseStatus.fromSimple(
        _$values[r'status'],
        explode: explode,
      ),
      orderDate: _$values[r'orderDate'].decodeSimpleDateTime(
        context: r'PurchaseReceiptModel.orderDate',
      ),
      price: _$values[r'price'].decodeSimpleInt(
        context: r'PurchaseReceiptModel.price',
      ),
      orderId: _$values[r'orderId'].decodeSimpleString(
        context: r'PurchaseReceiptModel.orderId',
      ),
    );
  }

  factory PurchaseReceiptModel.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'PurchaseReceiptModel');
    return PurchaseReceiptModel(
      quantity: _$map[r'quantity'].decodeJsonInt(
        context: r'PurchaseReceiptModel.quantity',
      ),
      status: _i4.PurchaseStatus.fromJson(_$map[r'status']),
      orderDate: _$map[r'orderDate'].decodeJsonDateTime(
        context: r'PurchaseReceiptModel.orderDate',
      ),
      price: _$map[r'price'].decodeJsonInt(
        context: r'PurchaseReceiptModel.price',
      ),
      orderId: _$map[r'orderId'].decodeJsonString(
        context: r'PurchaseReceiptModel.orderId',
      ),
    );
  }

  factory PurchaseReceiptModel.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {
        r'quantity',
        r'status',
        r'orderDate',
        r'price',
        r'orderId',
      },
      listKeys: {},
      context: r'PurchaseReceiptModel',
    );
    return PurchaseReceiptModel(
      quantity: _$values[r'quantity'].decodeFormInt(
        context: r'PurchaseReceiptModel.quantity',
      ),
      status: _i4.PurchaseStatus.fromForm(
        _$values[r'status'],
        explode: explode,
      ),
      orderDate: _$values[r'orderDate'].decodeFormDateTime(
        context: r'PurchaseReceiptModel.orderDate',
      ),
      price: _$values[r'price'].decodeFormInt(
        context: r'PurchaseReceiptModel.price',
      ),
      orderId: _$values[r'orderId'].decodeFormString(
        context: r'PurchaseReceiptModel.orderId',
      ),
    );
  }

  /// The amount of tickets issued by the purchase.
  final _i3.int quantity;

  final _i4.PurchaseStatus status;

  /// The date and time when the order was placed.
  final _i3.DateTime orderDate;

  /// The total price of the purchase in kr.
  final _i3.int price;

  /// The unique identifier of the order associated with the purchase.
  final _i3.String orderId;

  @_i3.override
  _i3.Object? toJson() => {
    r'quantity': this.quantity,
    r'status': this.status.toJson(),
    r'orderDate': this.orderDate.toTimeZonedIso8601String(),
    r'price': this.price,
    r'orderId': this.orderId,
  };

  PurchaseReceiptModel Function({
    _i3.int? quantity,
    _i4.PurchaseStatus? status,
    _i3.DateTime? orderDate,
    _i3.int? price,
    _i3.String? orderId,
  })
  get copyWith {
    return ({
      _i3.int? quantity,
      _i4.PurchaseStatus? status,
      _i3.DateTime? orderDate,
      _i3.int? price,
      _i3.String? orderId,
    }) => PurchaseReceiptModel(
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      price: price ?? this.price,
      orderId: orderId ?? this.orderId,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is PurchaseReceiptModel &&
        other.quantity == this.quantity &&
        other.status == this.status &&
        other.orderDate == this.orderDate &&
        other.price == this.price &&
        other.orderId == this.orderId;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.quantity,
      this.status,
      this.orderDate,
      this.price,
      this.orderId,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'quantity'] = _i1.PropertyValue.scalar(this.quantity.toString());
    _$result[r'status'] = _i1.PropertyValue.scalar(this.status.toJson());
    _$result[r'orderDate'] = _i1.PropertyValue.scalar(
      this.orderDate.toTimeZonedIso8601String(),
    );
    _$result[r'price'] = _i1.PropertyValue.scalar(this.price.toString());
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
      r'Cannot uriEncode PurchaseReceiptModel: complex types cannot be URI-encoded',
    );
  }
}
