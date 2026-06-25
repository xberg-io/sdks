import 'package:kreuzberg_cloud_sdk/kreuzberg_cloud_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('ApiException', () {
    test('toString includes status and message', () {
      const e = ApiException(status: 500, message: 'kaboom');
      expect(e.toString(), 'ApiException(500): kaboom');
    });

    test('preserves body', () {
      const e = ApiException(
        status: 400,
        message: 'bad',
        body: {'error': 'bad'},
      );
      expect(e.body, {'error': 'bad'});
    });
  });

  test('AuthException is an ApiException', () {
    const e = AuthException(status: 401, message: 'no key');
    expect(e, isA<ApiException>());
    expect(e.status, 401);
  });

  test('NotFoundException has fixed status 404', () {
    const e = NotFoundException(message: 'missing');
    expect(e.status, 404);
    expect(e, isA<ApiException>());
  });

  test('RateLimitException carries retryAfter', () {
    const e = RateLimitException(
      message: 'slow down',
      retryAfter: Duration(seconds: 7),
    );
    expect(e.status, 429);
    expect(e.retryAfter, const Duration(seconds: 7));
    expect(e.toString(), contains('retry after 7s'));
  });

  test('JobWaitTimeoutException is distinct from ApiException', () {
    const e = JobWaitTimeoutException(
      jobId: 'abc',
      elapsed: Duration(seconds: 10),
    );
    expect(e, isNot(isA<ApiException>()));
    expect(e.toString(), contains('abc'));
    expect(e.toString(), contains('10s'));
  });
}
