// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Representing a used ticket for a product
@_i2.immutable
class UsedTicketResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UsedTicketResponse({
    required this.id,
    required this.dateCreated,
    required this.dateUsed,
    required this.productName,
    this.menuItemName,
  });

  factory UsedTicketResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {
        r'id',
        r'dateCreated',
        r'dateUsed',
        r'productName',
        r'menuItemName',
      },
      listKeys: {},
      context: r'UsedTicketResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UsedTicketResponse(
      id: _$values[r'id'].decodeSimpleInt(context: r'UsedTicketResponse.id'),
      dateCreated: _$values[r'dateCreated'].decodeSimpleDateTime(
        context: r'UsedTicketResponse.dateCreated',
      ),
      dateUsed: _$values[r'dateUsed'].decodeSimpleDateTime(
        context: r'UsedTicketResponse.dateUsed',
      ),
      productName: _$values[r'productName'].decodeSimpleString(
        context: r'UsedTicketResponse.productName',
      ),
      menuItemName: _$values[r'menuItemName'].decodeSimpleNullableString(
        context: r'UsedTicketResponse.menuItemName',
      ),
    );
  }

  factory UsedTicketResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UsedTicketResponse');
    return UsedTicketResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'UsedTicketResponse.id'),
      dateCreated: _$map[r'dateCreated'].decodeJsonDateTime(
        context: r'UsedTicketResponse.dateCreated',
      ),
      dateUsed: _$map[r'dateUsed'].decodeJsonDateTime(
        context: r'UsedTicketResponse.dateUsed',
      ),
      productName: _$map[r'productName'].decodeJsonString(
        context: r'UsedTicketResponse.productName',
      ),
      menuItemName: _$map[r'menuItemName'].decodeJsonNullableString(
        context: r'UsedTicketResponse.menuItemName',
      ),
    );
  }

  factory UsedTicketResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {
        r'id',
        r'dateCreated',
        r'dateUsed',
        r'productName',
        r'menuItemName',
      },
      listKeys: {},
      context: r'UsedTicketResponse',
    );
    return UsedTicketResponse(
      id: _$values[r'id'].decodeFormInt(context: r'UsedTicketResponse.id'),
      dateCreated: _$values[r'dateCreated'].decodeFormDateTime(
        context: r'UsedTicketResponse.dateCreated',
      ),
      dateUsed: _$values[r'dateUsed'].decodeFormDateTime(
        context: r'UsedTicketResponse.dateUsed',
      ),
      productName: _$values[r'productName'].decodeFormString(
        context: r'UsedTicketResponse.productName',
      ),
      menuItemName: _$values[r'menuItemName'].decodeFormNullableString(
        context: r'UsedTicketResponse.menuItemName',
      ),
    );
  }

  /// Ticket Id
  ///
  /// **Example**:
  /// ```json
  /// 122
  /// ```
  final _i3.int id;

  /// Issuing date time for ticket in Utc format
  ///
  /// **Example**:
  /// ```
  /// 2022-01-09T21:03:52.2283208Z
  /// ```
  final _i3.DateTime dateCreated;

  /// Used date time for ticket in Utc format
  ///
  /// **Example**:
  /// ```
  /// 2022-01-09T21:03:52.2283208Z
  /// ```
  final _i3.DateTime dateUsed;

  /// Name of product a ticket is for
  ///
  /// **Example**:
  /// ```
  /// Small drink
  /// ```
  final _i3.String productName;

  /// Name of the menu item that this ticket was used on
  ///
  /// **Example**:
  /// ```
  /// Cappuccino
  /// ```
  final _i3.String? menuItemName;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'dateCreated': this.dateCreated.toTimeZonedIso8601String(),
    r'dateUsed': this.dateUsed.toTimeZonedIso8601String(),
    r'productName': this.productName,
    r'menuItemName': this.menuItemName,
  };

  UsedTicketResponse Function({
    _i3.int? id,
    _i3.DateTime? dateCreated,
    _i3.DateTime? dateUsed,
    _i3.String? productName,
    _i3.String? menuItemName,
  })
  get copyWith {
    const _i3.Object _sentinel = _i3.Object();
    return ({
      _i3.int? id,
      _i3.DateTime? dateCreated,
      _i3.DateTime? dateUsed,
      _i3.String? productName,
      _i3.Object? menuItemName = _sentinel,
    }) => UsedTicketResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUsed: dateUsed ?? this.dateUsed,
      productName: productName ?? this.productName,
      menuItemName: _i3.identical(menuItemName, _sentinel)
          ? this.menuItemName
          : (menuItemName as _i3.String?),
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UsedTicketResponse &&
        other.id == this.id &&
        other.dateCreated == this.dateCreated &&
        other.dateUsed == this.dateUsed &&
        other.productName == this.productName &&
        other.menuItemName == this.menuItemName;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.id,
      this.dateCreated,
      this.dateUsed,
      this.productName,
      this.menuItemName,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'id'] = _i1.PropertyValue.scalar(this.id.toString());
    _$result[r'dateCreated'] = _i1.PropertyValue.scalar(
      this.dateCreated.toTimeZonedIso8601String(),
    );
    _$result[r'dateUsed'] = _i1.PropertyValue.scalar(
      this.dateUsed.toTimeZonedIso8601String(),
    );
    _$result[r'productName'] = _i1.PropertyValue.scalar(this.productName);
    if (this.menuItemName != null) {
      _$result[r'menuItemName'] = _i1.PropertyValue.scalar(this.menuItemName!);
    }
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
      r'Cannot uriEncode UsedTicketResponse: complex types cannot be URI-encoded',
    );
  }
}
