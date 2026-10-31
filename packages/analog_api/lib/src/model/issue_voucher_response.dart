// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Response object for creating voucher codes
@_i2.immutable
class IssueVoucherResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const IssueVoucherResponse({
    required this.voucherCode,
    required this.productId,
    required this.productName,
    required this.issuedAt,
  });

  factory IssueVoucherResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'voucherCode', r'productId', r'productName', r'issuedAt'},
      listKeys: {},
      context: r'IssueVoucherResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return IssueVoucherResponse(
      voucherCode: _$values[r'voucherCode'].decodeSimpleString(
        context: r'IssueVoucherResponse.voucherCode',
      ),
      productId: _$values[r'productId'].decodeSimpleInt(
        context: r'IssueVoucherResponse.productId',
      ),
      productName: _$values[r'productName'].decodeSimpleString(
        context: r'IssueVoucherResponse.productName',
      ),
      issuedAt: _$values[r'issuedAt'].decodeSimpleDateTime(
        context: r'IssueVoucherResponse.issuedAt',
      ),
    );
  }

  factory IssueVoucherResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'IssueVoucherResponse');
    return IssueVoucherResponse(
      voucherCode: _$map[r'voucherCode'].decodeJsonString(
        context: r'IssueVoucherResponse.voucherCode',
      ),
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'IssueVoucherResponse.productId',
      ),
      productName: _$map[r'productName'].decodeJsonString(
        context: r'IssueVoucherResponse.productName',
      ),
      issuedAt: _$map[r'issuedAt'].decodeJsonDateTime(
        context: r'IssueVoucherResponse.issuedAt',
      ),
    );
  }

  factory IssueVoucherResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'voucherCode', r'productId', r'productName', r'issuedAt'},
      listKeys: {},
      context: r'IssueVoucherResponse',
    );
    return IssueVoucherResponse(
      voucherCode: _$values[r'voucherCode'].decodeFormString(
        context: r'IssueVoucherResponse.voucherCode',
      ),
      productId: _$values[r'productId'].decodeFormInt(
        context: r'IssueVoucherResponse.productId',
      ),
      productName: _$values[r'productName'].decodeFormString(
        context: r'IssueVoucherResponse.productName',
      ),
      issuedAt: _$values[r'issuedAt'].decodeFormDateTime(
        context: r'IssueVoucherResponse.issuedAt',
      ),
    );
  }

  /// Voucher code to be redeemed in the app
  final _i3.String voucherCode;

  /// The id of the product the voucher code is for
  final _i3.int productId;

  /// The name of the product the voucher code is for
  final _i3.String productName;

  /// The date the voucher code was created
  final _i3.DateTime issuedAt;

  @_i3.override
  _i3.Object? toJson() => {
    r'voucherCode': this.voucherCode,
    r'productId': this.productId,
    r'productName': this.productName,
    r'issuedAt': this.issuedAt.toTimeZonedIso8601String(),
  };

  IssueVoucherResponse Function({
    _i3.String? voucherCode,
    _i3.int? productId,
    _i3.String? productName,
    _i3.DateTime? issuedAt,
  })
  get copyWith {
    return ({
      _i3.String? voucherCode,
      _i3.int? productId,
      _i3.String? productName,
      _i3.DateTime? issuedAt,
    }) => IssueVoucherResponse(
      voucherCode: voucherCode ?? this.voucherCode,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      issuedAt: issuedAt ?? this.issuedAt,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is IssueVoucherResponse &&
        other.voucherCode == this.voucherCode &&
        other.productId == this.productId &&
        other.productName == this.productName &&
        other.issuedAt == this.issuedAt;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.voucherCode,
      this.productId,
      this.productName,
      this.issuedAt,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'voucherCode'] = _i1.PropertyValue.scalar(this.voucherCode);
    _$result[r'productId'] = _i1.PropertyValue.scalar(
      this.productId.toString(),
    );
    _$result[r'productName'] = _i1.PropertyValue.scalar(this.productName);
    _$result[r'issuedAt'] = _i1.PropertyValue.scalar(
      this.issuedAt.toTimeZonedIso8601String(),
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
      r'Cannot uriEncode IssueVoucherResponse: complex types cannot be URI-encoded',
    );
  }
}
