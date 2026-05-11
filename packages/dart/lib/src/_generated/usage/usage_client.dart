// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/usage_response.dart';

part 'usage_client.g.dart';

@RestApi()
abstract class UsageClient {
  factory UsageClient(Dio dio, {String? baseUrl}) = _UsageClient;

  /// Get usage statistics and quota.
  ///
  /// [start] - Start date (ISO 8601, e.g. "2026-03-01"). Defaults to first day of current month.
  ///
  /// [end] - End date (ISO 8601, e.g. "2026-04-01"). Defaults to first day of next month.
  @GET('/v1/usage')
  Future<UsageResponse> getUsage({
    @Query('start') String? start,
    @Query('end') String? end,
  });
}
