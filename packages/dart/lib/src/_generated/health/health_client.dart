// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/health_response.dart';
import '../models/readiness_response.dart';

part 'health_client.g.dart';

@RestApi()
abstract class HealthClient {
  factory HealthClient(Dio dio, {String? baseUrl}) = _HealthClient;

  /// Check service liveness
  @GET('/healthz')
  Future<HealthResponse> healthz();

  /// Check service readiness
  @GET('/readyz')
  Future<ReadinessResponse> readyz();
}
