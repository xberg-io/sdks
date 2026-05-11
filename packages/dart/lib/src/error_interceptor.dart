import 'package:dio/dio.dart';

import 'exceptions.dart';

/// Dio [Interceptor] that converts [DioException] into the typed
/// [ApiException] hierarchy used by [KreuzbergCloudClient].
class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response == null) {
      handler.next(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: ApiException(
            status: 0,
            message: err.message ?? err.type.name,
          ),
        ),
      );
      return;
    }

    final status = response.statusCode ?? 0;
    final body = response.data;
    final message = _extractMessage(body) ?? response.statusMessage ?? 'HTTP $status';

    final apiException = _classify(status, message, body, response);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: response,
        type: err.type,
        error: apiException,
      ),
    );
  }

  static ApiException _classify(
    int status,
    String message,
    Object? body,
    Response<dynamic> response,
  ) {
    if (status == 401 || status == 403) {
      return AuthException(status: status, message: message, body: body);
    }
    if (status == 400 || status == 422) {
      return ValidationException(status: status, message: message, body: body);
    }
    if (status == 404) {
      return NotFoundException(message: message, body: body);
    }
    if (status == 429) {
      return RateLimitException(
        message: message,
        retryAfter: _parseRetryAfter(response.headers.value('retry-after')),
        body: body,
      );
    }
    if (status >= 500 && status < 600) {
      return ServerException(status: status, message: message, body: body);
    }
    return ApiException(status: status, message: message, body: body);
  }

  static String? _extractMessage(Object? body) {
    if (body is Map) {
      final err = body['error'];
      if (err is String && err.isNotEmpty) {
        return err;
      }
      final msg = body['message'];
      if (msg is String && msg.isNotEmpty) {
        return msg;
      }
    } else if (body is String && body.isNotEmpty) {
      return body;
    }
    return null;
  }

  /// Parses the `Retry-After` header.
  ///
  /// Supports both delta-seconds (`Retry-After: 120`) and HTTP-date format
  /// (`Retry-After: Wed, 21 Oct 2026 07:28:00 GMT`). Returns `null` if the
  /// header is absent or unparseable.
  static Duration? _parseRetryAfter(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final secs = int.tryParse(value.trim());
    if (secs != null) {
      return Duration(seconds: secs);
    }
    final when = DateTime.tryParse(value);
    if (when != null) {
      final delta = when.toUtc().difference(DateTime.now().toUtc());
      return delta.isNegative ? Duration.zero : delta;
    }
    return null;
  }
}
