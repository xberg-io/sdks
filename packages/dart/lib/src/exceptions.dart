import 'package:meta/meta.dart';

/// Base exception thrown by [KreuzbergCloudClient] for non-success API responses.
///
/// All HTTP errors surface as a subclass of [ApiException]. The original
/// response body (decoded as JSON when possible) is preserved in [body], and
/// the numeric HTTP status is in [status].
@immutable
class ApiException implements Exception {
  const ApiException({required this.status, required this.message, this.body});

  /// HTTP status code.
  final int status;

  /// Human-readable error message. Extracted from the response body's `error`
  /// or `message` field when present; falls back to the raw body or HTTP
  /// reason phrase.
  final String message;

  /// Parsed response body, if any.
  final Object? body;

  @override
  String toString() => 'ApiException($status): $message';
}

/// 401 / 403 — authentication failure or insufficient permissions.
class AuthException extends ApiException {
  const AuthException({
    required super.status,
    required super.message,
    super.body,
  });

  @override
  String toString() => 'AuthException($status): $message';
}

/// 400 / 422 — request validation failed.
class ValidationException extends ApiException {
  const ValidationException({
    required super.status,
    required super.message,
    super.body,
  });

  @override
  String toString() => 'ValidationException($status): $message';
}

/// 404 — requested resource does not exist.
class NotFoundException extends ApiException {
  const NotFoundException({required super.message, super.body})
  : super(status: 404);

  @override
  String toString() => 'NotFoundException: $message';
}

/// 429 — rate limit or quota exhausted.
///
/// [retryAfter] is parsed from the `Retry-After` header when the server
/// supplies it. Wait this duration before re-issuing the request.
class RateLimitException extends ApiException {
  const RateLimitException({
    required super.message,
    this.retryAfter,
    super.body,
  }) : super(status: 429);

  /// Suggested wait time before retry, parsed from `Retry-After` header.
  final Duration? retryAfter;

  @override
  String toString() =>
  'RateLimitException: $message${retryAfter != null ? ' (retry after ${retryAfter!.inSeconds}s)' : ''}';
}

/// 5xx — upstream server error.
class ServerException extends ApiException {
  const ServerException({
    required super.status,
    required super.message,
    super.body,
  });

  @override
  String toString() => 'ServerException($status): $message';
}

/// Thrown by `waitForJob` / `waitForJobs` when the polling deadline elapses
/// before the job reaches a terminal status.
///
/// Distinct from request-level timeouts (which surface as [ApiException] with
/// status 0). The job may still complete on the server.
@immutable
class JobWaitTimeoutException implements Exception {
  const JobWaitTimeoutException({required this.jobId, required this.elapsed});

  /// The job that did not reach a terminal status in time.
  final String jobId;

  /// How long we waited before giving up.
  final Duration elapsed;

  @override
  String toString() =>
  'JobWaitTimeoutException: job $jobId did not finish within ${elapsed.inSeconds}s';
}
