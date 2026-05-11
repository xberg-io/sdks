// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extract_json_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractJsonRequest _$ExtractJsonRequestFromJson(Map<String, dynamic> json) =>
    _ExtractJsonRequest(
      documents: (json['documents'] as List<dynamic>)
          .map((e) => DocumentInput.fromJson(e as Map<String, dynamic>))
          .toList(),
      options: json['options'] == null
          ? null
          : ExtractionOptions.fromJson(json['options'] as Map<String, dynamic>),
      webhook: json['webhook'] == null
          ? null
          : WebhookConfig.fromJson(json['webhook'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtractJsonRequestToJson(_ExtractJsonRequest instance) =>
    <String, dynamic>{
      'documents': instance.documents,
      'options': instance.options,
      'webhook': instance.webhook,
    };
