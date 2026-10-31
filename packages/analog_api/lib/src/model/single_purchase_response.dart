// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/purchase_status.dart' as _i4;
import 'package:analog_api/src/model/single_purchase_response_payment_details_one_of_model.dart'
    as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents a purchase
@_i2.immutable
class SinglePurchaseResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const SinglePurchaseResponse({
    required this.id,
    required this.dateCreated,
    required this.productId,
    required this.totalAmount,
    required this.purchaseStatus,
    required this.paymentDetails,
  });

  factory SinglePurchaseResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    throw _i1.SimpleDecodingException(
      r'Simple encoding not supported for SinglePurchaseResponse: contains complex types',
    );
  }

  factory SinglePurchaseResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'SinglePurchaseResponse');
    return SinglePurchaseResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'SinglePurchaseResponse.id'),
      dateCreated: _$map[r'dateCreated'].decodeJsonDateTime(
        context: r'SinglePurchaseResponse.dateCreated',
      ),
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'SinglePurchaseResponse.productId',
      ),
      totalAmount: _$map[r'totalAmount'].decodeJsonInt(
        context: r'SinglePurchaseResponse.totalAmount',
      ),
      purchaseStatus: _i4.PurchaseStatus.fromJson(_$map[r'purchaseStatus']),
      paymentDetails:
          _i5.SinglePurchaseResponsePaymentDetailsOneOfModel.fromJson(
            _$map[r'paymentDetails'],
          ),
    );
  }

  factory SinglePurchaseResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    throw _i1.FormDecodingException(
      r'Form encoding not supported for SinglePurchaseResponse: contains complex types',
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

  /// Total purchase price in Danish Kroner (kr)
  ///
  /// **Example**:
  /// ```json
  /// 300
  /// ```
  final _i3.int totalAmount;

  final _i4.PurchaseStatus purchaseStatus;

  /// Details about the payment. The details object is specific to the Payment Type
  final _i5.SinglePurchaseResponsePaymentDetailsOneOfModel paymentDetails;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'dateCreated': this.dateCreated.toTimeZonedIso8601String(),
    r'productId': this.productId,
    r'totalAmount': this.totalAmount,
    r'purchaseStatus': this.purchaseStatus.toJson(),
    r'paymentDetails': this.paymentDetails.toJson(),
  };

  SinglePurchaseResponse Function({
    _i3.int? id,
    _i3.DateTime? dateCreated,
    _i3.int? productId,
    _i3.int? totalAmount,
    _i4.PurchaseStatus? purchaseStatus,
    _i5.SinglePurchaseResponsePaymentDetailsOneOfModel? paymentDetails,
  })
  get copyWith {
    return ({
      _i3.int? id,
      _i3.DateTime? dateCreated,
      _i3.int? productId,
      _i3.int? totalAmount,
      _i4.PurchaseStatus? purchaseStatus,
      _i5.SinglePurchaseResponsePaymentDetailsOneOfModel? paymentDetails,
    }) => SinglePurchaseResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      productId: productId ?? this.productId,
      totalAmount: totalAmount ?? this.totalAmount,
      purchaseStatus: purchaseStatus ?? this.purchaseStatus,
      paymentDetails: paymentDetails ?? this.paymentDetails,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is SinglePurchaseResponse &&
        other.id == this.id &&
        other.dateCreated == this.dateCreated &&
        other.productId == this.productId &&
        other.totalAmount == this.totalAmount &&
        other.purchaseStatus == this.purchaseStatus &&
        other.paymentDetails == this.paymentDetails;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.id,
      this.dateCreated,
      this.productId,
      this.totalAmount,
      this.purchaseStatus,
      this.paymentDetails,
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
    _$result[r'totalAmount'] = _i1.PropertyValue.scalar(
      this.totalAmount.toString(),
    );
    _$result[r'purchaseStatus'] = _i1.PropertyValue.scalar(
      this.purchaseStatus.toJson(),
    );
    _$result[r'paymentDetails'] = _i1.encodeAnyValueToPropertyValue(
      this.paymentDetails.toJson(),
      allowEmpty: allowEmpty,
    );
    return _$result;
  }

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode SinglePurchaseResponse: complex types cannot be URI-encoded',
    );
  }
}
