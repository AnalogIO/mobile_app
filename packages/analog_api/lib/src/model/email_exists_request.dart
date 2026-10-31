// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// An email that should be checked if it already exists
@_i2.immutable
class EmailExistsRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const EmailExistsRequest({required this.email});

  factory EmailExistsRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'email'},
      listKeys: {},
      context: r'EmailExistsRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return EmailExistsRequest(
      email: _$values[r'email'].decodeSimpleString(
        context: r'EmailExistsRequest.email',
      ),
    );
  }

  factory EmailExistsRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'EmailExistsRequest');
    return EmailExistsRequest(
      email: _$map[r'email'].decodeJsonString(
        context: r'EmailExistsRequest.email',
      ),
    );
  }

  factory EmailExistsRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'email'},
      listKeys: {},
      context: r'EmailExistsRequest',
    );
    return EmailExistsRequest(
      email: _$values[r'email'].decodeFormString(
        context: r'EmailExistsRequest.email',
      ),
    );
  }

  /// Email
  ///
  /// **Example**:
  /// ```
  /// johndoe@mail.com
  /// ```
  final _i3.String email;

  @_i3.override
  _i3.Object? toJson() => {r'email': this.email};

  EmailExistsRequest Function({_i3.String? email}) get copyWith {
    return ({_i3.String? email}) =>
        EmailExistsRequest(email: email ?? this.email);
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is EmailExistsRequest && other.email == this.email;
  }

  @_i3.override
  _i3.int get hashCode => this.email.hashCode;

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'email'] = _i1.PropertyValue.scalar(this.email);
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
      r'Cannot uriEncode EmailExistsRequest: complex types cannot be URI-encoded',
    );
  }
}
