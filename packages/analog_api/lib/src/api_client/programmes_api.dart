// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/programme_response.dart' as _i5;
import 'package:analog_api/src/operation/programmes_get.dart' as _i2;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i6;
import 'package:tonik_util/tonik_util.dart' as _i4;

class ProgrammesApi {
  ProgrammesApi(_i1.Server server)
    : _programmesGet = _i2.ProgrammesGet(server.baseUrl, () => server.dio);

  final _i2.ProgrammesGet _programmesGet;

  /// Returns the list of active study programmes.
  _i3.Future<
    _i4.TonikResult<_i3.List<_i5.ProgrammeResponse>, _i6.Response<_i3.Object?>>
  >
  programmesGet({_i4.TonikCancellation? cancellation}) async =>
      this._programmesGet(cancellation: cancellation);
}
