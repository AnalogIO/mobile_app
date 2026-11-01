// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i6;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/profile_background_color.dart' as _i5;
import 'package:analog_api/src/model/profile_icon.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// Update User information request object. All properties are optional as the server only updates the values of the properties which are present
@_i2.immutable
class UpdateUserRequest extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const UpdateUserRequest({
    this.name,
    this.email,
    this.privacyActivated,
    this.programmeId,
    this.password,
    this.profileIcon,
    this.profileBackgroundColor,
  });

  factory UpdateUserRequest.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {
        r'name',
        r'email',
        r'privacyActivated',
        r'programmeId',
        r'password',
        r'profileIcon',
        r'profileBackgroundColor',
      },
      listKeys: {},
      context: r'UpdateUserRequest',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return UpdateUserRequest(
      name: _$values[r'name'].decodeSimpleNullableString(
        context: r'UpdateUserRequest.name',
      ),
      email: _$values[r'email'].decodeSimpleNullableString(
        context: r'UpdateUserRequest.email',
      ),
      privacyActivated: _$values[r'privacyActivated'].decodeSimpleNullableBool(
        context: r'UpdateUserRequest.privacyActivated',
      ),
      programmeId: _$values[r'programmeId'].decodeSimpleNullableInt(
        context: r'UpdateUserRequest.programmeId',
      ),
      password: _$values[r'password'].decodeSimpleNullableString(
        context: r'UpdateUserRequest.password',
      ),
      profileIcon: _$values[r'profileIcon'] == null
          ? null
          : _i4.ProfileIcon.fromSimple(
              _$values[r'profileIcon'],
              explode: explode,
            ),
      profileBackgroundColor: _$values[r'profileBackgroundColor'] == null
          ? null
          : _i5.ProfileBackgroundColor.fromSimple(
              _$values[r'profileBackgroundColor'],
              explode: explode,
            ),
    );
  }

  factory UpdateUserRequest.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'UpdateUserRequest');
    return UpdateUserRequest(
      name: _$map[r'name'].decodeJsonNullableString(
        context: r'UpdateUserRequest.name',
      ),
      email: _$map[r'email'].decodeJsonNullableString(
        context: r'UpdateUserRequest.email',
      ),
      privacyActivated: _$map[r'privacyActivated'].decodeJsonNullableBool(
        context: r'UpdateUserRequest.privacyActivated',
      ),
      programmeId: _$map[r'programmeId'].decodeJsonNullableInt(
        context: r'UpdateUserRequest.programmeId',
      ),
      password: _$map[r'password'].decodeJsonNullableString(
        context: r'UpdateUserRequest.password',
      ),
      profileIcon: _$map[r'profileIcon'] == null
          ? null
          : _i4.ProfileIcon.fromJson(_$map[r'profileIcon']),
      profileBackgroundColor: _$map[r'profileBackgroundColor'] == null
          ? null
          : _i5.ProfileBackgroundColor.fromJson(
              _$map[r'profileBackgroundColor'],
            ),
    );
  }

  factory UpdateUserRequest.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {
        r'name',
        r'email',
        r'privacyActivated',
        r'programmeId',
        r'password',
        r'profileIcon',
        r'profileBackgroundColor',
      },
      listKeys: {},
      context: r'UpdateUserRequest',
    );
    return UpdateUserRequest(
      name: _$values[r'name'].decodeFormNullableString(
        context: r'UpdateUserRequest.name',
      ),
      email: _$values[r'email'].decodeFormNullableString(
        context: r'UpdateUserRequest.email',
      ),
      privacyActivated: _$values[r'privacyActivated'].decodeFormNullableBool(
        context: r'UpdateUserRequest.privacyActivated',
      ),
      programmeId: _$values[r'programmeId'].decodeFormNullableInt(
        context: r'UpdateUserRequest.programmeId',
      ),
      password: _$values[r'password'].decodeFormNullableString(
        context: r'UpdateUserRequest.password',
      ),
      profileIcon: _$values[r'profileIcon'] == null
          ? null
          : _i4.ProfileIcon.fromForm(
              _$values[r'profileIcon'],
              explode: explode,
            ),
      profileBackgroundColor: _$values[r'profileBackgroundColor'] == null
          ? null
          : _i5.ProfileBackgroundColor.fromForm(
              _$values[r'profileBackgroundColor'],
              explode: explode,
            ),
    );
  }

  /// Full Name of user
  ///
  /// **Example**:
  /// ```
  /// John Doe
  /// ```
  final _i3.String? name;

  /// Email of user
  ///
  /// **Example**:
  /// ```
  /// john@doe.com
  /// ```
  final _i3.String? email;

  /// Privacy Activated
  ///
  /// **Example**:
  /// ```json
  /// true
  /// ```
  final _i3.bool? privacyActivated;

  /// Study Programme Id of user
  ///
  /// **Example**:
  /// ```json
  /// 1
  /// ```
  final _i3.int? programmeId;

  /// Pin Code as first UTF8 encoded, then SHA256 hashed, and then Base64 encoded string
  ///
  /// **Example**:
  /// ```
  /// [no example provided]
  /// ```
  final _i3.String? password;

  final _i4.ProfileIcon? profileIcon;

  final _i5.ProfileBackgroundColor? profileBackgroundColor;

  @_i3.override
  _i3.Object? toJson() => {
    r'name': this.name,
    r'email': this.email,
    r'privacyActivated': this.privacyActivated,
    r'programmeId': this.programmeId,
    r'password': this.password,
    if (this.profileIcon != null) r'profileIcon': this.profileIcon?.toJson(),
    if (this.profileBackgroundColor != null)
      r'profileBackgroundColor': this.profileBackgroundColor?.toJson(),
  };

  UpdateUserRequest Function({
    _i3.String? name,
    _i3.String? email,
    _i3.bool? privacyActivated,
    _i3.int? programmeId,
    _i3.String? password,
    _i4.ProfileIcon? profileIcon,
    _i5.ProfileBackgroundColor? profileBackgroundColor,
  })
  get copyWith {
    const _i3.Object _sentinel = _i3.Object();
    return ({
      _i3.Object? name = _sentinel,
      _i3.Object? email = _sentinel,
      _i3.Object? privacyActivated = _sentinel,
      _i3.Object? programmeId = _sentinel,
      _i3.Object? password = _sentinel,
      _i3.Object? profileIcon = _sentinel,
      _i3.Object? profileBackgroundColor = _sentinel,
    }) => UpdateUserRequest(
      name: _i3.identical(name, _sentinel) ? this.name : (name as _i3.String?),
      email: _i3.identical(email, _sentinel)
          ? this.email
          : (email as _i3.String?),
      privacyActivated: _i3.identical(privacyActivated, _sentinel)
          ? this.privacyActivated
          : (privacyActivated as _i3.bool?),
      programmeId: _i3.identical(programmeId, _sentinel)
          ? this.programmeId
          : (programmeId as _i3.int?),
      password: _i3.identical(password, _sentinel)
          ? this.password
          : (password as _i3.String?),
      profileIcon: _i3.identical(profileIcon, _sentinel)
          ? this.profileIcon
          : (profileIcon as _i4.ProfileIcon?),
      profileBackgroundColor: _i3.identical(profileBackgroundColor, _sentinel)
          ? this.profileBackgroundColor
          : (profileBackgroundColor as _i5.ProfileBackgroundColor?),
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is UpdateUserRequest &&
        other.name == this.name &&
        other.email == this.email &&
        other.privacyActivated == this.privacyActivated &&
        other.programmeId == this.programmeId &&
        other.password == this.password &&
        other.profileIcon == this.profileIcon &&
        other.profileBackgroundColor == this.profileBackgroundColor;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.name,
      this.email,
      this.privacyActivated,
      this.programmeId,
      this.password,
      this.profileIcon,
      this.profileBackgroundColor,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    if (this.name != null) {
      _$result[r'name'] = _i1.PropertyValue.scalar(this.name!);
    }
    if (this.email != null) {
      _$result[r'email'] = _i1.PropertyValue.scalar(this.email!);
    }
    if (this.privacyActivated != null) {
      _$result[r'privacyActivated'] = _i1.PropertyValue.scalar(
        this.privacyActivated!.toString(),
      );
    }
    if (this.programmeId != null) {
      _$result[r'programmeId'] = _i1.PropertyValue.scalar(
        this.programmeId!.toString(),
      );
    }
    if (this.password != null) {
      _$result[r'password'] = _i1.PropertyValue.scalar(this.password!);
    }
    if (this.profileIcon != null) {
      _$result[r'profileIcon'] = _i1.PropertyValue.scalar(
        this.profileIcon!.toJson(),
      );
    }
    if (this.profileBackgroundColor != null) {
      _$result[r'profileBackgroundColor'] = _i1.PropertyValue.scalar(
        this.profileBackgroundColor!.toJson(),
      );
    }
    return _$result;
  }

  @_i3.override
  _i3.String uriEncode({
    required _i3.bool allowEmpty,
    required _i6.Encoding textEncoding,
    _i3.bool useQueryComponent = false,
    _i3.bool allowReserved = false,
  }) {
    throw _i1.EncodingException(
      r'Cannot uriEncode UpdateUserRequest: complex types cannot be URI-encoded',
    );
  }
}
