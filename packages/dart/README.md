# kreuzberg_cloud_sdk

Official Dart client SDK for the [Xberg Enterprise][cloud] document extraction API.

- Asynchronous extraction with webhook delivery, presigned uploads, and job polling
- Generated from the Xberg Enterprise OpenAPI 3.1 spec via `swagger_parser` (Retrofit + Dio, Freezed 3 sealed models)
- Hand-written facade adds bearer auth, retry-with-backoff, typed exception hierarchy, multipart helpers, and `waitForJob` polling

[cloud]: https://xberg.io

## Install

```sh
dart pub add kreuzberg_cloud_sdk
```

Flutter projects: works out of the box (pure Dart, no plugin code).

## Usage

```dart
import 'package:kreuzberg_cloud_sdk/kreuzberg_cloud_sdk.dart';

Future<void> main() async {
  final client = KreuzbergCloudClient(
    apiKey: 'kc_...',
    retryPolicy: const RetryPolicy(maxRetries: 3),
  );

  // 1. Health check.
  final health = await client.healthz();
  print(health.status); // ok

  // 2. Submit one or more documents (JSON path).
  final accepted = await client.extract(
    ExtractJsonRequest(
      documents: [
        DocumentInput(
          filename: 'invoice.pdf',
          mimeType: 'application/pdf',
          data: base64Encode(await File('invoice.pdf').readAsBytes()),
        ),
      ],
      options: const ExtractionOptions(
        extractionConfig: ExtractionConfig(outputFormat: 'markdown'),
      ),
    ),
  );

  // 3. Wait until the first job reaches a terminal status.
  final finished = await client.waitForJob(
    accepted.jobIds.first,
    timeout: const Duration(minutes: 5),
  );
  print(finished.result?.content);

  client.close();
}
```

### Multipart upload

The JSON path requires base64-encoded payloads, which doubles the wire size. For
large files use `extractMultipart`:

```dart
final response = await client.extractMultipart(
  files: [
    await MultipartFile.fromFile('invoice.pdf'),
  ],
  options: const ExtractionOptions(
    extractionConfig: ExtractionConfig(outputFormat: 'markdown'),
  ),
);
```

### Presigned uploads (large batches)

For batches that exceed request-size limits, request presigned URLs and upload
out of band:

```dart
final presigned = await client.presignUpload(
  PresignUploadRequest(
    documents: [
      PresignDocumentInput(filename: 'a.pdf', mimeType: 'application/pdf'),
      PresignDocumentInput(filename: 'b.pdf', mimeType: 'application/pdf'),
    ],
  ),
);

// PUT each file to presigned.uploads[i].uploadUrl directly...

await client.confirmUpload(ConfirmUploadRequest(batchId: presigned.batchId));
```

## Errors

Every HTTP failure surfaces as a typed subclass of `ApiException`:

| Status | Exception |
|---|---|
| 400 / 422 | `ValidationException` |
| 401 / 403 | `AuthException` |
| 404 | `NotFoundException` |
| 429 | `RateLimitException` (`.retryAfter` parsed from `Retry-After`) |
| 5xx | `ServerException` |

```dart
try {
  await client.getJob(jobId);
} on NotFoundException {
  // ...
} on RateLimitException catch (e) {
  await Future.delayed(e.retryAfter ?? const Duration(seconds: 5));
} on ApiException catch (e) {
  print('${e.status}: ${e.message}');
}
```

`waitForJob` throws `JobWaitTimeoutException` (not `ApiException`) when the
polling deadline elapses; the job may still complete server-side.

## Retry policy

By default the client does not retry. Opt in via `RetryPolicy`:

```dart
final client = KreuzbergCloudClient(
  apiKey: '...',
  retryPolicy: const RetryPolicy(
    maxRetries: 3,
    initialBackoff: Duration(milliseconds: 250),
    maxBackoff: Duration(seconds: 30),
  ),
);
```

Retries fire on `429`, `502`, `503`, `504`. The server's `Retry-After` header is
honored when present; otherwise backoff is exponential with the configured
ceiling.

## Configuration

```dart
KreuzbergCloudClient(
  apiKey: 'kc_...',
  baseUrl: 'https://api.staging.enterprise.xberg.io', // optional
  timeout: const Duration(seconds: 30),           // optional
  retryPolicy: const RetryPolicy(maxRetries: 3),  // optional
  userAgent: 'my-app/1.0',                        // optional
  dio: customDio,                                 // optional — inject for tracing, custom transport
);
```

## Generated models

All request/response schemas (66 in total) are generated as `freezed`
sealed/data classes with `fromJson` / `toJson`. They are re-exported from
this package, so `import 'package:kreuzberg_cloud_sdk/kreuzberg_cloud_sdk.dart';`
gives you everything.

## License

MIT — see `LICENSE`.

---

Built and maintained by [Kreuzberg, Inc.](https://xberg.io) — `contact@kreuzberg.dev`.
Cross-language SDKs available in [Python](https://pypi.org/project/kreuzberg-cloud-sdk/),
[TypeScript](https://www.npmjs.com/package/@kreuzberg/cloud), and
[Go](https://github.com/xberg-io/sdks/tree/main/packages/go/v1).
