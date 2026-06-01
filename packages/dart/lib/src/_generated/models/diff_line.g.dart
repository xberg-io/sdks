// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diff_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiffLineContext _$DiffLineContextFromJson(Map<String, dynamic> json) =>
    DiffLineContext(
      text: json['text'] as String,
      $type: json['kind'] as String?,
    );

Map<String, dynamic> _$DiffLineContextToJson(DiffLineContext instance) =>
    <String, dynamic>{'text': instance.text, 'kind': instance.$type};

DiffLineAdded _$DiffLineAddedFromJson(Map<String, dynamic> json) =>
    DiffLineAdded(text: json['text'] as String, $type: json['kind'] as String?);

Map<String, dynamic> _$DiffLineAddedToJson(DiffLineAdded instance) =>
    <String, dynamic>{'text': instance.text, 'kind': instance.$type};

DiffLineRemoved _$DiffLineRemovedFromJson(Map<String, dynamic> json) =>
    DiffLineRemoved(
      text: json['text'] as String,
      $type: json['kind'] as String?,
    );

Map<String, dynamic> _$DiffLineRemovedToJson(DiffLineRemoved instance) =>
    <String, dynamic>{'text': instance.text, 'kind': instance.$type};
