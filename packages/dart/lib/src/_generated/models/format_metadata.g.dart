// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'format_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormatMetadataArchive _$FormatMetadataArchiveFromJson(
  Map<String, dynamic> json,
) => FormatMetadataArchive(
  fileCount: (json['file_count'] as num).toInt(),
  fileList: (json['file_list'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  format: json['format'] as String,
  totalSize: (json['total_size'] as num).toInt(),
  compressedSize: (json['compressed_size'] as num?)?.toInt(),
  $type: json['format_type'] as String?,
);

Map<String, dynamic> _$FormatMetadataArchiveToJson(
  FormatMetadataArchive instance,
) => <String, dynamic>{
  'file_count': instance.fileCount,
  'file_list': instance.fileList,
  'format': instance.format,
  'total_size': instance.totalSize,
  'compressed_size': instance.compressedSize,
  'format_type': instance.$type,
};

FormatMetadataCsv _$FormatMetadataCsvFromJson(Map<String, dynamic> json) =>
    FormatMetadataCsv(
      columnCount: (json['column_count'] as num).toInt(),
      hasHeader: json['has_header'] as bool,
      rowCount: (json['row_count'] as num).toInt(),
      columnTypes: (json['column_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      delimiter: json['delimiter'] as String?,
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataCsvToJson(FormatMetadataCsv instance) =>
    <String, dynamic>{
      'column_count': instance.columnCount,
      'has_header': instance.hasHeader,
      'row_count': instance.rowCount,
      'column_types': instance.columnTypes,
      'delimiter': instance.delimiter,
      'format_type': instance.$type,
    };

FormatMetadataEmail _$FormatMetadataEmailFromJson(Map<String, dynamic> json) =>
    FormatMetadataEmail(
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      bccEmails: (json['bcc_emails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ccEmails: (json['cc_emails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      toEmails: (json['to_emails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fromEmail: json['from_email'] as String?,
      fromName: json['from_name'] as String?,
      messageId: json['message_id'] as String?,
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataEmailToJson(
  FormatMetadataEmail instance,
) => <String, dynamic>{
  'attachments': instance.attachments,
  'bcc_emails': instance.bccEmails,
  'cc_emails': instance.ccEmails,
  'to_emails': instance.toEmails,
  'from_email': instance.fromEmail,
  'from_name': instance.fromName,
  'message_id': instance.messageId,
  'format_type': instance.$type,
};

FormatMetadataExcel _$FormatMetadataExcelFromJson(Map<String, dynamic> json) =>
    FormatMetadataExcel(
      sheetCount: (json['sheet_count'] as num?)?.toInt(),
      sheetNames: (json['sheet_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataExcelToJson(
  FormatMetadataExcel instance,
) => <String, dynamic>{
  'sheet_count': instance.sheetCount,
  'sheet_names': instance.sheetNames,
  'format_type': instance.$type,
};

FormatMetadataHtml _$FormatMetadataHtmlFromJson(Map<String, dynamic> json) =>
    FormatMetadataHtml(
      author: json['author'] as String?,
      baseHref: json['base_href'] as String?,
      canonicalUrl: json['canonical_url'] as String?,
      description: json['description'] as String?,
      headers: (json['headers'] as List<dynamic>?)
          ?.map((e) => HeaderMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageMetadataType.fromJson(e as Map<String, dynamic>))
          .toList(),
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      language: json['language'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => LinkMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaTags: (json['meta_tags'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      openGraph: (json['open_graph'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      structuredData: (json['structured_data'] as List<dynamic>?)
          ?.map((e) => StructuredData.fromJson(e as Map<String, dynamic>))
          .toList(),
      textDirection: json['text_direction'] == null
          ? null
          : TextDirection.fromJson(json['text_direction'] as String),
      title: json['title'] as String?,
      twitterCard: (json['twitter_card'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataHtmlToJson(FormatMetadataHtml instance) =>
    <String, dynamic>{
      'author': instance.author,
      'base_href': instance.baseHref,
      'canonical_url': instance.canonicalUrl,
      'description': instance.description,
      'headers': instance.headers,
      'images': instance.images,
      'keywords': instance.keywords,
      'language': instance.language,
      'links': instance.links,
      'meta_tags': instance.metaTags,
      'open_graph': instance.openGraph,
      'structured_data': instance.structuredData,
      'text_direction': instance.textDirection,
      'title': instance.title,
      'twitter_card': instance.twitterCard,
      'format_type': instance.$type,
    };

FormatMetadataImage _$FormatMetadataImageFromJson(Map<String, dynamic> json) =>
    FormatMetadataImage(
      exif: Map<String, String>.from(json['exif'] as Map),
      format: json['format'] as String,
      height: (json['height'] as num).toInt(),
      width: (json['width'] as num).toInt(),
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataImageToJson(
  FormatMetadataImage instance,
) => <String, dynamic>{
  'exif': instance.exif,
  'format': instance.format,
  'height': instance.height,
  'width': instance.width,
  'format_type': instance.$type,
};

FormatMetadataOcr _$FormatMetadataOcrFromJson(Map<String, dynamic> json) =>
    FormatMetadataOcr(
      language: json['language'] as String,
      outputFormat: json['output_format'] as String,
      psm: (json['psm'] as num).toInt(),
      tableCount: (json['table_count'] as num).toInt(),
      tableCols: (json['table_cols'] as num?)?.toInt(),
      tableRows: (json['table_rows'] as num?)?.toInt(),
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataOcrToJson(FormatMetadataOcr instance) =>
    <String, dynamic>{
      'language': instance.language,
      'output_format': instance.outputFormat,
      'psm': instance.psm,
      'table_count': instance.tableCount,
      'table_cols': instance.tableCols,
      'table_rows': instance.tableRows,
      'format_type': instance.$type,
    };

FormatMetadataPptx _$FormatMetadataPptxFromJson(Map<String, dynamic> json) =>
    FormatMetadataPptx(
      slideCount: (json['slide_count'] as num).toInt(),
      slideNames: (json['slide_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageCount: (json['image_count'] as num?)?.toInt(),
      tableCount: (json['table_count'] as num?)?.toInt(),
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataPptxToJson(FormatMetadataPptx instance) =>
    <String, dynamic>{
      'slide_count': instance.slideCount,
      'slide_names': instance.slideNames,
      'image_count': instance.imageCount,
      'table_count': instance.tableCount,
      'format_type': instance.$type,
    };

FormatMetadataPst _$FormatMetadataPstFromJson(Map<String, dynamic> json) =>
    FormatMetadataPst(
      messageCount: (json['message_count'] as num).toInt(),
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataPstToJson(FormatMetadataPst instance) =>
    <String, dynamic>{
      'message_count': instance.messageCount,
      'format_type': instance.$type,
    };

FormatMetadataText _$FormatMetadataTextFromJson(Map<String, dynamic> json) =>
    FormatMetadataText(
      characterCount: (json['character_count'] as num).toInt(),
      lineCount: (json['line_count'] as num).toInt(),
      wordCount: (json['word_count'] as num).toInt(),
      codeBlocks: (json['code_blocks'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      headers: (json['headers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataTextToJson(FormatMetadataText instance) =>
    <String, dynamic>{
      'character_count': instance.characterCount,
      'line_count': instance.lineCount,
      'word_count': instance.wordCount,
      'code_blocks': instance.codeBlocks,
      'headers': instance.headers,
      'links': instance.links,
      'format_type': instance.$type,
    };

FormatMetadataXml _$FormatMetadataXmlFromJson(Map<String, dynamic> json) =>
    FormatMetadataXml(
      elementCount: (json['element_count'] as num).toInt(),
      uniqueElements: (json['unique_elements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      $type: json['format_type'] as String?,
    );

Map<String, dynamic> _$FormatMetadataXmlToJson(FormatMetadataXml instance) =>
    <String, dynamic>{
      'element_count': instance.elementCount,
      'unique_elements': instance.uniqueElements,
      'format_type': instance.$type,
    };
