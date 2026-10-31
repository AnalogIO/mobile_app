// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i4;
import 'dart:core' as _i3;

import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Request to complete a registration that was started from a login request.
/// The email address is read from the single-use registration token and is
/// deliberately not part of this request.
@_i2.immutable
class CompleteRegistrationRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const CompleteRegistrationRequest({
    required this.token,
    required this.name,
    required this.programmeId,
  });

  factory CompleteRegistrationRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'token', r'name', r'programmeId'},
      listKeys: {},
      context: r'CompleteRegistrationRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return CompleteRegistrationRequest(
      token: _$values[r'token'].decodeSimpleString(
        context: r'CompleteRegistrationRequest.token',
      ),
      name: _$values[r'name'].decodeSimpleString(
        context: r'CompleteRegistrationRequest.name',
      ),
      programmeId: _$values[r'programmeId'].decodeSimpleInt(
        context: r'CompleteRegistrationRequest.programmeId',
      ),
    );
  }

  factory CompleteRegistrationRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'CompleteRegistrationRequest');
    return CompleteRegistrationRequest(
      token: _$map[r'token'].decodeJsonString(
        context: r'CompleteRegistrationRequest.token',
      ),
      name: _$map[r'name'].decodeJsonString(
        context: r'CompleteRegistrationRequest.name',
      ),
      programmeId: _$map[r'programmeId'].decodeJsonInt(
        context: r'CompleteRegistrationRequest.programmeId',
      ),
    );
  }

  factory CompleteRegistrationRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'token', r'name', r'programmeId'},
      listKeys: {},
      context: r'CompleteRegistrationRequest',
    );
    return CompleteRegistrationRequest(
      token: _$values[r'token'].decodeFormString(
        context: r'CompleteRegistrationRequest.token',
      ),
      name: _$values[r'name'].decodeFormString(
        context: r'CompleteRegistrationRequest.name',
      ),
      programmeId: _$values[r'programmeId'].decodeFormInt(
        context: r'CompleteRegistrationRequest.programmeId',
      ),
    );
  }

  /// Token from the registration link sent to the user's email
  ///
  /// **Example**:
  /// ```
  /// [no example provided]
  /// ```
  final _i3.String token;

  /// Full name of the user
  ///
  /// **Example**:
  /// ```
  /// John Doe
  /// ```
  final _i3.String name;

  /// Programme of the user
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int programmeId;

  @_i3.override
  _i3.Object? toJson() => {
    r'token': this.token,
    r'name': this.name,
    r'programmeId': this.programmeId,
  };

  CompleteRegistrationRequest Function({
    _i3.String? token,
    _i3.String? name,
    _i3.int? programmeId,
  })
  get copyWith {
    return ({_i3.String? token, _i3.String? name, _i3.int? programmeId}) =>
        CompleteRegistrationRequest(
          token: token ?? this.token,
          name: name ?? this.name,
          programmeId: programmeId ?? this.programmeId,
        );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is CompleteRegistrationRequest &&
        other.token == this.token &&
        other.name == this.name &&
        other.programmeId == this.programmeId;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([this.token, this.name, this.programmeId]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'token'] = _i1.PropertyValue.scalar(this.token);
    _$result[r'name'] = _i1.PropertyValue.scalar(this.name);
    _$result[r'programmeId'] = _i1.PropertyValue.scalar(
      this.programmeId.toString(),
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
      r'Cannot uriEncode CompleteRegistrationRequest: complex types cannot be URI-encoded',
    );
  }
}
