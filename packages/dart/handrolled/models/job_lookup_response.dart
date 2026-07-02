// coverage:ignore-file
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'crawl_job_response.dart';
import 'job_response.dart';

part 'job_lookup_response.freezed.dart';

/// Response for either an extraction job or a crawl job.
///
/// The upstream `oneOf` schema has no discriminator; the two variants are
/// distinguished by the presence of unique fields:
///
/// * [JobResponse] always has `filename`.
/// * [CrawlJobResponse] always has `output_mode`, `seed_urls`, and `progress`.
///
/// Hand-written: `swagger_parser` cannot synthesize the runtime probe for a
/// discriminator-less `oneOf`.
@freezed
sealed class JobLookupResponse with _$JobLookupResponse {
  const JobLookupResponse._();

  /// Extraction job details.
  const factory JobLookupResponse.extraction(JobResponse value) =
  JobLookupResponseExtraction;

  /// Crawl job details.
  const factory JobLookupResponse.crawl(CrawlJobResponse value) =
  JobLookupResponseCrawl;

  /// Probes the JSON body to determine which variant to construct.
  ///
  /// `filename` is unique to [JobResponse]; `output_mode` is unique to
  /// [CrawlJobResponse]. The order checks the cheaper field first.
  factory JobLookupResponse.fromJson(Map<String, Object?> json) {
    if (json.containsKey('output_mode') || json.containsKey('seed_urls')) {
      return JobLookupResponse.crawl(CrawlJobResponse.fromJson(json));
    }
    return JobLookupResponse.extraction(JobResponse.fromJson(json));
  }

  /// Serializes the wrapped variant directly (the discriminator is implicit).
  Map<String, dynamic> toJson() {
    return switch (this) {
      JobLookupResponseExtraction(:final value) => value.toJson(),
      JobLookupResponseCrawl(:final value) => value.toJson(),
    };
  }
}
