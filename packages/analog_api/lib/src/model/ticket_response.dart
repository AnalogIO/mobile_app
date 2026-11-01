// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Representing a ticket for a product
@_i2.immutable
class TicketResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const TicketResponse({
    required this.id,
    required this.dateCreated,
    required this.productId,
    required this.productName,
    this.dateUsed,
    this.usedOnMenuItemName,
  });

  factory TicketResponse.fromSimple(
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
        r'productId',
        r'productName',
        r'usedOnMenuItemName',
      },
      listKeys: {},
      context: r'TicketResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return TicketResponse(
      id: _$values[r'id'].decodeSimpleInt(context: r'TicketResponse.id'),
      dateCreated: _$values[r'dateCreated'].decodeSimpleDateTime(
        context: r'TicketResponse.dateCreated',
      ),
      dateUsed: _$values[r'dateUsed'].decodeSimpleNullableDateTime(
        context: r'TicketResponse.dateUsed',
      ),
      productId: _$values[r'productId'].decodeSimpleInt(
        context: r'TicketResponse.productId',
      ),
      productName: _$values[r'productName'].decodeSimpleString(
        context: r'TicketResponse.productName',
      ),
      usedOnMenuItemName: _$values[r'usedOnMenuItemName']
          .decodeSimpleNullableString(
            context: r'TicketResponse.usedOnMenuItemName',
          ),
    );
  }

  factory TicketResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'TicketResponse');
    return TicketResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'TicketResponse.id'),
      dateCreated: _$map[r'dateCreated'].decodeJsonDateTime(
        context: r'TicketResponse.dateCreated',
      ),
      dateUsed: _$map[r'dateUsed'].decodeJsonNullableDateTime(
        context: r'TicketResponse.dateUsed',
      ),
      productId: _$map[r'productId'].decodeJsonInt(
        context: r'TicketResponse.productId',
      ),
      productName: _$map[r'productName'].decodeJsonString(
        context: r'TicketResponse.productName',
      ),
      usedOnMenuItemName: _$map[r'usedOnMenuItemName'].decodeJsonNullableString(
        context: r'TicketResponse.usedOnMenuItemName',
      ),
    );
  }

  factory TicketResponse.fromForm(
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
        r'productId',
        r'productName',
        r'usedOnMenuItemName',
      },
      listKeys: {},
      context: r'TicketResponse',
    );
    return TicketResponse(
      id: _$values[r'id'].decodeFormInt(context: r'TicketResponse.id'),
      dateCreated: _$values[r'dateCreated'].decodeFormDateTime(
        context: r'TicketResponse.dateCreated',
      ),
      dateUsed: _$values[r'dateUsed'].decodeFormNullableDateTime(
        context: r'TicketResponse.dateUsed',
      ),
      productId: _$values[r'productId'].decodeFormInt(
        context: r'TicketResponse.productId',
      ),
      productName: _$values[r'productName'].decodeFormString(
        context: r'TicketResponse.productName',
      ),
      usedOnMenuItemName: _$values[r'usedOnMenuItemName']
          .decodeFormNullableString(
            context: r'TicketResponse.usedOnMenuItemName',
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
  final _i3.DateTime? dateUsed;

  /// The Id of product a ticket is for
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int productId;

  /// Name of product a ticket is for
  ///
  /// **Example**:
  /// ```
  /// Coffee
  /// ```
  final _i3.String productName;

  /// The name of the menu item that this ticket was used on
  ///
  /// **Example**:
  /// ```
  /// Cappuccino
  /// ```
  final _i3.String? usedOnMenuItemName;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'dateCreated': this.dateCreated.toTimeZonedIso8601String(),
    r'dateUsed': this.dateUsed?.toTimeZonedIso8601String(),
    r'productId': this.productId,
    r'productName': this.productName,
    r'usedOnMenuItemName': this.usedOnMenuItemName,
  };

  TicketResponse Function({
    _i3.int? id,
    _i3.DateTime? dateCreated,
    _i3.DateTime? dateUsed,
    _i3.int? productId,
    _i3.String? productName,
    _i3.String? usedOnMenuItemName,
  })
  get copyWith {
    const _i3.Object _sentinel = _i3.Object();
    return ({
      _i3.int? id,
      _i3.DateTime? dateCreated,
      _i3.Object? dateUsed = _sentinel,
      _i3.int? productId,
      _i3.String? productName,
      _i3.Object? usedOnMenuItemName = _sentinel,
    }) => TicketResponse(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUsed: _i3.identical(dateUsed, _sentinel)
          ? this.dateUsed
          : (dateUsed as _i3.DateTime?),
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      usedOnMenuItemName: _i3.identical(usedOnMenuItemName, _sentinel)
          ? this.usedOnMenuItemName
          : (usedOnMenuItemName as _i3.String?),
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is TicketResponse &&
        other.id == this.id &&
        other.dateCreated == this.dateCreated &&
        other.dateUsed == this.dateUsed &&
        other.productId == this.productId &&
        other.productName == this.productName &&
        other.usedOnMenuItemName == this.usedOnMenuItemName;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.id,
      this.dateCreated,
      this.dateUsed,
      this.productId,
      this.productName,
      this.usedOnMenuItemName,
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
    if (this.dateUsed != null) {
      _$result[r'dateUsed'] = _i1.PropertyValue.scalar(
        this.dateUsed!.toTimeZonedIso8601String(),
      );
    }
    _$result[r'productId'] = _i1.PropertyValue.scalar(
      this.productId.toString(),
    );
    _$result[r'productName'] = _i1.PropertyValue.scalar(this.productName);
    if (this.usedOnMenuItemName != null) {
      _$result[r'usedOnMenuItemName'] = _i1.PropertyValue.scalar(
        this.usedOnMenuItemName!,
      );
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
      r'Cannot uriEncode TicketResponse: complex types cannot be URI-encoded',
    );
  }
}
