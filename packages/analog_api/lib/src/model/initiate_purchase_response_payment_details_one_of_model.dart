// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/free_purchase_payment_details.dart' as _i4;
import 'package:analog_api/src/model/mobile_pay_payment_details.dart' as _i5;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Details about the payment. The details object is specific to the Payment Type
@_i2.immutable
sealed class InitiatePurchaseResponsePaymentDetailsOneOfModel
    implements _i1.ParameterEncodable, _i1.UriEncodable {
  const InitiatePurchaseResponsePaymentDetailsOneOfModel();

  factory InitiatePurchaseResponsePaymentDetailsOneOfModel.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    if (explode && value != null && value.isNotEmpty) {
      _i3.String? _$discriminator;
      if (isHeader) {
        _$discriminator = value.findHeaderDiscriminator(r'discriminator', {
          r'FreePurchasePaymentDetails',
          r'MobilePayPaymentDetails',
        });
      } else {
        final _$pairs = value.split(',');
        for (final pair in _$pairs) {
          final _$separator = pair.indexOf('=');
          if (_$separator >= 0) {
            final _$key = pair.substring(0, _$separator);
            if (_$key == r'discriminator') {
              _$discriminator = pair.substring(_$separator + 1);
              break;
            }
          }
        }
      }
      if (_$discriminator == r'FreePurchasePaymentDetails') {
        return InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
          _i4.FreePurchasePaymentDetails.fromSimple(
            value,
            explode: explode,
            isHeader: isHeader,
          ),
        );
      }
      if (_$discriminator == r'MobilePayPaymentDetails') {
        return InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
          _i5.MobilePayPaymentDetails.fromSimple(
            value,
            explode: explode,
            isHeader: isHeader,
          ),
        );
      }
    }
    try {
      return InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        _i4.FreePurchasePaymentDetails.fromSimple(
          value,
          explode: explode,
          isHeader: isHeader,
        ),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    try {
      return InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        _i5.MobilePayPaymentDetails.fromSimple(
          value,
          explode: explode,
          isHeader: isHeader,
        ),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    throw _i1.SimpleDecodingException(
      r'Invalid simple value for InitiatePurchaseResponsePaymentDetailsOneOfModel',
    );
  }

  factory InitiatePurchaseResponsePaymentDetailsOneOfModel.fromForm(
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
          if (_$key == r'discriminator') {
            _$discriminator = pair.substring(_$separator + 1);
            break;
          }
        }
      }
      if (_$discriminator == r'FreePurchasePaymentDetails') {
        return InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
          _i4.FreePurchasePaymentDetails.fromForm(value, explode: explode),
        );
      }
      if (_$discriminator == r'MobilePayPaymentDetails') {
        return InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
          _i5.MobilePayPaymentDetails.fromForm(value, explode: explode),
        );
      }
    }
    try {
      return InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        _i4.FreePurchasePaymentDetails.fromForm(value, explode: explode),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    try {
      return InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        _i5.MobilePayPaymentDetails.fromForm(value, explode: explode),
      );
    } on _i1.DecodingException catch (_) {
    } on _i3.FormatException catch (_) {}
    throw _i1.SimpleDecodingException(
      r'Invalid form value for InitiatePurchaseResponsePaymentDetailsOneOfModel',
    );
  }

  factory InitiatePurchaseResponsePaymentDetailsOneOfModel.fromJson(
    _i3.Object? json,
  ) {
    final _$discriminator = json is _i3.Map<_i3.String, _i3.Object?>
        ? json[r'discriminator']
        : null;
    final _$result = switch (_$discriminator) {
      r'FreePurchasePaymentDetails' =>
        InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
          _i4.FreePurchasePaymentDetails.fromJson(json),
        ),
      r'MobilePayPaymentDetails' =>
        InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
          _i5.MobilePayPaymentDetails.fromJson(json),
        ),
      _ => null,
    };
    if (_$result != null) {
      return _$result;
    }
    try {
      return InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        _i4.FreePurchasePaymentDetails.fromJson(json),
      );
    } on _i3.Object catch (_) {}
    try {
      return InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        _i5.MobilePayPaymentDetails.fromJson(json),
      );
    } on _i3.Object catch (_) {}
    throw _i1.JsonDecodingException(
      r'Invalid JSON for InitiatePurchaseResponsePaymentDetailsOneOfModel',
    );
  }

  _i1.EncodingShape get currentEncodingShape {
    return switch (this) {
      InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        :final value,
      ) =>
        value.currentEncodingShape,
      InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        :final value,
      ) =>
        value.currentEncodingShape,
    };
  }

  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    return switch (this) {
      InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        :final value,
      ) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'discriminator': _i1.PropertyValue.scalar(
            r'FreePurchasePaymentDetails',
          ),
        },
      InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        :final value,
      ) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'discriminator': _i1.PropertyValue.scalar(
            r'MobilePayPaymentDetails',
          ),
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
      InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        :final value,
      ) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'discriminator': _i1.PropertyValue.scalar(
            r'FreePurchasePaymentDetails',
          ),
        }.toSimple(explode: explode, allowEmpty: allowEmpty, literal: literal),
      InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        :final value,
      ) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'discriminator': _i1.PropertyValue.scalar(
            r'MobilePayPaymentDetails',
          ),
        }.toSimple(explode: explode, allowEmpty: allowEmpty, literal: literal),
    };
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
    return switch (this) {
      InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        :final value,
      ) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'discriminator': _i1.PropertyValue.scalar(
            r'FreePurchasePaymentDetails',
          ),
        }.toForm(
          paramName,
          explode: explode,
          allowEmpty: allowEmpty,
          useQueryComponent: useQueryComponent,
          allowReserved: allowReserved,
          fieldEncodings: fieldEncodings,
          textEncoding: textEncoding,
        ),
      InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        :final value,
      ) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'discriminator': _i1.PropertyValue.scalar(
            r'MobilePayPaymentDetails',
          ),
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
      InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        :final value,
      ) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'discriminator': _i1.PropertyValue.scalar(
            r'FreePurchasePaymentDetails',
          ),
        }.toLabel(explode: explode, allowEmpty: allowEmpty),
      InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        :final value,
      ) =>
        {
          ...value.parameterProperties(allowEmpty: allowEmpty),
          r'discriminator': _i1.PropertyValue.scalar(
            r'MobilePayPaymentDetails',
          ),
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
      InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        :final value,
      ) =>
        value.toMatrix(paramName, explode: explode, allowEmpty: allowEmpty),
      InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        :final value,
      ) =>
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
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    return switch (this) {
      InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails() =>
        throw _i1.EncodingException(
          r'Cannot uriEncode InitiatePurchaseResponsePaymentDetailsOneOfModel: variant contains complex type',
        ),
      InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails() =>
        throw _i1.EncodingException(
          r'Cannot uriEncode InitiatePurchaseResponsePaymentDetailsOneOfModel: variant contains complex type',
        ),
    };
  }

  @_i3.override
  _i3.Object? toJson() {
    final (_i3.dynamic _$json, _i3.String? _$discriminator) = switch (this) {
      InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
        :final value,
      ) =>
        (value.toJson(), r'FreePurchasePaymentDetails'),

      InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
        :final value,
      ) =>
        (value.toJson(), r'MobilePayPaymentDetails'),
    };
    if (_$discriminator != null && _$json is _i3.Map<_i3.String, _i3.Object?>) {
      final _$map = <_i3.String, _i3.Object?>{..._$json};
      _$map.putIfAbsent(r'discriminator', () => _$discriminator);
      return _$map;
    }
    return _$json;
  }
}

@_i2.immutable
class InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails
    extends InitiatePurchaseResponsePaymentDetailsOneOfModel {
  const InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails(
    this.value,
  );

  final _i4.FreePurchasePaymentDetails value;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other
            is InitiatePurchaseResponsePaymentDetailsOneOfModelFreePurchasePaymentDetails &&
        other.value == this.value;
  }

  @_i3.override
  _i3.int get hashCode => this.value.hashCode;
}

@_i2.immutable
class InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails
    extends InitiatePurchaseResponsePaymentDetailsOneOfModel {
  const InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails(
    this.value,
  );

  final _i5.MobilePayPaymentDetails value;

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other
            is InitiatePurchaseResponsePaymentDetailsOneOfModelMobilePayPaymentDetails &&
        other.value == this.value;
  }

  @_i3.override
  _i3.int get hashCode => this.value.hashCode;
}
