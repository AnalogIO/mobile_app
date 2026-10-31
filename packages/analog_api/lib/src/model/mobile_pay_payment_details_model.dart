// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

@_i2.immutable
class MobilePayPaymentDetailsModel extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const MobilePayPaymentDetailsModel({
    required this.mobilePayAppRedirectUri,
    required this.paymentId,
  });

  factory MobilePayPaymentDetailsModel.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'mobilePayAppRedirectUri', r'paymentId'},
      listKeys: {},
      context: r'MobilePayPaymentDetailsModel',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return MobilePayPaymentDetailsModel(
      mobilePayAppRedirectUri: _$values[r'mobilePayAppRedirectUri']
          .decodeSimpleString(
            context: r'MobilePayPaymentDetailsModel.mobilePayAppRedirectUri',
          ),
      paymentId: _$values[r'paymentId'].decodeSimpleString(
        context: r'MobilePayPaymentDetailsModel.paymentId',
      ),
    );
  }

  factory MobilePayPaymentDetailsModel.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'MobilePayPaymentDetailsModel');
    return MobilePayPaymentDetailsModel(
      mobilePayAppRedirectUri: _$map[r'mobilePayAppRedirectUri']
          .decodeJsonString(
            context: r'MobilePayPaymentDetailsModel.mobilePayAppRedirectUri',
          ),
      paymentId: _$map[r'paymentId'].decodeJsonString(
        context: r'MobilePayPaymentDetailsModel.paymentId',
      ),
    );
  }

  factory MobilePayPaymentDetailsModel.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'mobilePayAppRedirectUri', r'paymentId'},
      listKeys: {},
      context: r'MobilePayPaymentDetailsModel',
    );
    return MobilePayPaymentDetailsModel(
      mobilePayAppRedirectUri: _$values[r'mobilePayAppRedirectUri']
          .decodeFormString(
            context: r'MobilePayPaymentDetailsModel.mobilePayAppRedirectUri',
          ),
      paymentId: _$values[r'paymentId'].decodeFormString(
        context: r'MobilePayPaymentDetailsModel.paymentId',
      ),
    );
  }

  /// App deeplink for a MobilePay payment
  ///
  /// **Example**:
  /// ```
  /// mobilepay://merchant_payments?payment_id=186d2b31-ff25-4414-9fd1-bfe9807fa8b7
  /// ```
  final _i3.String mobilePayAppRedirectUri;

  /// MobilePay Id for a payment
  ///
  /// **Example**:
  /// ```
  /// 186d2b31-ff25-4414-9fd1-bfe9807fa8b7
  /// ```
  final _i3.String paymentId;

  @_i3.override
  _i3.Object? toJson() => {
    r'mobilePayAppRedirectUri': this.mobilePayAppRedirectUri,
    r'paymentId': this.paymentId,
  };

  MobilePayPaymentDetailsModel Function({
    _i3.String? mobilePayAppRedirectUri,
    _i3.String? paymentId,
  })
  get copyWith {
    return ({_i3.String? mobilePayAppRedirectUri, _i3.String? paymentId}) =>
        MobilePayPaymentDetailsModel(
          mobilePayAppRedirectUri:
              mobilePayAppRedirectUri ?? this.mobilePayAppRedirectUri,
          paymentId: paymentId ?? this.paymentId,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MobilePayPaymentDetailsModel &&
        other.mobilePayAppRedirectUri == this.mobilePayAppRedirectUri &&
        other.paymentId == this.paymentId;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.mobilePayAppRedirectUri, this.paymentId]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'mobilePayAppRedirectUri'] = _i1.PropertyValue.scalar(
      this.mobilePayAppRedirectUri,
    );
    _$result[r'paymentId'] = _i1.PropertyValue.scalar(this.paymentId);
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
      r'Cannot uriEncode MobilePayPaymentDetailsModel: complex types cannot be URI-encoded',
    );
  }
}
