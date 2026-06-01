// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heading_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeadingLevel _$HeadingLevelFromJson(Map<String, dynamic> json) =>
    _HeadingLevel(
      level: (json['level'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$HeadingLevelToJson(_HeadingLevel instance) =>
    <String, dynamic>{'level': instance.level, 'text': instance.text};
