// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/mobile_pay_payment_details_model.dart'
    as _i5;
import 'package:analog_api/src/model/payment_details.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// MobilePay Payment details
@_i2.immutable
class MobilePayPaymentDetails
    implements _i1.ParameterEncodable, _i1.UriEncodable {
  const MobilePayPaymentDetails({
    required this.paymentDetails,
    required this.mobilePayPaymentDetailsModel,
  });

  factory MobilePayPaymentDetails.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    return MobilePayPaymentDetails(
      paymentDetails: _i4.PaymentDetails.fromSimple(
        value,
        explode: explode,
        isHeader: isHeader,
      ),
      mobilePayPaymentDetailsModel: _i5.MobilePayPaymentDetailsModel.fromSimple(
        value,
        explode: explode,
        isHeader: isHeader,
      ),
    );
  }

  factory MobilePayPaymentDetails.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    return MobilePayPaymentDetails(
      paymentDetails: _i4.PaymentDetails.fromForm(value, explode: explode),
      mobilePayPaymentDetailsModel: _i5.MobilePayPaymentDetailsModel.fromForm(
        value,
        explode: explode,
      ),
    );
  }

  factory MobilePayPaymentDetails.fromJson(_i3.Object? json) {
    return MobilePayPaymentDetails(
      paymentDetails: _i4.PaymentDetails.fromJson(json),
      mobilePayPaymentDetailsModel: _i5.MobilePayPaymentDetailsModel.fromJson(
        json,
      ),
    );
  }

  final _i4.PaymentDetails paymentDetails;

  final _i5.MobilePayPaymentDetailsModel mobilePayPaymentDetailsModel;

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Object? toJson() {
    final _$map = <_i3.String, _i3.Object?>{};
    final _$paymentDetailsJson = this.paymentDetails.toJson();
    if (_$paymentDetailsJson is! _i3.Map<_i3.String, _i3.Object?>) {
      throw _i1.EncodingException(
        'Expected paymentDetails.toJson() to return Map<String, Object?>, got ${_$paymentDetailsJson.runtimeType}',
      );
    }
    _i1.mergeJsonObject(_$map, _$paymentDetailsJson);
    final _$mobilePayPaymentDetailsModelJson = this.mobilePayPaymentDetailsModel
        .toJson();
    if (_$mobilePayPaymentDetailsModelJson
        is! _i3.Map<_i3.String, _i3.Object?>) {
      throw _i1.EncodingException(
        'Expected mobilePayPaymentDetailsModel.toJson() to return Map<String, Object?>, got ${_$mobilePayPaymentDetailsModelJson.runtimeType}',
      );
    }
    _i1.mergeJsonObject(_$map, _$mobilePayPaymentDetailsModelJson);
    return _$map;
  }

  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$mergedProperties = <_i3.String, _i1.PropertyValue>{};
    _$mergedProperties.addAll(
      this.paymentDetails.parameterProperties(allowEmpty: allowEmpty),
    );
    _$mergedProperties.addAll(
      this.mobilePayPaymentDetailsModel.parameterProperties(
        allowEmpty: allowEmpty,
      ),
    );
    return _$mergedProperties;
  }

  @_i3.override
  _i3.String toSimple({
    required _i3.bool explode,
    required _i3.bool allowEmpty,
    _i3.bool literal = false,
  }) {
    return parameterProperties(allowEmpty: allowEmpty)
        .toSimple(explode: explode, allowEmpty: allowEmpty, literal: literal);
  }

  @_i3.override
  _i3.List<_i1.ParameterEntry> toForm(
    _i3.String paramName, {
    required _i3.bool explode,
    required _i3.bool allowEmpty,
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
    _i3.Map<_i3.String, _i1.FormFieldEncoding> fieldEncodings = const {},
  }) {
    return parameterProperties(allowEmpty: allowEmpty).toForm(
      paramName,
      explode: explode,
      allowEmpty: allowEmpty,
      useQueryComponent: useQueryComponent,
      allowReserved: allowReserved,
      fieldEncodings: fieldEncodings,
      textEncoding: textEncoding,
    );
  }

  @_i3.override
  _i3.String toLabel({
    required _i3.bool explode,
    required _i3.bool allowEmpty,
  }) {
    return parameterProperties(allowEmpty: allowEmpty)
        .toLabel(explode: explode, allowEmpty: allowEmpty);
  }

  @_i3.override
  _i3.String toMatrix(
    _i3.String paramName, {
    required _i3.bool explode,
    required _i3.bool allowEmpty,
  }) {
    return parameterProperties(allowEmpty: allowEmpty)
        .toMatrix(paramName, explode: explode, allowEmpty: allowEmpty);
  }

  @_i3.override
  _i3.List<_i1.ParameterEntry> toDeepObject(
    _i3.String paramName, {
    required _i3.bool explode,
    required _i3.bool allowEmpty,
    _i3.bool allowReserved = false,
  }) {
    return parameterProperties(allowEmpty: allowEmpty).toDeepObject(
      paramName,
      explode: explode,
      allowEmpty: allowEmpty,
      allowReserved: allowReserved,
    );
  }

  @_i3.override
  _i3.List<_i1.ParameterEntry> toPipeDelimited(
    _i3.String paramName, {
    required _i3.bool allowEmpty,
    _i3.bool allowReserved = false,
  }) {
    return parameterProperties(allowEmpty: allowEmpty).toPipeDelimited(
      paramName,
      allowEmpty: allowEmpty,
      allowReserved: allowReserved,
    );
  }

  @_i3.override
  _i3.List<_i1.ParameterEntry> toSpaceDelimited(
    _i3.String paramName, {
    required _i3.bool allowEmpty,
    _i3.bool allowReserved = false,
  }) {
    return parameterProperties(allowEmpty: allowEmpty).toSpaceDelimited(
      paramName,
      allowEmpty: allowEmpty,
      allowReserved: allowReserved,
    );
  }

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode MobilePayPaymentDetails: contains complex types',
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MobilePayPaymentDetails &&
        other.paymentDetails == this.paymentDetails &&
        other.mobilePayPaymentDetailsModel == this.mobilePayPaymentDetailsModel;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.paymentDetails,
      this.mobilePayPaymentDetailsModel,
    ]);
  }

  MobilePayPaymentDetails Function({
    _i4.PaymentDetails? paymentDetails,
    _i5.MobilePayPaymentDetailsModel? mobilePayPaymentDetailsModel,
  })
  get copyWith {
    return ({
      _i4.PaymentDetails? paymentDetails,
      _i5.MobilePayPaymentDetailsModel? mobilePayPaymentDetailsModel,
    }) => MobilePayPaymentDetails(
      paymentDetails: paymentDetails ?? this.paymentDetails,
      mobilePayPaymentDetailsModel:
          mobilePayPaymentDetailsModel ?? this.mobilePayPaymentDetailsModel,
    );
  }
}
