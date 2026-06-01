// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pptx_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PptxMetadata {

/// Total number of slides in the presentation
@JsonKey(name: 'slide_count') int get slideCount;/// Names of slides (if available)
@JsonKey(name: 'slide_names') List<String> get slideNames;/// Number of embedded images
@JsonKey(name: 'image_count') int? get imageCount;/// Number of tables
@JsonKey(name: 'table_count') int? get tableCount;
/// Create a copy of PptxMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PptxMetadataCopyWith<PptxMetadata> get copyWith => _$PptxMetadataCopyWithImpl<PptxMetadata>(this as PptxMetadata, _$identity);

  /// Serializes this PptxMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PptxMetadata&&(identical(other.slideCount, slideCount) || other.slideCount == slideCount)&&const DeepCollectionEquality().equals(other.slideNames, slideNames)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.tableCount, tableCount) || other.tableCount == tableCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slideCount,const DeepCollectionEquality().hash(slideNames),imageCount,tableCount);

@override
String toString() {
  return 'PptxMetadata(slideCount: $slideCount, slideNames: $slideNames, imageCount: $imageCount, tableCount: $tableCount)';
}


}

/// @nodoc
abstract mixin class $PptxMetadataCopyWith<$Res>  {
  factory $PptxMetadataCopyWith(PptxMetadata value, $Res Function(PptxMetadata) _then) = _$PptxMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'slide_count') int slideCount,@JsonKey(name: 'slide_names') List<String> slideNames,@JsonKey(name: 'image_count') int? imageCount,@JsonKey(name: 'table_count') int? tableCount
});




}
/// @nodoc
class _$PptxMetadataCopyWithImpl<$Res>
    implements $PptxMetadataCopyWith<$Res> {
  _$PptxMetadataCopyWithImpl(this._self, this._then);

  final PptxMetadata _self;
  final $Res Function(PptxMetadata) _then;

/// Create a copy of PptxMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slideCount = null,Object? slideNames = null,Object? imageCount = freezed,Object? tableCount = freezed,}) {
  return _then(_self.copyWith(
slideCount: null == slideCount ? _self.slideCount : slideCount // ignore: cast_nullable_to_non_nullable
as int,slideNames: null == slideNames ? _self.slideNames : slideNames // ignore: cast_nullable_to_non_nullable
as List<String>,imageCount: freezed == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int?,tableCount: freezed == tableCount ? _self.tableCount : tableCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PptxMetadata].
extension PptxMetadataPatterns on PptxMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PptxMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PptxMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PptxMetadata value)  $default,){
final _that = this;
switch (_that) {
case _PptxMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PptxMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _PptxMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'slide_count')  int slideCount, @JsonKey(name: 'slide_names')  List<String> slideNames, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'table_count')  int? tableCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PptxMetadata() when $default != null:
return $default(_that.slideCount,_that.slideNames,_that.imageCount,_that.tableCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'slide_count')  int slideCount, @JsonKey(name: 'slide_names')  List<String> slideNames, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'table_count')  int? tableCount)  $default,) {final _that = this;
switch (_that) {
case _PptxMetadata():
return $default(_that.slideCount,_that.slideNames,_that.imageCount,_that.tableCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'slide_count')  int slideCount, @JsonKey(name: 'slide_names')  List<String> slideNames, @JsonKey(name: 'image_count')  int? imageCount, @JsonKey(name: 'table_count')  int? tableCount)?  $default,) {final _that = this;
switch (_that) {
case _PptxMetadata() when $default != null:
return $default(_that.slideCount,_that.slideNames,_that.imageCount,_that.tableCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PptxMetadata implements PptxMetadata {
  const _PptxMetadata({@JsonKey(name: 'slide_count') required this.slideCount, @JsonKey(name: 'slide_names') required final  List<String> slideNames, @JsonKey(name: 'image_count') this.imageCount, @JsonKey(name: 'table_count') this.tableCount}): _slideNames = slideNames;
  factory _PptxMetadata.fromJson(Map<String, dynamic> json) => _$PptxMetadataFromJson(json);

/// Total number of slides in the presentation
@override@JsonKey(name: 'slide_count') final  int slideCount;
/// Names of slides (if available)
 final  List<String> _slideNames;
/// Names of slides (if available)
@override@JsonKey(name: 'slide_names') List<String> get slideNames {
  if (_slideNames is EqualUnmodifiableListView) return _slideNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slideNames);
}

/// Number of embedded images
@override@JsonKey(name: 'image_count') final  int? imageCount;
/// Number of tables
@override@JsonKey(name: 'table_count') final  int? tableCount;

/// Create a copy of PptxMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PptxMetadataCopyWith<_PptxMetadata> get copyWith => __$PptxMetadataCopyWithImpl<_PptxMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PptxMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PptxMetadata&&(identical(other.slideCount, slideCount) || other.slideCount == slideCount)&&const DeepCollectionEquality().equals(other._slideNames, _slideNames)&&(identical(other.imageCount, imageCount) || other.imageCount == imageCount)&&(identical(other.tableCount, tableCount) || other.tableCount == tableCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slideCount,const DeepCollectionEquality().hash(_slideNames),imageCount,tableCount);

@override
String toString() {
  return 'PptxMetadata(slideCount: $slideCount, slideNames: $slideNames, imageCount: $imageCount, tableCount: $tableCount)';
}


}

/// @nodoc
abstract mixin class _$PptxMetadataCopyWith<$Res> implements $PptxMetadataCopyWith<$Res> {
  factory _$PptxMetadataCopyWith(_PptxMetadata value, $Res Function(_PptxMetadata) _then) = __$PptxMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'slide_count') int slideCount,@JsonKey(name: 'slide_names') List<String> slideNames,@JsonKey(name: 'image_count') int? imageCount,@JsonKey(name: 'table_count') int? tableCount
});




}
/// @nodoc
class __$PptxMetadataCopyWithImpl<$Res>
    implements _$PptxMetadataCopyWith<$Res> {
  __$PptxMetadataCopyWithImpl(this._self, this._then);

  final _PptxMetadata _self;
  final $Res Function(_PptxMetadata) _then;

/// Create a copy of PptxMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slideCount = null,Object? slideNames = null,Object? imageCount = freezed,Object? tableCount = freezed,}) {
  return _then(_PptxMetadata(
slideCount: null == slideCount ? _self.slideCount : slideCount // ignore: cast_nullable_to_non_nullable
as int,slideNames: null == slideNames ? _self._slideNames : slideNames // ignore: cast_nullable_to_non_nullable
as List<String>,imageCount: freezed == imageCount ? _self.imageCount : imageCount // ignore: cast_nullable_to_non_nullable
as int?,tableCount: freezed == tableCount ? _self.tableCount : tableCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
