// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentNode _$DocumentNodeFromJson(Map<String, dynamic> json) =>
    _DocumentNode(
      content: NodeContent.fromJson(json['content'] as Map<String, dynamic>),
      id: json['id'] as String,
      annotations: (json['annotations'] as List<dynamic>?)
          ?.map((e) => TextAnnotation.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      bbox: json['bbox'] == null
          ? null
          : BoundingBox.fromJson(json['bbox'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      contentLayer: json['content_layer'] == null
          ? null
          : ContentLayer.fromJson(json['content_layer'] as String),
      page: (json['page'] as num?)?.toInt(),
      pageEnd: (json['page_end'] as num?)?.toInt(),
      parent: (json['parent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DocumentNodeToJson(_DocumentNode instance) =>
    <String, dynamic>{
      'content': instance.content,
      'id': instance.id,
      'annotations': instance.annotations,
      'attributes': instance.attributes,
      'bbox': instance.bbox,
      'children': instance.children,
      'content_layer': instance.contentLayer,
      'page': instance.page,
      'page_end': instance.pageEnd,
      'parent': instance.parent,
    };
