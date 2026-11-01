// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

@_i2.immutable
class ApiError extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const ApiError({this.message});

  factory ApiError.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'message'},
      listKeys: {},
      context: r'ApiError',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return ApiError(
      message: _$values[r'message'].decodeSimpleNullableString(
        context: r'ApiError.message',
      ),
    );
  }

  factory ApiError.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'ApiError');
    return ApiError(
      message: _$map[r'message'].decodeJsonNullableString(
        context: r'ApiError.message',
      ),
    );
  }

  factory ApiError.fromForm(_i3.String? value, {required _i3.bool explode}) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'message'},
      listKeys: {},
      context: r'ApiError',
    );
    return ApiError(
      message: _$values[r'message'].decodeFormNullableString(
        context: r'ApiError.message',
      ),
    );
  }

  final _i3.String? message;

  @_i3.override
  _i3.Object? toJson() => {r'message': this.message};

  ApiError Function({_i3.String? message}) get copyWith {
    const _i3.Object _sentinel = _i3.Object();
    return ({_i3.Object? message = _sentinel}) => ApiError(
      message: _i3.identical(message, _sentinel)
          ? this.message
          : (message as _i3.String?),
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ApiError && other.message == this.message;
  }

  @_i3.override
  _i3.int get hashCode => this.message.hashCode;

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    if (this.message != null) {
      _$result[r'message'] = _i1.PropertyValue.scalar(this.message!);
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
      r'Cannot uriEncode ApiError: complex types cannot be URI-encoded',
    );
  }
}
