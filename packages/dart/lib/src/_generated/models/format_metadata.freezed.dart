// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'format_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
FormatMetadata _$FormatMetadataFromJson(
  Map<String, dynamic> json
) {
        switch (json['format_type']) {
                  case 'archive':
          return FormatMetadataArchive.fromJson(
            json
          );
                case 'csv':
          return FormatMetadataCsv.fromJson(
            json
          );
                case 'email':
          return FormatMetadataEmail.fromJson(
            json
          );
                case 'excel':
          return FormatMetadataExcel.fromJson(
            json
          );
                case 'html':
          return FormatMetadataHtml.fromJson(
            json
          );
                case 'image':
          return FormatMetadataImage.fromJson(
            json
          );
                case 'ocr':
          return FormatMetadataOcr.fromJson(
            json
          );
                case 'pptx':
          return FormatMetadataPptx.fromJson(
            json
          );
                case 'pst':
          return FormatMetadataPst.fromJson(
            json
          );
                case 'text':
          return FormatMetadataText.fromJson(
            json
          );
                case 'xml':
          return FormatMetadataXml.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'format_type',
  'FormatMetadata',
  'Invalid union type "${json['format_type']}"!'
);
        }
      
}

/// @nodoc
mixin _$FormatMetadata {



  /// Serializes this FormatMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadata);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormatMetadata()';
}


}

/// @nodoc
class $FormatMetadataCopyWith<$Res>  {
$FormatMetadataCopyWith(FormatMetadata _, $Res Function(FormatMetadata) __);
}


/// Adds pattern-matching-related methods to [FormatMetadata].
extension FormatMetadataPatterns on FormatMetadata {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FormatMetadataArchive value)?  archive,TResult Function( FormatMetadataCsv value)?  csv,TResult Function( FormatMetadataEmail value)?  email,TResult Function( FormatMetadataExcel value)?  excel,TResult Function( FormatMetadataHtml value)?  html,TResult Function( FormatMetadataImage value)?  image,TResult Function( FormatMetadataOcr value)?  ocr,TResult Function( FormatMetadataPptx value)?  pptx,TResult Function( FormatMetadataPst value)?  pst,TResult Function( FormatMetadataText value)?  text,TResult Function( FormatMetadataXml value)?  xml,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FormatMetadataArchive() when archive != null:
return archive(_that);case FormatMetadataCsv() when csv != null:
return csv(_that);case FormatMetadataEmail() when email != null:
return email(_that);case FormatMetadataExcel() when excel != null:
return excel(_that);case FormatMetadataHtml() when html != null:
return html(_that);case FormatMetadataImage() when image != null:
return image(_that);case FormatMetadataOcr() when ocr != null:
return ocr(_that);case FormatMetadataPptx() when pptx != null:
return pptx(_that);case FormatMetadataPst() when pst != null:
return pst(_that);case FormatMetadataText() when text != null:
return text(_that);case FormatMetadataXml() when xml != null:
return xml(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FormatMetadataArchive value)  archive,required TResult Function( FormatMetadataCsv value)  csv,required TResult Function( FormatMetadataEmail value)  email,required TResult Function( FormatMetadataExcel value)  excel,required TResult Function( FormatMetadataHtml value)  html,required TResult Function( FormatMetadataImage value)  image,required TResult Function( FormatMetadataOcr value)  ocr,required TResult Function( FormatMetadataPptx value)  pptx,required TResult Function( FormatMetadataPst value)  pst,required TResult Function( FormatMetadataText value)  text,required TResult Function( FormatMetadataXml value)  xml,}){
final _that = this;
switch (_that) {
case FormatMetadataArchive():
return archive(_that);case FormatMetadataCsv():
return csv(_that);case FormatMetadataEmail():
return email(_that);case FormatMetadataExcel():
return excel(_that);case FormatMetadataHtml():
return html(_that);case FormatMetadataImage():
return image(_that);case FormatMetadataOcr():
return ocr(_that);case FormatMetadataPptx():
return pptx(_that);case FormatMetadataPst():
return pst(_that);case FormatMetadataText():
return text(_that);case FormatMetadataXml():
return xml(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FormatMetadataArchive value)?  archive,TResult? Function( FormatMetadataCsv value)?  csv,TResult? Function( FormatMetadataEmail value)?  email,TResult? Function( FormatMetadataExcel value)?  excel,TResult? Function( FormatMetadataHtml value)?  html,TResult? Function( FormatMetadataImage value)?  image,TResult? Function( FormatMetadataOcr value)?  ocr,TResult? Function( FormatMetadataPptx value)?  pptx,TResult? Function( FormatMetadataPst value)?  pst,TResult? Function( FormatMetadataText value)?  text,TResult? Function( FormatMetadataXml value)?  xml,}){
final _that = this;
switch (_that) {
case FormatMetadataArchive() when archive != null:
return archive(_that);case FormatMetadataCsv() when csv != null:
return csv(_that);case FormatMetadataEmail() when email != null:
return email(_that);case FormatMetadataExcel() when excel != null:
return excel(_that);case FormatMetadataHtml() when html != null:
return html(_that);case FormatMetadataImage() when image != null:
return image(_that);case FormatMetadataOcr() when ocr != null:
return ocr(_that);case FormatMetadataPptx() when pptx != null:
return pptx(_that);case FormatMetadataPst() when pst != null:
return pst(_that);case FormatMetadataText() when text != null:
return text(_that);case FormatMetadataXml() when xml != null:
return xml(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'file_count')  int fileCount, @JsonKey(name: 'file_list')  List<String> fileList,  String format, @JsonKey(name: 'total_size')  int totalSize, @JsonKey(name: 'compressed_size')  int? compressedSize)?  archive,TResult Function(@JsonKey(name: 'column_count')  int columnCount, @JsonKey(name: 'has_header')  bool hasHeader, @JsonKey(name: 'row_count')  int rowCount, @JsonKey(name: 'column_types')  List<String>? columnTypes,  String? delimiter)?  csv,TResult Function( List<String> attachments, @JsonKey(name: 'bcc_emails')  List<String> bccEmails, @JsonKey(name: 'cc_emails')  List<String> ccEmails, @JsonKey(name: 'to_emails')  List<String> toEmails, @JsonKey(name: 'from_email')  String? fromEmail, @JsonKey(name: 'from_name')  String? fromName, @JsonKey(name: 'message_id')  String? messageId)?  email,TResult Function(@JsonKey(name: 'sheet_count')  int? sheetCount, @JsonKey(name: 'sheet_names')  List<String>? sheetNames)?  excel,TResult Function( String? author, @JsonKey(name: 'base_href')  String? baseHref, @JsonKey(name: 'canonical_url')  String? canonicalUrl,  String? description,  List<HeaderMetadata>? headers,  List<ImageMetadataType>? images,  List<String>? keywords,  String? language,  List<LinkMetadata>? links, @JsonKey(name: 'meta_tags')  Map<String, String>? metaTags, @JsonKey(name: 'open_graph')  Map<String, String>? openGraph, @JsonKey(name: 'structured_data')  List<StructuredData>? structuredData, @JsonKey(name: 'text_direction')  TextDirection? textDirection,  String? title, @JsonKey(name: 'twitter_card')  Map<String, String>? twitterCard)?  html,TResult Function( Map<String, String> exif,  String format,  int height,  int width)?  image,TResult Function( String language, @JsonKey(name: 'output_format')  String outputFormat,  int psm, @JsonKey(name: 'table_count')  int tableCount, @JsonKey(name: 'table_cols')  int? tableCols, @JsonKey(name: 'table_rows')  int? tableRows)?  ocr,TResult Function(@JsonKey(name: 'slide_count')  int slideCount, @JsonKey(name: 'slide_names')  List<String> slideNames, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'table_count')  int? tableCount)?  pptx,TResult Function(@JsonKey(name: 'message_count')  int messageCount)?  pst,TResult Function(@JsonKey(name: 'character_count')  int characterCount, @JsonKey(name: 'line_count')  int lineCount, @JsonKey(name: 'word_count')  int wordCount, @JsonKey(name: 'code_blocks')  List<List<String>>? codeBlocks,  List<String>? headers,  List<List<String>>? links)?  text,TResult Function(@JsonKey(name: 'element_count')  int elementCount, @JsonKey(name: 'unique_elements')  List<String> uniqueElements)?  xml,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FormatMetadataArchive() when archive != null:
return archive(_that.fileCount,_that.fileList,_that.format,_that.totalSize,_that.compressedSize);case FormatMetadataCsv() when csv != null:
return csv(_that.columnCount,_that.hasHeader,_that.rowCount,_that.columnTypes,_that.delimiter);case FormatMetadataEmail() when email != null:
return email(_that.attachments,_that.bccEmails,_that.ccEmails,_that.toEmails,_that.fromEmail,_that.fromName,_that.messageId);case FormatMetadataExcel() when excel != null:
return excel(_that.sheetCount,_that.sheetNames);case FormatMetadataHtml() when html != null:
return html(_that.author,_that.baseHref,_that.canonicalUrl,_that.description,_that.headers,_that.images,_that.keywords,_that.language,_that.links,_that.metaTags,_that.openGraph,_that.structuredData,_that.textDirection,_that.title,_that.twitterCard);case FormatMetadataImage() when image != null:
return image(_that.exif,_that.format,_that.height,_that.width);case FormatMetadataOcr() when ocr != null:
return ocr(_that.language,_that.outputFormat,_that.psm,_that.tableCount,_that.tableCols,_that.tableRows);case FormatMetadataPptx() when pptx != null:
return pptx(_that.slideCount,_that.slideNames,_that.imageCount,_that.tableCount);case FormatMetadataPst() when pst != null:
return pst(_that.messageCount);case FormatMetadataText() when text != null:
return text(_that.characterCount,_that.lineCount,_that.wordCount,_that.codeBlocks,_that.headers,_that.links);case FormatMetadataXml() when xml != null:
return xml(_that.elementCount,_that.uniqueElements);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'file_count')  int fileCount, @JsonKey(name: 'file_list')  List<String> fileList,  String format, @JsonKey(name: 'total_size')  int totalSize, @JsonKey(name: 'compressed_size')  int? compressedSize)  archive,required TResult Function(@JsonKey(name: 'column_count')  int columnCount, @JsonKey(name: 'has_header')  bool hasHeader, @JsonKey(name: 'row_count')  int rowCount, @JsonKey(name: 'column_types')  List<String>? columnTypes,  String? delimiter)  csv,required TResult Function( List<String> attachments, @JsonKey(name: 'bcc_emails')  List<String> bccEmails, @JsonKey(name: 'cc_emails')  List<String> ccEmails, @JsonKey(name: 'to_emails')  List<String> toEmails, @JsonKey(name: 'from_email')  String? fromEmail, @JsonKey(name: 'from_name')  String? fromName, @JsonKey(name: 'message_id')  String? messageId)  email,required TResult Function(@JsonKey(name: 'sheet_count')  int? sheetCount, @JsonKey(name: 'sheet_names')  List<String>? sheetNames)  excel,required TResult Function( String? author, @JsonKey(name: 'base_href')  String? baseHref, @JsonKey(name: 'canonical_url')  String? canonicalUrl,  String? description,  List<HeaderMetadata>? headers,  List<ImageMetadataType>? images,  List<String>? keywords,  String? language,  List<LinkMetadata>? links, @JsonKey(name: 'meta_tags')  Map<String, String>? metaTags, @JsonKey(name: 'open_graph')  Map<String, String>? openGraph, @JsonKey(name: 'structured_data')  List<StructuredData>? structuredData, @JsonKey(name: 'text_direction')  TextDirection? textDirection,  String? title, @JsonKey(name: 'twitter_card')  Map<String, String>? twitterCard)  html,required TResult Function( Map<String, String> exif,  String format,  int height,  int width)  image,required TResult Function( String language, @JsonKey(name: 'output_format')  String outputFormat,  int psm, @JsonKey(name: 'table_count')  int tableCount, @JsonKey(name: 'table_cols')  int? tableCols, @JsonKey(name: 'table_rows')  int? tableRows)  ocr,required TResult Function(@JsonKey(name: 'slide_count')  int slideCount, @JsonKey(name: 'slide_names')  List<String> slideNames, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'table_count')  int? tableCount)  pptx,required TResult Function(@JsonKey(name: 'message_count')  int messageCount)  pst,required TResult Function(@JsonKey(name: 'character_count')  int characterCount, @JsonKey(name: 'line_count')  int lineCount, @JsonKey(name: 'word_count')  int wordCount, @JsonKey(name: 'code_blocks')  List<List<String>>? codeBlocks,  List<String>? headers,  List<List<String>>? links)  text,required TResult Function(@JsonKey(name: 'element_count')  int elementCount, @JsonKey(name: 'unique_elements')  List<String> uniqueElements)  xml,}) {final _that = this;
switch (_that) {
case FormatMetadataArchive():
return archive(_that.fileCount,_that.fileList,_that.format,_that.totalSize,_that.compressedSize);case FormatMetadataCsv():
return csv(_that.columnCount,_that.hasHeader,_that.rowCount,_that.columnTypes,_that.delimiter);case FormatMetadataEmail():
return email(_that.attachments,_that.bccEmails,_that.ccEmails,_that.toEmails,_that.fromEmail,_that.fromName,_that.messageId);case FormatMetadataExcel():
return excel(_that.sheetCount,_that.sheetNames);case FormatMetadataHtml():
return html(_that.author,_that.baseHref,_that.canonicalUrl,_that.description,_that.headers,_that.images,_that.keywords,_that.language,_that.links,_that.metaTags,_that.openGraph,_that.structuredData,_that.textDirection,_that.title,_that.twitterCard);case FormatMetadataImage():
return image(_that.exif,_that.format,_that.height,_that.width);case FormatMetadataOcr():
return ocr(_that.language,_that.outputFormat,_that.psm,_that.tableCount,_that.tableCols,_that.tableRows);case FormatMetadataPptx():
return pptx(_that.slideCount,_that.slideNames,_that.imageCount,_that.tableCount);case FormatMetadataPst():
return pst(_that.messageCount);case FormatMetadataText():
return text(_that.characterCount,_that.lineCount,_that.wordCount,_that.codeBlocks,_that.headers,_that.links);case FormatMetadataXml():
return xml(_that.elementCount,_that.uniqueElements);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'file_count')  int fileCount, @JsonKey(name: 'file_list')  List<String> fileList,  String format, @JsonKey(name: 'total_size')  int totalSize, @JsonKey(name: 'compressed_size')  int? compressedSize)?  archive,TResult? Function(@JsonKey(name: 'column_count')  int columnCount, @JsonKey(name: 'has_header')  bool hasHeader, @JsonKey(name: 'row_count')  int rowCount, @JsonKey(name: 'column_types')  List<String>? columnTypes,  String? delimiter)?  csv,TResult? Function( List<String> attachments, @JsonKey(name: 'bcc_emails')  List<String> bccEmails, @JsonKey(name: 'cc_emails')  List<String> ccEmails, @JsonKey(name: 'to_emails')  List<String> toEmails, @JsonKey(name: 'from_email')  String? fromEmail, @JsonKey(name: 'from_name')  String? fromName, @JsonKey(name: 'message_id')  String? messageId)?  email,TResult? Function(@JsonKey(name: 'sheet_count')  int? sheetCount, @JsonKey(name: 'sheet_names')  List<String>? sheetNames)?  excel,TResult? Function( String? author, @JsonKey(name: 'base_href')  String? baseHref, @JsonKey(name: 'canonical_url')  String? canonicalUrl,  String? description,  List<HeaderMetadata>? headers,  List<ImageMetadataType>? images,  List<String>? keywords,  String? language,  List<LinkMetadata>? links, @JsonKey(name: 'meta_tags')  Map<String, String>? metaTags, @JsonKey(name: 'open_graph')  Map<String, String>? openGraph, @JsonKey(name: 'structured_data')  List<StructuredData>? structuredData, @JsonKey(name: 'text_direction')  TextDirection? textDirection,  String? title, @JsonKey(name: 'twitter_card')  Map<String, String>? twitterCard)?  html,TResult? Function( Map<String, String> exif,  String format,  int height,  int width)?  image,TResult? Function( String language, @JsonKey(name: 'output_format')  String outputFormat,  int psm, @JsonKey(name: 'table_count')  int tableCount, @JsonKey(name: 'table_cols')  int? tableCols, @JsonKey(name: 'table_rows')  int? tableRows)?  ocr,TResult? Function(@JsonKey(name: 'slide_count')  int slideCount, @JsonKey(name: 'slide_names')  List<String> slideNames, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'table_count')  int? tableCount)?  pptx,TResult? Function(@JsonKey(name: 'message_count')  int messageCount)?  pst,TResult? Function(@JsonKey(name: 'character_count')  int characterCount, @JsonKey(name: 'line_count')  int lineCount, @JsonKey(name: 'word_count')  int wordCount, @JsonKey(name: 'code_blocks')  List<List<String>>? codeBlocks,  List<String>? headers,  List<List<String>>? links)?  text,TResult? Function(@JsonKey(name: 'element_count')  int elementCount, @JsonKey(name: 'unique_elements')  List<String> uniqueElements)?  xml,}) {final _that = this;
switch (_that) {
case FormatMetadataArchive() when archive != null:
return archive(_that.fileCount,_that.fileList,_that.format,_that.totalSize,_that.compressedSize);case FormatMetadataCsv() when csv != null:
return csv(_that.columnCount,_that.hasHeader,_that.rowCount,_that.columnTypes,_that.delimiter);case FormatMetadataEmail() when email != null:
return email(_that.attachments,_that.bccEmails,_that.ccEmails,_that.toEmails,_that.fromEmail,_that.fromName,_that.messageId);case FormatMetadataExcel() when excel != null:
return excel(_that.sheetCount,_that.sheetNames);case FormatMetadataHtml() when html != null:
return html(_that.author,_that.baseHref,_that.canonicalUrl,_that.description,_that.headers,_that.images,_that.keywords,_that.language,_that.links,_that.metaTags,_that.openGraph,_that.structuredData,_that.textDirection,_that.title,_that.twitterCard);case FormatMetadataImage() when image != null:
return image(_that.exif,_that.format,_that.height,_that.width);case FormatMetadataOcr() when ocr != null:
return ocr(_that.language,_that.outputFormat,_that.psm,_that.tableCount,_that.tableCols,_that.tableRows);case FormatMetadataPptx() when pptx != null:
return pptx(_that.slideCount,_that.slideNames,_that.imageCount,_that.tableCount);case FormatMetadataPst() when pst != null:
return pst(_that.messageCount);case FormatMetadataText() when text != null:
return text(_that.characterCount,_that.lineCount,_that.wordCount,_that.codeBlocks,_that.headers,_that.links);case FormatMetadataXml() when xml != null:
return xml(_that.elementCount,_that.uniqueElements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class FormatMetadataArchive implements FormatMetadata {
  const FormatMetadataArchive({@JsonKey(name: 'file_count') required this.fileCount, @JsonKey(name: 'file_list') required final  List<String> fileList, required this.format, @JsonKey(name: 'total_size') required this.totalSize, @JsonKey(name: 'compressed_size') this.compressedSize, final  String? $type}): _fileList = fileList,$type = $type ?? 'archive';
  factory FormatMetadataArchive.fromJson(Map<String, dynamic> json) => _$FormatMetadataArchiveFromJson(json);

/// Total number of files in the archive
@JsonKey(name: 'file_count') final  int fileCount;
/// List of file paths within the archive
 final  List<String> _fileList;
/// List of file paths within the archive
@JsonKey(name: 'file_list') List<String> get fileList {
  if (_fileList is EqualUnmodifiableListView) return _fileList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fileList);
}

/// Archive format ("ZIP", "TAR", "7Z", etc.)
 final  String format;
/// Total uncompressed size in bytes
@JsonKey(name: 'total_size') final  int totalSize;
/// Compressed size in bytes (if available)
@JsonKey(name: 'compressed_size') final  int? compressedSize;

@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataArchiveCopyWith<FormatMetadataArchive> get copyWith => _$FormatMetadataArchiveCopyWithImpl<FormatMetadataArchive>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataArchiveToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataArchive&&(identical(other.fileCount, fileCount) || other.fileCount == fileCount)&&const DeepCollectionEquality().equals(other._fileList, _fileList)&&(identical(other.format, format) || other.format == format)&&(identical(other.totalSize, totalSize) || other.totalSize == totalSize)&&(identical(other.compressedSize, compressedSize) || other.compressedSize == compressedSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileCount,const DeepCollectionEquality().hash(_fileList),format,totalSize,compressedSize);

@override
String toString() {
  return 'FormatMetadata.archive(fileCount: $fileCount, fileList: $fileList, format: $format, totalSize: $totalSize, compressedSize: $compressedSize)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataArchiveCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataArchiveCopyWith(FormatMetadataArchive value, $Res Function(FormatMetadataArchive) _then) = _$FormatMetadataArchiveCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'file_count') int fileCount,@JsonKey(name: 'file_list') List<String> fileList, String format,@JsonKey(name: 'total_size') int totalSize,@JsonKey(name: 'compressed_size') int? compressedSize
});




}
/// @nodoc
class _$FormatMetadataArchiveCopyWithImpl<$Res>
    implements $FormatMetadataArchiveCopyWith<$Res> {
  _$FormatMetadataArchiveCopyWithImpl(this._self, this._then);

  final FormatMetadataArchive _self;
  final $Res Function(FormatMetadataArchive) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fileCount = null,Object? fileList = null,Object? format = null,Object? totalSize = null,Object? compressedSize = freezed,}) {
  return _then(FormatMetadataArchive(
fileCount: null == fileCount ? _self.fileCount : fileCount // ignore: cast_nullable_to_non_nullable
as int,fileList: null == fileList ? _self._fileList : fileList // ignore: cast_nullable_to_non_nullable
as List<String>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,totalSize: null == totalSize ? _self.totalSize : totalSize // ignore: cast_nullable_to_non_nullable
as int,compressedSize: freezed == compressedSize ? _self.compressedSize : compressedSize // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataCsv implements FormatMetadata {
  const FormatMetadataCsv({@JsonKey(name: 'column_count') required this.columnCount, @JsonKey(name: 'has_header') required this.hasHeader, @JsonKey(name: 'row_count') required this.rowCount, @JsonKey(name: 'column_types') final  List<String>? columnTypes, this.delimiter, final  String? $type}): _columnTypes = columnTypes,$type = $type ?? 'csv';
  factory FormatMetadataCsv.fromJson(Map<String, dynamic> json) => _$FormatMetadataCsvFromJson(json);

@JsonKey(name: 'column_count') final  int columnCount;
@JsonKey(name: 'has_header') final  bool hasHeader;
@JsonKey(name: 'row_count') final  int rowCount;
 final  List<String>? _columnTypes;
@JsonKey(name: 'column_types') List<String>? get columnTypes {
  final value = _columnTypes;
  if (value == null) return null;
  if (_columnTypes is EqualUnmodifiableListView) return _columnTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  String? delimiter;

@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataCsvCopyWith<FormatMetadataCsv> get copyWith => _$FormatMetadataCsvCopyWithImpl<FormatMetadataCsv>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataCsvToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataCsv&&(identical(other.columnCount, columnCount) || other.columnCount == columnCount)&&(identical(other.hasHeader, hasHeader) || other.hasHeader == hasHeader)&&(identical(other.rowCount, rowCount) || other.rowCount == rowCount)&&const DeepCollectionEquality().equals(other._columnTypes, _columnTypes)&&(identical(other.delimiter, delimiter) || other.delimiter == delimiter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,columnCount,hasHeader,rowCount,const DeepCollectionEquality().hash(_columnTypes),delimiter);

@override
String toString() {
  return 'FormatMetadata.csv(columnCount: $columnCount, hasHeader: $hasHeader, rowCount: $rowCount, columnTypes: $columnTypes, delimiter: $delimiter)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataCsvCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataCsvCopyWith(FormatMetadataCsv value, $Res Function(FormatMetadataCsv) _then) = _$FormatMetadataCsvCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'column_count') int columnCount,@JsonKey(name: 'has_header') bool hasHeader,@JsonKey(name: 'row_count') int rowCount,@JsonKey(name: 'column_types') List<String>? columnTypes, String? delimiter
});




}
/// @nodoc
class _$FormatMetadataCsvCopyWithImpl<$Res>
    implements $FormatMetadataCsvCopyWith<$Res> {
  _$FormatMetadataCsvCopyWithImpl(this._self, this._then);

  final FormatMetadataCsv _self;
  final $Res Function(FormatMetadataCsv) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? columnCount = null,Object? hasHeader = null,Object? rowCount = null,Object? columnTypes = freezed,Object? delimiter = freezed,}) {
  return _then(FormatMetadataCsv(
columnCount: null == columnCount ? _self.columnCount : columnCount // ignore: cast_nullable_to_non_nullable
as int,hasHeader: null == hasHeader ? _self.hasHeader : hasHeader // ignore: cast_nullable_to_non_nullable
as bool,rowCount: null == rowCount ? _self.rowCount : rowCount // ignore: cast_nullable_to_non_nullable
as int,columnTypes: freezed == columnTypes ? _self._columnTypes : columnTypes // ignore: cast_nullable_to_non_nullable
as List<String>?,delimiter: freezed == delimiter ? _self.delimiter : delimiter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataEmail implements FormatMetadata {
  const FormatMetadataEmail({required final  List<String> attachments, @JsonKey(name: 'bcc_emails') required final  List<String> bccEmails, @JsonKey(name: 'cc_emails') required final  List<String> ccEmails, @JsonKey(name: 'to_emails') required final  List<String> toEmails, @JsonKey(name: 'from_email') this.fromEmail, @JsonKey(name: 'from_name') this.fromName, @JsonKey(name: 'message_id') this.messageId, final  String? $type}): _attachments = attachments,_bccEmails = bccEmails,_ccEmails = ccEmails,_toEmails = toEmails,$type = $type ?? 'email';
  factory FormatMetadataEmail.fromJson(Map<String, dynamic> json) => _$FormatMetadataEmailFromJson(json);

/// List of attachment filenames
 final  List<String> _attachments;
/// List of attachment filenames
 List<String> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

/// BCC recipients
 final  List<String> _bccEmails;
/// BCC recipients
@JsonKey(name: 'bcc_emails') List<String> get bccEmails {
  if (_bccEmails is EqualUnmodifiableListView) return _bccEmails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bccEmails);
}

/// CC recipients
 final  List<String> _ccEmails;
/// CC recipients
@JsonKey(name: 'cc_emails') List<String> get ccEmails {
  if (_ccEmails is EqualUnmodifiableListView) return _ccEmails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ccEmails);
}

/// Primary recipients
 final  List<String> _toEmails;
/// Primary recipients
@JsonKey(name: 'to_emails') List<String> get toEmails {
  if (_toEmails is EqualUnmodifiableListView) return _toEmails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_toEmails);
}

/// Sender's email address
@JsonKey(name: 'from_email') final  String? fromEmail;
/// Sender's display name
@JsonKey(name: 'from_name') final  String? fromName;
/// Message-ID header value
@JsonKey(name: 'message_id') final  String? messageId;

@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataEmailCopyWith<FormatMetadataEmail> get copyWith => _$FormatMetadataEmailCopyWithImpl<FormatMetadataEmail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataEmailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataEmail&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&const DeepCollectionEquality().equals(other._bccEmails, _bccEmails)&&const DeepCollectionEquality().equals(other._ccEmails, _ccEmails)&&const DeepCollectionEquality().equals(other._toEmails, _toEmails)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.fromName, fromName) || other.fromName == fromName)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_attachments),const DeepCollectionEquality().hash(_bccEmails),const DeepCollectionEquality().hash(_ccEmails),const DeepCollectionEquality().hash(_toEmails),fromEmail,fromName,messageId);

@override
String toString() {
  return 'FormatMetadata.email(attachments: $attachments, bccEmails: $bccEmails, ccEmails: $ccEmails, toEmails: $toEmails, fromEmail: $fromEmail, fromName: $fromName, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataEmailCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataEmailCopyWith(FormatMetadataEmail value, $Res Function(FormatMetadataEmail) _then) = _$FormatMetadataEmailCopyWithImpl;
@useResult
$Res call({
 List<String> attachments,@JsonKey(name: 'bcc_emails') List<String> bccEmails,@JsonKey(name: 'cc_emails') List<String> ccEmails,@JsonKey(name: 'to_emails') List<String> toEmails,@JsonKey(name: 'from_email') String? fromEmail,@JsonKey(name: 'from_name') String? fromName,@JsonKey(name: 'message_id') String? messageId
});




}
/// @nodoc
class _$FormatMetadataEmailCopyWithImpl<$Res>
    implements $FormatMetadataEmailCopyWith<$Res> {
  _$FormatMetadataEmailCopyWithImpl(this._self, this._then);

  final FormatMetadataEmail _self;
  final $Res Function(FormatMetadataEmail) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? attachments = null,Object? bccEmails = null,Object? ccEmails = null,Object? toEmails = null,Object? fromEmail = freezed,Object? fromName = freezed,Object? messageId = freezed,}) {
  return _then(FormatMetadataEmail(
attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,bccEmails: null == bccEmails ? _self._bccEmails : bccEmails // ignore: cast_nullable_to_non_nullable
as List<String>,ccEmails: null == ccEmails ? _self._ccEmails : ccEmails // ignore: cast_nullable_to_non_nullable
as List<String>,toEmails: null == toEmails ? _self._toEmails : toEmails // ignore: cast_nullable_to_non_nullable
as List<String>,fromEmail: freezed == fromEmail ? _self.fromEmail : fromEmail // ignore: cast_nullable_to_non_nullable
as String?,fromName: freezed == fromName ? _self.fromName : fromName // ignore: cast_nullable_to_non_nullable
as String?,messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataExcel implements FormatMetadata {
  const FormatMetadataExcel({@JsonKey(name: 'sheet_count') this.sheetCount, @JsonKey(name: 'sheet_names') final  List<String>? sheetNames, final  String? $type}): _sheetNames = sheetNames,$type = $type ?? 'excel';
  factory FormatMetadataExcel.fromJson(Map<String, dynamic> json) => _$FormatMetadataExcelFromJson(json);

/// Number of sheets in the workbook.
@JsonKey(name: 'sheet_count') final  int? sheetCount;
/// Names of all sheets in the workbook.
 final  List<String>? _sheetNames;
/// Names of all sheets in the workbook.
@JsonKey(name: 'sheet_names') List<String>? get sheetNames {
  final value = _sheetNames;
  if (value == null) return null;
  if (_sheetNames is EqualUnmodifiableListView) return _sheetNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataExcelCopyWith<FormatMetadataExcel> get copyWith => _$FormatMetadataExcelCopyWithImpl<FormatMetadataExcel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataExcelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataExcel&&(identical(other.sheetCount, sheetCount) || other.sheetCount == sheetCount)&&const DeepCollectionEquality().equals(other._sheetNames, _sheetNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sheetCount,const DeepCollectionEquality().hash(_sheetNames));

@override
String toString() {
  return 'FormatMetadata.excel(sheetCount: $sheetCount, sheetNames: $sheetNames)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataExcelCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataExcelCopyWith(FormatMetadataExcel value, $Res Function(FormatMetadataExcel) _then) = _$FormatMetadataExcelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'sheet_count') int? sheetCount,@JsonKey(name: 'sheet_names') List<String>? sheetNames
});




}
/// @nodoc
class _$FormatMetadataExcelCopyWithImpl<$Res>
    implements $FormatMetadataExcelCopyWith<$Res> {
  _$FormatMetadataExcelCopyWithImpl(this._self, this._then);

  final FormatMetadataExcel _self;
  final $Res Function(FormatMetadataExcel) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sheetCount = freezed,Object? sheetNames = freezed,}) {
  return _then(FormatMetadataExcel(
sheetCount: freezed == sheetCount ? _self.sheetCount : sheetCount // ignore: cast_nullable_to_non_nullable
as int?,sheetNames: freezed == sheetNames ? _self._sheetNames : sheetNames // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataHtml implements FormatMetadata {
  const FormatMetadataHtml({this.author, @JsonKey(name: 'base_href') this.baseHref, @JsonKey(name: 'canonical_url') this.canonicalUrl, this.description, final  List<HeaderMetadata>? headers, final  List<ImageMetadataType>? images, final  List<String>? keywords, this.language, final  List<LinkMetadata>? links, @JsonKey(name: 'meta_tags') final  Map<String, String>? metaTags, @JsonKey(name: 'open_graph') final  Map<String, String>? openGraph, @JsonKey(name: 'structured_data') final  List<StructuredData>? structuredData, @JsonKey(name: 'text_direction') this.textDirection, this.title, @JsonKey(name: 'twitter_card') final  Map<String, String>? twitterCard, final  String? $type}): _headers = headers,_images = images,_keywords = keywords,_links = links,_metaTags = metaTags,_openGraph = openGraph,_structuredData = structuredData,_twitterCard = twitterCard,$type = $type ?? 'html';
  factory FormatMetadataHtml.fromJson(Map<String, dynamic> json) => _$FormatMetadataHtmlFromJson(json);

/// Document author from `<meta name="author">` tag
 final  String? author;
/// Base URL from `<base href="">` tag for resolving relative URLs
@JsonKey(name: 'base_href') final  String? baseHref;
/// Canonical URL from `<link rel="canonical">` tag
@JsonKey(name: 'canonical_url') final  String? canonicalUrl;
/// Document description from `<meta name="description">` tag
 final  String? description;
/// Extracted header elements with hierarchy
 final  List<HeaderMetadata>? _headers;
/// Extracted header elements with hierarchy
 List<HeaderMetadata>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableListView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Extracted images with source and dimensions
 final  List<ImageMetadataType>? _images;
/// Extracted images with source and dimensions
 List<ImageMetadataType>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Document keywords from `<meta name="keywords">` tag, split on commas
 final  List<String>? _keywords;
/// Document keywords from `<meta name="keywords">` tag, split on commas
 List<String>? get keywords {
  final value = _keywords;
  if (value == null) return null;
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Document language from `lang` attribute
 final  String? language;
/// Extracted hyperlinks with type classification
 final  List<LinkMetadata>? _links;
/// Extracted hyperlinks with type classification
 List<LinkMetadata>? get links {
  final value = _links;
  if (value == null) return null;
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Additional meta tags not covered by specific fields.
/// Keys are meta name/property attributes, values are content.
 final  Map<String, String>? _metaTags;
/// Additional meta tags not covered by specific fields.
/// Keys are meta name/property attributes, values are content.
@JsonKey(name: 'meta_tags') Map<String, String>? get metaTags {
  final value = _metaTags;
  if (value == null) return null;
  if (_metaTags is EqualUnmodifiableMapView) return _metaTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Open Graph metadata (og:* properties) for social media.
/// Keys like "title", "description", "image", "url", etc.
 final  Map<String, String>? _openGraph;
/// Open Graph metadata (og:* properties) for social media.
/// Keys like "title", "description", "image", "url", etc.
@JsonKey(name: 'open_graph') Map<String, String>? get openGraph {
  final value = _openGraph;
  if (value == null) return null;
  if (_openGraph is EqualUnmodifiableMapView) return _openGraph;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Extracted structured data blocks
 final  List<StructuredData>? _structuredData;
/// Extracted structured data blocks
@JsonKey(name: 'structured_data') List<StructuredData>? get structuredData {
  final value = _structuredData;
  if (value == null) return null;
  if (_structuredData is EqualUnmodifiableListView) return _structuredData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Document text direction from `dir` attribute
@JsonKey(name: 'text_direction') final  TextDirection? textDirection;
/// Document title from `<title>` tag
 final  String? title;
/// Twitter Card metadata (twitter:* properties).
/// Keys like "card", "site", "creator", "title", "description", "image", etc.
 final  Map<String, String>? _twitterCard;
/// Twitter Card metadata (twitter:* properties).
/// Keys like "card", "site", "creator", "title", "description", "image", etc.
@JsonKey(name: 'twitter_card') Map<String, String>? get twitterCard {
  final value = _twitterCard;
  if (value == null) return null;
  if (_twitterCard is EqualUnmodifiableMapView) return _twitterCard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataHtmlCopyWith<FormatMetadataHtml> get copyWith => _$FormatMetadataHtmlCopyWithImpl<FormatMetadataHtml>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataHtmlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataHtml&&(identical(other.author, author) || other.author == author)&&(identical(other.baseHref, baseHref) || other.baseHref == baseHref)&&(identical(other.canonicalUrl, canonicalUrl) || other.canonicalUrl == canonicalUrl)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._headers, _headers)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._keywords, _keywords)&&(identical(other.language, language) || other.language == language)&&const DeepCollectionEquality().equals(other._links, _links)&&const DeepCollectionEquality().equals(other._metaTags, _metaTags)&&const DeepCollectionEquality().equals(other._openGraph, _openGraph)&&const DeepCollectionEquality().equals(other._structuredData, _structuredData)&&(identical(other.textDirection, textDirection) || other.textDirection == textDirection)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._twitterCard, _twitterCard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,baseHref,canonicalUrl,description,const DeepCollectionEquality().hash(_headers),const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_keywords),language,const DeepCollectionEquality().hash(_links),const DeepCollectionEquality().hash(_metaTags),const DeepCollectionEquality().hash(_openGraph),const DeepCollectionEquality().hash(_structuredData),textDirection,title,const DeepCollectionEquality().hash(_twitterCard));

@override
String toString() {
  return 'FormatMetadata.html(author: $author, baseHref: $baseHref, canonicalUrl: $canonicalUrl, description: $description, headers: $headers, images: $images, keywords: $keywords, language: $language, links: $links, metaTags: $metaTags, openGraph: $openGraph, structuredData: $structuredData, textDirection: $textDirection, title: $title, twitterCard: $twitterCard)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataHtmlCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataHtmlCopyWith(FormatMetadataHtml value, $Res Function(FormatMetadataHtml) _then) = _$FormatMetadataHtmlCopyWithImpl;
@useResult
$Res call({
 String? author,@JsonKey(name: 'base_href') String? baseHref,@JsonKey(name: 'canonical_url') String? canonicalUrl, String? description, List<HeaderMetadata>? headers, List<ImageMetadataType>? images, List<String>? keywords, String? language, List<LinkMetadata>? links,@JsonKey(name: 'meta_tags') Map<String, String>? metaTags,@JsonKey(name: 'open_graph') Map<String, String>? openGraph,@JsonKey(name: 'structured_data') List<StructuredData>? structuredData,@JsonKey(name: 'text_direction') TextDirection? textDirection, String? title,@JsonKey(name: 'twitter_card') Map<String, String>? twitterCard
});




}
/// @nodoc
class _$FormatMetadataHtmlCopyWithImpl<$Res>
    implements $FormatMetadataHtmlCopyWith<$Res> {
  _$FormatMetadataHtmlCopyWithImpl(this._self, this._then);

  final FormatMetadataHtml _self;
  final $Res Function(FormatMetadataHtml) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? author = freezed,Object? baseHref = freezed,Object? canonicalUrl = freezed,Object? description = freezed,Object? headers = freezed,Object? images = freezed,Object? keywords = freezed,Object? language = freezed,Object? links = freezed,Object? metaTags = freezed,Object? openGraph = freezed,Object? structuredData = freezed,Object? textDirection = freezed,Object? title = freezed,Object? twitterCard = freezed,}) {
  return _then(FormatMetadataHtml(
author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,baseHref: freezed == baseHref ? _self.baseHref : baseHref // ignore: cast_nullable_to_non_nullable
as String?,canonicalUrl: freezed == canonicalUrl ? _self.canonicalUrl : canonicalUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as List<HeaderMetadata>?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ImageMetadataType>?,keywords: freezed == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,links: freezed == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<LinkMetadata>?,metaTags: freezed == metaTags ? _self._metaTags : metaTags // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,openGraph: freezed == openGraph ? _self._openGraph : openGraph // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,structuredData: freezed == structuredData ? _self._structuredData : structuredData // ignore: cast_nullable_to_non_nullable
as List<StructuredData>?,textDirection: freezed == textDirection ? _self.textDirection : textDirection // ignore: cast_nullable_to_non_nullable
as TextDirection?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,twitterCard: freezed == twitterCard ? _self._twitterCard : twitterCard // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataImage implements FormatMetadata {
  const FormatMetadataImage({required final  Map<String, String> exif, required this.format, required this.height, required this.width, final  String? $type}): _exif = exif,$type = $type ?? 'image';
  factory FormatMetadataImage.fromJson(Map<String, dynamic> json) => _$FormatMetadataImageFromJson(json);

/// EXIF metadata tags
 final  Map<String, String> _exif;
/// EXIF metadata tags
 Map<String, String> get exif {
  if (_exif is EqualUnmodifiableMapView) return _exif;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_exif);
}

/// Image format (e.g., "PNG", "JPEG", "TIFF")
 final  String format;
/// Image height in pixels
 final  int height;
/// Image width in pixels
 final  int width;

@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataImageCopyWith<FormatMetadataImage> get copyWith => _$FormatMetadataImageCopyWithImpl<FormatMetadataImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataImage&&const DeepCollectionEquality().equals(other._exif, _exif)&&(identical(other.format, format) || other.format == format)&&(identical(other.height, height) || other.height == height)&&(identical(other.width, width) || other.width == width));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_exif),format,height,width);

@override
String toString() {
  return 'FormatMetadata.image(exif: $exif, format: $format, height: $height, width: $width)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataImageCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataImageCopyWith(FormatMetadataImage value, $Res Function(FormatMetadataImage) _then) = _$FormatMetadataImageCopyWithImpl;
@useResult
$Res call({
 Map<String, String> exif, String format, int height, int width
});




}
/// @nodoc
class _$FormatMetadataImageCopyWithImpl<$Res>
    implements $FormatMetadataImageCopyWith<$Res> {
  _$FormatMetadataImageCopyWithImpl(this._self, this._then);

  final FormatMetadataImage _self;
  final $Res Function(FormatMetadataImage) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exif = null,Object? format = null,Object? height = null,Object? width = null,}) {
  return _then(FormatMetadataImage(
exif: null == exif ? _self._exif : exif // ignore: cast_nullable_to_non_nullable
as Map<String, String>,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataOcr implements FormatMetadata {
  const FormatMetadataOcr({required this.language, @JsonKey(name: 'output_format') required this.outputFormat, required this.psm, @JsonKey(name: 'table_count') required this.tableCount, @JsonKey(name: 'table_cols') this.tableCols, @JsonKey(name: 'table_rows') this.tableRows, final  String? $type}): $type = $type ?? 'ocr';
  factory FormatMetadataOcr.fromJson(Map<String, dynamic> json) => _$FormatMetadataOcrFromJson(json);

/// OCR language code(s) used
 final  String language;
/// Output format (e.g., "text", "hocr")
@JsonKey(name: 'output_format') final  String outputFormat;
/// Tesseract Page Segmentation Mode (PSM)
 final  int psm;
/// Number of tables detected
@JsonKey(name: 'table_count') final  int tableCount;
@JsonKey(name: 'table_cols') final  int? tableCols;
@JsonKey(name: 'table_rows') final  int? tableRows;

@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataOcrCopyWith<FormatMetadataOcr> get copyWith => _$FormatMetadataOcrCopyWithImpl<FormatMetadataOcr>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataOcrToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataOcr&&(identical(other.language, language) || other.language == language)&&(identical(other.outputFormat, outputFormat) || other.outputFormat == outputFormat)&&(identical(other.psm, psm) || other.psm == psm)&&(identical(other.tableCount, tableCount) || other.tableCount == tableCount)&&(identical(other.tableCols, tableCols) || other.tableCols == tableCols)&&(identical(other.tableRows, tableRows) || other.tableRows == tableRows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,outputFormat,psm,tableCount,tableCols,tableRows);

@override
String toString() {
  return 'FormatMetadata.ocr(language: $language, outputFormat: $outputFormat, psm: $psm, tableCount: $tableCount, tableCols: $tableCols, tableRows: $tableRows)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataOcrCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataOcrCopyWith(FormatMetadataOcr value, $Res Function(FormatMetadataOcr) _then) = _$FormatMetadataOcrCopyWithImpl;
@useResult
$Res call({
 String language,@JsonKey(name: 'output_format') String outputFormat, int psm,@JsonKey(name: 'table_count') int tableCount,@JsonKey(name: 'table_cols') int? tableCols,@JsonKey(name: 'table_rows') int? tableRows
});




}
/// @nodoc
class _$FormatMetadataOcrCopyWithImpl<$Res>
    implements $FormatMetadataOcrCopyWith<$Res> {
  _$FormatMetadataOcrCopyWithImpl(this._self, this._then);

  final FormatMetadataOcr _self;
  final $Res Function(FormatMetadataOcr) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? language = null,Object? outputFormat = null,Object? psm = null,Object? tableCount = null,Object? tableCols = freezed,Object? tableRows = freezed,}) {
  return _then(FormatMetadataOcr(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,outputFormat: null == outputFormat ? _self.outputFormat : outputFormat // ignore: cast_nullable_to_non_nullable
as String,psm: null == psm ? _self.psm : psm // ignore: cast_nullable_to_non_nullable
as int,tableCount: null == tableCount ? _self.tableCount : tableCount // ignore: cast_nullable_to_non_nullable
as int,tableCols: freezed == tableCols ? _self.tableCols : tableCols // ignore: cast_nullable_to_non_nullable
as int?,tableRows: freezed == tableRows ? _self.tableRows : tableRows // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataPptx implements FormatMetadata {
  const FormatMetadataPptx({@JsonKey(name: 'slide_count') required this.slideCount, @JsonKey(name: 'slide_names') required final  List<String> slideNames, @JsonKey(name: 'image_count') this.imageCount, @JsonKey(name: 'table_count') this.tableCount, final  String? $type}): _slideNames = slideNames,$type = $type ?? 'pptx';
  factory FormatMetadataPptx.fromJson(Map<String, dynamic> json) => _$FormatMetadataPptxFromJson(json);

/// Total number of slides in the presentation
@JsonKey(name: 'slide_count') final  int slideCount;
/// Names of slides (if available)
 final  List<String> _slideNames;
/// Names of slides (if available)
@JsonKey(name: 'slide_names') List<String> get slideNames {
  if (_slideNames is EqualUnmodifiableListView) return _slideNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slideNames);
}

/// Number of embedded images
@JsonKey(name: 'image_count') final  int? imageCount;
/// Number of tables
@JsonKey(name: 'table_count') final  int? tableCount;

@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataPptxCopyWith<FormatMetadataPptx> get copyWith => _$FormatMetadataPptxCopyWithImpl<FormatMetadataPptx>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataPptxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataPptx&&(identical(other.slideCount, slideCount) || other.slideCount == slideCount)&&const DeepCollectionEquality().equals(other._slideNames, _slideNames)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.tableCount, tableCount) || other.tableCount == tableCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slideCount,const DeepCollectionEquality().hash(_slideNames),imageCount,tableCount);

@override
String toString() {
  return 'FormatMetadata.pptx(slideCount: $slideCount, slideNames: $slideNames, imageCount: $imageCount, tableCount: $tableCount)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataPptxCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataPptxCopyWith(FormatMetadataPptx value, $Res Function(FormatMetadataPptx) _then) = _$FormatMetadataPptxCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'slide_count') int slideCount,@JsonKey(name: 'slide_names') List<String> slideNames,@JsonKey(name: 'image_count') int? imageCount,@JsonKey(name: 'table_count') int? tableCount
});




}
/// @nodoc
class _$FormatMetadataPptxCopyWithImpl<$Res>
    implements $FormatMetadataPptxCopyWith<$Res> {
  _$FormatMetadataPptxCopyWithImpl(this._self, this._then);

  final FormatMetadataPptx _self;
  final $Res Function(FormatMetadataPptx) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? slideCount = null,Object? slideNames = null,Object? imageCount = freezed,Object? tableCount = freezed,}) {
  return _then(FormatMetadataPptx(
slideCount: null == slideCount ? _self.slideCount : slideCount // ignore: cast_nullable_to_non_nullable
as int,slideNames: null == slideNames ? _self._slideNames : slideNames // ignore: cast_nullable_to_non_nullable
as List<String>,imageCount: freezed == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int?,tableCount: freezed == tableCount ? _self.tableCount : tableCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataPst implements FormatMetadata {
  const FormatMetadataPst({@JsonKey(name: 'message_count') required this.messageCount, final  String? $type}): $type = $type ?? 'pst';
  factory FormatMetadataPst.fromJson(Map<String, dynamic> json) => _$FormatMetadataPstFromJson(json);

@JsonKey(name: 'message_count') final  int messageCount;

@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataPstCopyWith<FormatMetadataPst> get copyWith => _$FormatMetadataPstCopyWithImpl<FormatMetadataPst>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataPstToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataPst&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageCount);

@override
String toString() {
  return 'FormatMetadata.pst(messageCount: $messageCount)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataPstCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataPstCopyWith(FormatMetadataPst value, $Res Function(FormatMetadataPst) _then) = _$FormatMetadataPstCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'message_count') int messageCount
});




}
/// @nodoc
class _$FormatMetadataPstCopyWithImpl<$Res>
    implements $FormatMetadataPstCopyWith<$Res> {
  _$FormatMetadataPstCopyWithImpl(this._self, this._then);

  final FormatMetadataPst _self;
  final $Res Function(FormatMetadataPst) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messageCount = null,}) {
  return _then(FormatMetadataPst(
messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataText implements FormatMetadata {
  const FormatMetadataText({@JsonKey(name: 'character_count') required this.characterCount, @JsonKey(name: 'line_count') required this.lineCount, @JsonKey(name: 'word_count') required this.wordCount, @JsonKey(name: 'code_blocks') final  List<List<String>>? codeBlocks, final  List<String>? headers, final  List<List<String>>? links, final  String? $type}): _codeBlocks = codeBlocks,_headers = headers,_links = links,$type = $type ?? 'text';
  factory FormatMetadataText.fromJson(Map<String, dynamic> json) => _$FormatMetadataTextFromJson(json);

/// Number of characters
@JsonKey(name: 'character_count') final  int characterCount;
/// Number of lines in the document
@JsonKey(name: 'line_count') final  int lineCount;
/// Number of words
@JsonKey(name: 'word_count') final  int wordCount;
/// Code blocks as (language, code) tuples (for Markdown files)
 final  List<List<String>>? _codeBlocks;
/// Code blocks as (language, code) tuples (for Markdown files)
@JsonKey(name: 'code_blocks') List<List<String>>? get codeBlocks {
  final value = _codeBlocks;
  if (value == null) return null;
  if (_codeBlocks is EqualUnmodifiableListView) return _codeBlocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Markdown headers (headings text only, for Markdown files)
 final  List<String>? _headers;
/// Markdown headers (headings text only, for Markdown files)
 List<String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableListView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Markdown links as (text, url) tuples (for Markdown files)
 final  List<List<String>>? _links;
/// Markdown links as (text, url) tuples (for Markdown files)
 List<List<String>>? get links {
  final value = _links;
  if (value == null) return null;
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataTextCopyWith<FormatMetadataText> get copyWith => _$FormatMetadataTextCopyWithImpl<FormatMetadataText>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataTextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataText&&(identical(other.characterCount, characterCount) || other.characterCount == characterCount)&&(identical(other.lineCount, lineCount) || other.lineCount == lineCount)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&const DeepCollectionEquality().equals(other._codeBlocks, _codeBlocks)&&const DeepCollectionEquality().equals(other._headers, _headers)&&const DeepCollectionEquality().equals(other._links, _links));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,characterCount,lineCount,wordCount,const DeepCollectionEquality().hash(_codeBlocks),const DeepCollectionEquality().hash(_headers),const DeepCollectionEquality().hash(_links));

@override
String toString() {
  return 'FormatMetadata.text(characterCount: $characterCount, lineCount: $lineCount, wordCount: $wordCount, codeBlocks: $codeBlocks, headers: $headers, links: $links)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataTextCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataTextCopyWith(FormatMetadataText value, $Res Function(FormatMetadataText) _then) = _$FormatMetadataTextCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'character_count') int characterCount,@JsonKey(name: 'line_count') int lineCount,@JsonKey(name: 'word_count') int wordCount,@JsonKey(name: 'code_blocks') List<List<String>>? codeBlocks, List<String>? headers, List<List<String>>? links
});




}
/// @nodoc
class _$FormatMetadataTextCopyWithImpl<$Res>
    implements $FormatMetadataTextCopyWith<$Res> {
  _$FormatMetadataTextCopyWithImpl(this._self, this._then);

  final FormatMetadataText _self;
  final $Res Function(FormatMetadataText) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? characterCount = null,Object? lineCount = null,Object? wordCount = null,Object? codeBlocks = freezed,Object? headers = freezed,Object? links = freezed,}) {
  return _then(FormatMetadataText(
characterCount: null == characterCount ? _self.characterCount : characterCount // ignore: cast_nullable_to_non_nullable
as int,lineCount: null == lineCount ? _self.lineCount : lineCount // ignore: cast_nullable_to_non_nullable
as int,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,codeBlocks: freezed == codeBlocks ? _self._codeBlocks : codeBlocks // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as List<String>?,links: freezed == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<List<String>>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FormatMetadataXml implements FormatMetadata {
  const FormatMetadataXml({@JsonKey(name: 'element_count') required this.elementCount, @JsonKey(name: 'unique_elements') required final  List<String> uniqueElements, final  String? $type}): _uniqueElements = uniqueElements,$type = $type ?? 'xml';
  factory FormatMetadataXml.fromJson(Map<String, dynamic> json) => _$FormatMetadataXmlFromJson(json);

/// Total number of XML elements processed
@JsonKey(name: 'element_count') final  int elementCount;
/// List of unique element tag names (sorted)
 final  List<String> _uniqueElements;
/// List of unique element tag names (sorted)
@JsonKey(name: 'unique_elements') List<String> get uniqueElements {
  if (_uniqueElements is EqualUnmodifiableListView) return _uniqueElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uniqueElements);
}


@JsonKey(name: 'format_type')
final String $type;


/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatMetadataXmlCopyWith<FormatMetadataXml> get copyWith => _$FormatMetadataXmlCopyWithImpl<FormatMetadataXml>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormatMetadataXmlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatMetadataXml&&(identical(other.elementCount, elementCount) || other.elementCount == elementCount)&&const DeepCollectionEquality().equals(other._uniqueElements, _uniqueElements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elementCount,const DeepCollectionEquality().hash(_uniqueElements));

@override
String toString() {
  return 'FormatMetadata.xml(elementCount: $elementCount, uniqueElements: $uniqueElements)';
}


}

/// @nodoc
abstract mixin class $FormatMetadataXmlCopyWith<$Res> implements $FormatMetadataCopyWith<$Res> {
  factory $FormatMetadataXmlCopyWith(FormatMetadataXml value, $Res Function(FormatMetadataXml) _then) = _$FormatMetadataXmlCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'element_count') int elementCount,@JsonKey(name: 'unique_elements') List<String> uniqueElements
});




}
/// @nodoc
class _$FormatMetadataXmlCopyWithImpl<$Res>
    implements $FormatMetadataXmlCopyWith<$Res> {
  _$FormatMetadataXmlCopyWithImpl(this._self, this._then);

  final FormatMetadataXml _self;
  final $Res Function(FormatMetadataXml) _then;

/// Create a copy of FormatMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? elementCount = null,Object? uniqueElements = null,}) {
  return _then(FormatMetadataXml(
elementCount: null == elementCount ? _self.elementCount : elementCount // ignore: cast_nullable_to_non_nullable
as int,uniqueElements: null == uniqueElements ? _self._uniqueElements : uniqueElements // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
