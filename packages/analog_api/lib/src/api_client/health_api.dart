// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i4;

import 'package:analog_api/src/operation/health_healthcheck.dart' as _i3;
import 'package:analog_api/src/operation/health_ping.dart' as _i2;
import 'package:analog_api/src/response_wrapper/health_healthcheck_response.dart'
    as _i7;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i6;
import 'package:tonik_util/tonik_util.dart' as _i5;

class HealthApi {
  HealthApi(_i1.Server server)
    : _healthPing = _i2.HealthPing(server.baseUrl, () => server.dio),
      _healthHealthcheck = _i3.HealthHealthcheck(
        server.baseUrl,
        () => server.dio,
      );

  final _i2.HealthPing _healthPing;

  final _i3.HealthHealthcheck _healthHealthcheck;

  /// Ping
  ///
  /// Security:
  /// - API Key (header): Api Key used for health endpoints
  _i4.Future<_i5.TonikResult<_i4.String, _i6.Response<_i4.Object?>>>
  healthPing({_i5.TonikCancellation? cancellation}) async =>
      this._healthPing(cancellation: cancellation);

  /// Check service health
  ///
  /// Security:
  /// - API Key (header): Api Key used for health endpoints
  _i4.Future<
    _i5.TonikResult<_i7.HealthHealthcheckResponse, _i6.Response<_i4.Object?>>
  >
  healthHealthcheck({_i5.TonikCancellation? cancellation}) async =>
      this._healthHealthcheck(cancellation: cancellation);
}
