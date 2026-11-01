import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

typedef FakeHttpHandler = Future<ResponseBody> Function(RequestOptions options);

/// A minimal [HttpClientAdapter] that lets tests script HTTP responses.
class FakeHttpClientAdapter implements HttpClientAdapter {
  new(this.handler);

  FakeHttpHandler handler;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requests.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

/// Builds a JSON [ResponseBody] with the given status code.
ResponseBody jsonResponse(Object body, int statusCode) {
  return ResponseBody.fromString(
    jsonEncode(body),
    statusCode,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}
