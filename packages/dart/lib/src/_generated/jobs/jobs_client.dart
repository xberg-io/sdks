// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/job_response.dart';

part 'jobs_client.g.dart';

@RestApi()
abstract class JobsClient {
  factory JobsClient(Dio dio, {String? baseUrl}) = _JobsClient;

  /// Get job status and results.
  ///
  /// [id] - Job ID (UUID).
  @GET('/v1/jobs/{id}')
  Future<JobResponse> getJob({
    @Path('id') required String id,
  });
}
