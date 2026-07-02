import 'package:dio/dio.dart';
import 'package:kreuzberg_cloud_sdk/kreuzberg_cloud_sdk.dart';
import 'package:test/test.dart';

import '_mock_adapter.dart';

KreuzbergCloudClient _newClient(MockAdapter adapter, {RetryPolicy? policy}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.example.test'));
  dio.httpClientAdapter = adapter;
  return KreuzbergCloudClient(
    apiKey: 'test-key',
    baseUrl: 'https://api.example.test',
    dio: dio,
    retryPolicy: policy ?? const RetryPolicy(),
  );
}

void main() {
  group('auth + headers', () {
    test('Authorization header is set to Bearer <apiKey>', () async {
      final adapter = MockAdapter()
      ..enqueueJson(statusCode: 200, body: {'status': 'ok'});
      final client = _newClient(adapter);
      await client.healthz();
      expect(
        adapter.captured.single.headers['Authorization'],
        'Bearer test-key',
      );
    });

    test('User-Agent header carries package version', () async {
      final adapter = MockAdapter()
      ..enqueueJson(statusCode: 200, body: {'status': 'ok'});
      final client = _newClient(adapter);
      await client.healthz();
      expect(
        adapter.captured.single.headers['User-Agent'],
        startsWith('kreuzberg-cloud-sdk-dart/'),
      );
    });

    test('Accept header defaults to application/json', () async {
      final adapter = MockAdapter()
      ..enqueueJson(statusCode: 200, body: {'status': 'ok'});
      final client = _newClient(adapter);
      await client.healthz();
      expect(adapter.captured.single.headers['Accept'], 'application/json');
    });
  });

  group('healthz / readyz', () {
    test('healthz returns parsed HealthResponse', () async {
      final adapter = MockAdapter()
      ..enqueueJson(statusCode: 200, body: {'status': 'ok'});
      final client = _newClient(adapter);
      final res = await client.healthz();
      expect(res.status, 'ok');
      expect(adapter.captured.single.path, '/healthz');
      expect(adapter.captured.single.method, 'GET');
    });

    test('readyz returns parsed ReadinessResponse with checks', () async {
      final adapter = MockAdapter()
      ..enqueueJson(
        statusCode: 200,
        body: {
          'status': 'ready',
          'checks': {'database': 'ok', 'nats': 'ok'},
        },
      );
      final client = _newClient(adapter);
      final res = await client.readyz();
      expect(res.status, 'ready');
      expect(res.checks.database, 'ok');
      expect(res.checks.nats, 'ok');
    });
  });

  group('jobs', () {
    test('getJob fetches /v1/jobs/{id}', () async {
      final adapter = MockAdapter()
      ..enqueueJson(
        statusCode: 200,
        body: {
          'id': '550e8400-e29b-41d4-a716-446655440000',
          'filename': 'foo.pdf',
          'status': 'pending',
          'created_at': '2026-05-11T12:00:00Z',
        },
      );
      final client = _newClient(adapter);
      final job = await client.getJob('550e8400-e29b-41d4-a716-446655440000');
      expect(job.id, '550e8400-e29b-41d4-a716-446655440000');
      expect(job.status, JobStatus.pending);
      expect(adapter.captured.single.path, contains('/v1/jobs/'));
      expect(adapter.captured.single.method, 'GET');
    });

    test('JobStatus.isTerminal works for all terminal states', () {
      expect(JobStatus.completed.isTerminal, isTrue);
      expect(JobStatus.partialSuccess.isTerminal, isTrue);
      expect(JobStatus.failed.isTerminal, isTrue);
      expect(JobStatus.cancelled.isTerminal, isTrue);
      expect(JobStatus.pending.isTerminal, isFalse);
      expect(JobStatus.processing.isTerminal, isFalse);
    });
  });

  group('usage', () {
    test('getUsage forwards query parameters', () async {
      final adapter = MockAdapter()
      ..enqueueJson(
        statusCode: 200,
        body: {
          'period_start': '2026-05-01',
          'period_end': '2026-06-01',
          'total_pages': 0,
          'total_documents': 0,
          'total_failed': 0,
          'by_mime_type': <String, dynamic>{},
        },
      );
      final client = _newClient(adapter);
      await client.getUsage(start: '2026-05-01', end: '2026-06-01');
      expect(adapter.captured.single.queryParameters['start'], '2026-05-01');
      expect(adapter.captured.single.queryParameters['end'], '2026-06-01');
    });
  });

  group('error mapping', () {
    Future<void> assertMaps({
      required int status,
      required Object? body,
      required Matcher matcher,
    }) async {
      final adapter = MockAdapter()
      ..enqueueJson(statusCode: status, body: body);
      final client = _newClient(adapter);
      try {
        await client.healthz();
        fail('expected exception for status $status');
      } on DioException catch (e) {
        expect(e.error, matcher);
      }
    }

    test(
      '401 -> AuthException',
      () => assertMaps(
        status: 401,
        body: {'error': 'no auth'},
        matcher: isA<AuthException>(),
      ),
    );

    test(
      '403 -> AuthException',
      () => assertMaps(
        status: 403,
        body: {'error': 'forbidden'},
        matcher: isA<AuthException>(),
      ),
    );

    test(
      '400 -> ValidationException',
      () => assertMaps(
        status: 400,
        body: {'error': 'bad input'},
        matcher: isA<ValidationException>(),
      ),
    );

    test(
      '422 -> ValidationException',
      () => assertMaps(
        status: 422,
        body: {'error': 'bad input'},
        matcher: isA<ValidationException>(),
      ),
    );

    test(
      '404 -> NotFoundException',
      () => assertMaps(
        status: 404,
        body: {'error': 'gone'},
        matcher: isA<NotFoundException>(),
      ),
    );

    test(
      '429 -> RateLimitException',
      () => assertMaps(
        status: 429,
        body: {'error': 'slow down'},
        matcher: isA<RateLimitException>(),
      ),
    );

    test(
      '500 -> ServerException',
      () => assertMaps(
        status: 500,
        body: {'error': 'oops'},
        matcher: isA<ServerException>(),
      ),
    );

    test(
      '503 -> ServerException',
      () => assertMaps(
        status: 503,
        body: {'error': 'down'},
        matcher: isA<ServerException>(),
      ),
    );

    test('429 parses Retry-After delta-seconds', () async {
      final adapter = MockAdapter()
      ..enqueue(
        const MockResponse(
          statusCode: 429,
          body: {'error': 'slow down'},
          headers: {
            'content-type': ['application/json'],
            'retry-after': ['7'],
          },
        ),
      );
      final client = _newClient(adapter);
      try {
        await client.healthz();
        fail('expected RateLimitException');
      } on DioException catch (e) {
        final err = e.error as RateLimitException;
        expect(err.retryAfter, const Duration(seconds: 7));
      }
    });
  });

  group('retry', () {
    test('retries on 503 then succeeds', () async {
      final adapter = MockAdapter()
      ..enqueueJson(statusCode: 503, body: {'error': 'down'})
      ..enqueueJson(statusCode: 200, body: {'status': 'ok'});
      final client = _newClient(
        adapter,
        policy: const RetryPolicy(
          maxRetries: 2,
          initialBackoff: Duration(milliseconds: 1),
        ),
      );
      final res = await client.healthz();
      expect(res.status, 'ok');
      expect(adapter.captured.length, 2);
    });

    test('gives up after maxRetries on persistent 504', () async {
      final adapter = MockAdapter()
      ..enqueueJson(statusCode: 504, body: {'error': 'tmout'})
      ..enqueueJson(statusCode: 504, body: {'error': 'tmout'})
      ..enqueueJson(statusCode: 504, body: {'error': 'tmout'});
      final client = _newClient(
        adapter,
        policy: const RetryPolicy(
          maxRetries: 2,
          initialBackoff: Duration(milliseconds: 1),
        ),
      );
      try {
        await client.healthz();
        fail('expected ServerException');
      } on DioException catch (e) {
        expect(e.error, isA<ServerException>());
        expect(adapter.captured.length, 3); // initial + 2 retries
      }
    });

    test('does not retry on 400', () async {
      final adapter = MockAdapter()
      ..enqueueJson(statusCode: 400, body: {'error': 'no'});
      final client = _newClient(
        adapter,
        policy: const RetryPolicy(
          maxRetries: 3,
          initialBackoff: Duration(milliseconds: 1),
        ),
      );
      try {
        await client.healthz();
        fail('expected ValidationException');
      } on DioException catch (e) {
        expect(e.error, isA<ValidationException>());
        expect(adapter.captured.length, 1);
      }
    });

    test('honors Retry-After header on 429', () async {
      final adapter = MockAdapter()
      ..enqueue(
        const MockResponse(
          statusCode: 429,
          body: {'error': 'slow'},
          headers: {
            'content-type': ['application/json'],
            'retry-after': ['0'],
          },
        ),
      )
      ..enqueueJson(statusCode: 200, body: {'status': 'ok'});
      final client = _newClient(
        adapter,
        policy: const RetryPolicy(maxRetries: 1),
      );
      final res = await client.healthz();
      expect(res.status, 'ok');
      expect(adapter.captured.length, 2);
    });
  });

  group('waitForJob', () {
    test('polls until terminal status', () async {
      final adapter = MockAdapter()
      ..enqueueJson(
        statusCode: 200,
        body: {
          'id': 'job-1',
          'filename': 'f.pdf',
          'status': 'pending',
          'created_at': '2026-05-11T12:00:00Z',
        },
      )
      ..enqueueJson(
        statusCode: 200,
        body: {
          'id': 'job-1',
          'filename': 'f.pdf',
          'status': 'processing',
          'created_at': '2026-05-11T12:00:00Z',
        },
      )
      ..enqueueJson(
        statusCode: 200,
        body: {
          'id': 'job-1',
          'filename': 'f.pdf',
          'status': 'completed',
          'created_at': '2026-05-11T12:00:00Z',
        },
      );
      final client = _newClient(adapter);
      final job = await client.waitForJob(
        'job-1',
        timeout: const Duration(seconds: 5),
        pollInterval: const Duration(milliseconds: 5),
        backoff: BackoffKind.constant,
      );
      expect(job.status, JobStatus.completed);
      expect(adapter.captured.length, 3);
    });

    test('throws JobWaitTimeoutException when deadline elapses', () async {
      final adapter = MockAdapter();
      for (var i = 0; i < 100; i++) {
        adapter.enqueueJson(
          statusCode: 200,
          body: {
            'id': 'job-1',
            'filename': 'f.pdf',
            'status': 'processing',
            'created_at': '2026-05-11T12:00:00Z',
          },
        );
      }
      final client = _newClient(adapter);
      try {
        await client.waitForJob(
          'job-1',
          timeout: const Duration(milliseconds: 50),
          pollInterval: const Duration(milliseconds: 10),
          backoff: BackoffKind.constant,
        );
        fail('expected JobWaitTimeoutException');
      } on JobWaitTimeoutException catch (e) {
        expect(e.jobId, 'job-1');
      }
    });
  });
}
