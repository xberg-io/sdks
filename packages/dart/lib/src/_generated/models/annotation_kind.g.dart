// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation_kind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnotationKindBold _$AnnotationKindBoldFromJson(Map<String, dynamic> json) =>
    AnnotationKindBold($type: json['annotation_type'] as String?);

Map<String, dynamic> _$AnnotationKindBoldToJson(AnnotationKindBold instance) =>
    <String, dynamic>{'annotation_type': instance.$type};

AnnotationKindItalic _$AnnotationKindItalicFromJson(
  Map<String, dynamic> json,
) => AnnotationKindItalic($type: json['annotation_type'] as String?);

Map<String, dynamic> _$AnnotationKindItalicToJson(
  AnnotationKindItalic instance,
) => <String, dynamic>{'annotation_type': instance.$type};

AnnotationKindUnderline _$AnnotationKindUnderlineFromJson(
  Map<String, dynamic> json,
) => AnnotationKindUnderline($type: json['annotation_type'] as String?);

Map<String, dynamic> _$AnnotationKindUnderlineToJson(
  AnnotationKindUnderline instance,
) => <String, dynamic>{'annotation_type': instance.$type};

AnnotationKindStrikethrough _$AnnotationKindStrikethroughFromJson(
  Map<String, dynamic> json,
) => AnnotationKindStrikethrough($type: json['annotation_type'] as String?);

Map<String, dynamic> _$AnnotationKindStrikethroughToJson(
  AnnotationKindStrikethrough instance,
) => <String, dynamic>{'annotation_type': instance.$type};

AnnotationKindCode _$AnnotationKindCodeFromJson(Map<String, dynamic> json) =>
    AnnotationKindCode($type: json['annotation_type'] as String?);

Map<String, dynamic> _$AnnotationKindCodeToJson(AnnotationKindCode instance) =>
    <String, dynamic>{'annotation_type': instance.$type};

AnnotationKindSubscript _$AnnotationKindSubscriptFromJson(
  Map<String, dynamic> json,
) => AnnotationKindSubscript($type: json['annotation_type'] as String?);

Map<String, dynamic> _$AnnotationKindSubscriptToJson(
  AnnotationKindSubscript instance,
) => <String, dynamic>{'annotation_type': instance.$type};

AnnotationKindSuperscript _$AnnotationKindSuperscriptFromJson(
  Map<String, dynamic> json,
) => AnnotationKindSuperscript($type: json['annotation_type'] as String?);

Map<String, dynamic> _$AnnotationKindSuperscriptToJson(
  AnnotationKindSuperscript instance,
) => <String, dynamic>{'annotation_type': instance.$type};

AnnotationKindLink _$AnnotationKindLinkFromJson(Map<String, dynamic> json) =>
    AnnotationKindLink(
      url: json['url'] as String,
      title: json['title'] as String?,
      $type: json['annotation_type'] as String?,
    );

Map<String, dynamic> _$AnnotationKindLinkToJson(AnnotationKindLink instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'annotation_type': instance.$type,
    };

AnnotationKindHighlight _$AnnotationKindHighlightFromJson(
  Map<String, dynamic> json,
) => AnnotationKindHighlight($type: json['annotation_type'] as String?);

Map<String, dynamic> _$AnnotationKindHighlightToJson(
  AnnotationKindHighlight instance,
) => <String, dynamic>{'annotation_type': instance.$type};

AnnotationKindColor _$AnnotationKindColorFromJson(Map<String, dynamic> json) =>
    AnnotationKindColor(
      value: json['value'] as String,
      $type: json['annotation_type'] as String?,
    );

Map<String, dynamic> _$AnnotationKindColorToJson(
  AnnotationKindColor instance,
) => <String, dynamic>{
  'value': instance.value,
  'annotation_type': instance.$type,
};

AnnotationKindFontSize _$AnnotationKindFontSizeFromJson(
  Map<String, dynamic> json,
) => AnnotationKindFontSize(
  value: json['value'] as String,
  $type: json['annotation_type'] as String?,
);

Map<String, dynamic> _$AnnotationKindFontSizeToJson(
  AnnotationKindFontSize instance,
) => <String, dynamic>{
  'value': instance.value,
  'annotation_type': instance.$type,
};

AnnotationKindCustom _$AnnotationKindCustomFromJson(
  Map<String, dynamic> json,
) => AnnotationKindCustom(
  name: json['name'] as String,
  value: json['value'] as String?,
  $type: json['annotation_type'] as String?,
);

Map<String, dynamic> _$AnnotationKindCustomToJson(
  AnnotationKindCustom instance,
) => <String, dynamic>{
  'name': instance.name,
  'value': instance.value,
  'annotation_type': instance.$type,
};
