// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Service Health
@_i2.immutable
class ServiceHealthResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const ServiceHealthResponse({this.mobilePay, this.database});

  factory ServiceHealthResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'mobilePay', r'database'},
      listKeys: {},
      context: r'ServiceHealthResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return ServiceHealthResponse(
      mobilePay: _$values[r'mobilePay'].decodeSimpleNullableBool(
        context: r'ServiceHealthResponse.mobilePay',
      ),
      database: _$values[r'database'].decodeSimpleNullableBool(
        context: r'ServiceHealthResponse.database',
      ),
    );
  }

  factory ServiceHealthResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'ServiceHealthResponse');
    return ServiceHealthResponse(
      mobilePay: _$map[r'mobilePay'].decodeJsonNullableBool(
        context: r'ServiceHealthResponse.mobilePay',
      ),
      database: _$map[r'database'].decodeJsonNullableBool(
        context: r'ServiceHealthResponse.database',
      ),
    );
  }

  factory ServiceHealthResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'mobilePay', r'database'},
      listKeys: {},
      context: r'ServiceHealthResponse',
    );
    return ServiceHealthResponse(
      mobilePay: _$values[r'mobilePay'].decodeFormNullableBool(
        context: r'ServiceHealthResponse.mobilePay',
      ),
      database: _$values[r'database'].decodeFormNullableBool(
        context: r'ServiceHealthResponse.database',
      ),
    );
  }

  /// MobilePay connected
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool? mobilePay;

  /// Database connected
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool? database;

  @_i3.override
  _i3.Object? toJson() => {
    if (this.mobilePay != null) r'mobilePay': this.mobilePay,
    if (this.database != null) r'database': this.database,
  };

  ServiceHealthResponse Function({_i3.bool? mobilePay, _i3.bool? database})
  get copyWith {
    const _i3.Object _sentinel = _i3.Object();
    return ({
      _i3.Object? mobilePay = _sentinel,
      _i3.Object? database = _sentinel,
    }) => ServiceHealthResponse(
      mobilePay: _i3.identical(mobilePay, _sentinel)
          ? this.mobilePay
          : (mobilePay as _i3.bool?),
      database: _i3.identical(database, _sentinel)
          ? this.database
          : (database as _i3.bool?),
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ServiceHealthResponse &&
        other.mobilePay == this.mobilePay &&
        other.database == this.database;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.mobilePay, this.database]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    if (this.mobilePay != null) {
      _$result[r'mobilePay'] = _i1.PropertyValue.scalar(
        this.mobilePay!.toString(),
      );
    }
    if (this.database != null) {
      _$result[r'database'] = _i1.PropertyValue.scalar(
        this.database!.toString(),
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
      r'Cannot uriEncode ServiceHealthResponse: complex types cannot be URI-encoded',
    );
  }
}
