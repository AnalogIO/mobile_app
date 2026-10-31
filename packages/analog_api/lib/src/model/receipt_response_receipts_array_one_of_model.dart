// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i7;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/purchase_receipt.dart' as _i4;
import 'package:analog_api/src/model/used_ticket_receipt.dart' as _i6;
import 'package:analog_api/src/model/voucher_receipt.dart' as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Shared properties for all receipt types.
@_i2.immutable
sealed class ReceiptResponseReceiptsArrayOneOfModel
    implements _i1.ParameterEncodable, _i1.UriEncodable {
  const ReceiptResponseReceiptsArrayOneOfModel();

  factory ReceiptResponseReceiptsArrayOneOfModel.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    if (explode && value != null && value.isNotEmpty) {
      _i3.String? _$discriminator;
      if (isHeader) {
        _$discriminator = value.findHeaderDiscriminator(r'Type', {
          r'Purchase',
          r'Voucher',
          r'UsedTicket',
        });
      } else {
        final _$pairs = value.split(',');
        for (final pair in _$pairs) {
          final _$separator = pair.indexOf('=');
          if (_$separator >= 0) {
            final _$key = pair.substring(0, _$separator);
            if (_$key == r'Type') {
              _$discriminator = pair.substring(_$separator + 1);
              break;
            }
          }
        }
      }
      if (_$discriminator == r'Purchase') {
        return ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(
          _i4.PurchaseReceipt.fromSimple(
            value,
            explode: explode,
            isHeader: isHeader,
          ),
        );
      }
      if (_$discriminator == r'Voucher') {
        return ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(
          _i5.VoucherReceipt.fromSimple(
            value,
            explode: explode,
            isHeader: isHeader,
          ),
        );
      }
      if (_$discriminator == r'UsedTicket') {
        return ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(
          _i6.UsedTicketReceipt.fromSimple(
            value,
            explode: explode,
            isHeader: isHeader,
          ),
        );
      }
    }
    try {
      return ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(
        _i4.PurchaseReceipt.fromSimple(
          value,
          explode: explode,
          isHeader: isHeader,
        ),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    try {
      return ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(
        _i6.UsedTicketReceipt.fromSimple(
          value,
          explode: explode,
          isHeader: isHeader,
        ),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    try {
      return ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(
        _i5.VoucherReceipt.fromSimple(
          value,
          explode: explode,
          isHeader: isHeader,
        ),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    throw _i1.SimpleDecodingException(
      r'Invalid simple value for ReceiptResponseReceiptsArrayOneOfModel',
    );
  }

  factory ReceiptResponseReceiptsArrayOneOfModel.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    if (explode && value != null && value.isNotEmpty) {
      final _$pairs = value.split('&');
      _i3.String? _$discriminator;
      for (final pair in _$pairs) {
        final _$separator = pair.indexOf('=');
        if (_$separator >= 0) {
          final _i3.String _$key;
          try {
            _$key = _i3.Uri.decodeComponent(pair.substring(0, _$separator));
            // ignore: avoid_catching_errors
          } on _i3.ArgumentError catch (_) {
            continue;
          } on _i3.FormatException catch (_) {
            continue;
          }
          if (_$key == r'Type') {
            _$discriminator = pair.substring(_$separator + 1);
            break;
          }
        }
      }
      if (_$discriminator == r'Purchase') {
        return ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(
          _i4.PurchaseReceipt.fromForm(value, explode: explode),
        );
      }
      if (_$discriminator == r'Voucher') {
        return ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(
          _i5.VoucherReceipt.fromForm(value, explode: explode),
        );
      }
      if (_$discriminator == r'UsedTicket') {
        return ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(
          _i6.UsedTicketReceipt.fromForm(value, explode: explode),
        );
      }
    }
    try {
      return ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(
        _i4.PurchaseReceipt.fromForm(value, explode: explode),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    try {
      return ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(
        _i6.UsedTicketReceipt.fromForm(value, explode: explode),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    try {
      return ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(
        _i5.VoucherReceipt.fromForm(value, explode: explode),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    throw _i1.SimpleDecodingException(
      r'Invalid form value for ReceiptResponseReceiptsArrayOneOfModel',
    );
  }

  factory ReceiptResponseReceiptsArrayOneOfModel.fromJson(_i3.Object? json) {
    final _$discriminator = json is _i3.Map<_i3.String, _i3.Object?>
        ? json[r'Type']
        : null;
    final _$result = switch (_$discriminator) {
      r'Purchase' => ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(
        _i4.PurchaseReceipt.fromJson(json),
      ),
      r'Voucher' => ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(
        _i5.VoucherReceipt.fromJson(json),
      ),
      r'UsedTicket' => ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(
        _i6.UsedTicketReceipt.fromJson(json),
      ),
      _ => null,
    };
    if (_$result != null) {
      return _$result;
    }
    try {
      return ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(
        _i4.PurchaseReceipt.fromJson(json),
      );
    } on _i3.Object catch (_) {}
    try {
      return ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(
        _i6.UsedTicketReceipt.fromJson(json),
      );
    } on _i3.Object catch (_) {}
    try {
      return ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(
        _i5.VoucherReceipt.fromJson(json),
      );
    } on _i3.Object catch (_) {}
    throw _i1.JsonDecodingException(
      r'Invalid JSON for ReceiptResponseReceiptsArrayOneOfModel',
    );
  }

  _i1.EncodingShape get currentEncodingShape {
    return switch (this) {
      ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(:final value) =>
        value.currentEncodingShape,
      ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(:final value) =>
        value.currentEncodingShape,
      ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(:final value) =>
        value.currentEncodingShape,
    };
  }

  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    return switch (this) {
      ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'Purchase'),
      },
      ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'Voucher'),
      },
      ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'UsedTicket'),
      },
    };
  }

  @_i3.override
  _i3.String toSimple({
    required _i3.bool explode,
    required _i3.bool allowEmpty,
    _i3.bool literal = false,
  }) {
    return switch (this) {
      ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'Purchase'),
      }.toSimple(explode: explode, allowEmpty: allowEmpty, literal: literal),
      ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'Voucher'),
      }.toSimple(explode: explode, allowEmpty: allowEmpty, literal: literal),
      ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'UsedTicket'),
      }.toSimple(explode: explode, allowEmpty: allowEmpty, literal: literal),
    };
  }

  @_i3.override
  _i3.List<_i1.ParameterEntry> toForm(
    _i3.String paramName, {
    required _i3.bool explode,
    required _i3.bool allowEmpty,
    required _i7.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
    _i3.Map<_i3.String, _i1.FormFieldEncoding> fieldEncodings = const {},
  }) {
    return switch (this) {
      ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(:final value) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'Type': _i1.PropertyValue.scalar(r'Purchase'),
        }.toForm(
          paramName,
          explode: explode,
          allowEmpty: allowEmpty,
          useQueryComponent: useQueryComponent,
          allowReserved: allowReserved,
          fieldEncodings: fieldEncodings,
          textEncoding: textEncoding,
        ),
      ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(:final value) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'Type': _i1.PropertyValue.scalar(r'Voucher'),
        }.toForm(
          paramName,
          explode: explode,
          allowEmpty: allowEmpty,
          useQueryComponent: useQueryComponent,
          allowReserved: allowReserved,
          fieldEncodings: fieldEncodings,
          textEncoding: textEncoding,
        ),
      ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(:final value) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'Type': _i1.PropertyValue.scalar(r'UsedTicket'),
        }.toForm(
          paramName,
          explode: explode,
          allowEmpty: allowEmpty,
          useQueryComponent: useQueryComponent,
          allowReserved: allowReserved,
          fieldEncodings: fieldEncodings,
          textEncoding: textEncoding,
        ),
    };
  }

  @_i3.override
  _i3.String toLabel({
    required _i3.bool explode,
    required _i3.bool allowEmpty,
  }) {
    return switch (this) {
      ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'Purchase'),
      }.toLabel(explode: explode, allowEmpty: allowEmpty),
      ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'Voucher'),
      }.toLabel(explode: explode, allowEmpty: allowEmpty),
      ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(:final value) => {
        ...value.parameterProperties(allowEmpty: allowEmpty),
        r'Type': _i1.PropertyValue.scalar(r'UsedTicket'),
      }.toLabel(explode: explode, allowEmpty: allowEmpty),
    };
  }

  @_i3.override
  _i3.String toMatrix(
    _i3.String paramName, {
    required _i3.bool explode,
    required _i3.bool allowEmpty,
  }) {
    return switch (this) {
      ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(:final value) =>
        value.toMatrix(paramName, explode: explode, allowEmpty: allowEmpty),
      ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(:final value) =>
        value.toMatrix(paramName, explode: explode, allowEmpty: allowEmpty),
      ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(:final value) =>
        value.toMatrix(paramName, explode: explode, allowEmpty: allowEmpty),
    };
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
    required _i7.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    return switch (this) {
      ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt() =>
        throw _i1.EncodingException(
          r'Cannot uriEncode ReceiptResponseReceiptsArrayOneOfModel: variant contains complex type',
        ),
      ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt() =>
        throw _i1.EncodingException(
          r'Cannot uriEncode ReceiptResponseReceiptsArrayOneOfModel: variant contains complex type',
        ),
      ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt() =>
        throw _i1.EncodingException(
          r'Cannot uriEncode ReceiptResponseReceiptsArrayOneOfModel: variant contains complex type',
        ),
    };
  }

  @_i3.override
  _i3.Object? toJson() {
    final (_i3.dynamic _$json, _i3.String? _$discriminator) = switch (this) {
      ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(:final value) => (
        value.toJson(),
        r'Purchase',
      ),

      ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(:final value) => (
        value.toJson(),
        r'Voucher',
      ),

      ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(:final value) => (
        value.toJson(),
        r'UsedTicket',
      ),
    };
    if (_$discriminator != null && _$json is _i3.Map<_i3.String, _i3.Object?>) {
      final _$map = <_i3.String, _i3.Object?>{..._$json};
      _$map.putIfAbsent(r'Type', () => _$discriminator);
      return _$map;
    }
    return _$json;
  }
}

@_i2.immutable
class ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt
    extends ReceiptResponseReceiptsArrayOneOfModel {
  const ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt(this.value);

  final _i4.PurchaseReceipt value;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ReceiptResponseReceiptsArrayOneOfModelPurchaseReceipt &&
        other.value == this.value;
  }

  @_i3.override
  _i3.int get hashCode => this.value.hashCode;
}

@_i2.immutable
class ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt
    extends ReceiptResponseReceiptsArrayOneOfModel {
  const ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt(this.value);

  final _i5.VoucherReceipt value;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ReceiptResponseReceiptsArrayOneOfModelVoucherReceipt &&
        other.value == this.value;
  }

  @_i3.override
  _i3.int get hashCode => this.value.hashCode;
}

@_i2.immutable
class ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt
    extends ReceiptResponseReceiptsArrayOneOfModel {
  const ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt(this.value);

  final _i6.UsedTicketReceipt value;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ReceiptResponseReceiptsArrayOneOfModelUsedTicketReceipt &&
        other.value == this.value;
  }

  @_i3.override
  _i3.int get hashCode => this.value.hashCode;
}
