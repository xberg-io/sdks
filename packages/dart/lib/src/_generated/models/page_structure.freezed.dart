// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_structure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageStructure {

/// Total number of pages/slides/sheets
@JsonKey(name: 'total_count') int get totalCount;/// Type of paginated unit
@JsonKey(name: 'unit_type') PageUnitType get unitType;/// Character offset boundaries for each page.
///
/// Maps character ranges in the extracted content to page numbers.
/// Used for chunk page range calculation.
 List<PageBoundary>? get boundaries;/// Detailed per-page metadata (optional, only when needed)
 List<PageInfo>? get pages;
/// Create a copy of PageStructure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageStructureCopyWith<PageStructure> get copyWith => _$PageStructureCopyWithImpl<PageStructure>(this as PageStructure, _$identity);

  /// Serializes this PageStructure to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageStructure&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.unitType, unitType) || other.unitType == unitType)&&const DeepCollectionEquality().equals(other.boundaries, boundaries)&&const DeepCollectionEquality().equals(other.pages, pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,unitType,const DeepCollectionEquality().hash(boundaries),const DeepCollectionEquality().hash(pages));

@override
String toString() {
  return 'PageStructure(totalCount: $totalCount, unitType: $unitType, boundaries: $boundaries, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $PageStructureCopyWith<$Res>  {
  factory $PageStructureCopyWith(PageStructure value, $Res Function(PageStructure) _then) = _$PageStructureCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_count') int totalCount,@JsonKey(name: 'unit_type') PageUnitType unitType, List<PageBoundary>? boundaries, List<PageInfo>? pages
});




}
/// @nodoc
class _$PageStructureCopyWithImpl<$Res>
    implements $PageStructureCopyWith<$Res> {
  _$PageStructureCopyWithImpl(this._self, this._then);

  final PageStructure _self;
  final $Res Function(PageStructure) _then;

/// Create a copy of PageStructure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? unitType = null,Object? boundaries = freezed,Object? pages = freezed,}) {
  return _then(_self.copyWith(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,unitType: null == unitType ? _self.unitType : unitType // ignore: cast_nullable_to_non_nullable
as PageUnitType,boundaries: freezed == boundaries ? _self.boundaries : boundaries // ignore: cast_nullable_to_non_nullable
as List<PageBoundary>?,pages: freezed == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as List<PageInfo>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PageStructure].
extension PageStructurePatterns on PageStructure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageStructure value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageStructure() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageStructure value)  $default,){
final _that = this;
switch (_that) {
case _PageStructure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageStructure value)?  $default,){
final _that = this;
switch (_that) {
case _PageStructure() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_count')  int totalCount, @JsonKey(name: 'unit_type')  PageUnitType unitType,  List<PageBoundary>? boundaries,  List<PageInfo>? pages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageStructure() when $default != null:
return $default(_that.totalCount,_that.unitType,_that.boundaries,_that.pages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_count')  int totalCount, @JsonKey(name: 'unit_type')  PageUnitType unitType,  List<PageBoundary>? boundaries,  List<PageInfo>? pages)  $default,) {final _that = this;
switch (_that) {
case _PageStructure():
return $default(_that.totalCount,_that.unitType,_that.boundaries,_that.pages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_count')  int totalCount, @JsonKey(name: 'unit_type')  PageUnitType unitType,  List<PageBoundary>? boundaries,  List<PageInfo>? pages)?  $default,) {final _that = this;
switch (_that) {
case _PageStructure() when $default != null:
return $default(_that.totalCount,_that.unitType,_that.boundaries,_that.pages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageStructure implements PageStructure {
  const _PageStructure({@JsonKey(name: 'total_count') required this.totalCount, @JsonKey(name: 'unit_type') required this.unitType, final  List<PageBoundary>? boundaries, final  List<PageInfo>? pages}): _boundaries = boundaries,_pages = pages;
  factory _PageStructure.fromJson(Map<String, dynamic> json) => _$PageStructureFromJson(json);

/// Total number of pages/slides/sheets
@override@JsonKey(name: 'total_count') final  int totalCount;
/// Type of paginated unit
@override@JsonKey(name: 'unit_type') final  PageUnitType unitType;
/// Character offset boundaries for each page.
///
/// Maps character ranges in the extracted content to page numbers.
/// Used for chunk page range calculation.
 final  List<PageBoundary>? _boundaries;
/// Character offset boundaries for each page.
///
/// Maps character ranges in the extracted content to page numbers.
/// Used for chunk page range calculation.
@override List<PageBoundary>? get boundaries {
  final value = _boundaries;
  if (value == null) return null;
  if (_boundaries is EqualUnmodifiableListView) return _boundaries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Detailed per-page metadata (optional, only when needed)
 final  List<PageInfo>? _pages;
/// Detailed per-page metadata (optional, only when needed)
@override List<PageInfo>? get pages {
  final value = _pages;
  if (value == null) return null;
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PageStructure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageStructureCopyWith<_PageStructure> get copyWith => __$PageStructureCopyWithImpl<_PageStructure>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageStructureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageStructure&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.unitType, unitType) || other.unitType == unitType)&&const DeepCollectionEquality().equals(other._boundaries, _boundaries)&&const DeepCollectionEquality().equals(other._pages, _pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCount,unitType,const DeepCollectionEquality().hash(_boundaries),const DeepCollectionEquality().hash(_pages));

@override
String toString() {
  return 'PageStructure(totalCount: $totalCount, unitType: $unitType, boundaries: $boundaries, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$PageStructureCopyWith<$Res> implements $PageStructureCopyWith<$Res> {
  factory _$PageStructureCopyWith(_PageStructure value, $Res Function(_PageStructure) _then) = __$PageStructureCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_count') int totalCount,@JsonKey(name: 'unit_type') PageUnitType unitType, List<PageBoundary>? boundaries, List<PageInfo>? pages
});




}
/// @nodoc
class __$PageStructureCopyWithImpl<$Res>
    implements _$PageStructureCopyWith<$Res> {
  __$PageStructureCopyWithImpl(this._self, this._then);

  final _PageStructure _self;
  final $Res Function(_PageStructure) _then;

/// Create a copy of PageStructure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? unitType = null,Object? boundaries = freezed,Object? pages = freezed,}) {
  return _then(_PageStructure(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,unitType: null == unitType ? _self.unitType : unitType // ignore: cast_nullable_to_non_nullable
as PageUnitType,boundaries: freezed == boundaries ? _self._boundaries : boundaries // ignore: cast_nullable_to_non_nullable
as List<PageBoundary>?,pages: freezed == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<PageInfo>?,
  ));
}


}

// dart format on
