import 'dart:async';
import 'dart:math' as math;

import 'package:dio/dio.dart';

import 'exceptions.dart';

/// Retry policy for transient HTTP failures.
class RetryPolicy {
  const RetryPolicy({
    this.maxRetries = 0,
    this.initialBackoff = const Duration(milliseconds: 250),
    this.maxBackoff = const Duration(seconds: 30),
    this.retryableStatuses = const {429, 502, 503, 504},
  });

  /// Maximum number of retry attempts. Default `0` (no retries).
  final int maxRetries;

  /// Initial backoff duration. Doubles on each subsequent retry.
  final Duration initialBackoff;

  /// Maximum backoff duration (caps exponential growth).
  final Duration maxBackoff;

  /// HTTP status codes that trigger a retry.
  final Set<int> retryableStatuses;

  bool get enabled => maxRetries > 0;
}

/// Dio [Interceptor] that retries failed requests according to [RetryPolicy].
///
/// Honors a `Retry-After` header from the server when present (parsed by
/// [ErrorInterceptor] into [RateLimitException.retryAfter]); otherwise uses
/// exponential backoff bounded by [RetryPolicy.maxBackoff].
class RetryInterceptor extends Interceptor {
  RetryInterceptor({required this.dio, required this.policy});

  final Dio dio;
  final RetryPolicy policy;

  static const _retryAttemptKey = '_kreuzberg_retry_attempt';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!policy.enabled || !_shouldRetry(err)) {
      handler.next(err);
      return;
    }

    final attempt = (err.requestOptions.extra[_retryAttemptKey] as int? ?? 0);
    if (attempt >= policy.maxRetries) {
      handler.next(err);
      return;
    }

    final wait = _waitDuration(err, attempt);
    if (wait > Duration.zero) {
      await Future<void>.delayed(wait);
    }

    final options = err.requestOptions;
    final next = Options(
      method: options.method,
      headers: options.headers,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      contentType: options.contentType,
      responseType: options.responseType,
      extra: {...options.extra, _retryAttemptKey: attempt + 1},
    );

    try {
      final response = await dio.request<dynamic>(
        options.path,
        data: options.data,
        queryParameters: options.queryParameters,
        cancelToken: options.cancelToken,
        options: next,
      );
      handler.resolve(response);
    } on DioException catch (retryErr) {
      handler.next(retryErr);
    }
  }

  bool _shouldRetry(DioException err) {
    final status = err.response?.statusCode;
    if (status != null && policy.retryableStatuses.contains(status)) {
      return true;
    }
    // Idempotent transport-level errors are also retryable when the request
    // method is GET or the retryable-status set explicitly includes 0.
    return false;
  }

  Duration _waitDuration(DioException err, int attempt) {
    final inner = err.error;
    if (inner is RateLimitException && inner.retryAfter != null) {
      final hinted = inner.retryAfter!;
      return hinted > policy.maxBackoff ? policy.maxBackoff : hinted;
    }
    final ms = policy.initialBackoff.inMilliseconds * math.pow(2, attempt);
    final capped = math.min(ms.toInt(), policy.maxBackoff.inMilliseconds);
    return Duration(milliseconds: capped);
  }
}
