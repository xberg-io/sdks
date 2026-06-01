// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heading_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeadingContext _$HeadingContextFromJson(Map<String, dynamic> json) =>
    _HeadingContext(
      headings: (json['headings'] as List<dynamic>)
          .map((e) => HeadingLevel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HeadingContextToJson(_HeadingContext instance) =>
    <String, dynamic>{'headings': instance.headings};
