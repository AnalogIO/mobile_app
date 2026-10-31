// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/user_group.dart' as _i4;
import 'package:collection/collection.dart' as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Initiate a new product add request.
@_i2.immutable
class AddProductRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const AddProductRequest({
    required this.price,
    required this.numberOfTickets,
    required this.name,
    required this.description,
    required this.allowedUserGroups,
    required this.menuItemIds,
    this.visible = visibleDefault,
  });

  factory AddProductRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {
        r'price',
        r'numberOfTickets',
        r'name',
        r'description',
        r'visible',
        r'allowedUserGroups',
        r'menuItemIds',
      },
      listKeys: {r'allowedUserGroups', r'menuItemIds'},
      context: r'AddProductRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return AddProductRequest(
      price: _$values[r'price'].decodeSimpleInt(
        context: r'AddProductRequest.price',
      ),
      numberOfTickets: _$values[r'numberOfTickets'].decodeSimpleInt(
        context: r'AddProductRequest.numberOfTickets',
      ),
      name: _$values[r'name'].decodeSimpleString(
        context: r'AddProductRequest.name',
      ),
      description: _$values[r'description'].decodeSimpleString(
        context: r'AddProductRequest.description',
      ),
      visible: _$values.containsKey(r'visible')
          ? _$values[r'visible'].decodeSimpleBool(
              context: r'AddProductRequest.visible',
            )
          : visibleDefault,
      allowedUserGroups: _$values[r'allowedUserGroups']
          .decodeSimpleStringList(
            context: r'AddProductRequest.allowedUserGroups',
            isHeader: isHeader,
          )
          .map((e) => _i4.UserGroup.fromSimple(e, explode: explode))
          .toList(),
      menuItemIds: _$values[r'menuItemIds']
          .decodeSimpleStringList(
            context: r'AddProductRequest.menuItemIds',
            isHeader: isHeader,
          )
          .map(
            (e) => e.decodeSimpleInt(context: r'AddProductRequest.menuItemIds'),
          )
          .toList(),
    );
  }

  factory AddProductRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'AddProductRequest');
    return AddProductRequest(
      price: _$map[r'price'].decodeJsonInt(context: r'AddProductRequest.price'),
      numberOfTickets: _$map[r'numberOfTickets'].decodeJsonInt(
        context: r'AddProductRequest.numberOfTickets',
      ),
      name: _$map[r'name'].decodeJsonString(context: r'AddProductRequest.name'),
      description: _$map[r'description'].decodeJsonString(
        context: r'AddProductRequest.description',
      ),
      visible: _$map.containsKey(r'visible')
          ? _$map[r'visible'].decodeJsonBool(
              context: r'AddProductRequest.visible',
            )
          : visibleDefault,
      allowedUserGroups: _$map[r'allowedUserGroups']
          .decodeJsonList<_i3.Object?>(
            context: r'AddProductRequest.allowedUserGroups',
          )
          .map(_i4.UserGroup.fromJson)
          .toList(),
      menuItemIds: _$map[r'menuItemIds'].decodeJsonList<_i3.int>(
        context: r'AddProductRequest.menuItemIds',
      ),
    );
  }

  factory AddProductRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {
        r'price',
        r'numberOfTickets',
        r'name',
        r'description',
        r'visible',
        r'allowedUserGroups',
        r'menuItemIds',
      },
      listKeys: {r'allowedUserGroups', r'menuItemIds'},
      context: r'AddProductRequest',
    );
    return AddProductRequest(
      price: _$values[r'price'].decodeFormInt(
        context: r'AddProductRequest.price',
      ),
      numberOfTickets: _$values[r'numberOfTickets'].decodeFormInt(
        context: r'AddProductRequest.numberOfTickets',
      ),
      name: _$values[r'name'].decodeFormString(
        context: r'AddProductRequest.name',
      ),
      description: _$values[r'description'].decodeFormString(
        context: r'AddProductRequest.description',
      ),
      visible: _$values.containsKey(r'visible')
          ? _$values[r'visible'].decodeFormBool(
              context: r'AddProductRequest.visible',
            )
          : visibleDefault,
      allowedUserGroups: _$values[r'allowedUserGroups']
          .decodeSimpleStringList(
            context: r'AddProductRequest.allowedUserGroups',
          )
          .map((e) => _i4.UserGroup.fromForm(e, explode: explode))
          .toList(),
      menuItemIds: _$values[r'menuItemIds']
          .decodeSimpleStringList(context: r'AddProductRequest.menuItemIds')
          .map(
            (e) => e.decodeFormInt(context: r'AddProductRequest.menuItemIds'),
          )
          .toList(),
    );
  }

  static const _i3.bool visibleDefault = true;

  /// Gets or sets the price of the product.
  ///
  /// **Example**:
  /// ```json
  /// 10
  /// ```
  final _i3.int price;

  /// Gets or sets the number of tickets associated with the product.
  ///
  /// **Example**:
  /// ```json
  /// 5
  /// ```
  final _i3.int numberOfTickets;

  /// Gets or sets the name of the product.
  ///
  /// **Example**:
  /// ```
  /// Latte
  /// ```
  final _i3.String name;

  /// Gets or sets the description of the product.
  ///
  /// **Example**:
  /// ```
  /// A homemade latte with soy milk
  /// ```
  final _i3.String description;

  /// Gets or sets the visibility of the product. Default is true.
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool visible;

  /// Gets or sets the user groups that can access the product.
  ///
  /// **Example**:
  /// ```json
  /// [
  ///   "Manager",
  ///   "Board"
  /// ]
  /// ```
  final _i3.List<_i4.UserGroup> allowedUserGroups;

  /// Gets or sets the menu items that are eligible for the product.
  ///
  /// **Example**:
  /// ```json
  /// [
  ///   1,
  ///   2
  /// ]
  /// ```
  final _i3.List<_i3.int> menuItemIds;

  @_i3.override
  _i3.Object? toJson() => {
    r'price': this.price,
    r'numberOfTickets': this.numberOfTickets,
    r'name': this.name,
    r'description': this.description,
    r'visible': this.visible,
    r'allowedUserGroups': this.allowedUserGroups
        .map((e) => e.toJson())
        .toList(),
    r'menuItemIds': this.menuItemIds,
  };

  AddProductRequest Function({
    _i3.int? price,
    _i3.int? numberOfTickets,
    _i3.String? name,
    _i3.String? description,
    _i3.bool? visible,
    _i3.List<_i4.UserGroup>? allowedUserGroups,
    _i3.List<_i3.int>? menuItemIds,
  })
  get copyWith {
    return ({
      _i3.int? price,
      _i3.int? numberOfTickets,
      _i3.String? name,
      _i3.String? description,
      _i3.bool? visible,
      _i3.List<_i4.UserGroup>? allowedUserGroups,
      _i3.List<_i3.int>? menuItemIds,
    }) => AddProductRequest(
      price: price ?? this.price,
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      name: name ?? this.name,
      description: description ?? this.description,
      visible: visible ?? this.visible,
      allowedUserGroups: allowedUserGroups ?? this.allowedUserGroups,
      menuItemIds: menuItemIds ?? this.menuItemIds,
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    const _$deepEquals = _i5.DeepCollectionEquality();
    return other is AddProductRequest &&
        other.price == this.price &&
        other.numberOfTickets == this.numberOfTickets &&
        other.name == this.name &&
        other.description == this.description &&
        other.visible == this.visible &&
        _$deepEquals.equals(other.allowedUserGroups, this.allowedUserGroups) &&
        _$deepEquals.equals(other.menuItemIds, this.menuItemIds);
  }

  @_i3.override
  _i3.int get hashCode {
    const deepEquals = _i5.DeepCollectionEquality();
    return _i3.Object.hashAll([
      this.price,
      this.numberOfTickets,
      this.name,
      this.description,
      this.visible,
      deepEquals.hash(this.allowedUserGroups),
      deepEquals.hash(this.menuItemIds),
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'price'] = _i1.PropertyValue.scalar(this.price.toString());
    _$result[r'numberOfTickets'] = _i1.PropertyValue.scalar(
      this.numberOfTickets.toString(),
    );
    _$result[r'name'] = _i1.PropertyValue.scalar(this.name);
    _$result[r'description'] = _i1.PropertyValue.scalar(this.description);
    _$result[r'visible'] = _i1.PropertyValue.scalar(this.visible.toString());
    _$result[r'allowedUserGroups'] = _i1.PropertyValue.array(
      this.allowedUserGroups.map((e) => e.toJson()).toList(),
    );
    _$result[r'menuItemIds'] = _i1.PropertyValue.array(
      this.menuItemIds.map((e) => e.toString()).toList(),
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
      r'Cannot uriEncode AddProductRequest: complex types cannot be URI-encoded',
    );
  }
}
