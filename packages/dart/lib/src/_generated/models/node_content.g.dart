// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeContentTitle _$NodeContentTitleFromJson(Map<String, dynamic> json) =>
    NodeContentTitle(
      text: json['text'] as String,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentTitleToJson(NodeContentTitle instance) =>
    <String, dynamic>{'text': instance.text, 'node_type': instance.$type};

NodeContentHeading _$NodeContentHeadingFromJson(Map<String, dynamic> json) =>
    NodeContentHeading(
      level: (json['level'] as num).toInt(),
      text: json['text'] as String,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentHeadingToJson(NodeContentHeading instance) =>
    <String, dynamic>{
      'level': instance.level,
      'text': instance.text,
      'node_type': instance.$type,
    };

NodeContentParagraph _$NodeContentParagraphFromJson(
  Map<String, dynamic> json,
) => NodeContentParagraph(
  text: json['text'] as String,
  $type: json['node_type'] as String?,
);

Map<String, dynamic> _$NodeContentParagraphToJson(
  NodeContentParagraph instance,
) => <String, dynamic>{'text': instance.text, 'node_type': instance.$type};

NodeContentList _$NodeContentListFromJson(Map<String, dynamic> json) =>
    NodeContentList(
      ordered: json['ordered'] as bool,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentListToJson(NodeContentList instance) =>
    <String, dynamic>{'ordered': instance.ordered, 'node_type': instance.$type};

NodeContentListItem _$NodeContentListItemFromJson(Map<String, dynamic> json) =>
    NodeContentListItem(
      text: json['text'] as String,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentListItemToJson(
  NodeContentListItem instance,
) => <String, dynamic>{'text': instance.text, 'node_type': instance.$type};

NodeContentTable _$NodeContentTableFromJson(Map<String, dynamic> json) =>
    NodeContentTable(
      grid: TableGrid.fromJson(json['grid'] as Map<String, dynamic>),
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentTableToJson(NodeContentTable instance) =>
    <String, dynamic>{'grid': instance.grid, 'node_type': instance.$type};

NodeContentImage _$NodeContentImageFromJson(Map<String, dynamic> json) =>
    NodeContentImage(
      description: json['description'] as String?,
      imageIndex: (json['image_index'] as num?)?.toInt(),
      src: json['src'] as String?,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentImageToJson(NodeContentImage instance) =>
    <String, dynamic>{
      'description': instance.description,
      'image_index': instance.imageIndex,
      'src': instance.src,
      'node_type': instance.$type,
    };

NodeContentCode _$NodeContentCodeFromJson(Map<String, dynamic> json) =>
    NodeContentCode(
      text: json['text'] as String,
      language: json['language'] as String?,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentCodeToJson(NodeContentCode instance) =>
    <String, dynamic>{
      'text': instance.text,
      'language': instance.language,
      'node_type': instance.$type,
    };

NodeContentQuote _$NodeContentQuoteFromJson(Map<String, dynamic> json) =>
    NodeContentQuote($type: json['node_type'] as String?);

Map<String, dynamic> _$NodeContentQuoteToJson(NodeContentQuote instance) =>
    <String, dynamic>{'node_type': instance.$type};

NodeContentFormula _$NodeContentFormulaFromJson(Map<String, dynamic> json) =>
    NodeContentFormula(
      text: json['text'] as String,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentFormulaToJson(NodeContentFormula instance) =>
    <String, dynamic>{'text': instance.text, 'node_type': instance.$type};

NodeContentFootnote _$NodeContentFootnoteFromJson(Map<String, dynamic> json) =>
    NodeContentFootnote(
      text: json['text'] as String,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentFootnoteToJson(
  NodeContentFootnote instance,
) => <String, dynamic>{'text': instance.text, 'node_type': instance.$type};

NodeContentGroup _$NodeContentGroupFromJson(Map<String, dynamic> json) =>
    NodeContentGroup(
      headingLevel: (json['heading_level'] as num?)?.toInt(),
      headingText: json['heading_text'] as String?,
      label: json['label'] as String?,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentGroupToJson(NodeContentGroup instance) =>
    <String, dynamic>{
      'heading_level': instance.headingLevel,
      'heading_text': instance.headingText,
      'label': instance.label,
      'node_type': instance.$type,
    };

NodeContentPageBreak _$NodeContentPageBreakFromJson(
  Map<String, dynamic> json,
) => NodeContentPageBreak($type: json['node_type'] as String?);

Map<String, dynamic> _$NodeContentPageBreakToJson(
  NodeContentPageBreak instance,
) => <String, dynamic>{'node_type': instance.$type};

NodeContentSlide _$NodeContentSlideFromJson(Map<String, dynamic> json) =>
    NodeContentSlide(
      number: (json['number'] as num).toInt(),
      title: json['title'] as String?,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentSlideToJson(NodeContentSlide instance) =>
    <String, dynamic>{
      'number': instance.number,
      'title': instance.title,
      'node_type': instance.$type,
    };

NodeContentDefinitionList _$NodeContentDefinitionListFromJson(
  Map<String, dynamic> json,
) => NodeContentDefinitionList($type: json['node_type'] as String?);

Map<String, dynamic> _$NodeContentDefinitionListToJson(
  NodeContentDefinitionList instance,
) => <String, dynamic>{'node_type': instance.$type};

NodeContentDefinitionItem _$NodeContentDefinitionItemFromJson(
  Map<String, dynamic> json,
) => NodeContentDefinitionItem(
  term: json['term'] as String,
  definition: json['definition'] as String,
  $type: json['node_type'] as String?,
);

Map<String, dynamic> _$NodeContentDefinitionItemToJson(
  NodeContentDefinitionItem instance,
) => <String, dynamic>{
  'term': instance.term,
  'definition': instance.definition,
  'node_type': instance.$type,
};

NodeContentCitation _$NodeContentCitationFromJson(Map<String, dynamic> json) =>
    NodeContentCitation(
      key: json['key'] as String,
      text: json['text'] as String,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentCitationToJson(
  NodeContentCitation instance,
) => <String, dynamic>{
  'key': instance.key,
  'text': instance.text,
  'node_type': instance.$type,
};

NodeContentAdmonition _$NodeContentAdmonitionFromJson(
  Map<String, dynamic> json,
) => NodeContentAdmonition(
  kind: json['kind'] as String,
  title: json['title'] as String?,
  $type: json['node_type'] as String?,
);

Map<String, dynamic> _$NodeContentAdmonitionToJson(
  NodeContentAdmonition instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'title': instance.title,
  'node_type': instance.$type,
};

NodeContentRawBlock _$NodeContentRawBlockFromJson(Map<String, dynamic> json) =>
    NodeContentRawBlock(
      format: json['format'] as String,
      content: json['content'] as String,
      $type: json['node_type'] as String?,
    );

Map<String, dynamic> _$NodeContentRawBlockToJson(
  NodeContentRawBlock instance,
) => <String, dynamic>{
  'format': instance.format,
  'content': instance.content,
  'node_type': instance.$type,
};

NodeContentMetadataBlock _$NodeContentMetadataBlockFromJson(
  Map<String, dynamic> json,
) => NodeContentMetadataBlock(
  entries: (json['entries'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
      .toList(),
  $type: json['node_type'] as String?,
);

Map<String, dynamic> _$NodeContentMetadataBlockToJson(
  NodeContentMetadataBlock instance,
) => <String, dynamic>{
  'entries': instance.entries,
  'node_type': instance.$type,
};
