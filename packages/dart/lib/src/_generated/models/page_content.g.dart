// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageContent _$PageContentFromJson(Map<String, dynamic> json) => _PageContent(
      pageNumber: (json['page_number'] as num).toInt(),
      content: json['content'] as String?,
      isBlank: json['is_blank'] as bool?,
    );

Map<String, dynamic> _$PageContentToJson(_PageContent instance) =>
    <String, dynamic>{
      'page_number': instance.pageNumber,
      'content': instance.content,
      'is_blank': instance.isBlank,
    };
