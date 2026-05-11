// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'health/health_client.dart';
import 'extract/extract_client.dart';
import 'jobs/jobs_client.dart';
import 'uploads/uploads_client.dart';
import 'usage/usage_client.dart';

/// Kreuzberg Cloud API `v1.0.0`.
///
/// Cloud document extraction API powered by Kreuzberg. Supports asynchronous extraction with webhook delivery.
class KreuzbergCloudApi {
  KreuzbergCloudApi(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.0.0';

  HealthClient? _health;
  ExtractClient? _extract;
  JobsClient? _jobs;
  UploadsClient? _uploads;
  UsageClient? _usage;

  HealthClient get health => _health ??= HealthClient(_dio, baseUrl: _baseUrl);

  ExtractClient get extract => _extract ??= ExtractClient(_dio, baseUrl: _baseUrl);

  JobsClient get jobs => _jobs ??= JobsClient(_dio, baseUrl: _baseUrl);

  UploadsClient get uploads => _uploads ??= UploadsClient(_dio, baseUrl: _baseUrl);

  UsageClient get usage => _usage ??= UsageClient(_dio, baseUrl: _baseUrl);
}
