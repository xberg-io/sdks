import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '_generated/kreuzberg_cloud_api.dart';
import '_generated/models/confirm_upload_request.dart';
import '_generated/models/confirm_upload_response.dart';
import '_generated/models/extract_json_request.dart';
import '_generated/models/extract_response.dart';
import '_generated/models/crawl_job_response.dart';
import '_generated/models/extraction_options.dart';
import '_generated/models/health_response.dart';
import '_generated/models/job_lookup_response.dart';
import '_generated/models/job_response.dart';
import '_generated/models/presign_upload_request.dart';
import '_generated/models/presign_upload_response.dart';
import '_generated/models/readiness_response.dart';
import '_generated/models/usage_response.dart';
import '_generated/models/webhook_config.dart';
import 'error_interceptor.dart';
import 'jobs_wait.dart';
import 'retry.dart';
import 'version.dart';

const _defaultBaseUrl = 'https://api.kreuzberg.dev';
const _defaultTimeout = Duration(seconds: 30);

/// High-level Dart client for the Kreuzberg Cloud API.
///
/// Wraps the generated Retrofit clients with:
/// * bearer-token authentication
/// * retry-with-backoff for 429/502/503/504 (honors `Retry-After`)
/// * a typed exception hierarchy ([ApiException] and subclasses)
/// * job-polling helpers ([waitForJob], [waitForJobs])
/// * a multipart variant of `/v1/extract` ([extractMultipart])
///
/// Construct one client per API key and reuse it across requests; the
/// underlying Dio HTTP client maintains a connection pool internally.
class KreuzbergCloudClient {
  /// Creates a new client.
  ///
  /// [apiKey] is sent as `Authorization: Bearer <apiKey>` on every request.
  ///
  /// [baseUrl] defaults to `https://api.kreuzberg.dev`.
  ///
  /// [timeout] is applied as connect/send/receive timeout on the underlying
  /// Dio client (default 30s).
  ///
  /// [retryPolicy] controls automatic retries. Default is `RetryPolicy()` —
  /// no retries. Pass `RetryPolicy(maxRetries: 3)` for production usage.
  ///
  /// [userAgent] overrides the default `kreuzberg-cloud-sdk-dart/<version>`
  /// header.
  ///
  /// [dio] lets callers inject a pre-configured Dio instance (for custom
  /// transports, interceptors, or tests). When provided, the client appends
  /// its own auth/error/retry interceptors but does not modify the base
  /// options.
  KreuzbergCloudClient({
    required this.apiKey,
    this.baseUrl = _defaultBaseUrl,
    Duration timeout = _defaultTimeout,
    RetryPolicy retryPolicy = const RetryPolicy(),
    String? userAgent,
    Dio? dio,
  }) : _userAgent = userAgent ?? 'kreuzberg-cloud-sdk-dart/$packageVersion',
       _dio = dio ?? _buildDio(baseUrl: baseUrl, timeout: timeout) {
    _dio.interceptors
      ..add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers.putIfAbsent(
              'Authorization',
              () => 'Bearer $apiKey',
            );
            options.headers.putIfAbsent('User-Agent', () => _userAgent);
            options.headers.putIfAbsent('Accept', () => 'application/json');
            handler.next(options);
          },
        ),
      )
      ..add(const ErrorInterceptor())
      ..add(RetryInterceptor(dio: _dio, policy: retryPolicy));
    _api = KreuzbergCloudApi(_dio, baseUrl: baseUrl);
  }

  /// API key used for bearer authentication.
  final String apiKey;

  /// Base URL of the API.
  final String baseUrl;

  final String _userAgent;
  final Dio _dio;
  late final KreuzbergCloudApi _api;

  /// Access to the underlying Dio instance — for advanced callers who need
  /// to add custom interceptors or inspect the connection pool.
  @visibleForTesting
  Dio get dio => _dio;

  static Dio _buildDio({required String baseUrl, required Duration timeout}) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        sendTimeout: timeout,
        receiveTimeout: timeout,
        responseType: ResponseType.json,
      ),
    );
  }

  /// Release all sockets in the underlying Dio connection pool.
  ///
  /// Call when the client is no longer needed (e.g. in shutdown handlers).
  void close({bool force = false}) => _dio.close(force: force);

  // ---- Health -----------------------------------------------------------

  /// Liveness probe. Returns 200 with `status: ok` if the service is alive.
  Future<HealthResponse> healthz() => _api.health.healthz();

  /// Readiness probe. May return 503 if dependencies (database, NATS, …)
  /// are unavailable; the [ReadinessResponse] payload describes which
  /// component is unhealthy.
  Future<ReadinessResponse> readyz() => _api.health.readyz();

  // ---- Extraction (JSON) ------------------------------------------------

  /// Submits one or more documents for extraction via the JSON endpoint.
  ///
  /// Each document's payload must be supplied as base64 in
  /// `DocumentInput.data`. For binary uploads of large files, prefer
  /// [extractMultipart] or the presign-upload flow ([presignUpload] +
  /// [confirmUpload]).
  Future<ExtractResponse> extract(ExtractJsonRequest request) =>
      _api.extract.extract(body: request);

  /// Submits one or more files via `multipart/form-data` on `/v1/extract`.
  ///
  /// [files] is the list of file parts to upload (construct via
  /// `MultipartFile.fromBytes`, `MultipartFile.fromPath`, or
  /// `MultipartFile.fromStream`).
  ///
  /// [options] are encoded into the optional `options` form field.
  ///
  /// [webhook] is encoded into the optional `webhook` form field.
  Future<ExtractResponse> extractMultipart({
    required List<MultipartFile> files,
    ExtractionOptions? options,
    WebhookConfig? webhook,
  }) async {
    if (files.isEmpty) {
      throw ArgumentError.value(
        files,
        'files',
        'must contain at least one file',
      );
    }
    final form = FormData();
    for (final file in files) {
      form.files.add(MapEntry('file', file));
    }
    if (options != null) {
      form.fields.add(MapEntry('options', jsonEncode(options.toJson())));
    }
    if (webhook != null) {
      form.fields.add(MapEntry('webhook', jsonEncode(webhook.toJson())));
    }
    final response = await _dio.post<Map<String, dynamic>>(
      '/v1/extract',
      data: form,
      options: Options(contentType: 'multipart/form-data'),
    );
    return ExtractResponse.fromJson(response.data!);
  }

  // ---- Jobs -------------------------------------------------------------

  /// Fetches the current status (and result, when terminal) of a job.
  ///
  /// The underlying `/v1/jobs/{id}` endpoint can return either an extraction
  /// job ([JobResponse]) or a crawl job ([CrawlJobResponse]). This helper
  /// unwraps the extraction variant for back-compat; use [getJobLookup] to
  /// access the full discriminated response.
  Future<JobResponse> getJob(String jobId) async {
    final lookup = await _api.jobs.getJob(id: jobId);
    return switch (lookup) {
      JobLookupResponseExtraction(:final value) => value,
      JobLookupResponseCrawl() => throw StateError(
        'Job $jobId is a crawl job; use getJobLookup() to access it.',
      ),
    };
  }

  /// Fetches the discriminated lookup response for a job ID, preserving the
  /// extraction-vs-crawl distinction.
  Future<JobLookupResponse> getJobLookup(String jobId) =>
      _api.jobs.getJob(id: jobId);

  /// Polls [getJob] until the job reaches a terminal status, or `timeout`
  /// elapses. Throws [JobWaitTimeoutException] on timeout, or [ApiException]
  /// on a transport failure.
  Future<JobResponse> waitForJob(
    String jobId, {
    Duration timeout = const Duration(minutes: 5),
    Duration pollInterval = const Duration(seconds: 1),
    BackoffKind backoff = BackoffKind.exponential,
  }) {
    return pollUntilTerminal(
      jobId: jobId,
      fetch: () => getJob(jobId),
      timeout: timeout,
      pollInterval: pollInterval,
      backoff: backoff,
    );
  }

  /// Concurrently polls multiple jobs to terminal status. Order of results
  /// matches order of `jobIds`. First failure cancels logical interest in
  /// the rest (matches Go SDK semantics).
  Future<List<JobResponse>> waitForJobs(
    List<String> jobIds, {
    Duration timeout = const Duration(minutes: 5),
    Duration pollInterval = const Duration(seconds: 1),
    BackoffKind backoff = BackoffKind.exponential,
  }) {
    return pollManyUntilTerminal(
      jobIds: jobIds,
      fetch: getJob,
      timeout: timeout,
      pollInterval: pollInterval,
      backoff: backoff,
    );
  }

  // ---- Uploads ----------------------------------------------------------

  /// Requests presigned upload URLs for one or more documents. The client
  /// then PUTs each file to the returned URL out-of-band, and calls
  /// [confirmUpload] with the `batch_id` to start processing.
  Future<PresignUploadResponse> presignUpload(PresignUploadRequest request) =>
      _api.uploads.presignUpload(body: request);

  /// Confirms uploads against a `batch_id` returned by [presignUpload]; the
  /// server verifies all files exist in storage and dispatches jobs.
  Future<ConfirmUploadResponse> confirmUpload(ConfirmUploadRequest request) =>
      _api.uploads.confirmUpload(body: request);

  // ---- Usage ------------------------------------------------------------

  /// Returns usage and quota statistics for the given date range.
  ///
  /// Both [start] and [end] are ISO 8601 dates (e.g. `2026-03-01`). When
  /// omitted, the server defaults to the current calendar month.
  Future<UsageResponse> getUsage({String? start, String? end}) =>
      _api.usage.getUsage(start: start, end: end);
}
