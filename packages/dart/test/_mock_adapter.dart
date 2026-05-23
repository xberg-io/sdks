import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Captured request data for assertions.
class CapturedRequest {
  CapturedRequest({
    required this.method,
    required this.path,
    required this.headers,
    required this.queryParameters,
    this.body,
  });

  final String method;
  final String path;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> queryParameters;
  final Object? body;
}

/// Canned response for a queued call.
class MockResponse {
  const MockResponse({
    required this.statusCode,
    this.body,
    this.headers = const {},
  });

  final int statusCode;
  final Object? body;
  final Map<String, List<String>> headers;
}

/// Lightweight Dio [HttpClientAdapter] that returns queued responses in order
/// and records every request for inspection. No external dependency.
class MockAdapter implements HttpClientAdapter {
  MockAdapter();

  final List<MockResponse> _responses = [];
  final List<CapturedRequest> captured = [];

  /// Enqueue a single response to be returned by the next request.
  void enqueue(MockResponse response) => _responses.add(response);

  /// Enqueue a JSON-body response.
  void enqueueJson({
    required int statusCode,
    Object? body,
    Map<String, List<String>> headers = const {},
  }) {
    _responses.add(
      MockResponse(
        statusCode: statusCode,
        body: body,
        headers: {
          'content-type': const ['application/json'],
          ...headers,
        },
      ),
    );
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    Object? capturedBody;
    if (requestStream != null) {
      final bytes = await _collect(requestStream);
      try {
        capturedBody = utf8.decode(bytes);
      } on FormatException {
        capturedBody = bytes;
      }
    }

    captured.add(
      CapturedRequest(
        method: options.method,
        path: options.path,
        headers: {...options.headers},
        queryParameters: {...options.queryParameters},
        body: capturedBody,
      ),
    );

    if (_responses.isEmpty) {
      throw StateError(
        'MockAdapter: no response queued for ${options.method} ${options.path}',
      );
    }
    final response = _responses.removeAt(0);
    final bodyBytes = _encodeBody(response.body);
    return ResponseBody.fromBytes(
      bodyBytes,
      response.statusCode,
      headers: response.headers,
    );
  }

  Uint8List _encodeBody(Object? body) {
    if (body == null) {
      return Uint8List(0);
    }
    if (body is Uint8List) {
      return body;
    }
    if (body is String) {
      return Uint8List.fromList(utf8.encode(body));
    }
    return Uint8List.fromList(utf8.encode(jsonEncode(body)));
  }

  Future<Uint8List> _collect(Stream<Uint8List> stream) async {
    final builder = BytesBuilder(copy: false);
    await for (final chunk in stream) {
      builder.add(chunk);
    }
    return builder.toBytes();
  }

  @override
  void close({bool force = false}) {}
}
