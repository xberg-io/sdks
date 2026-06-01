// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footnote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Footnote _$FootnoteFromJson(Map<String, dynamic> json) => _Footnote(
  content: (json['content'] as List<dynamic>)
      .map((e) => FormattedBlock.fromJson(e as Map<String, dynamic>))
      .toList(),
  label: json['label'] as String,
);

Map<String, dynamic> _$FootnoteToJson(_Footnote instance) => <String, dynamic>{
  'content': instance.content,
  'label': instance.label,
};
