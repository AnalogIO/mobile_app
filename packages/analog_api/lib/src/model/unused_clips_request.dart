// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Initialize a request for data with unused clips.
@_i2.immutable
class UnusedClipsRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UnusedClipsRequest({required this.startDate, required this.endDate});

  factory UnusedClipsRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'startDate', r'endDate'},
      listKeys: {},
      context: r'UnusedClipsRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UnusedClipsRequest(
      startDate: _$values[r'startDate'].decodeSimpleDateTime(
        context: r'UnusedClipsRequest.startDate',
      ),
      endDate: _$values[r'endDate'].decodeSimpleDateTime(
        context: r'UnusedClipsRequest.endDate',
      ),
    );
  }

  factory UnusedClipsRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UnusedClipsRequest');
    return UnusedClipsRequest(
      startDate: _$map[r'startDate'].decodeJsonDateTime(
        context: r'UnusedClipsRequest.startDate',
      ),
      endDate: _$map[r'endDate'].decodeJsonDateTime(
        context: r'UnusedClipsRequest.endDate',
      ),
    );
  }

  factory UnusedClipsRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'startDate', r'endDate'},
      listKeys: {},
      context: r'UnusedClipsRequest',
    );
    return UnusedClipsRequest(
      startDate: _$values[r'startDate'].decodeFormDateTime(
        context: r'UnusedClipsRequest.startDate',
      ),
      endDate: _$values[r'endDate'].decodeFormDateTime(
        context: r'UnusedClipsRequest.endDate',
      ),
    );
  }

  /// The start date of unused tickets query.
  ///
  /// **Example**:
  /// ```
  /// 2021-02-08
  /// ```
  final _i3.DateTime startDate;

  /// The end date of unused tickets query.
  ///
  /// **Example**:
  /// ```
  /// 2024-02-08
  /// ```
  final _i3.DateTime endDate;

  @_i3.override
  _i3.Object? toJson() => {
    r'startDate': this.startDate.toTimeZonedIso8601String(),
    r'endDate': this.endDate.toTimeZonedIso8601String(),
  };

  UnusedClipsRequest Function({_i3.DateTime? startDate, _i3.DateTime? endDate})
  get copyWith {
    return ({_i3.DateTime? startDate, _i3.DateTime? endDate}) =>
        UnusedClipsRequest(
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UnusedClipsRequest &&
        other.startDate == this.startDate &&
        other.endDate == this.endDate;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.startDate, this.endDate]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'startDate'] = _i1.PropertyValue.scalar(
      this.startDate.toTimeZonedIso8601String(),
    );
    _$result[r'endDate'] = _i1.PropertyValue.scalar(
      this.endDate.toTimeZonedIso8601String(),
    );
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
      r'Cannot uriEncode UnusedClipsRequest: complex types cannot be URI-encoded',
    );
  }
}
