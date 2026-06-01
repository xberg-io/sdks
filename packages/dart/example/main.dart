// Minimal end-to-end example of the Kreuzberg Cloud Dart SDK.
//
// Run with:
//
//   KREUZBERG_API_KEY=kc_... dart run example/main.dart
//
// Submits a small inline document, polls the resulting job to completion, and
// prints the extracted Markdown.

import 'dart:convert';
import 'dart:io';

import 'package:kreuzberg_cloud_sdk/kreuzberg_cloud_sdk.dart';

Future<void> main() async {
  final apiKey = Platform.environment['KREUZBERG_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    stderr.writeln('Set KREUZBERG_API_KEY in the environment.');
    exit(2);
  }

  final client = KreuzbergCloudClient(
    apiKey: apiKey,
    retryPolicy: const RetryPolicy(maxRetries: 3),
  );

  try {
    final accepted = await client.extract(
      ExtractJsonRequest(
        documents: [
          DocumentInput(
            filename: 'hello.txt',
            mimeType: 'text/plain',
            data: base64Encode(utf8.encode('Hello, Kreuzberg Cloud!')),
          ),
        ],
        options: const ExtractionOptions(
          extractionConfig: ExtractionConfig(outputFormat: 'markdown'),
        ),
      ),
    );

    final jobId = accepted.jobIds!.first;
    stderr.writeln('submitted job $jobId');

    final finished = await client.waitForJob(
      jobId,
      timeout: const Duration(minutes: 2),
    );

    if (finished.status == JobStatus.completed ||
        finished.status == JobStatus.partialSuccess) {
      stdout.writeln(finished.result?.content ?? '<no content>');
    } else {
      stderr.writeln('job ended with status ${finished.status}');
      exit(1);
    }
  } finally {
    client.close();
  }
}
