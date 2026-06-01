// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extracted_uri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtractedUri _$ExtractedUriFromJson(Map<String, dynamic> json) =>
    _ExtractedUri(
      kind: UriKind.fromJson(json['kind'] as String),
      url: json['url'] as String,
      label: json['label'] as String?,
      page: (json['page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExtractedUriToJson(_ExtractedUri instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'url': instance.url,
      'label': instance.label,
      'page': instance.page,
    };
