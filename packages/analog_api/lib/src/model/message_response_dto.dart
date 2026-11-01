// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Simple response class with a string message
@_i2.immutable
class MessageResponseDto extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const MessageResponseDto({this.message});

  factory MessageResponseDto.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'message'},
      listKeys: {},
      context: r'MessageResponseDto',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return MessageResponseDto(
      message: _$values[r'message'].decodeSimpleNullableString(
        context: r'MessageResponseDto.message',
      ),
    );
  }

  factory MessageResponseDto.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'MessageResponseDto');
    return MessageResponseDto(
      message: _$map[r'message'].decodeJsonNullableString(
        context: r'MessageResponseDto.message',
      ),
    );
  }

  factory MessageResponseDto.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'message'},
      listKeys: {},
      context: r'MessageResponseDto',
    );
    return MessageResponseDto(
      message: _$values[r'message'].decodeFormNullableString(
        context: r'MessageResponseDto.message',
      ),
    );
  }

  /// Message with API response
  ///
  /// **Example**:
  /// ```
  /// Successful completion
  /// ```
  final _i3.String? message;

  @_i3.override
  _i3.Object? toJson() => {r'message': this.message};

  MessageResponseDto Function({_i3.String? message}) get copyWith {
    const _i3.Object _sentinel = _i3.Object();
    return ({_i3.Object? message = _sentinel}) => MessageResponseDto(
      message: _i3.identical(message, _sentinel)
          ? this.message
          : (message as _i3.String?),
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is MessageResponseDto && other.message == this.message;
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
      r'Cannot uriEncode MessageResponseDto: complex types cannot be URI-encoded',
    );
  }
}
