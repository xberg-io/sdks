// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageInfo {

/// Page number (1-indexed)
 int get number;/// Dimensions in points (PDF) or pixels (images): (width, height)
 List<double>? get dimensions;/// Whether this page contains non-trivial vector graphics (paths, shapes, curves).
///
/// Indicates the presence of vector-drawn content such as charts, diagrams,.
/// or geometric shapes (e.g., from Adobe InDesign, LaTeX TikZ). These are.
/// invisible to `ExtractionResult.images` since they are not embedded as raster.
/// XObjects. Set to `true` when path count exceeds a heuristic threshold,.
/// signaling that downstream consumers may want to rasterize the page to.
/// capture this content.
///
/// Only populated for PDFs; `None` for other document types.
@JsonKey(name: 'has_vector_graphics') bool? get hasVectorGraphics;/// Whether this page is hidden (e.g., in presentations)
 bool? get hidden;/// Number of images on this page
@JsonKey(name: 'image_count') int? get imageCount;/// Whether this page is blank (no meaningful text, no images, no tables).
///
/// A page is considered blank if it has fewer than 3 non-whitespace characters.
/// and contains no tables or images. This is useful for filtering out empty pages.
/// in scanned documents or PDFs with blank separator pages.
@JsonKey(name: 'is_blank') bool? get isBlank;/// Number of tables on this page
@JsonKey(name: 'table_count') int? get tableCount;/// Page title (usually for presentations)
 String? get title;
/// Create a copy of PageInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageInfoCopyWith<PageInfo> get copyWith => _$PageInfoCopyWithImpl<PageInfo>(this as PageInfo, _$identity);

  /// Serializes this PageInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageInfo&&(identical(other.number, number) || other.number == number)&&const DeepCollectionEquality().equals(other.dimensions, dimensions)&&(identical(other.hasVectorGraphics, hasVectorGraphics) || other.hasVectorGraphics == hasVectorGraphics)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.isBlank, isBlank) || other.isBlank == isBlank)&&(identical(other.tableCount, tableCount) || other.tableCount == tableCount)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,const DeepCollectionEquality().hash(dimensions),hasVectorGraphics,hidden,imageCount,isBlank,tableCount,title);

@override
String toString() {
  return 'PageInfo(number: $number, dimensions: $dimensions, hasVectorGraphics: $hasVectorGraphics, hidden: $hidden, imageCount: $imageCount, isBlank: $isBlank, tableCount: $tableCount, title: $title)';
}


}

/// @nodoc
abstract mixin class $PageInfoCopyWith<$Res>  {
  factory $PageInfoCopyWith(PageInfo value, $Res Function(PageInfo) _then) = _$PageInfoCopyWithImpl;
@useResult
$Res call({
 int number, List<double>? dimensions,@JsonKey(name: 'has_vector_graphics') bool? hasVectorGraphics, bool? hidden,@JsonKey(name: 'image_count') int? imageCount,@JsonKey(name: 'is_blank') bool? isBlank,@JsonKey(name: 'table_count') int? tableCount, String? title
});




}
/// @nodoc
class _$PageInfoCopyWithImpl<$Res>
    implements $PageInfoCopyWith<$Res> {
  _$PageInfoCopyWithImpl(this._self, this._then);

  final PageInfo _self;
  final $Res Function(PageInfo) _then;

/// Create a copy of PageInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? dimensions = freezed,Object? hasVectorGraphics = freezed,Object? hidden = freezed,Object? imageCount = freezed,Object? isBlank = freezed,Object? tableCount = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<double>?,hasVectorGraphics: freezed == hasVectorGraphics ? _self.hasVectorGraphics : hasVectorGraphics // ignore: cast_nullable_to_non_nullable
as bool?,hidden: freezed == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool?,imageCount: freezed == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int?,isBlank: freezed == isBlank ? _self.isBlank : isBlank // ignore: cast_nullable_to_non_nullable
as bool?,tableCount: freezed == tableCount ? _self.tableCount : tableCount // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PageInfo].
extension PageInfoPatterns on PageInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageInfo value)  $default,){
final _that = this;
switch (_that) {
case _PageInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PageInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  List<double>? dimensions, @JsonKey(name: 'has_vector_graphics')  bool? hasVectorGraphics,  bool? hidden, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'is_blank')  bool? isBlank, @JsonKey(name: 'table_count')  int? tableCount,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageInfo() when $default != null:
return $default(_that.number,_that.dimensions,_that.hasVectorGraphics,_that.hidden,_that.imageCount,_that.isBlank,_that.tableCount,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  List<double>? dimensions, @JsonKey(name: 'has_vector_graphics')  bool? hasVectorGraphics,  bool? hidden, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'is_blank')  bool? isBlank, @JsonKey(name: 'table_count')  int? tableCount,  String? title)  $default,) {final _that = this;
switch (_that) {
case _PageInfo():
return $default(_that.number,_that.dimensions,_that.hasVectorGraphics,_that.hidden,_that.imageCount,_that.isBlank,_that.tableCount,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  List<double>? dimensions, @JsonKey(name: 'has_vector_graphics')  bool? hasVectorGraphics,  bool? hidden, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'is_blank')  bool? isBlank, @JsonKey(name: 'table_count')  int? tableCount,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _PageInfo() when $default != null:
return $default(_that.number,_that.dimensions,_that.hasVectorGraphics,_that.hidden,_that.imageCount,_that.isBlank,_that.tableCount,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageInfo implements PageInfo {
  const _PageInfo({required this.number, final  List<double>? dimensions, @JsonKey(name: 'has_vector_graphics') this.hasVectorGraphics, this.hidden, @JsonKey(name: 'image_count') this.imageCount, @JsonKey(name: 'is_blank') this.isBlank, @JsonKey(name: 'table_count') this.tableCount, this.title}): _dimensions = dimensions;
  factory _PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);

/// Page number (1-indexed)
@override final  int number;
/// Dimensions in points (PDF) or pixels (images): (width, height)
 final  List<double>? _dimensions;
/// Dimensions in points (PDF) or pixels (images): (width, height)
@override List<double>? get dimensions {
  final value = _dimensions;
  if (value == null) return null;
  if (_dimensions is EqualUnmodifiableListView) return _dimensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Whether this page contains non-trivial vector graphics (paths, shapes, curves).
///
/// Indicates the presence of vector-drawn content such as charts, diagrams,.
/// or geometric shapes (e.g., from Adobe InDesign, LaTeX TikZ). These are.
/// invisible to `ExtractionResult.images` since they are not embedded as raster.
/// XObjects. Set to `true` when path count exceeds a heuristic threshold,.
/// signaling that downstream consumers may want to rasterize the page to.
/// capture this content.
///
/// Only populated for PDFs; `None` for other document types.
@override@JsonKey(name: 'has_vector_graphics') final  bool? hasVectorGraphics;
/// Whether this page is hidden (e.g., in presentations)
@override final  bool? hidden;
/// Number of images on this page
@override@JsonKey(name: 'image_count') final  int? imageCount;
/// Whether this page is blank (no meaningful text, no images, no tables).
///
/// A page is considered blank if it has fewer than 3 non-whitespace characters.
/// and contains no tables or images. This is useful for filtering out empty pages.
/// in scanned documents or PDFs with blank separator pages.
@override@JsonKey(name: 'is_blank') final  bool? isBlank;
/// Number of tables on this page
@override@JsonKey(name: 'table_count') final  int? tableCount;
/// Page title (usually for presentations)
@override final  String? title;

/// Create a copy of PageInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageInfoCopyWith<_PageInfo> get copyWith => __$PageInfoCopyWithImpl<_PageInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageInfo&&(identical(other.number, number) || other.number == number)&&const DeepCollectionEquality().equals(other._dimensions, _dimensions)&&(identical(other.hasVectorGraphics, hasVectorGraphics) || other.hasVectorGraphics == hasVectorGraphics)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.isBlank, isBlank) || other.isBlank == isBlank)&&(identical(other.tableCount, tableCount) || other.tableCount == tableCount)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,number,const DeepCollectionEquality().hash(_dimensions),hasVectorGraphics,hidden,imageCount,isBlank,tableCount,title);

@override
String toString() {
  return 'PageInfo(number: $number, dimensions: $dimensions, hasVectorGraphics: $hasVectorGraphics, hidden: $hidden, imageCount: $imageCount, isBlank: $isBlank, tableCount: $tableCount, title: $title)';
}


}

/// @nodoc
abstract mixin class _$PageInfoCopyWith<$Res> implements $PageInfoCopyWith<$Res> {
  factory _$PageInfoCopyWith(_PageInfo value, $Res Function(_PageInfo) _then) = __$PageInfoCopyWithImpl;
@override @useResult
$Res call({
 int number, List<double>? dimensions,@JsonKey(name: 'has_vector_graphics') bool? hasVectorGraphics, bool? hidden,@JsonKey(name: 'image_count') int? imageCount,@JsonKey(name: 'is_blank') bool? isBlank,@JsonKey(name: 'table_count') int? tableCount, String? title
});




}
/// @nodoc
class __$PageInfoCopyWithImpl<$Res>
    implements _$PageInfoCopyWith<$Res> {
  __$PageInfoCopyWithImpl(this._self, this._then);

  final _PageInfo _self;
  final $Res Function(_PageInfo) _then;

/// Create a copy of PageInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? dimensions = freezed,Object? hasVectorGraphics = freezed,Object? hidden = freezed,Object? imageCount = freezed,Object? isBlank = freezed,Object? tableCount = freezed,Object? title = freezed,}) {
  return _then(_PageInfo(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,dimensions: freezed == dimensions ? _self._dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<double>?,hasVectorGraphics: freezed == hasVectorGraphics ? _self.hasVectorGraphics : hasVectorGraphics // ignore: cast_nullable_to_non_nullable
as bool?,hidden: freezed == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool?,imageCount: freezed == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int?,isBlank: freezed == isBlank ? _self.isBlank : isBlank // ignore: cast_nullable_to_non_nullable
as bool?,tableCount: freezed == tableCount ? _self.tableCount : tableCount // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
