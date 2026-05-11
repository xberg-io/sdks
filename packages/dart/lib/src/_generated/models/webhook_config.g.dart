// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebhookConfig _$WebhookConfigFromJson(Map<String, dynamic> json) =>
    _WebhookConfig(
      url: json['url'] as String,
      metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      secret: json['secret'] as String?,
    );

Map<String, dynamic> _$WebhookConfigToJson(_WebhookConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'metadata': instance.metadata,
      'secret': instance.secret,
    };
