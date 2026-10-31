// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Resend Invite email request
@_i2.immutable
class ResendAccountVerificationEmailRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const ResendAccountVerificationEmailRequest({required this.email});

  factory ResendAccountVerificationEmailRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'email'},
      listKeys: {},
      context: r'ResendAccountVerificationEmailRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return ResendAccountVerificationEmailRequest(
      email: _$values[r'email'].decodeSimpleString(
        context: r'ResendAccountVerificationEmailRequest.email',
      ),
    );
  }

  factory ResendAccountVerificationEmailRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(
      context: r'ResendAccountVerificationEmailRequest',
    );
    return ResendAccountVerificationEmailRequest(
      email: _$map[r'email'].decodeJsonString(
        context: r'ResendAccountVerificationEmailRequest.email',
      ),
    );
  }

  factory ResendAccountVerificationEmailRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'email'},
      listKeys: {},
      context: r'ResendAccountVerificationEmailRequest',
    );
    return ResendAccountVerificationEmailRequest(
      email: _$values[r'email'].decodeFormString(
        context: r'ResendAccountVerificationEmailRequest.email',
      ),
    );
  }

  /// User email
  ///
  /// **Example**:
  /// ```
  /// john@doe.com
  /// ```
  final _i3.String email;

  @_i3.override
  _i3.Object? toJson() => {r'email': this.email};

  ResendAccountVerificationEmailRequest Function({_i3.String? email})
  get copyWith {
    return ({_i3.String? email}) =>
        ResendAccountVerificationEmailRequest(email: email ?? this.email);
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is ResendAccountVerificationEmailRequest &&
        other.email == this.email;
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
      r'Cannot uriEncode ResendAccountVerificationEmailRequest: complex types cannot be URI-encoded',
    );
  }
}
