// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'webhook_config.freezed.dart';
part 'webhook_config.g.dart';

/// Webhook configuration for async delivery
@Freezed()
abstract class WebhookConfig with _$WebhookConfig {
  const factory WebhookConfig({
    /// URL to deliver results to
    required String url,

    /// Optional key-value metadata to include in the webhook payload
    Map<String, String>? metadata,

    /// Optional HMAC secret for signing the webhook payload
    String? secret,
  }) = _WebhookConfig;

  factory WebhookConfig.fromJson(Map<String, Object?> json) =>
      _$WebhookConfigFromJson(json);
}
