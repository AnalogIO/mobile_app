// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/menu_item_response.dart' as _i4;
import 'package:collection/collection.dart' as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// A collection of unused tickets a user owns for a product.
@_i2.immutable
class GroupedTicketsResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const GroupedTicketsResponse({
    required this.productId,
    required this.productName,
    required this.ticketsLeft,
    required this.eligibleMenuItems,
  });

  factory GroupedTicketsResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    throw _i1.SimpleDecodingException(
      r'Simple encoding not supported for GroupedTicketsResponse: contains complex types',
    );
  }

  factory GroupedTicketsResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'GroupedTicketsResponse');
    return GroupedTicketsResponse(
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'GroupedTicketsResponse.productId',
      ),
      productName: _$map[r'productName'].decodeJsonString(
        context: r'GroupedTicketsResponse.productName',
      ),
      ticketsLeft: _$map[r'ticketsLeft'].decodeJsonInt(
        context: r'GroupedTicketsResponse.ticketsLeft',
      ),
      eligibleMenuItems: _$map[r'eligibleMenuItems']
          .decodeJsonList<_i3.Object?>(
            context: r'GroupedTicketsResponse.eligibleMenuItems',
          )
          .map(_i4.MenuItemResponse.fromJson)
          .toList(),
    );
  }

  factory GroupedTicketsResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    throw _i1.FormDecodingException(
      r'Form encoding not supported for GroupedTicketsResponse: contains complex types',
    );
  }

  /// Id of product
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int productId;

  /// Name of product
  ///
  /// **Example**:
  /// ```
  /// Filter Coffee
  /// ```
  final _i3.String productName;

  /// Remaining (if any) unused tickets left for product
  ///
  /// **Example**:
  /// ```json
  /// 5
  /// ```
  final _i3.int ticketsLeft;

  /// The menu items that this ticket can be used on.
  ///
  /// **Example**:
  /// ```json
  /// [
  ///   {
  ///     "id": 1,
  ///     "name": "Cappuccino",
  ///     "active": true
  ///   },
  ///   {
  ///     "id": 2,
  ///     "name": "Caffe Latte",
  ///     "active": false
  ///   }
  /// ]
  /// ```
  final _i3.List<_i4.MenuItemResponse> eligibleMenuItems;

  @_i3.override
  _i3.Object? toJson() => {
    r'productId': this.productId,
    r'productName': this.productName,
    r'ticketsLeft': this.ticketsLeft,
    r'eligibleMenuItems': this.eligibleMenuItems
        .map((e) => e.toJson())
        .toList(),
  };

  GroupedTicketsResponse Function({
    _i3.int? productId,
    _i3.String? productName,
    _i3.int? ticketsLeft,
    _i3.List<_i4.MenuItemResponse>? eligibleMenuItems,
  })
  get copyWith {
    return ({
      _i3.int? productId,
      _i3.String? productName,
      _i3.int? ticketsLeft,
      _i3.List<_i4.MenuItemResponse>? eligibleMenuItems,
    }) => GroupedTicketsResponse(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      ticketsLeft: ticketsLeft ?? this.ticketsLeft,
      eligibleMenuItems: eligibleMenuItems ?? this.eligibleMenuItems,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    const _$deepEquals = _i5.DeepCollectionEquality();
    return other is GroupedTicketsResponse &&
        other.productId == this.productId &&
        other.productName == this.productName &&
        other.ticketsLeft == this.ticketsLeft &&
        _$deepEquals.equals(other.eligibleMenuItems, this.eligibleMenuItems);
  }

  @_i3.override
  _i3.int get hashCode {
    const deepEquals = _i5.DeepCollectionEquality();
    return _i3.Object.hashAll([
      this.productId,
      this.productName,
      this.ticketsLeft,
      deepEquals.hash(this.eligibleMenuItems),
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) => throw _i1.EncodingException(
    r'parameterProperties not supported for GroupedTicketsResponse: contains complex types',
  );

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode GroupedTicketsResponse: complex types cannot be URI-encoded',
    );
  }
}
