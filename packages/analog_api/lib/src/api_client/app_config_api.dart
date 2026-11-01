// Generated code - do not modify by hand

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:core' as _i3;

import 'package:analog_api/src/model/app_config.dart' as _i5;
import 'package:analog_api/src/operation/app_config_get.dart' as _i2;
import 'package:analog_api/src/server/server.dart' as _i1;
import 'package:dio/dio.dart' as _i6;
import 'package:tonik_util/tonik_util.dart' as _i4;

class AppConfigApi {
  AppConfigApi(_i1.Server server)
    : _appConfigGet = _i2.AppConfigGet(server.baseUrl, () => server.dio);

  final _i2.AppConfigGet _appConfigGet;

  /// Get app configuration
  _i3.Future<_i4.TonikResult<_i5.AppConfig, _i6.Response<_i3.Object?>>>
  appConfigGet({_i4.TonikCancellation? cancellation}) async =>
      this._appConfigGet(cancellation: cancellation);
}
