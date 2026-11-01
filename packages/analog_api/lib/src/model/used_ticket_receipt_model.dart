// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

@_i2.immutable
class UsedTicketReceiptModel extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UsedTicketReceiptModel({
    required this.swipeDate,
    required this.menuItemName,
  });

  factory UsedTicketReceiptModel.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'swipeDate', r'menuItemName'},
      listKeys: {},
      context: r'UsedTicketReceiptModel',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UsedTicketReceiptModel(
      swipeDate: _$values[r'swipeDate'].decodeSimpleDateTime(
        context: r'UsedTicketReceiptModel.swipeDate',
      ),
      menuItemName: _$values[r'menuItemName'].decodeSimpleString(
        context: r'UsedTicketReceiptModel.menuItemName',
      ),
    );
  }

  factory UsedTicketReceiptModel.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UsedTicketReceiptModel');
    return UsedTicketReceiptModel(
      swipeDate: _$map[r'swipeDate'].decodeJsonDateTime(
        context: r'UsedTicketReceiptModel.swipeDate',
      ),
      menuItemName: _$map[r'menuItemName'].decodeJsonString(
        context: r'UsedTicketReceiptModel.menuItemName',
      ),
    );
  }

  factory UsedTicketReceiptModel.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'swipeDate', r'menuItemName'},
      listKeys: {},
      context: r'UsedTicketReceiptModel',
    );
    return UsedTicketReceiptModel(
      swipeDate: _$values[r'swipeDate'].decodeFormDateTime(
        context: r'UsedTicketReceiptModel.swipeDate',
      ),
      menuItemName: _$values[r'menuItemName'].decodeFormString(
        context: r'UsedTicketReceiptModel.menuItemName',
      ),
    );
  }

  /// The date and time when the swipe was made.
  final _i3.DateTime swipeDate;

  /// The name of the menu item that was redeemed with the ticket.
  final _i3.String menuItemName;

  @_i3.override
  _i3.Object? toJson() => {
    r'swipeDate': this.swipeDate.toTimeZonedIso8601String(),
    r'menuItemName': this.menuItemName,
  };

  UsedTicketReceiptModel Function({
    _i3.DateTime? swipeDate,
    _i3.String? menuItemName,
  })
  get copyWith {
    return ({_i3.DateTime? swipeDate, _i3.String? menuItemName}) =>
        UsedTicketReceiptModel(
          swipeDate: swipeDate ?? this.swipeDate,
          menuItemName: menuItemName ?? this.menuItemName,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UsedTicketReceiptModel &&
        other.swipeDate == this.swipeDate &&
        other.menuItemName == this.menuItemName;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.swipeDate, this.menuItemName]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'swipeDate'] = _i1.PropertyValue.scalar(
      this.swipeDate.toTimeZonedIso8601String(),
    );
    _$result[r'menuItemName'] = _i1.PropertyValue.scalar(this.menuItemName);
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
      r'Cannot uriEncode UsedTicketReceiptModel: complex types cannot be URI-encoded',
    );
  }
}
