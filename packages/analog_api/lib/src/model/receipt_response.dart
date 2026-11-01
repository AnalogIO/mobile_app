// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/receipt_response_receipts_array_one_of_model.dart'
    as _i4;
import 'package:collection/collection.dart' as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

@_i2.immutable
class ReceiptResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const ReceiptResponse({
    required this.receipts,
    required this.continuationToken,
  });

  factory ReceiptResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    throw _i1.SimpleDecodingException(
      r'Simple encoding not supported for ReceiptResponse: contains complex types',
    );
  }

  factory ReceiptResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'ReceiptResponse');
    return ReceiptResponse(
      receipts: _$map[r'receipts']
          .decodeJsonList<_i3.Object?>(context: r'ReceiptResponse.receipts')
          .map(_i4.ReceiptResponseReceiptsArrayOneOfModel.fromJson)
          .toList(),
      continuationToken: _$map[r'continuationToken'].decodeJsonString(
        context: r'ReceiptResponse.continuationToken',
      ),
    );
  }

  factory ReceiptResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    throw _i1.FormDecodingException(
      r'Form encoding not supported for ReceiptResponse: contains complex types',
    );
  }

  /// The list of receipts for the user.
  final _i3.List<_i4.ReceiptResponseReceiptsArrayOneOfModel> receipts;

  /// Used as the "from" parameter in the next request to get the next batch of receipts.
  /// Is set to the date and time of the oldest receipt in the current batch.
  final _i3.String continuationToken;

  @_i3.override
  _i3.Object? toJson() => {
    r'receipts': this.receipts.map((e) => e.toJson()).toList(),
    r'continuationToken': this.continuationToken,
  };

  ReceiptResponse Function({
    _i3.List<_i4.ReceiptResponseReceiptsArrayOneOfModel>? receipts,
    _i3.String? continuationToken,
  })
  get copyWith {
    return ({
      _i3.List<_i4.ReceiptResponseReceiptsArrayOneOfModel>? receipts,
      _i3.String? continuationToken,
    }) => ReceiptResponse(
      receipts: receipts ?? this.receipts,
      continuationToken: continuationToken ?? this.continuationToken,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    const _$deepEquals = _i5.DeepCollectionEquality();
    return other is ReceiptResponse &&
        _$deepEquals.equals(other.receipts, this.receipts) &&
        other.continuationToken == this.continuationToken;
  }

  @_i3.override
  _i3.int get hashCode {
    const deepEquals = _i5.DeepCollectionEquality();
    return _i3.Object.hashAll([
      deepEquals.hash(this.receipts),
      this.continuationToken,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) => throw _i1.EncodingException(
    r'parameterProperties not supported for ReceiptResponse: contains complex types',
  );

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode ReceiptResponse: complex types cannot be URI-encoded',
    );
  }
}
