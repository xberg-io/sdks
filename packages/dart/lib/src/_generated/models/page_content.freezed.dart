// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageContent {

/// Text content for this page
 String get content;/// Page number (1-indexed)
@JsonKey(name: 'page_number') int get pageNumber;/// Hierarchy information for the page (when hierarchy extraction is enabled).
///
/// Contains text hierarchy levels (H1-H6) extracted from the page content.
 PageHierarchy? get hierarchy;/// Indices into `ExtractionResult.images` for images found on this page.
///
/// Each value is a zero-based index into the top-level `images` collection.
/// Only populated when `extract_images = true` in the extraction config.
@JsonKey(name: 'image_indices') List<int>? get imageIndices;/// Whether this page is blank (no meaningful text content).
///
/// Determined during extraction based on text content analysis.
/// A page is blank if it has fewer than 3 non-whitespace characters.
/// and contains no tables or images.
@JsonKey(name: 'is_blank') bool? get isBlank;/// Layout detection regions for this page (when layout detection is enabled).
///
/// Contains detected layout regions with class, confidence, bounding box,.
/// and area fraction. Only populated when layout detection is configured.
@JsonKey(name: 'layout_regions') List<LayoutRegion>? get layoutRegions;/// Section name this slide belongs to (PPTX only).
///
/// PowerPoint sections group slides into logical chapters (`<p:sectionLst>` in.
/// `ppt/presentation.xml`). Only populated when the source is a PPTX file and.
/// the slide belongs to a named section.
@JsonKey(name: 'section_name') String? get sectionName;/// Sheet name for this page (XLSX/ODS only).
///
/// Each spreadsheet sheet maps to one `PageContent` entry. This field carries the.
/// sheet's display name as it appears in the workbook. `None` for all non-spreadsheet.
/// formats and for sheets with an empty name.
@JsonKey(name: 'sheet_name') String? get sheetName;/// Speaker notes for this slide (PPTX only).
///
/// Contains the text from the slide's notes pane (`ppt/notesSlides/notesSlide{N}.xml`).
/// Only populated when the source is a PPTX file and notes are present.
@JsonKey(name: 'speaker_notes') String? get speakerNotes;/// Tables found on this page (uses Arc for memory efficiency).
///
/// Serializes as Vec<Table> for JSON compatibility while maintaining.
/// Arc semantics in-memory for zero-copy sharing.
 List<Table>? get tables;
/// Create a copy of PageContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageContentCopyWith<PageContent> get copyWith => _$PageContentCopyWithImpl<PageContent>(this as PageContent, _$identity);

  /// Serializes this PageContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageContent&&(identical(other.content, content) || other.content == content)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.hierarchy, hierarchy) || other.hierarchy == hierarchy)&&const DeepCollectionEquality().equals(other.imageIndices, imageIndices)&&(identical(other.isBlank, isBlank) || other.isBlank == isBlank)&&const DeepCollectionEquality().equals(other.layoutRegions, layoutRegions)&&(identical(other.sectionName, sectionName) || other.sectionName == sectionName)&&(identical(other.sheetName, sheetName) || other.sheetName == sheetName)&&(identical(other.speakerNotes, speakerNotes) || other.speakerNotes == speakerNotes)&&const DeepCollectionEquality().equals(other.tables, tables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,pageNumber,hierarchy,const DeepCollectionEquality().hash(imageIndices),isBlank,const DeepCollectionEquality().hash(layoutRegions),sectionName,sheetName,speakerNotes,const DeepCollectionEquality().hash(tables));

@override
String toString() {
  return 'PageContent(content: $content, pageNumber: $pageNumber, hierarchy: $hierarchy, imageIndices: $imageIndices, isBlank: $isBlank, layoutRegions: $layoutRegions, sectionName: $sectionName, sheetName: $sheetName, speakerNotes: $speakerNotes, tables: $tables)';
}


}

/// @nodoc
abstract mixin class $PageContentCopyWith<$Res>  {
  factory $PageContentCopyWith(PageContent value, $Res Function(PageContent) _then) = _$PageContentCopyWithImpl;
@useResult
$Res call({
 String content,@JsonKey(name: 'page_number') int pageNumber, PageHierarchy? hierarchy,@JsonKey(name: 'image_indices') List<int>? imageIndices,@JsonKey(name: 'is_blank') bool? isBlank,@JsonKey(name: 'layout_regions') List<LayoutRegion>? layoutRegions,@JsonKey(name: 'section_name') String? sectionName,@JsonKey(name: 'sheet_name') String? sheetName,@JsonKey(name: 'speaker_notes') String? speakerNotes, List<Table>? tables
});


$PageHierarchyCopyWith<$Res>? get hierarchy;

}
/// @nodoc
class _$PageContentCopyWithImpl<$Res>
    implements $PageContentCopyWith<$Res> {
  _$PageContentCopyWithImpl(this._self, this._then);

  final PageContent _self;
  final $Res Function(PageContent) _then;

/// Create a copy of PageContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? pageNumber = null,Object? hierarchy = freezed,Object? imageIndices = freezed,Object? isBlank = freezed,Object? layoutRegions = freezed,Object? sectionName = freezed,Object? sheetName = freezed,Object? speakerNotes = freezed,Object? tables = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,hierarchy: freezed == hierarchy ? _self.hierarchy : hierarchy // ignore: cast_nullable_to_non_nullable
as PageHierarchy?,imageIndices: freezed == imageIndices ? _self.imageIndices : imageIndices // ignore: cast_nullable_to_non_nullable
as List<int>?,isBlank: freezed == isBlank ? _self.isBlank : isBlank // ignore: cast_nullable_to_non_nullable
as bool?,layoutRegions: freezed == layoutRegions ? _self.layoutRegions : layoutRegions // ignore: cast_nullable_to_non_nullable
as List<LayoutRegion>?,sectionName: freezed == sectionName ? _self.sectionName : sectionName // ignore: cast_nullable_to_non_nullable
as String?,sheetName: freezed == sheetName ? _self.sheetName : sheetName // ignore: cast_nullable_to_non_nullable
as String?,speakerNotes: freezed == speakerNotes ? _self.speakerNotes : speakerNotes // ignore: cast_nullable_to_non_nullable
as String?,tables: freezed == tables ? _self.tables : tables // ignore: cast_nullable_to_non_nullable
as List<Table>?,
  ));
}
/// Create a copy of PageContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PageHierarchyCopyWith<$Res>? get hierarchy {
    if (_self.hierarchy == null) {
    return null;
  }

  return $PageHierarchyCopyWith<$Res>(_self.hierarchy!, (value) {
    return _then(_self.copyWith(hierarchy: value));
  });
}
}


/// Adds pattern-matching-related methods to [PageContent].
extension PageContentPatterns on PageContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageContent() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageContent value)  $default,){
final _that = this;
switch (_that) {
case _PageContent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageContent value)?  $default,){
final _that = this;
switch (_that) {
case _PageContent() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content, @JsonKey(name: 'page_number')  int pageNumber,  PageHierarchy? hierarchy, @JsonKey(name: 'image_indices')  List<int>? imageIndices, @JsonKey(name: 'is_blank')  bool? isBlank, @JsonKey(name: 'layout_regions')  List<LayoutRegion>? layoutRegions, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'sheet_name')  String? sheetName, @JsonKey(name: 'speaker_notes')  String? speakerNotes,  List<Table>? tables)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageContent() when $default != null:
return $default(_that.content,_that.pageNumber,_that.hierarchy,_that.imageIndices,_that.isBlank,_that.layoutRegions,_that.sectionName,_that.sheetName,_that.speakerNotes,_that.tables);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content, @JsonKey(name: 'page_number')  int pageNumber,  PageHierarchy? hierarchy, @JsonKey(name: 'image_indices')  List<int>? imageIndices, @JsonKey(name: 'is_blank')  bool? isBlank, @JsonKey(name: 'layout_regions')  List<LayoutRegion>? layoutRegions, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'sheet_name')  String? sheetName, @JsonKey(name: 'speaker_notes')  String? speakerNotes,  List<Table>? tables)  $default,) {final _that = this;
switch (_that) {
case _PageContent():
return $default(_that.content,_that.pageNumber,_that.hierarchy,_that.imageIndices,_that.isBlank,_that.layoutRegions,_that.sectionName,_that.sheetName,_that.speakerNotes,_that.tables);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content, @JsonKey(name: 'page_number')  int pageNumber,  PageHierarchy? hierarchy, @JsonKey(name: 'image_indices')  List<int>? imageIndices, @JsonKey(name: 'is_blank')  bool? isBlank, @JsonKey(name: 'layout_regions')  List<LayoutRegion>? layoutRegions, @JsonKey(name: 'section_name')  String? sectionName, @JsonKey(name: 'sheet_name')  String? sheetName, @JsonKey(name: 'speaker_notes')  String? speakerNotes,  List<Table>? tables)?  $default,) {final _that = this;
switch (_that) {
case _PageContent() when $default != null:
return $default(_that.content,_that.pageNumber,_that.hierarchy,_that.imageIndices,_that.isBlank,_that.layoutRegions,_that.sectionName,_that.sheetName,_that.speakerNotes,_that.tables);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageContent implements PageContent {
  const _PageContent({required this.content, @JsonKey(name: 'page_number') required this.pageNumber, this.hierarchy, @JsonKey(name: 'image_indices') final  List<int>? imageIndices, @JsonKey(name: 'is_blank') this.isBlank, @JsonKey(name: 'layout_regions') final  List<LayoutRegion>? layoutRegions, @JsonKey(name: 'section_name') this.sectionName, @JsonKey(name: 'sheet_name') this.sheetName, @JsonKey(name: 'speaker_notes') this.speakerNotes, final  List<Table>? tables}): _imageIndices = imageIndices,_layoutRegions = layoutRegions,_tables = tables;
  factory _PageContent.fromJson(Map<String, dynamic> json) => _$PageContentFromJson(json);

/// Text content for this page
@override final  String content;
/// Page number (1-indexed)
@override@JsonKey(name: 'page_number') final  int pageNumber;
/// Hierarchy information for the page (when hierarchy extraction is enabled).
///
/// Contains text hierarchy levels (H1-H6) extracted from the page content.
@override final  PageHierarchy? hierarchy;
/// Indices into `ExtractionResult.images` for images found on this page.
///
/// Each value is a zero-based index into the top-level `images` collection.
/// Only populated when `extract_images = true` in the extraction config.
 final  List<int>? _imageIndices;
/// Indices into `ExtractionResult.images` for images found on this page.
///
/// Each value is a zero-based index into the top-level `images` collection.
/// Only populated when `extract_images = true` in the extraction config.
@override@JsonKey(name: 'image_indices') List<int>? get imageIndices {
  final value = _imageIndices;
  if (value == null) return null;
  if (_imageIndices is EqualUnmodifiableListView) return _imageIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Whether this page is blank (no meaningful text content).
///
/// Determined during extraction based on text content analysis.
/// A page is blank if it has fewer than 3 non-whitespace characters.
/// and contains no tables or images.
@override@JsonKey(name: 'is_blank') final  bool? isBlank;
/// Layout detection regions for this page (when layout detection is enabled).
///
/// Contains detected layout regions with class, confidence, bounding box,.
/// and area fraction. Only populated when layout detection is configured.
 final  List<LayoutRegion>? _layoutRegions;
/// Layout detection regions for this page (when layout detection is enabled).
///
/// Contains detected layout regions with class, confidence, bounding box,.
/// and area fraction. Only populated when layout detection is configured.
@override@JsonKey(name: 'layout_regions') List<LayoutRegion>? get layoutRegions {
  final value = _layoutRegions;
  if (value == null) return null;
  if (_layoutRegions is EqualUnmodifiableListView) return _layoutRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Section name this slide belongs to (PPTX only).
///
/// PowerPoint sections group slides into logical chapters (`<p:sectionLst>` in.
/// `ppt/presentation.xml`). Only populated when the source is a PPTX file and.
/// the slide belongs to a named section.
@override@JsonKey(name: 'section_name') final  String? sectionName;
/// Sheet name for this page (XLSX/ODS only).
///
/// Each spreadsheet sheet maps to one `PageContent` entry. This field carries the.
/// sheet's display name as it appears in the workbook. `None` for all non-spreadsheet.
/// formats and for sheets with an empty name.
@override@JsonKey(name: 'sheet_name') final  String? sheetName;
/// Speaker notes for this slide (PPTX only).
///
/// Contains the text from the slide's notes pane (`ppt/notesSlides/notesSlide{N}.xml`).
/// Only populated when the source is a PPTX file and notes are present.
@override@JsonKey(name: 'speaker_notes') final  String? speakerNotes;
/// Tables found on this page (uses Arc for memory efficiency).
///
/// Serializes as Vec<Table> for JSON compatibility while maintaining.
/// Arc semantics in-memory for zero-copy sharing.
 final  List<Table>? _tables;
/// Tables found on this page (uses Arc for memory efficiency).
///
/// Serializes as Vec<Table> for JSON compatibility while maintaining.
/// Arc semantics in-memory for zero-copy sharing.
@override List<Table>? get tables {
  final value = _tables;
  if (value == null) return null;
  if (_tables is EqualUnmodifiableListView) return _tables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PageContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageContentCopyWith<_PageContent> get copyWith => __$PageContentCopyWithImpl<_PageContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageContent&&(identical(other.content, content) || other.content == content)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.hierarchy, hierarchy) || other.hierarchy == hierarchy)&&const DeepCollectionEquality().equals(other._imageIndices, _imageIndices)&&(identical(other.isBlank, isBlank) || other.isBlank == isBlank)&&const DeepCollectionEquality().equals(other._layoutRegions, _layoutRegions)&&(identical(other.sectionName, sectionName) || other.sectionName == sectionName)&&(identical(other.sheetName, sheetName) || other.sheetName == sheetName)&&(identical(other.speakerNotes, speakerNotes) || other.speakerNotes == speakerNotes)&&const DeepCollectionEquality().equals(other._tables, _tables));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,pageNumber,hierarchy,const DeepCollectionEquality().hash(_imageIndices),isBlank,const DeepCollectionEquality().hash(_layoutRegions),sectionName,sheetName,speakerNotes,const DeepCollectionEquality().hash(_tables));

@override
String toString() {
  return 'PageContent(content: $content, pageNumber: $pageNumber, hierarchy: $hierarchy, imageIndices: $imageIndices, isBlank: $isBlank, layoutRegions: $layoutRegions, sectionName: $sectionName, sheetName: $sheetName, speakerNotes: $speakerNotes, tables: $tables)';
}


}

/// @nodoc
abstract mixin class _$PageContentCopyWith<$Res> implements $PageContentCopyWith<$Res> {
  factory _$PageContentCopyWith(_PageContent value, $Res Function(_PageContent) _then) = __$PageContentCopyWithImpl;
@override @useResult
$Res call({
 String content,@JsonKey(name: 'page_number') int pageNumber, PageHierarchy? hierarchy,@JsonKey(name: 'image_indices') List<int>? imageIndices,@JsonKey(name: 'is_blank') bool? isBlank,@JsonKey(name: 'layout_regions') List<LayoutRegion>? layoutRegions,@JsonKey(name: 'section_name') String? sectionName,@JsonKey(name: 'sheet_name') String? sheetName,@JsonKey(name: 'speaker_notes') String? speakerNotes, List<Table>? tables
});


@override $PageHierarchyCopyWith<$Res>? get hierarchy;

}
/// @nodoc
class __$PageContentCopyWithImpl<$Res>
    implements _$PageContentCopyWith<$Res> {
  __$PageContentCopyWithImpl(this._self, this._then);

  final _PageContent _self;
  final $Res Function(_PageContent) _then;

/// Create a copy of PageContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? pageNumber = null,Object? hierarchy = freezed,Object? imageIndices = freezed,Object? isBlank = freezed,Object? layoutRegions = freezed,Object? sectionName = freezed,Object? sheetName = freezed,Object? speakerNotes = freezed,Object? tables = freezed,}) {
  return _then(_PageContent(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,hierarchy: freezed == hierarchy ? _self.hierarchy : hierarchy // ignore: cast_nullable_to_non_nullable
as PageHierarchy?,imageIndices: freezed == imageIndices ? _self._imageIndices : imageIndices // ignore: cast_nullable_to_non_nullable
as List<int>?,isBlank: freezed == isBlank ? _self.isBlank : isBlank // ignore: cast_nullable_to_non_nullable
as bool?,layoutRegions: freezed == layoutRegions ? _self._layoutRegions : layoutRegions // ignore: cast_nullable_to_non_nullable
as List<LayoutRegion>?,sectionName: freezed == sectionName ? _self.sectionName : sectionName // ignore: cast_nullable_to_non_nullable
as String?,sheetName: freezed == sheetName ? _self.sheetName : sheetName // ignore: cast_nullable_to_non_nullable
as String?,speakerNotes: freezed == speakerNotes ? _self.speakerNotes : speakerNotes // ignore: cast_nullable_to_non_nullable
as String?,tables: freezed == tables ? _self._tables : tables // ignore: cast_nullable_to_non_nullable
as List<Table>?,
  ));
}

/// Create a copy of PageContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PageHierarchyCopyWith<$Res>? get hierarchy {
    if (_self.hierarchy == null) {
    return null;
  }

  return $PageHierarchyCopyWith<$Res>(_self.hierarchy!, (value) {
    return _then(_self.copyWith(hierarchy: value));
  });
}
}

// dart format on
