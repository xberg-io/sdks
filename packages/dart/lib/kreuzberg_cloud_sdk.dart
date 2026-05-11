/// Official Dart client SDK for the Kreuzberg Cloud document extraction API.
///
/// Construct a [KreuzbergCloudClient] with your API key, then call the
/// endpoint methods. Generated request/response models live under the
/// `_generated` subtree and are re-exported here for convenience.
///
/// ```dart
/// import 'package:kreuzberg_cloud_sdk/kreuzberg_cloud_sdk.dart';
///
/// final client = KreuzbergCloudClient(apiKey: 'kc_...');
/// final health = await client.healthz();
/// print(health.status); // ok
/// ```
library;

export 'src/client.dart' show KreuzbergCloudClient;
export 'src/exceptions.dart'
    show
        ApiException,
        AuthException,
        JobWaitTimeoutException,
        NotFoundException,
        RateLimitException,
        ServerException,
        ValidationException;
export 'src/jobs_wait.dart' show BackoffKind, JobStatusTerminal;
export 'src/retry.dart' show RetryPolicy;
export 'src/version.dart' show packageVersion;

// Generated request/response models and sub-client interfaces.
export 'src/_generated/export.dart';
