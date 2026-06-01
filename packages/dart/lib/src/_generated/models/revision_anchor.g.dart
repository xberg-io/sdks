// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_anchor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevisionAnchorParagraph _$RevisionAnchorParagraphFromJson(
  Map<String, dynamic> json,
) => RevisionAnchorParagraph(
  index: (json['index'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$RevisionAnchorParagraphToJson(
  RevisionAnchorParagraph instance,
) => <String, dynamic>{'index': instance.index, 'type': instance.$type};

RevisionAnchorTableCell _$RevisionAnchorTableCellFromJson(
  Map<String, dynamic> json,
) => RevisionAnchorTableCell(
  row: (json['row'] as num).toInt(),
  col: (json['col'] as num).toInt(),
  tableIndex: (json['table_index'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$RevisionAnchorTableCellToJson(
  RevisionAnchorTableCell instance,
) => <String, dynamic>{
  'row': instance.row,
  'col': instance.col,
  'table_index': instance.tableIndex,
  'type': instance.$type,
};

RevisionAnchorPage _$RevisionAnchorPageFromJson(Map<String, dynamic> json) =>
    RevisionAnchorPage(
      index: (json['index'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RevisionAnchorPageToJson(RevisionAnchorPage instance) =>
    <String, dynamic>{'index': instance.index, 'type': instance.$type};

RevisionAnchorSlide _$RevisionAnchorSlideFromJson(Map<String, dynamic> json) =>
    RevisionAnchorSlide(
      index: (json['index'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RevisionAnchorSlideToJson(
  RevisionAnchorSlide instance,
) => <String, dynamic>{'index': instance.index, 'type': instance.$type};

RevisionAnchorSheet _$RevisionAnchorSheetFromJson(Map<String, dynamic> json) =>
    RevisionAnchorSheet(
      index: (json['index'] as num).toInt(),
      name: json['name'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RevisionAnchorSheetToJson(
  RevisionAnchorSheet instance,
) => <String, dynamic>{
  'index': instance.index,
  'name': instance.name,
  'type': instance.$type,
};
