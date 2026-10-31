// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/receipt_base.dart' as _i4;
import 'package:analog_api/src/model/used_ticket_receipt_model.dart' as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents a receipt for a ticket being used by a swipe
@_i2.immutable
class UsedTicketReceipt implements _i1.ParameterEncodable, _i1.UriEncodable {
  const UsedTicketReceipt({
    required this.receiptBase,
    required this.usedTicketReceiptModel,
  });

  factory UsedTicketReceipt.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    return UsedTicketReceipt(
      receiptBase: _i4.ReceiptBase.fromSimple(
        value,
        explode: explode,
        isHeader: isHeader,
      ),
      usedTicketReceiptModel: _i5.UsedTicketReceiptModel.fromSimple(
        value,
        explode: explode,
        isHeader: isHeader,
      ),
    );
  }

  factory UsedTicketReceipt.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    return UsedTicketReceipt(
      receiptBase: _i4.ReceiptBase.fromForm(value, explode: explode),
      usedTicketReceiptModel: _i5.UsedTicketReceiptModel.fromForm(
        value,
        explode: explode,
      ),
    );
  }

  factory UsedTicketReceipt.fromJson(_i3.Object? json) {
    return UsedTicketReceipt(
      receiptBase: _i4.ReceiptBase.fromJson(json),
      usedTicketReceiptModel: _i5.UsedTicketReceiptModel.fromJson(json),
    );
  }

  final _i4.ReceiptBase receiptBase;

  final _i5.UsedTicketReceiptModel usedTicketReceiptModel;

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Object? toJson() {
    final _$map = <_i3.String, _i3.Object?>{};
    final _$receiptBaseJson = this.receiptBase.toJson();
    if (_$receiptBaseJson is! _i3.Map<_i3.String, _i3.Object?>) {
      throw _i1.EncodingException(
        'Expected receiptBase.toJson() to return Map<String, Object?>, got ${_$receiptBaseJson.runtimeType}',
      );
    }
    _i1.mergeJsonObject(_$map, _$receiptBaseJson);
    final _$usedTicketReceiptModelJson = this.usedTicketReceiptModel.toJson();
    if (_$usedTicketReceiptModelJson is! _i3.Map<_i3.String, _i3.Object?>) {
      throw _i1.EncodingException(
        'Expected usedTicketReceiptModel.toJson() to return Map<String, Object?>, got ${_$usedTicketReceiptModelJson.runtimeType}',
      );
    }
    _i1.mergeJsonObject(_$map, _$usedTicketReceiptModelJson);
    return _$map;
  }

  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$mergedProperties = <_i3.String, _i1.PropertyValue>{};
    _$mergedProperties.addAll(
      this.receiptBase.parameterProperties(allowEmpty: allowEmpty),
    );
    _$mergedProperties.addAll(
      this.usedTicketReceiptModel.parameterProperties(allowEmpty: allowEmpty),
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
      r'Cannot uriEncode UsedTicketReceipt: contains complex types',
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UsedTicketReceipt &&
        other.receiptBase == this.receiptBase &&
        other.usedTicketReceiptModel == this.usedTicketReceiptModel;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.receiptBase, this.usedTicketReceiptModel]);
  }

  UsedTicketReceipt Function({
    _i4.ReceiptBase? receiptBase,
    _i5.UsedTicketReceiptModel? usedTicketReceiptModel,
  })
  get copyWith {
    return ({
      _i4.ReceiptBase? receiptBase,
      _i5.UsedTicketReceiptModel? usedTicketReceiptModel,
    }) => UsedTicketReceipt(
      receiptBase: receiptBase ?? this.receiptBase,
      usedTicketReceiptModel:
          usedTicketReceiptModel ?? this.usedTicketReceiptModel,
    );
  }
}
