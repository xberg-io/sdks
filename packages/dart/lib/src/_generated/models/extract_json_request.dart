// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'document_input.dart';
import 'extraction_options.dart';
import 'webhook_config.dart';

part 'extract_json_request.freezed.dart';
part 'extract_json_request.g.dart';

/// JSON body for `POST /v1/extract`
@Freezed()
abstract class ExtractJsonRequest with _$ExtractJsonRequest {
  const factory ExtractJsonRequest({
    /// Documents to process
    required List<DocumentInput> documents,

    /// Extraction options (optional)
    ExtractionOptions? options,

    /// Webhook configuration for async result delivery (optional)
    WebhookConfig? webhook,
  }) = _ExtractJsonRequest;
  
  factory ExtractJsonRequest.fromJson(Map<String, Object?> json) => _$ExtractJsonRequestFromJson(json);
}
