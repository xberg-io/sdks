// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'bypass_mode.dart';

part 'bypass_request_override.freezed.dart';
part 'bypass_request_override.g.dart';

/// Per-request bypass override. When set on a crawl request, applies an.
/// external bypass provider (e.g., Bright Data, Zyte, ScrapingBee) to bypass.
/// WAF/antibot on the crawl.
@Freezed()
abstract class BypassRequestOverride with _$BypassRequestOverride {
  const factory BypassRequestOverride({
    /// Whether cloud provides vendor credentials (managed) or caller does (byo).
    required BypassMode mode,

    /// Vendor identifier — must be registered in bypass-providers/registry.
    /// Today: "bright_data" | "zyte" | "scrapingbee".
    required String vendor,

    /// Per-vendor credentials JSON. Required when mode = byo; ignored for.
    /// managed (cloud uses its own credentials from Secret Manager).
    dynamic credentials,
  }) = _BypassRequestOverride;

  factory BypassRequestOverride.fromJson(Map<String, Object?> json) =>
      _$BypassRequestOverrideFromJson(json);
}
