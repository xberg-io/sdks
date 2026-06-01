// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_versions_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListVersionsQuery _$ListVersionsQueryFromJson(Map<String, dynamic> json) =>
    _ListVersionsQuery(
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ListVersionsQueryToJson(_ListVersionsQuery instance) =>
    <String, dynamic>{'limit': instance.limit, 'offset': instance.offset};
