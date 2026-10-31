// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/environment_type.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// App Configuration
@_i2.immutable
class AppConfig extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const AppConfig({required this.environmentType});

  factory AppConfig.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'environmentType'},
      listKeys: {},
      context: r'AppConfig',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return AppConfig(
      environmentType: _i4.EnvironmentType.fromSimple(
        _$values[r'environmentType'],
        explode: explode,
      ),
    );
  }

  factory AppConfig.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'AppConfig');
    return AppConfig(
      environmentType: _i4.EnvironmentType.fromJson(_$map[r'environmentType']),
    );
  }

  factory AppConfig.fromForm(_i3.String? value, {required _i3.bool explode}) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'environmentType'},
      listKeys: {},
      context: r'AppConfig',
    );
    return AppConfig(
      environmentType: _i4.EnvironmentType.fromForm(
        _$values[r'environmentType'],
        explode: explode,
      ),
    );
  }

  final _i4.EnvironmentType environmentType;

  @_i3.override
  _i3.Object? toJson() => {r'environmentType': this.environmentType.toJson()};

  AppConfig Function({_i4.EnvironmentType? environmentType}) get copyWith {
    return ({_i4.EnvironmentType? environmentType}) =>
        AppConfig(environmentType: environmentType ?? this.environmentType);
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is AppConfig && other.environmentType == this.environmentType;
  }

  @_i3.override
  _i3.int get hashCode => this.environmentType.hashCode;

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'environmentType'] = _i1.PropertyValue.scalar(
      this.environmentType.toJson(),
    );
    return _$result;
  }

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i5.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode AppConfig: complex types cannot be URI-encoded',
    );
  }
}
