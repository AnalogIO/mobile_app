// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i7;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/menu_item_response.dart' as _i5;
import 'package:analog_api/src/model/user_group.dart' as _i4;
import 'package:collection/collection.dart' as _i6;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents a purchasable product
@_i2.immutable
class ProductResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const ProductResponse({
    required this.id,
    required this.price,
    required this.numberOfTickets,
    required this.name,
    required this.description,
    required this.isPerk,
    required this.visible,
    required this.allowedUserGroups,
    required this.eligibleMenuItems,
  });

  factory ProductResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    throw _i1.SimpleDecodingException(
      r'Simple encoding not supported for ProductResponse: contains complex types',
    );
  }

  factory ProductResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'ProductResponse');
    return ProductResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'ProductResponse.id'),
      price: _$map[r'price'].decodeJsonInt(context: r'ProductResponse.price'),
      numberOfTickets: _$map[r'numberOfTickets'].decodeJsonInt(
        context: r'ProductResponse.numberOfTickets',
      ),
      name: _$map[r'name'].decodeJsonString(context: r'ProductResponse.name'),
      description: _$map[r'description'].decodeJsonString(
        context: r'ProductResponse.description',
      ),
      isPerk: _$map[r'isPerk'].decodeJsonBool(
        context: r'ProductResponse.isPerk',
      ),
      visible: _$map[r'visible'].decodeJsonBool(
        context: r'ProductResponse.visible',
      ),
      allowedUserGroups: _$map[r'allowedUserGroups']
          .decodeJsonList<_i3.Object?>(
            context: r'ProductResponse.allowedUserGroups',
          )
          .map(_i4.UserGroup.fromJson)
          .toList(),
      eligibleMenuItems: _$map[r'eligibleMenuItems']
          .decodeJsonList<_i3.Object?>(
            context: r'ProductResponse.eligibleMenuItems',
          )
          .map(_i5.MenuItemResponse.fromJson)
          .toList(),
    );
  }

  factory ProductResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    throw _i1.FormDecodingException(
      r'Form encoding not supported for ProductResponse: contains complex types',
    );
  }

  /// Id of product
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int id;

  /// Product price
  ///
  /// **Example**:
  /// ```json
  /// 300
  /// ```
  final _i3.int price;

  /// Number of tickets in product
  ///
  /// **Example**:
  /// ```json
  /// 10
  /// ```
  final _i3.int numberOfTickets;

  /// Name of product
  ///
  /// **Example**:
  /// ```
  /// Coffee clip card
  /// ```
  final _i3.String name;

  /// Description of products
  ///
  /// **Example**:
  /// ```
  /// Coffee clip card of 10 clips
  /// ```
  final _i3.String description;

  /// Eligible due to a user perk privilege
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool isPerk;

  /// Visibility of products for users
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool visible;

  /// Decides the user groups that can access the product.
  ///
  /// **Example**:
  /// ```
  ///  Manager, Board
  /// ```
  final _i3.List<_i4.UserGroup> allowedUserGroups;

  /// The menu items that this product can be used on.
  ///
  /// **Example**:
  /// ```json
  /// [
  ///   "Cappuccino",
  ///   "Caffe Latte"
  /// ]
  /// ```
  final _i3.List<_i5.MenuItemResponse> eligibleMenuItems;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'price': this.price,
    r'numberOfTickets': this.numberOfTickets,
    r'name': this.name,
    r'description': this.description,
    r'isPerk': this.isPerk,
    r'visible': this.visible,
    r'allowedUserGroups': this.allowedUserGroups
        .map((e) => e.toJson())
        .toList(),
    r'eligibleMenuItems': this.eligibleMenuItems
        .map((e) => e.toJson())
        .toList(),
  };

  ProductResponse Function({
    _i3.int? id,
    _i3.int? price,
    _i3.int? numberOfTickets,
    _i3.String? name,
    _i3.String? description,
    _i3.bool? isPerk,
    _i3.bool? visible,
    _i3.List<_i4.UserGroup>? allowedUserGroups,
    _i3.List<_i5.MenuItemResponse>? eligibleMenuItems,
  })
  get copyWith {
    return ({
      _i3.int? id,
      _i3.int? price,
      _i3.int? numberOfTickets,
      _i3.String? name,
      _i3.String? description,
      _i3.bool? isPerk,
      _i3.bool? visible,
      _i3.List<_i4.UserGroup>? allowedUserGroups,
      _i3.List<_i5.MenuItemResponse>? eligibleMenuItems,
    }) => ProductResponse(
      id: id ?? this.id,
      price: price ?? this.price,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      name: name ?? this.name,
      description: description ?? this.description,
      isPerk: isPerk ?? this.isPerk,
      visible: visible ?? this.visible,
      allowedUserGroups: allowedUserGroups ?? this.allowedUserGroups,
      eligibleMenuItems: eligibleMenuItems ?? this.eligibleMenuItems,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    const _$deepEquals = _i6.DeepCollectionEquality();
    return other is ProductResponse &&
        other.id == this.id &&
        other.price == this.price &&
        other.numberOfTickets == this.numberOfTickets &&
        other.name == this.name &&
        other.description == this.description &&
        other.isPerk == this.isPerk &&
        other.visible == this.visible &&
        _$deepEquals.equals(other.allowedUserGroups, this.allowedUserGroups) &&
        _$deepEquals.equals(other.eligibleMenuItems, this.eligibleMenuItems);
  }

  @_i3.override
  _i3.int get hashCode {
    const deepEquals = _i6.DeepCollectionEquality();
    return _i3.Object.hashAll([
      this.id,
      this.price,
      this.numberOfTickets,
      this.name,
      this.description,
      this.isPerk,
      this.visible,
      deepEquals.hash(this.allowedUserGroups),
      deepEquals.hash(this.eligibleMenuItems),
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) => throw _i1.EncodingException(
    r'parameterProperties not supported for ProductResponse: contains complex types',
  );

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i7.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode ProductResponse: complex types cannot be URI-encoded',
    );
  }
}
