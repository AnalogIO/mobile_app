// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Request object for creating voucher codes
@_i2.immutable
class IssueVoucherRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const IssueVoucherRequest({
    required this.productId,
    required this.amount,
    required this.voucherPrefix,
    required this.description,
    required this.requester,
  });

  factory IssueVoucherRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {
        r'productId',
        r'amount',
        r'voucherPrefix',
        r'description',
        r'requester',
      },
      listKeys: {},
      context: r'IssueVoucherRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return IssueVoucherRequest(
      productId: _$values[r'productId'].decodeSimpleInt(
        context: r'IssueVoucherRequest.productId',
      ),
      amount: _$values[r'amount'].decodeSimpleInt(
        context: r'IssueVoucherRequest.amount',
      ),
      voucherPrefix: _$values[r'voucherPrefix'].decodeSimpleString(
        context: r'IssueVoucherRequest.voucherPrefix',
      ),
      description: _$values[r'description'].decodeSimpleString(
        context: r'IssueVoucherRequest.description',
      ),
      requester: _$values[r'requester'].decodeSimpleString(
        context: r'IssueVoucherRequest.requester',
      ),
    );
  }

  factory IssueVoucherRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'IssueVoucherRequest');
    return IssueVoucherRequest(
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'IssueVoucherRequest.productId',
      ),
      amount: _$map[r'amount'].decodeJsonInt(
        context: r'IssueVoucherRequest.amount',
      ),
      voucherPrefix: _$map[r'voucherPrefix'].decodeJsonString(
        context: r'IssueVoucherRequest.voucherPrefix',
      ),
      description: _$map[r'description'].decodeJsonString(
        context: r'IssueVoucherRequest.description',
      ),
      requester: _$map[r'requester'].decodeJsonString(
        context: r'IssueVoucherRequest.requester',
      ),
    );
  }

  factory IssueVoucherRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {
        r'productId',
        r'amount',
        r'voucherPrefix',
        r'description',
        r'requester',
      },
      listKeys: {},
      context: r'IssueVoucherRequest',
    );
    return IssueVoucherRequest(
      productId: _$values[r'productId'].decodeFormInt(
        context: r'IssueVoucherRequest.productId',
      ),
      amount: _$values[r'amount'].decodeFormInt(
        context: r'IssueVoucherRequest.amount',
      ),
      voucherPrefix: _$values[r'voucherPrefix'].decodeFormString(
        context: r'IssueVoucherRequest.voucherPrefix',
      ),
      description: _$values[r'description'].decodeFormString(
        context: r'IssueVoucherRequest.description',
      ),
      requester: _$values[r'requester'].decodeFormString(
        context: r'IssueVoucherRequest.requester',
      ),
    );
  }

  /// Id of the product to create voucher codes for
  ///
  /// **Example**:
  /// ```json
  /// 6
  /// ```
  final _i3.int productId;

  /// The amount of vouchers to be issued
  ///
  /// **Example**:
  /// ```json
  /// 10
  /// ```
  final _i3.int amount;

  /// A 3 character long user defined prefix for every voucher code
  ///
  /// **Example**:
  /// ```
  /// ABC
  /// ```
  final _i3.String voucherPrefix;

  /// Description of the purpose for the creation of vouchers
  ///
  /// **Example**:
  /// ```
  /// Voucher codes for intro week
  /// ```
  final _i3.String description;

  /// The requester of the voucher codes
  ///
  /// **Example**:
  /// ```
  /// John Doe
  /// ```
  final _i3.String requester;

  @_i3.override
  _i3.Object? toJson() => {
    r'productId': this.productId,
    r'amount': this.amount,
    r'voucherPrefix': this.voucherPrefix,
    r'description': this.description,
    r'requester': this.requester,
  };

  IssueVoucherRequest Function({
    _i3.int? productId,
    _i3.int? amount,
    _i3.String? voucherPrefix,
    _i3.String? description,
    _i3.String? requester,
  })
  get copyWith {
    return ({
      _i3.int? productId,
      _i3.int? amount,
      _i3.String? voucherPrefix,
      _i3.String? description,
      _i3.String? requester,
    }) => IssueVoucherRequest(
      productId: productId ?? this.productId,
      amount: amount ?? this.amount,
      voucherPrefix: voucherPrefix ?? this.voucherPrefix,
      description: description ?? this.description,
      requester: requester ?? this.requester,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is IssueVoucherRequest &&
        other.productId == this.productId &&
        other.amount == this.amount &&
        other.voucherPrefix == this.voucherPrefix &&
        other.description == this.description &&
        other.requester == this.requester;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.productId,
      this.amount,
      this.voucherPrefix,
      this.description,
      this.requester,
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
    _$result[r'amount'] = _i1.PropertyValue.scalar(this.amount.toString());
    _$result[r'voucherPrefix'] = _i1.PropertyValue.scalar(this.voucherPrefix);
    _$result[r'description'] = _i1.PropertyValue.scalar(this.description);
    _$result[r'requester'] = _i1.PropertyValue.scalar(this.requester);
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
      r'Cannot uriEncode IssueVoucherRequest: complex types cannot be URI-encoded',
    );
  }
}
