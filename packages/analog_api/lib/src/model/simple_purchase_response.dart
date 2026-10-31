// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/purchase_status.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents a purchase
@_i2.immutable
class SimplePurchaseResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const SimplePurchaseResponse({
    required this.id,
    required this.dateCreated,
    required this.productId,
    required this.productName,
    required this.numberOfTickets,
    required this.totalAmount,
    required this.purchaseStatus,
  });

  factory SimplePurchaseResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {
        r'id',
        r'dateCreated',
        r'productId',
        r'productName',
        r'numberOfTickets',
        r'totalAmount',
        r'purchaseStatus',
      },
      listKeys: {},
      context: r'SimplePurchaseResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return SimplePurchaseResponse(
      id: _$values[r'id'].decodeSimpleInt(
        context: r'SimplePurchaseResponse.id',
      ),
      dateCreated: _$values[r'dateCreated'].decodeSimpleDateTime(
        context: r'SimplePurchaseResponse.dateCreated',
      ),
      productId: _$values[r'productId'].decodeSimpleInt(
        context: r'SimplePurchaseResponse.productId',
      ),
      productName: _$values[r'productName'].decodeSimpleString(
        context: r'SimplePurchaseResponse.productName',
      ),
      numberOfTickets: _$values[r'numberOfTickets'].decodeSimpleInt(
        context: r'SimplePurchaseResponse.numberOfTickets',
      ),
      totalAmount: _$values[r'totalAmount'].decodeSimpleInt(
        context: r'SimplePurchaseResponse.totalAmount',
      ),
      purchaseStatus: _i4.PurchaseStatus.fromSimple(
        _$values[r'purchaseStatus'],
        explode: explode,
      ),
    );
  }

  factory SimplePurchaseResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'SimplePurchaseResponse');
    return SimplePurchaseResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'SimplePurchaseResponse.id'),
      dateCreated: _$map[r'dateCreated'].decodeJsonDateTime(
        context: r'SimplePurchaseResponse.dateCreated',
      ),
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'SimplePurchaseResponse.productId',
      ),
      productName: _$map[r'productName'].decodeJsonString(
        context: r'SimplePurchaseResponse.productName',
      ),
      numberOfTickets: _$map[r'numberOfTickets'].decodeJsonInt(
        context: r'SimplePurchaseResponse.numberOfTickets',
      ),
      totalAmount: _$map[r'totalAmount'].decodeJsonInt(
        context: r'SimplePurchaseResponse.totalAmount',
      ),
      purchaseStatus: _i4.PurchaseStatus.fromJson(_$map[r'purchaseStatus']),
    );
  }

  factory SimplePurchaseResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {
        r'id',
        r'dateCreated',
        r'productId',
        r'productName',
        r'numberOfTickets',
        r'totalAmount',
        r'purchaseStatus',
      },
      listKeys: {},
      context: r'SimplePurchaseResponse',
    );
    return SimplePurchaseResponse(
      id: _$values[r'id'].decodeFormInt(context: r'SimplePurchaseResponse.id'),
      dateCreated: _$values[r'dateCreated'].decodeFormDateTime(
        context: r'SimplePurchaseResponse.dateCreated',
      ),
      productId: _$values[r'productId'].decodeFormInt(
        context: r'SimplePurchaseResponse.productId',
      ),
      productName: _$values[r'productName'].decodeFormString(
        context: r'SimplePurchaseResponse.productName',
      ),
      numberOfTickets: _$values[r'numberOfTickets'].decodeFormInt(
        context: r'SimplePurchaseResponse.numberOfTickets',
      ),
      totalAmount: _$values[r'totalAmount'].decodeFormInt(
        context: r'SimplePurchaseResponse.totalAmount',
      ),
      purchaseStatus: _i4.PurchaseStatus.fromForm(
        _$values[r'purchaseStatus'],
        explode: explode,
      ),
    );
  }

  /// Id of purchase
  ///
  /// **Example**:
  /// ```json
  /// 1371
  /// ```
  final _i3.int id;

  /// Date time for purchase in Utc format
  ///
  /// **Example**:
  /// ```
  /// 2022-01-09T21:03:52.2283208Z
  /// ```
  final _i3.DateTime dateCreated;

  /// Id of purchased product
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int productId;

  /// Name of purchased product
  ///
  /// **Example**:
  /// ```
  /// 1
  /// ```
  final _i3.String productName;

  /// Number of tickets issued in purchase
  ///
  /// **Example**:
  /// ```json
  /// 10
  /// ```
  final _i3.int numberOfTickets;

  /// Total purchase price in Danish Kroner (kr)
  ///
  /// **Example**:
  /// ```json
  /// 300
  /// ```
  final _i3.int totalAmount;

  final _i4.PurchaseStatus purchaseStatus;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'dateCreated': this.dateCreated.toTimeZonedIso8601String(),
    r'productId': this.productId,
    r'productName': this.productName,
    r'numberOfTickets': this.numberOfTickets,
    r'totalAmount': this.totalAmount,
    r'purchaseStatus': this.purchaseStatus.toJson(),
  };

  SimplePurchaseResponse Function({
    _i3.int? id,
    _i3.DateTime? dateCreated,
    _i3.int? productId,
    _i3.String? productName,
    _i3.int? numberOfTickets,
    _i3.int? totalAmount,
    _i4.PurchaseStatus? purchaseStatus,
  })
  get copyWith {
    return ({
      _i3.int? id,
      _i3.DateTime? dateCreated,
      _i3.int? productId,
      _i3.String? productName,
      _i3.int? numberOfTickets,
      _i3.int? totalAmount,
      _i4.PurchaseStatus? purchaseStatus,
    }) => SimplePurchaseResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      totalAmount: totalAmount ?? this.totalAmount,
      purchaseStatus: purchaseStatus ?? this.purchaseStatus,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is SimplePurchaseResponse &&
        other.id == this.id &&
        other.dateCreated == this.dateCreated &&
        other.productId == this.productId &&
        other.productName == this.productName &&
        other.numberOfTickets == this.numberOfTickets &&
        other.totalAmount == this.totalAmount &&
        other.purchaseStatus == this.purchaseStatus;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.id,
      this.dateCreated,
      this.productId,
      this.productName,
      this.numberOfTickets,
      this.totalAmount,
      this.purchaseStatus,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'id'] = _i1.PropertyValue.scalar(this.id.toString());
    _$result[r'dateCreated'] = _i1.PropertyValue.scalar(
      this.dateCreated.toTimeZonedIso8601String(),
    );
    _$result[r'productId'] = _i1.PropertyValue.scalar(
      this.productId.toString(),
    );
    _$result[r'productName'] = _i1.PropertyValue.scalar(this.productName);
    _$result[r'numberOfTickets'] = _i1.PropertyValue.scalar(
      this.numberOfTickets.toString(),
    );
    _$result[r'totalAmount'] = _i1.PropertyValue.scalar(
      this.totalAmount.toString(),
    );
    _$result[r'purchaseStatus'] = _i1.PropertyValue.scalar(
      this.purchaseStatus.toJson(),
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
      r'Cannot uriEncode SimplePurchaseResponse: complex types cannot be URI-encoded',
    );
  }
}
