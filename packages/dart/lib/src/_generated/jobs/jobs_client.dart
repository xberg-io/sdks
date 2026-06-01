// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/job_lookup_response.dart';

part 'jobs_client.g.dart';

@RestApi()
abstract class JobsClient {
  factory JobsClient(Dio dio, {String? baseUrl}) = _JobsClient;

  /// Get job status and results.
  ///
  /// Accepts both extraction job IDs (returned in `job_ids`) and crawl job IDs.
  /// (returned in `crawl_job_ids`) from `POST /v1/extract`. When the ID belongs.
  /// to a crawl job, the response body follows the `CrawlJobResponse` schema.
  /// instead of `JobResponse`.
  ///
  /// [id] - Job ID or crawl job ID (UUID).
  @GET('/v1/jobs/{id}')
  Future<JobLookupResponse> getJob({
    @Path('id') required String id,
  });
}
