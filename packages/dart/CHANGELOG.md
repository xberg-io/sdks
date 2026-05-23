## 0.1.1

- Publish Dart releases from the split pub.dev workflow.

## 0.1.0

- Default API endpoint is now `https://api.kreuzberg.dev`.
- Updated generated package metadata and dependency pins for the SDK release.

## 0.0.1

- Initial release of the Kreuzberg Cloud Dart SDK.
- Generated from the Kreuzberg Cloud OpenAPI 3.1 spec via `swagger_parser`,
  targeting Retrofit + Dio with Freezed 3 sealed data classes.
- Hand-written facade `KreuzbergCloudClient` adds bearer auth, retry-with-backoff
  (429/502/503/504, honors `Retry-After`), typed exception hierarchy,
  multipart helpers for `/v1/extract`, and `waitForJob`/`waitForJobs` polling.
- Covers all 7 public endpoints: `healthz`, `readyz`, `/v1/extract`,
  `/v1/jobs/{id}`, `/v1/uploads/presign`, `/v1/uploads/confirm`, `/v1/usage`.
