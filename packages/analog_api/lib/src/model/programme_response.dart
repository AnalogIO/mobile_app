// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Represents a study programme
@_i2.immutable
class ProgrammeResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const ProgrammeResponse({
    required this.id,
    required this.shortName,
    required this.fullName,
  });

  factory ProgrammeResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'id', r'shortName', r'fullName'},
      listKeys: {},
      context: r'ProgrammeResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return ProgrammeResponse(
      id: _$values[r'id'].decodeSimpleInt(context: r'ProgrammeResponse.id'),
      shortName: _$values[r'shortName'].decodeSimpleString(
        context: r'ProgrammeResponse.shortName',
      ),
      fullName: _$values[r'fullName'].decodeSimpleString(
        context: r'ProgrammeResponse.fullName',
      ),
    );
  }

  factory ProgrammeResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'ProgrammeResponse');
    return ProgrammeResponse(
      id: _$map[r'id'].decodeJsonInt(context: r'ProgrammeResponse.id'),
      shortName: _$map[r'shortName'].decodeJsonString(
        context: r'ProgrammeResponse.shortName',
      ),
      fullName: _$map[r'fullName'].decodeJsonString(
        context: r'ProgrammeResponse.fullName',
      ),
    );
  }

  factory ProgrammeResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'id', r'shortName', r'fullName'},
      listKeys: {},
      context: r'ProgrammeResponse',
    );
    return ProgrammeResponse(
      id: _$values[r'id'].decodeFormInt(context: r'ProgrammeResponse.id'),
      shortName: _$values[r'shortName'].decodeFormString(
        context: r'ProgrammeResponse.shortName',
      ),
      fullName: _$values[r'fullName'].decodeFormString(
        context: r'ProgrammeResponse.fullName',
      ),
    );
  }

  /// Id of study programme
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int id;

  /// Short name of study programme
  ///
  /// **Example**:
  /// ```
  /// SWU
  /// ```
  final _i3.String shortName;

  /// Full name of study programme
  ///
  /// **Example**:
  /// ```
  /// Software development
  /// ```
  final _i3.String fullName;

  @_i3.override
  _i3.Object? toJson() => {
    r'id': this.id,
    r'shortName': this.shortName,
    r'fullName': this.fullName,
  };

  ProgrammeResponse Function({
    _i3.int? id,
    _i3.String? shortName,
    _i3.String? fullName,
  })
  get copyWith {
    return ({_i3.int? id, _i3.String? shortName, _i3.String? fullName}) =>
        ProgrammeResponse(
          id: id ?? this.id,
          shortName: shortName ?? this.shortName,
          fullName: fullName ?? this.fullName,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ProgrammeResponse &&
        other.id == this.id &&
        other.shortName == this.shortName &&
        other.fullName == this.fullName;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.id, this.shortName, this.fullName]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'id'] = _i1.PropertyValue.scalar(this.id.toString());
    _$result[r'shortName'] = _i1.PropertyValue.scalar(this.shortName);
    _$result[r'fullName'] = _i1.PropertyValue.scalar(this.fullName);
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
      r'Cannot uriEncode ProgrammeResponse: complex types cannot be URI-encoded',
    );
  }
}
