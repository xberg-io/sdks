import 'dart:async';
import 'dart:math' as math;

import '_generated/models/job_response.dart';
import '_generated/models/job_status.dart';
import 'exceptions.dart';

/// Polling cadence for [KreuzbergCloudClient.waitForJob].
enum BackoffKind {
  /// Doubles the wait interval after each poll, capped at 30s.
  exponential,

  /// Uses the configured `pollInterval` for every poll.
  constant,
}

/// Terminal statuses that end the job lifecycle.
const _terminalStatuses = <JobStatus>{
  JobStatus.completed,
  JobStatus.partialSuccess,
  JobStatus.failed,
  JobStatus.cancelled,
};

/// Convenience extension for [JobStatus].
extension JobStatusTerminal on JobStatus {
  /// Whether this status indicates the job lifecycle is over (success,
  /// partial-success, failure, or cancellation).
  bool get isTerminal => _terminalStatuses.contains(this);
}

/// Polls `fetch` until the returned [JobResponse] reaches a terminal status,
/// the timeout elapses, or an [ApiException] is thrown.
///
/// Mirrors the Go SDK's `WaitForJob` semantics.
Future<JobResponse> pollUntilTerminal({
  required String jobId,
  required Future<JobResponse> Function() fetch,
  required Duration timeout,
  required Duration pollInterval,
  required BackoffKind backoff,
}) async {
  const maxPollInterval = Duration(seconds: 30);
  final deadline = DateTime.now().add(timeout);
  var interval = pollInterval;

  while (true) {
    final job = await fetch();
    if (job.status.isTerminal) {
      return job;
    }

    final remaining = deadline.difference(DateTime.now());
    if (remaining.isNegative || remaining == Duration.zero) {
      throw JobWaitTimeoutException(jobId: jobId, elapsed: timeout);
    }

    final wait = interval > remaining ? remaining : interval;
    await Future<void>.delayed(wait);

    if (backoff == BackoffKind.exponential) {
      final next = interval * 2;
      interval = next > maxPollInterval ? maxPollInterval : next;
    }
  }
}

/// Concurrently polls a list of jobs. Returns one [JobResponse] per input
/// `jobId`, in the same order. If any job times out or fails, all in-flight
/// polls are cancelled and the first exception is rethrown.
Future<List<JobResponse>> pollManyUntilTerminal({
  required List<String> jobIds,
  required Future<JobResponse> Function(String jobId) fetch,
  required Duration timeout,
  required Duration pollInterval,
  required BackoffKind backoff,
}) async {
  if (jobIds.isEmpty) {
    return const [];
  }
  final futures = jobIds.map(
    (id) => pollUntilTerminal(
      jobId: id,
      fetch: () => fetch(id),
      timeout: timeout,
      pollInterval: pollInterval,
      backoff: backoff,
    ),
  );
  // `Future.wait` rethrows the first error and cancels logical interest in
  // the remaining futures; in-flight HTTP calls finish but their results are
  // discarded — matching the Go SDK's first-error-wins semantics.
  return Future.wait(futures, eagerError: true);
}

/// Caps a [Duration] at `max`, used by callers that want explicit bounds on
/// backoff arithmetic without exposing [math].
Duration capDuration(Duration value, Duration max) => value > max
    ? max
    : Duration(milliseconds: math.max(0, value.inMilliseconds));
