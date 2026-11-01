// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:convert' as _i5;
import 'dart:core' as _i3;

import 'package:analog_api/src/model/quick_stat_type.dart' as _i4;
import 'package:meta/meta.dart' as _i2;
import 'package:tonik_util/tonik_util.dart' as _i1;

/// A small stat card used by the quick statistics endpoint.
@_i2.immutable
class QuickStatResponse extends _i1.ObjectParameterEncodable
    implements _i1.UriEncodable {
  const QuickStatResponse({
    required this.key,
    required this.title,
    required this.value,
    required this.supportingText,
  });

  factory QuickStatResponse.fromSimple(
    _i3.String? value, {
    required _i3.bool explode,
    _i3.bool isHeader = false,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: ',',
      expectedKeys: {r'key', r'title', r'value', r'supportingText'},
      listKeys: {},
      context: r'QuickStatResponse',
      isHeader: isHeader,
      percentDecodeKeys: false,
    );
    return QuickStatResponse(
      key: _i4.QuickStatType.fromSimple(_$values[r'key'], explode: explode),
      title: _$values[r'title'].decodeSimpleString(
        context: r'QuickStatResponse.title',
      ),
      value: _$values[r'value'].decodeSimpleInt(
        context: r'QuickStatResponse.value',
      ),
      supportingText: _$values[r'supportingText'].decodeSimpleNullableString(
        context: r'QuickStatResponse.supportingText',
      ),
    );
  }

  factory QuickStatResponse.fromJson(_i3.Object? json) {
    final _$map = json.decodeMap(context: r'QuickStatResponse');
    return QuickStatResponse(
      key: _i4.QuickStatType.fromJson(_$map[r'key']),
      title: _$map[r'title'].decodeJsonString(
        context: r'QuickStatResponse.title',
      ),
      value: _$map[r'value'].decodeJsonInt(context: r'QuickStatResponse.value'),
      supportingText: _$map[r'supportingText'].decodeJsonNullableString(
        context: r'QuickStatResponse.supportingText',
      ),
    );
  }

  factory QuickStatResponse.fromForm(
    _i3.String? value, {
    required _i3.bool explode,
  }) {
    final _$values = value.decodeObject(
      explode: explode,
      explodeSeparator: '&',
      expectedKeys: {r'key', r'title', r'value', r'supportingText'},
      listKeys: {},
      context: r'QuickStatResponse',
    );
    return QuickStatResponse(
      key: _i4.QuickStatType.fromForm(_$values[r'key'], explode: explode),
      title: _$values[r'title'].decodeFormString(
        context: r'QuickStatResponse.title',
      ),
      value: _$values[r'value'].decodeFormInt(
        context: r'QuickStatResponse.value',
      ),
      supportingText: _$values[r'supportingText'].decodeFormNullableString(
        context: r'QuickStatResponse.supportingText',
      ),
    );
  }

  final _i4.QuickStatType key;

  /// Card title.
  final _i3.String title;

  /// Main value shown in the card.
  final _i3.int value;

  /// Smaller supporting text shown below the main value.
  final _i3.String? supportingText;

  @_i3.override
  _i3.Object? toJson() => {
    r'key': this.key.toJson(),
    r'title': this.title,
    r'value': this.value,
    r'supportingText': this.supportingText,
  };

  QuickStatResponse Function({
    _i4.QuickStatType? key,
    _i3.String? title,
    _i3.int? value,
    _i3.String? supportingText,
  })
  get copyWith {
    const _i3.Object _sentinel = _i3.Object();
    return ({
      _i4.QuickStatType? key,
      _i3.String? title,
      _i3.int? value,
      _i3.Object? supportingText = _sentinel,
    }) => QuickStatResponse(
      key: key ?? this.key,
      title: title ?? this.title,
      value: value ?? this.value,
      supportingText: _i3.identical(supportingText, _sentinel)
          ? this.supportingText
          : (supportingText as _i3.String?),
    );
  }

  @_i3.override
  _i3.bool operator ==(_i3.Object other) {
    if (_i3.identical(this, other)) return true;
    return other is QuickStatResponse &&
        other.key == this.key &&
        other.title == this.title &&
        other.value == this.value &&
        other.supportingText == this.supportingText;
  }

  @_i3.override
  _i3.int get hashCode {
    return _i3.Object.hashAll([
      this.key,
      this.title,
      this.value,
      this.supportingText,
    ]);
  }

  _i1.EncodingShape get currentEncodingShape => _i1.EncodingShape.complex;

  @_i3.override
  _i3.Map<_i3.String, _i1.PropertyValue> parameterProperties({
    _i3.bool allowEmpty = true,
  }) {
    final _$result = <_i3.String, _i1.PropertyValue>{};
    _$result[r'key'] = _i1.PropertyValue.scalar(this.key.toJson());
    _$result[r'title'] = _i1.PropertyValue.scalar(this.title);
    _$result[r'value'] = _i1.PropertyValue.scalar(this.value.toString());
    if (this.supportingText != null) {
      _$result[r'supportingText'] = _i1.PropertyValue.scalar(
        this.supportingText!,
      );
    }
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
      r'Cannot uriEncode QuickStatResponse: complex types cannot be URI-encoded',
    );
  }
}
