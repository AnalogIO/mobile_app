// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Shared properties for all receipt types.
@_i2.immutable
class ReceiptBase extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const ReceiptBase({required this.$type, required this.productName});

  factory ReceiptBase.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'Type', r'productName'},
      listKeys: {},
      context: r'ReceiptBase',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return ReceiptBase(
      $type: _$values[r'Type'].decodeSimpleString(context: r'ReceiptBase.Type'),
      productName: _$values[r'productName'].decodeSimpleString(
        context: r'ReceiptBase.productName',
      ),
    );
  }

  factory ReceiptBase.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'ReceiptBase');
    return ReceiptBase(
      $type: _$map[r'Type'].decodeJsonString(context: r'ReceiptBase.Type'),
      productName: _$map[r'productName'].decodeJsonString(
        context: r'ReceiptBase.productName',
      ),
    );
  }

  factory ReceiptBase.fromForm(_i3.String? value, {required _i3.bool explode}) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'Type', r'productName'},
      listKeys: {},
      context: r'ReceiptBase',
    );
    return ReceiptBase(
      $type: _$values[r'Type'].decodeFormString(context: r'ReceiptBase.Type'),
      productName: _$values[r'productName'].decodeFormString(
        context: r'ReceiptBase.productName',
      ),
    );
  }

  final _i3.String $type;

  final _i3.String productName;

  @_i3.override
  _i3.Object? toJson() => {
    r'Type': this.$type,
    r'productName': this.productName,
  };

  ReceiptBase Function({_i3.String? $type, _i3.String? productName})
  get copyWith {
    return ({_i3.String? $type, _i3.String? productName}) => ReceiptBase(
      $type: $type ?? this.$type,
      productName: productName ?? this.productName,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ReceiptBase &&
        other.$type == this.$type &&
        other.productName == this.productName;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.$type, this.productName]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'Type'] = _i1.PropertyValue.scalar(this.$type);
    _$result[r'productName'] = _i1.PropertyValue.scalar(this.productName);
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
      r'Cannot uriEncode ReceiptBase: complex types cannot be URI-encoded',
    );
  }
}
