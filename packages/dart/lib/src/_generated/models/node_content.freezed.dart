// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
NodeContent _$NodeContentFromJson(
  Map<String, dynamic> json
) {
        switch (json['node_type']) {
                  case 'title':
          return NodeContentTitle.fromJson(
            json
          );
                case 'heading':
          return NodeContentHeading.fromJson(
            json
          );
                case 'paragraph':
          return NodeContentParagraph.fromJson(
            json
          );
                case 'list':
          return NodeContentList.fromJson(
            json
          );
                case 'list_item':
          return NodeContentListItem.fromJson(
            json
          );
                case 'table':
          return NodeContentTable.fromJson(
            json
          );
                case 'image':
          return NodeContentImage.fromJson(
            json
          );
                case 'code':
          return NodeContentCode.fromJson(
            json
          );
                case 'quote':
          return NodeContentQuote.fromJson(
            json
          );
                case 'formula':
          return NodeContentFormula.fromJson(
            json
          );
                case 'footnote':
          return NodeContentFootnote.fromJson(
            json
          );
                case 'group':
          return NodeContentGroup.fromJson(
            json
          );
                case 'page_break':
          return NodeContentPageBreak.fromJson(
            json
          );
                case 'slide':
          return NodeContentSlide.fromJson(
            json
          );
                case 'definition_list':
          return NodeContentDefinitionList.fromJson(
            json
          );
                case 'definition_item':
          return NodeContentDefinitionItem.fromJson(
            json
          );
                case 'citation':
          return NodeContentCitation.fromJson(
            json
          );
                case 'admonition':
          return NodeContentAdmonition.fromJson(
            json
          );
                case 'raw_block':
          return NodeContentRawBlock.fromJson(
            json
          );
                case 'metadata_block':
          return NodeContentMetadataBlock.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'node_type',
  'NodeContent',
  'Invalid union type "${json['node_type']}"!'
);
        }
      
}

/// @nodoc
mixin _$NodeContent {



  /// Serializes this NodeContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NodeContent()';
}


}

/// @nodoc
class $NodeContentCopyWith<$Res>  {
$NodeContentCopyWith(NodeContent _, $Res Function(NodeContent) __);
}


/// Adds pattern-matching-related methods to [NodeContent].
extension NodeContentPatterns on NodeContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NodeContentTitle value)?  title,TResult Function( NodeContentHeading value)?  heading,TResult Function( NodeContentParagraph value)?  paragraph,TResult Function( NodeContentList value)?  list,TResult Function( NodeContentListItem value)?  listItem,TResult Function( NodeContentTable value)?  table,TResult Function( NodeContentImage value)?  image,TResult Function( NodeContentCode value)?  code,TResult Function( NodeContentQuote value)?  quote,TResult Function( NodeContentFormula value)?  formula,TResult Function( NodeContentFootnote value)?  footnote,TResult Function( NodeContentGroup value)?  group,TResult Function( NodeContentPageBreak value)?  pageBreak,TResult Function( NodeContentSlide value)?  slide,TResult Function( NodeContentDefinitionList value)?  definitionList,TResult Function( NodeContentDefinitionItem value)?  definitionItem,TResult Function( NodeContentCitation value)?  citation,TResult Function( NodeContentAdmonition value)?  admonition,TResult Function( NodeContentRawBlock value)?  rawBlock,TResult Function( NodeContentMetadataBlock value)?  metadataBlock,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NodeContentTitle() when title != null:
return title(_that);case NodeContentHeading() when heading != null:
return heading(_that);case NodeContentParagraph() when paragraph != null:
return paragraph(_that);case NodeContentList() when list != null:
return list(_that);case NodeContentListItem() when listItem != null:
return listItem(_that);case NodeContentTable() when table != null:
return table(_that);case NodeContentImage() when image != null:
return image(_that);case NodeContentCode() when code != null:
return code(_that);case NodeContentQuote() when quote != null:
return quote(_that);case NodeContentFormula() when formula != null:
return formula(_that);case NodeContentFootnote() when footnote != null:
return footnote(_that);case NodeContentGroup() when group != null:
return group(_that);case NodeContentPageBreak() when pageBreak != null:
return pageBreak(_that);case NodeContentSlide() when slide != null:
return slide(_that);case NodeContentDefinitionList() when definitionList != null:
return definitionList(_that);case NodeContentDefinitionItem() when definitionItem != null:
return definitionItem(_that);case NodeContentCitation() when citation != null:
return citation(_that);case NodeContentAdmonition() when admonition != null:
return admonition(_that);case NodeContentRawBlock() when rawBlock != null:
return rawBlock(_that);case NodeContentMetadataBlock() when metadataBlock != null:
return metadataBlock(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NodeContentTitle value)  title,required TResult Function( NodeContentHeading value)  heading,required TResult Function( NodeContentParagraph value)  paragraph,required TResult Function( NodeContentList value)  list,required TResult Function( NodeContentListItem value)  listItem,required TResult Function( NodeContentTable value)  table,required TResult Function( NodeContentImage value)  image,required TResult Function( NodeContentCode value)  code,required TResult Function( NodeContentQuote value)  quote,required TResult Function( NodeContentFormula value)  formula,required TResult Function( NodeContentFootnote value)  footnote,required TResult Function( NodeContentGroup value)  group,required TResult Function( NodeContentPageBreak value)  pageBreak,required TResult Function( NodeContentSlide value)  slide,required TResult Function( NodeContentDefinitionList value)  definitionList,required TResult Function( NodeContentDefinitionItem value)  definitionItem,required TResult Function( NodeContentCitation value)  citation,required TResult Function( NodeContentAdmonition value)  admonition,required TResult Function( NodeContentRawBlock value)  rawBlock,required TResult Function( NodeContentMetadataBlock value)  metadataBlock,}){
final _that = this;
switch (_that) {
case NodeContentTitle():
return title(_that);case NodeContentHeading():
return heading(_that);case NodeContentParagraph():
return paragraph(_that);case NodeContentList():
return list(_that);case NodeContentListItem():
return listItem(_that);case NodeContentTable():
return table(_that);case NodeContentImage():
return image(_that);case NodeContentCode():
return code(_that);case NodeContentQuote():
return quote(_that);case NodeContentFormula():
return formula(_that);case NodeContentFootnote():
return footnote(_that);case NodeContentGroup():
return group(_that);case NodeContentPageBreak():
return pageBreak(_that);case NodeContentSlide():
return slide(_that);case NodeContentDefinitionList():
return definitionList(_that);case NodeContentDefinitionItem():
return definitionItem(_that);case NodeContentCitation():
return citation(_that);case NodeContentAdmonition():
return admonition(_that);case NodeContentRawBlock():
return rawBlock(_that);case NodeContentMetadataBlock():
return metadataBlock(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NodeContentTitle value)?  title,TResult? Function( NodeContentHeading value)?  heading,TResult? Function( NodeContentParagraph value)?  paragraph,TResult? Function( NodeContentList value)?  list,TResult? Function( NodeContentListItem value)?  listItem,TResult? Function( NodeContentTable value)?  table,TResult? Function( NodeContentImage value)?  image,TResult? Function( NodeContentCode value)?  code,TResult? Function( NodeContentQuote value)?  quote,TResult? Function( NodeContentFormula value)?  formula,TResult? Function( NodeContentFootnote value)?  footnote,TResult? Function( NodeContentGroup value)?  group,TResult? Function( NodeContentPageBreak value)?  pageBreak,TResult? Function( NodeContentSlide value)?  slide,TResult? Function( NodeContentDefinitionList value)?  definitionList,TResult? Function( NodeContentDefinitionItem value)?  definitionItem,TResult? Function( NodeContentCitation value)?  citation,TResult? Function( NodeContentAdmonition value)?  admonition,TResult? Function( NodeContentRawBlock value)?  rawBlock,TResult? Function( NodeContentMetadataBlock value)?  metadataBlock,}){
final _that = this;
switch (_that) {
case NodeContentTitle() when title != null:
return title(_that);case NodeContentHeading() when heading != null:
return heading(_that);case NodeContentParagraph() when paragraph != null:
return paragraph(_that);case NodeContentList() when list != null:
return list(_that);case NodeContentListItem() when listItem != null:
return listItem(_that);case NodeContentTable() when table != null:
return table(_that);case NodeContentImage() when image != null:
return image(_that);case NodeContentCode() when code != null:
return code(_that);case NodeContentQuote() when quote != null:
return quote(_that);case NodeContentFormula() when formula != null:
return formula(_that);case NodeContentFootnote() when footnote != null:
return footnote(_that);case NodeContentGroup() when group != null:
return group(_that);case NodeContentPageBreak() when pageBreak != null:
return pageBreak(_that);case NodeContentSlide() when slide != null:
return slide(_that);case NodeContentDefinitionList() when definitionList != null:
return definitionList(_that);case NodeContentDefinitionItem() when definitionItem != null:
return definitionItem(_that);case NodeContentCitation() when citation != null:
return citation(_that);case NodeContentAdmonition() when admonition != null:
return admonition(_that);case NodeContentRawBlock() when rawBlock != null:
return rawBlock(_that);case NodeContentMetadataBlock() when metadataBlock != null:
return metadataBlock(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  title,TResult Function( int level,  String text)?  heading,TResult Function( String text)?  paragraph,TResult Function( bool ordered)?  list,TResult Function( String text)?  listItem,TResult Function( TableGrid grid)?  table,TResult Function( String? description, @JsonKey(name: 'image_index')  int? imageIndex,  String? src)?  image,TResult Function( String text,  String? language)?  code,TResult Function()?  quote,TResult Function( String text)?  formula,TResult Function( String text)?  footnote,TResult Function(@JsonKey(name: 'heading_level')  int? headingLevel, @JsonKey(name: 'heading_text')  String? headingText,  String? label)?  group,TResult Function()?  pageBreak,TResult Function( int number,  String? title)?  slide,TResult Function()?  definitionList,TResult Function( String term,  String definition)?  definitionItem,TResult Function( String key,  String text)?  citation,TResult Function( String kind,  String? title)?  admonition,TResult Function( String format,  String content)?  rawBlock,TResult Function( List<List<String>> entries)?  metadataBlock,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NodeContentTitle() when title != null:
return title(_that.text);case NodeContentHeading() when heading != null:
return heading(_that.level,_that.text);case NodeContentParagraph() when paragraph != null:
return paragraph(_that.text);case NodeContentList() when list != null:
return list(_that.ordered);case NodeContentListItem() when listItem != null:
return listItem(_that.text);case NodeContentTable() when table != null:
return table(_that.grid);case NodeContentImage() when image != null:
return image(_that.description,_that.imageIndex,_that.src);case NodeContentCode() when code != null:
return code(_that.text,_that.language);case NodeContentQuote() when quote != null:
return quote();case NodeContentFormula() when formula != null:
return formula(_that.text);case NodeContentFootnote() when footnote != null:
return footnote(_that.text);case NodeContentGroup() when group != null:
return group(_that.headingLevel,_that.headingText,_that.label);case NodeContentPageBreak() when pageBreak != null:
return pageBreak();case NodeContentSlide() when slide != null:
return slide(_that.number,_that.title);case NodeContentDefinitionList() when definitionList != null:
return definitionList();case NodeContentDefinitionItem() when definitionItem != null:
return definitionItem(_that.term,_that.definition);case NodeContentCitation() when citation != null:
return citation(_that.key,_that.text);case NodeContentAdmonition() when admonition != null:
return admonition(_that.kind,_that.title);case NodeContentRawBlock() when rawBlock != null:
return rawBlock(_that.format,_that.content);case NodeContentMetadataBlock() when metadataBlock != null:
return metadataBlock(_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  title,required TResult Function( int level,  String text)  heading,required TResult Function( String text)  paragraph,required TResult Function( bool ordered)  list,required TResult Function( String text)  listItem,required TResult Function( TableGrid grid)  table,required TResult Function( String? description, @JsonKey(name: 'image_index')  int? imageIndex,  String? src)  image,required TResult Function( String text,  String? language)  code,required TResult Function()  quote,required TResult Function( String text)  formula,required TResult Function( String text)  footnote,required TResult Function(@JsonKey(name: 'heading_level')  int? headingLevel, @JsonKey(name: 'heading_text')  String? headingText,  String? label)  group,required TResult Function()  pageBreak,required TResult Function( int number,  String? title)  slide,required TResult Function()  definitionList,required TResult Function( String term,  String definition)  definitionItem,required TResult Function( String key,  String text)  citation,required TResult Function( String kind,  String? title)  admonition,required TResult Function( String format,  String content)  rawBlock,required TResult Function( List<List<String>> entries)  metadataBlock,}) {final _that = this;
switch (_that) {
case NodeContentTitle():
return title(_that.text);case NodeContentHeading():
return heading(_that.level,_that.text);case NodeContentParagraph():
return paragraph(_that.text);case NodeContentList():
return list(_that.ordered);case NodeContentListItem():
return listItem(_that.text);case NodeContentTable():
return table(_that.grid);case NodeContentImage():
return image(_that.description,_that.imageIndex,_that.src);case NodeContentCode():
return code(_that.text,_that.language);case NodeContentQuote():
return quote();case NodeContentFormula():
return formula(_that.text);case NodeContentFootnote():
return footnote(_that.text);case NodeContentGroup():
return group(_that.headingLevel,_that.headingText,_that.label);case NodeContentPageBreak():
return pageBreak();case NodeContentSlide():
return slide(_that.number,_that.title);case NodeContentDefinitionList():
return definitionList();case NodeContentDefinitionItem():
return definitionItem(_that.term,_that.definition);case NodeContentCitation():
return citation(_that.key,_that.text);case NodeContentAdmonition():
return admonition(_that.kind,_that.title);case NodeContentRawBlock():
return rawBlock(_that.format,_that.content);case NodeContentMetadataBlock():
return metadataBlock(_that.entries);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  title,TResult? Function( int level,  String text)?  heading,TResult? Function( String text)?  paragraph,TResult? Function( bool ordered)?  list,TResult? Function( String text)?  listItem,TResult? Function( TableGrid grid)?  table,TResult? Function( String? description, @JsonKey(name: 'image_index')  int? imageIndex,  String? src)?  image,TResult? Function( String text,  String? language)?  code,TResult? Function()?  quote,TResult? Function( String text)?  formula,TResult? Function( String text)?  footnote,TResult? Function(@JsonKey(name: 'heading_level')  int? headingLevel, @JsonKey(name: 'heading_text')  String? headingText,  String? label)?  group,TResult? Function()?  pageBreak,TResult? Function( int number,  String? title)?  slide,TResult? Function()?  definitionList,TResult? Function( String term,  String definition)?  definitionItem,TResult? Function( String key,  String text)?  citation,TResult? Function( String kind,  String? title)?  admonition,TResult? Function( String format,  String content)?  rawBlock,TResult? Function( List<List<String>> entries)?  metadataBlock,}) {final _that = this;
switch (_that) {
case NodeContentTitle() when title != null:
return title(_that.text);case NodeContentHeading() when heading != null:
return heading(_that.level,_that.text);case NodeContentParagraph() when paragraph != null:
return paragraph(_that.text);case NodeContentList() when list != null:
return list(_that.ordered);case NodeContentListItem() when listItem != null:
return listItem(_that.text);case NodeContentTable() when table != null:
return table(_that.grid);case NodeContentImage() when image != null:
return image(_that.description,_that.imageIndex,_that.src);case NodeContentCode() when code != null:
return code(_that.text,_that.language);case NodeContentQuote() when quote != null:
return quote();case NodeContentFormula() when formula != null:
return formula(_that.text);case NodeContentFootnote() when footnote != null:
return footnote(_that.text);case NodeContentGroup() when group != null:
return group(_that.headingLevel,_that.headingText,_that.label);case NodeContentPageBreak() when pageBreak != null:
return pageBreak();case NodeContentSlide() when slide != null:
return slide(_that.number,_that.title);case NodeContentDefinitionList() when definitionList != null:
return definitionList();case NodeContentDefinitionItem() when definitionItem != null:
return definitionItem(_that.term,_that.definition);case NodeContentCitation() when citation != null:
return citation(_that.key,_that.text);case NodeContentAdmonition() when admonition != null:
return admonition(_that.kind,_that.title);case NodeContentRawBlock() when rawBlock != null:
return rawBlock(_that.format,_that.content);case NodeContentMetadataBlock() when metadataBlock != null:
return metadataBlock(_that.entries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class NodeContentTitle implements NodeContent {
  const NodeContentTitle({required this.text, final  String? $type}): $type = $type ?? 'title';
  factory NodeContentTitle.fromJson(Map<String, dynamic> json) => _$NodeContentTitleFromJson(json);

 final  String text;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentTitleCopyWith<NodeContentTitle> get copyWith => _$NodeContentTitleCopyWithImpl<NodeContentTitle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentTitleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentTitle&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'NodeContent.title(text: $text)';
}


}

/// @nodoc
abstract mixin class $NodeContentTitleCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentTitleCopyWith(NodeContentTitle value, $Res Function(NodeContentTitle) _then) = _$NodeContentTitleCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$NodeContentTitleCopyWithImpl<$Res>
    implements $NodeContentTitleCopyWith<$Res> {
  _$NodeContentTitleCopyWithImpl(this._self, this._then);

  final NodeContentTitle _self;
  final $Res Function(NodeContentTitle) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(NodeContentTitle(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentHeading implements NodeContent {
  const NodeContentHeading({required this.level, required this.text, final  String? $type}): $type = $type ?? 'heading';
  factory NodeContentHeading.fromJson(Map<String, dynamic> json) => _$NodeContentHeadingFromJson(json);

 final  int level;
 final  String text;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentHeadingCopyWith<NodeContentHeading> get copyWith => _$NodeContentHeadingCopyWithImpl<NodeContentHeading>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentHeadingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentHeading&&(identical(other.level, level) || other.level == level)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,text);

@override
String toString() {
  return 'NodeContent.heading(level: $level, text: $text)';
}


}

/// @nodoc
abstract mixin class $NodeContentHeadingCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentHeadingCopyWith(NodeContentHeading value, $Res Function(NodeContentHeading) _then) = _$NodeContentHeadingCopyWithImpl;
@useResult
$Res call({
 int level, String text
});




}
/// @nodoc
class _$NodeContentHeadingCopyWithImpl<$Res>
    implements $NodeContentHeadingCopyWith<$Res> {
  _$NodeContentHeadingCopyWithImpl(this._self, this._then);

  final NodeContentHeading _self;
  final $Res Function(NodeContentHeading) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? level = null,Object? text = null,}) {
  return _then(NodeContentHeading(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentParagraph implements NodeContent {
  const NodeContentParagraph({required this.text, final  String? $type}): $type = $type ?? 'paragraph';
  factory NodeContentParagraph.fromJson(Map<String, dynamic> json) => _$NodeContentParagraphFromJson(json);

 final  String text;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentParagraphCopyWith<NodeContentParagraph> get copyWith => _$NodeContentParagraphCopyWithImpl<NodeContentParagraph>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentParagraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentParagraph&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'NodeContent.paragraph(text: $text)';
}


}

/// @nodoc
abstract mixin class $NodeContentParagraphCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentParagraphCopyWith(NodeContentParagraph value, $Res Function(NodeContentParagraph) _then) = _$NodeContentParagraphCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$NodeContentParagraphCopyWithImpl<$Res>
    implements $NodeContentParagraphCopyWith<$Res> {
  _$NodeContentParagraphCopyWithImpl(this._self, this._then);

  final NodeContentParagraph _self;
  final $Res Function(NodeContentParagraph) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(NodeContentParagraph(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentList implements NodeContent {
  const NodeContentList({required this.ordered, final  String? $type}): $type = $type ?? 'list';
  factory NodeContentList.fromJson(Map<String, dynamic> json) => _$NodeContentListFromJson(json);

 final  bool ordered;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentListCopyWith<NodeContentList> get copyWith => _$NodeContentListCopyWithImpl<NodeContentList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentList&&(identical(other.ordered, ordered) || other.ordered == ordered));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ordered);

@override
String toString() {
  return 'NodeContent.list(ordered: $ordered)';
}


}

/// @nodoc
abstract mixin class $NodeContentListCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentListCopyWith(NodeContentList value, $Res Function(NodeContentList) _then) = _$NodeContentListCopyWithImpl;
@useResult
$Res call({
 bool ordered
});




}
/// @nodoc
class _$NodeContentListCopyWithImpl<$Res>
    implements $NodeContentListCopyWith<$Res> {
  _$NodeContentListCopyWithImpl(this._self, this._then);

  final NodeContentList _self;
  final $Res Function(NodeContentList) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ordered = null,}) {
  return _then(NodeContentList(
ordered: null == ordered ? _self.ordered : ordered // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentListItem implements NodeContent {
  const NodeContentListItem({required this.text, final  String? $type}): $type = $type ?? 'list_item';
  factory NodeContentListItem.fromJson(Map<String, dynamic> json) => _$NodeContentListItemFromJson(json);

 final  String text;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentListItemCopyWith<NodeContentListItem> get copyWith => _$NodeContentListItemCopyWithImpl<NodeContentListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentListItem&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'NodeContent.listItem(text: $text)';
}


}

/// @nodoc
abstract mixin class $NodeContentListItemCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentListItemCopyWith(NodeContentListItem value, $Res Function(NodeContentListItem) _then) = _$NodeContentListItemCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$NodeContentListItemCopyWithImpl<$Res>
    implements $NodeContentListItemCopyWith<$Res> {
  _$NodeContentListItemCopyWithImpl(this._self, this._then);

  final NodeContentListItem _self;
  final $Res Function(NodeContentListItem) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(NodeContentListItem(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentTable implements NodeContent {
  const NodeContentTable({required this.grid, final  String? $type}): $type = $type ?? 'table';
  factory NodeContentTable.fromJson(Map<String, dynamic> json) => _$NodeContentTableFromJson(json);

 final  TableGrid grid;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentTableCopyWith<NodeContentTable> get copyWith => _$NodeContentTableCopyWithImpl<NodeContentTable>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentTableToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentTable&&(identical(other.grid, grid) || other.grid == grid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grid);

@override
String toString() {
  return 'NodeContent.table(grid: $grid)';
}


}

/// @nodoc
abstract mixin class $NodeContentTableCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentTableCopyWith(NodeContentTable value, $Res Function(NodeContentTable) _then) = _$NodeContentTableCopyWithImpl;
@useResult
$Res call({
 TableGrid grid
});


$TableGridCopyWith<$Res> get grid;

}
/// @nodoc
class _$NodeContentTableCopyWithImpl<$Res>
    implements $NodeContentTableCopyWith<$Res> {
  _$NodeContentTableCopyWithImpl(this._self, this._then);

  final NodeContentTable _self;
  final $Res Function(NodeContentTable) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? grid = null,}) {
  return _then(NodeContentTable(
grid: null == grid ? _self.grid : grid // ignore: cast_nullable_to_non_nullable
as TableGrid,
  ));
}

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TableGridCopyWith<$Res> get grid {
  
  return $TableGridCopyWith<$Res>(_self.grid, (value) {
    return _then(_self.copyWith(grid: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class NodeContentImage implements NodeContent {
  const NodeContentImage({this.description, @JsonKey(name: 'image_index') this.imageIndex, this.src, final  String? $type}): $type = $type ?? 'image';
  factory NodeContentImage.fromJson(Map<String, dynamic> json) => _$NodeContentImageFromJson(json);

 final  String? description;
@JsonKey(name: 'image_index') final  int? imageIndex;
/// Source URL or path of the image (from `<img src="...">` or `![](src)`).
 final  String? src;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentImageCopyWith<NodeContentImage> get copyWith => _$NodeContentImageCopyWithImpl<NodeContentImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentImage&&(identical(other.description, description) || other.description == description)&&(identical(other.imageIndex, imageIndex) || other.imageIndex == imageIndex)&&(identical(other.src, src) || other.src == src));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,imageIndex,src);

@override
String toString() {
  return 'NodeContent.image(description: $description, imageIndex: $imageIndex, src: $src)';
}


}

/// @nodoc
abstract mixin class $NodeContentImageCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentImageCopyWith(NodeContentImage value, $Res Function(NodeContentImage) _then) = _$NodeContentImageCopyWithImpl;
@useResult
$Res call({
 String? description,@JsonKey(name: 'image_index') int? imageIndex, String? src
});




}
/// @nodoc
class _$NodeContentImageCopyWithImpl<$Res>
    implements $NodeContentImageCopyWith<$Res> {
  _$NodeContentImageCopyWithImpl(this._self, this._then);

  final NodeContentImage _self;
  final $Res Function(NodeContentImage) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? description = freezed,Object? imageIndex = freezed,Object? src = freezed,}) {
  return _then(NodeContentImage(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageIndex: freezed == imageIndex ? _self.imageIndex : imageIndex // ignore: cast_nullable_to_non_nullable
as int?,src: freezed == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentCode implements NodeContent {
  const NodeContentCode({required this.text, this.language, final  String? $type}): $type = $type ?? 'code';
  factory NodeContentCode.fromJson(Map<String, dynamic> json) => _$NodeContentCodeFromJson(json);

 final  String text;
 final  String? language;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentCodeCopyWith<NodeContentCode> get copyWith => _$NodeContentCodeCopyWithImpl<NodeContentCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentCode&&(identical(other.text, text) || other.text == text)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,language);

@override
String toString() {
  return 'NodeContent.code(text: $text, language: $language)';
}


}

/// @nodoc
abstract mixin class $NodeContentCodeCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentCodeCopyWith(NodeContentCode value, $Res Function(NodeContentCode) _then) = _$NodeContentCodeCopyWithImpl;
@useResult
$Res call({
 String text, String? language
});




}
/// @nodoc
class _$NodeContentCodeCopyWithImpl<$Res>
    implements $NodeContentCodeCopyWith<$Res> {
  _$NodeContentCodeCopyWithImpl(this._self, this._then);

  final NodeContentCode _self;
  final $Res Function(NodeContentCode) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? language = freezed,}) {
  return _then(NodeContentCode(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentQuote implements NodeContent {
  const NodeContentQuote({final  String? $type}): $type = $type ?? 'quote';
  factory NodeContentQuote.fromJson(Map<String, dynamic> json) => _$NodeContentQuoteFromJson(json);



@JsonKey(name: 'node_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NodeContentQuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentQuote);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NodeContent.quote()';
}


}




/// @nodoc
@JsonSerializable()

class NodeContentFormula implements NodeContent {
  const NodeContentFormula({required this.text, final  String? $type}): $type = $type ?? 'formula';
  factory NodeContentFormula.fromJson(Map<String, dynamic> json) => _$NodeContentFormulaFromJson(json);

 final  String text;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentFormulaCopyWith<NodeContentFormula> get copyWith => _$NodeContentFormulaCopyWithImpl<NodeContentFormula>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentFormulaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentFormula&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'NodeContent.formula(text: $text)';
}


}

/// @nodoc
abstract mixin class $NodeContentFormulaCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentFormulaCopyWith(NodeContentFormula value, $Res Function(NodeContentFormula) _then) = _$NodeContentFormulaCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$NodeContentFormulaCopyWithImpl<$Res>
    implements $NodeContentFormulaCopyWith<$Res> {
  _$NodeContentFormulaCopyWithImpl(this._self, this._then);

  final NodeContentFormula _self;
  final $Res Function(NodeContentFormula) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(NodeContentFormula(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentFootnote implements NodeContent {
  const NodeContentFootnote({required this.text, final  String? $type}): $type = $type ?? 'footnote';
  factory NodeContentFootnote.fromJson(Map<String, dynamic> json) => _$NodeContentFootnoteFromJson(json);

 final  String text;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentFootnoteCopyWith<NodeContentFootnote> get copyWith => _$NodeContentFootnoteCopyWithImpl<NodeContentFootnote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentFootnoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentFootnote&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'NodeContent.footnote(text: $text)';
}


}

/// @nodoc
abstract mixin class $NodeContentFootnoteCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentFootnoteCopyWith(NodeContentFootnote value, $Res Function(NodeContentFootnote) _then) = _$NodeContentFootnoteCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$NodeContentFootnoteCopyWithImpl<$Res>
    implements $NodeContentFootnoteCopyWith<$Res> {
  _$NodeContentFootnoteCopyWithImpl(this._self, this._then);

  final NodeContentFootnote _self;
  final $Res Function(NodeContentFootnote) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(NodeContentFootnote(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentGroup implements NodeContent {
  const NodeContentGroup({@JsonKey(name: 'heading_level') this.headingLevel, @JsonKey(name: 'heading_text') this.headingText, this.label, final  String? $type}): $type = $type ?? 'group';
  factory NodeContentGroup.fromJson(Map<String, dynamic> json) => _$NodeContentGroupFromJson(json);

@JsonKey(name: 'heading_level') final  int? headingLevel;
@JsonKey(name: 'heading_text') final  String? headingText;
 final  String? label;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentGroupCopyWith<NodeContentGroup> get copyWith => _$NodeContentGroupCopyWithImpl<NodeContentGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentGroup&&(identical(other.headingLevel, headingLevel) || other.headingLevel == headingLevel)&&(identical(other.headingText, headingText) || other.headingText == headingText)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,headingLevel,headingText,label);

@override
String toString() {
  return 'NodeContent.group(headingLevel: $headingLevel, headingText: $headingText, label: $label)';
}


}

/// @nodoc
abstract mixin class $NodeContentGroupCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentGroupCopyWith(NodeContentGroup value, $Res Function(NodeContentGroup) _then) = _$NodeContentGroupCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'heading_level') int? headingLevel,@JsonKey(name: 'heading_text') String? headingText, String? label
});




}
/// @nodoc
class _$NodeContentGroupCopyWithImpl<$Res>
    implements $NodeContentGroupCopyWith<$Res> {
  _$NodeContentGroupCopyWithImpl(this._self, this._then);

  final NodeContentGroup _self;
  final $Res Function(NodeContentGroup) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? headingLevel = freezed,Object? headingText = freezed,Object? label = freezed,}) {
  return _then(NodeContentGroup(
headingLevel: freezed == headingLevel ? _self.headingLevel : headingLevel // ignore: cast_nullable_to_non_nullable
as int?,headingText: freezed == headingText ? _self.headingText : headingText // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentPageBreak implements NodeContent {
  const NodeContentPageBreak({final  String? $type}): $type = $type ?? 'page_break';
  factory NodeContentPageBreak.fromJson(Map<String, dynamic> json) => _$NodeContentPageBreakFromJson(json);



@JsonKey(name: 'node_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NodeContentPageBreakToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentPageBreak);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NodeContent.pageBreak()';
}


}




/// @nodoc
@JsonSerializable()

class NodeContentSlide implements NodeContent {
  const NodeContentSlide({required this.number, this.title, final  String? $type}): $type = $type ?? 'slide';
  factory NodeContentSlide.fromJson(Map<String, dynamic> json) => _$NodeContentSlideFromJson(json);

/// 1-indexed slide number.
 final  int number;
 final  String? title;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentSlideCopyWith<NodeContentSlide> get copyWith => _$NodeContentSlideCopyWithImpl<NodeContentSlide>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentSlideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentSlide&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,title);

@override
String toString() {
  return 'NodeContent.slide(number: $number, title: $title)';
}


}

/// @nodoc
abstract mixin class $NodeContentSlideCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentSlideCopyWith(NodeContentSlide value, $Res Function(NodeContentSlide) _then) = _$NodeContentSlideCopyWithImpl;
@useResult
$Res call({
 int number, String? title
});




}
/// @nodoc
class _$NodeContentSlideCopyWithImpl<$Res>
    implements $NodeContentSlideCopyWith<$Res> {
  _$NodeContentSlideCopyWithImpl(this._self, this._then);

  final NodeContentSlide _self;
  final $Res Function(NodeContentSlide) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? number = null,Object? title = freezed,}) {
  return _then(NodeContentSlide(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentDefinitionList implements NodeContent {
  const NodeContentDefinitionList({final  String? $type}): $type = $type ?? 'definition_list';
  factory NodeContentDefinitionList.fromJson(Map<String, dynamic> json) => _$NodeContentDefinitionListFromJson(json);



@JsonKey(name: 'node_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$NodeContentDefinitionListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentDefinitionList);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NodeContent.definitionList()';
}


}




/// @nodoc
@JsonSerializable()

class NodeContentDefinitionItem implements NodeContent {
  const NodeContentDefinitionItem({required this.term, required this.definition, final  String? $type}): $type = $type ?? 'definition_item';
  factory NodeContentDefinitionItem.fromJson(Map<String, dynamic> json) => _$NodeContentDefinitionItemFromJson(json);

 final  String term;
 final  String definition;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentDefinitionItemCopyWith<NodeContentDefinitionItem> get copyWith => _$NodeContentDefinitionItemCopyWithImpl<NodeContentDefinitionItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentDefinitionItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentDefinitionItem&&(identical(other.term, term) || other.term == term)&&(identical(other.definition, definition) || other.definition == definition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,term,definition);

@override
String toString() {
  return 'NodeContent.definitionItem(term: $term, definition: $definition)';
}


}

/// @nodoc
abstract mixin class $NodeContentDefinitionItemCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentDefinitionItemCopyWith(NodeContentDefinitionItem value, $Res Function(NodeContentDefinitionItem) _then) = _$NodeContentDefinitionItemCopyWithImpl;
@useResult
$Res call({
 String term, String definition
});




}
/// @nodoc
class _$NodeContentDefinitionItemCopyWithImpl<$Res>
    implements $NodeContentDefinitionItemCopyWith<$Res> {
  _$NodeContentDefinitionItemCopyWithImpl(this._self, this._then);

  final NodeContentDefinitionItem _self;
  final $Res Function(NodeContentDefinitionItem) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? term = null,Object? definition = null,}) {
  return _then(NodeContentDefinitionItem(
term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentCitation implements NodeContent {
  const NodeContentCitation({required this.key, required this.text, final  String? $type}): $type = $type ?? 'citation';
  factory NodeContentCitation.fromJson(Map<String, dynamic> json) => _$NodeContentCitationFromJson(json);

 final  String key;
 final  String text;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentCitationCopyWith<NodeContentCitation> get copyWith => _$NodeContentCitationCopyWithImpl<NodeContentCitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentCitationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentCitation&&(identical(other.key, key) || other.key == key)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,text);

@override
String toString() {
  return 'NodeContent.citation(key: $key, text: $text)';
}


}

/// @nodoc
abstract mixin class $NodeContentCitationCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentCitationCopyWith(NodeContentCitation value, $Res Function(NodeContentCitation) _then) = _$NodeContentCitationCopyWithImpl;
@useResult
$Res call({
 String key, String text
});




}
/// @nodoc
class _$NodeContentCitationCopyWithImpl<$Res>
    implements $NodeContentCitationCopyWith<$Res> {
  _$NodeContentCitationCopyWithImpl(this._self, this._then);

  final NodeContentCitation _self;
  final $Res Function(NodeContentCitation) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? key = null,Object? text = null,}) {
  return _then(NodeContentCitation(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentAdmonition implements NodeContent {
  const NodeContentAdmonition({required this.kind, this.title, final  String? $type}): $type = $type ?? 'admonition';
  factory NodeContentAdmonition.fromJson(Map<String, dynamic> json) => _$NodeContentAdmonitionFromJson(json);

/// Kind of admonition (e.g. "note", "warning", "tip", "danger").
 final  String kind;
 final  String? title;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentAdmonitionCopyWith<NodeContentAdmonition> get copyWith => _$NodeContentAdmonitionCopyWithImpl<NodeContentAdmonition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentAdmonitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentAdmonition&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,title);

@override
String toString() {
  return 'NodeContent.admonition(kind: $kind, title: $title)';
}


}

/// @nodoc
abstract mixin class $NodeContentAdmonitionCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentAdmonitionCopyWith(NodeContentAdmonition value, $Res Function(NodeContentAdmonition) _then) = _$NodeContentAdmonitionCopyWithImpl;
@useResult
$Res call({
 String kind, String? title
});




}
/// @nodoc
class _$NodeContentAdmonitionCopyWithImpl<$Res>
    implements $NodeContentAdmonitionCopyWith<$Res> {
  _$NodeContentAdmonitionCopyWithImpl(this._self, this._then);

  final NodeContentAdmonition _self;
  final $Res Function(NodeContentAdmonition) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = freezed,}) {
  return _then(NodeContentAdmonition(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentRawBlock implements NodeContent {
  const NodeContentRawBlock({required this.format, required this.content, final  String? $type}): $type = $type ?? 'raw_block';
  factory NodeContentRawBlock.fromJson(Map<String, dynamic> json) => _$NodeContentRawBlockFromJson(json);

/// Source format identifier (e.g. "html", "latex", "jsx").
 final  String format;
 final  String content;

@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentRawBlockCopyWith<NodeContentRawBlock> get copyWith => _$NodeContentRawBlockCopyWithImpl<NodeContentRawBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentRawBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentRawBlock&&(identical(other.format, format) || other.format == format)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,content);

@override
String toString() {
  return 'NodeContent.rawBlock(format: $format, content: $content)';
}


}

/// @nodoc
abstract mixin class $NodeContentRawBlockCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentRawBlockCopyWith(NodeContentRawBlock value, $Res Function(NodeContentRawBlock) _then) = _$NodeContentRawBlockCopyWithImpl;
@useResult
$Res call({
 String format, String content
});




}
/// @nodoc
class _$NodeContentRawBlockCopyWithImpl<$Res>
    implements $NodeContentRawBlockCopyWith<$Res> {
  _$NodeContentRawBlockCopyWithImpl(this._self, this._then);

  final NodeContentRawBlock _self;
  final $Res Function(NodeContentRawBlock) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? format = null,Object? content = null,}) {
  return _then(NodeContentRawBlock(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NodeContentMetadataBlock implements NodeContent {
  const NodeContentMetadataBlock({required final  List<List<String>> entries, final  String? $type}): _entries = entries,$type = $type ?? 'metadata_block';
  factory NodeContentMetadataBlock.fromJson(Map<String, dynamic> json) => _$NodeContentMetadataBlockFromJson(json);

 final  List<List<String>> _entries;
 List<List<String>> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


@JsonKey(name: 'node_type')
final String $type;


/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodeContentMetadataBlockCopyWith<NodeContentMetadataBlock> get copyWith => _$NodeContentMetadataBlockCopyWithImpl<NodeContentMetadataBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodeContentMetadataBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodeContentMetadataBlock&&const DeepCollectionEquality().equals(other._entries, _entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'NodeContent.metadataBlock(entries: $entries)';
}


}

/// @nodoc
abstract mixin class $NodeContentMetadataBlockCopyWith<$Res> implements $NodeContentCopyWith<$Res> {
  factory $NodeContentMetadataBlockCopyWith(NodeContentMetadataBlock value, $Res Function(NodeContentMetadataBlock) _then) = _$NodeContentMetadataBlockCopyWithImpl;
@useResult
$Res call({
 List<List<String>> entries
});




}
/// @nodoc
class _$NodeContentMetadataBlockCopyWithImpl<$Res>
    implements $NodeContentMetadataBlockCopyWith<$Res> {
  _$NodeContentMetadataBlockCopyWithImpl(this._self, this._then);

  final NodeContentMetadataBlock _self;
  final $Res Function(NodeContentMetadataBlock) _then;

/// Create a copy of NodeContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? entries = null,}) {
  return _then(NodeContentMetadataBlock(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<List<String>>,
  ));
}


}

// dart format on
