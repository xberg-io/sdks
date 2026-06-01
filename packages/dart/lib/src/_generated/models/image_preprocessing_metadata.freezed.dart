// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_preprocessing_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImagePreprocessingMetadata {

/// Whether DPI was auto-adjusted based on content
@JsonKey(name: 'auto_adjusted') bool get autoAdjusted;/// Whether dimensions were clamped to max_image_dimension
@JsonKey(name: 'dimension_clamped') bool get dimensionClamped;/// Final DPI after processing
@JsonKey(name: 'final_dpi') int get finalDpi;/// Original image dimensions (width, height) in pixels
@JsonKey(name: 'original_dimensions') List<int> get originalDimensions;/// Original image DPI (horizontal, vertical)
@JsonKey(name: 'original_dpi') List<double> get originalDpi;/// Resampling algorithm used ("LANCZOS3", "CATMULLROM", etc.)
@JsonKey(name: 'resample_method') String get resampleMethod;/// Scaling factor applied to the image
@JsonKey(name: 'scale_factor') double get scaleFactor;/// Whether resize was skipped (dimensions already optimal)
@JsonKey(name: 'skipped_resize') bool get skippedResize;/// Target DPI from configuration
@JsonKey(name: 'target_dpi') int get targetDpi;/// Calculated optimal DPI (if auto_adjust_dpi enabled)
@JsonKey(name: 'calculated_dpi') int? get calculatedDpi;/// New dimensions after resizing (if resized)
@JsonKey(name: 'new_dimensions') List<int>? get newDimensions;/// Error message if resize failed
@JsonKey(name: 'resize_error') String? get resizeError;
/// Create a copy of ImagePreprocessingMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImagePreprocessingMetadataCopyWith<ImagePreprocessingMetadata> get copyWith => _$ImagePreprocessingMetadataCopyWithImpl<ImagePreprocessingMetadata>(this as ImagePreprocessingMetadata, _$identity);

  /// Serializes this ImagePreprocessingMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImagePreprocessingMetadata&&(identical(other.autoAdjusted, autoAdjusted) || other.autoAdjusted == autoAdjusted)&&(identical(other.dimensionClamped, dimensionClamped) || other.dimensionClamped == dimensionClamped)&&(identical(other.finalDpi, finalDpi) || other.finalDpi == finalDpi)&&const DeepCollectionEquality().equals(other.originalDimensions, originalDimensions)&&const DeepCollectionEquality().equals(other.originalDpi, originalDpi)&&(identical(other.resampleMethod, resampleMethod) || other.resampleMethod == resampleMethod)&&(identical(other.scaleFactor, scaleFactor) || other.scaleFactor == scaleFactor)&&(identical(other.skippedResize, skippedResize) || other.skippedResize == skippedResize)&&(identical(other.targetDpi, targetDpi) || other.targetDpi == targetDpi)&&(identical(other.calculatedDpi, calculatedDpi) || other.calculatedDpi == calculatedDpi)&&const DeepCollectionEquality().equals(other.newDimensions, newDimensions)&&(identical(other.resizeError, resizeError) || other.resizeError == resizeError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,autoAdjusted,dimensionClamped,finalDpi,const DeepCollectionEquality().hash(originalDimensions),const DeepCollectionEquality().hash(originalDpi),resampleMethod,scaleFactor,skippedResize,targetDpi,calculatedDpi,const DeepCollectionEquality().hash(newDimensions),resizeError);

@override
String toString() {
  return 'ImagePreprocessingMetadata(autoAdjusted: $autoAdjusted, dimensionClamped: $dimensionClamped, finalDpi: $finalDpi, originalDimensions: $originalDimensions, originalDpi: $originalDpi, resampleMethod: $resampleMethod, scaleFactor: $scaleFactor, skippedResize: $skippedResize, targetDpi: $targetDpi, calculatedDpi: $calculatedDpi, newDimensions: $newDimensions, resizeError: $resizeError)';
}


}

/// @nodoc
abstract mixin class $ImagePreprocessingMetadataCopyWith<$Res>  {
  factory $ImagePreprocessingMetadataCopyWith(ImagePreprocessingMetadata value, $Res Function(ImagePreprocessingMetadata) _then) = _$ImagePreprocessingMetadataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'auto_adjusted') bool autoAdjusted,@JsonKey(name: 'dimension_clamped') bool dimensionClamped,@JsonKey(name: 'final_dpi') int finalDpi,@JsonKey(name: 'original_dimensions') List<int> originalDimensions,@JsonKey(name: 'original_dpi') List<double> originalDpi,@JsonKey(name: 'resample_method') String resampleMethod,@JsonKey(name: 'scale_factor') double scaleFactor,@JsonKey(name: 'skipped_resize') bool skippedResize,@JsonKey(name: 'target_dpi') int targetDpi,@JsonKey(name: 'calculated_dpi') int? calculatedDpi,@JsonKey(name: 'new_dimensions') List<int>? newDimensions,@JsonKey(name: 'resize_error') String? resizeError
});




}
/// @nodoc
class _$ImagePreprocessingMetadataCopyWithImpl<$Res>
    implements $ImagePreprocessingMetadataCopyWith<$Res> {
  _$ImagePreprocessingMetadataCopyWithImpl(this._self, this._then);

  final ImagePreprocessingMetadata _self;
  final $Res Function(ImagePreprocessingMetadata) _then;

/// Create a copy of ImagePreprocessingMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autoAdjusted = null,Object? dimensionClamped = null,Object? finalDpi = null,Object? originalDimensions = null,Object? originalDpi = null,Object? resampleMethod = null,Object? scaleFactor = null,Object? skippedResize = null,Object? targetDpi = null,Object? calculatedDpi = freezed,Object? newDimensions = freezed,Object? resizeError = freezed,}) {
  return _then(_self.copyWith(
autoAdjusted: null == autoAdjusted ? _self.autoAdjusted : autoAdjusted // ignore: cast_nullable_to_non_nullable
as bool,dimensionClamped: null == dimensionClamped ? _self.dimensionClamped : dimensionClamped // ignore: cast_nullable_to_non_nullable
as bool,finalDpi: null == finalDpi ? _self.finalDpi : finalDpi // ignore: cast_nullable_to_non_nullable
as int,originalDimensions: null == originalDimensions ? _self.originalDimensions : originalDimensions // ignore: cast_nullable_to_non_nullable
as List<int>,originalDpi: null == originalDpi ? _self.originalDpi : originalDpi // ignore: cast_nullable_to_non_nullable
as List<double>,resampleMethod: null == resampleMethod ? _self.resampleMethod : resampleMethod // ignore: cast_nullable_to_non_nullable
as String,scaleFactor: null == scaleFactor ? _self.scaleFactor : scaleFactor // ignore: cast_nullable_to_non_nullable
as double,skippedResize: null == skippedResize ? _self.skippedResize : skippedResize // ignore: cast_nullable_to_non_nullable
as bool,targetDpi: null == targetDpi ? _self.targetDpi : targetDpi // ignore: cast_nullable_to_non_nullable
as int,calculatedDpi: freezed == calculatedDpi ? _self.calculatedDpi : calculatedDpi // ignore: cast_nullable_to_non_nullable
as int?,newDimensions: freezed == newDimensions ? _self.newDimensions : newDimensions // ignore: cast_nullable_to_non_nullable
as List<int>?,resizeError: freezed == resizeError ? _self.resizeError : resizeError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImagePreprocessingMetadata].
extension ImagePreprocessingMetadataPatterns on ImagePreprocessingMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImagePreprocessingMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImagePreprocessingMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImagePreprocessingMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ImagePreprocessingMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImagePreprocessingMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ImagePreprocessingMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'auto_adjusted')  bool autoAdjusted, @JsonKey(name: 'dimension_clamped')  bool dimensionClamped, @JsonKey(name: 'final_dpi')  int finalDpi, @JsonKey(name: 'original_dimensions')  List<int> originalDimensions, @JsonKey(name: 'original_dpi')  List<double> originalDpi, @JsonKey(name: 'resample_method')  String resampleMethod, @JsonKey(name: 'scale_factor')  double scaleFactor, @JsonKey(name: 'skipped_resize')  bool skippedResize, @JsonKey(name: 'target_dpi')  int targetDpi, @JsonKey(name: 'calculated_dpi')  int? calculatedDpi, @JsonKey(name: 'new_dimensions')  List<int>? newDimensions, @JsonKey(name: 'resize_error')  String? resizeError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImagePreprocessingMetadata() when $default != null:
return $default(_that.autoAdjusted,_that.dimensionClamped,_that.finalDpi,_that.originalDimensions,_that.originalDpi,_that.resampleMethod,_that.scaleFactor,_that.skippedResize,_that.targetDpi,_that.calculatedDpi,_that.newDimensions,_that.resizeError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'auto_adjusted')  bool autoAdjusted, @JsonKey(name: 'dimension_clamped')  bool dimensionClamped, @JsonKey(name: 'final_dpi')  int finalDpi, @JsonKey(name: 'original_dimensions')  List<int> originalDimensions, @JsonKey(name: 'original_dpi')  List<double> originalDpi, @JsonKey(name: 'resample_method')  String resampleMethod, @JsonKey(name: 'scale_factor')  double scaleFactor, @JsonKey(name: 'skipped_resize')  bool skippedResize, @JsonKey(name: 'target_dpi')  int targetDpi, @JsonKey(name: 'calculated_dpi')  int? calculatedDpi, @JsonKey(name: 'new_dimensions')  List<int>? newDimensions, @JsonKey(name: 'resize_error')  String? resizeError)  $default,) {final _that = this;
switch (_that) {
case _ImagePreprocessingMetadata():
return $default(_that.autoAdjusted,_that.dimensionClamped,_that.finalDpi,_that.originalDimensions,_that.originalDpi,_that.resampleMethod,_that.scaleFactor,_that.skippedResize,_that.targetDpi,_that.calculatedDpi,_that.newDimensions,_that.resizeError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'auto_adjusted')  bool autoAdjusted, @JsonKey(name: 'dimension_clamped')  bool dimensionClamped, @JsonKey(name: 'final_dpi')  int finalDpi, @JsonKey(name: 'original_dimensions')  List<int> originalDimensions, @JsonKey(name: 'original_dpi')  List<double> originalDpi, @JsonKey(name: 'resample_method')  String resampleMethod, @JsonKey(name: 'scale_factor')  double scaleFactor, @JsonKey(name: 'skipped_resize')  bool skippedResize, @JsonKey(name: 'target_dpi')  int targetDpi, @JsonKey(name: 'calculated_dpi')  int? calculatedDpi, @JsonKey(name: 'new_dimensions')  List<int>? newDimensions, @JsonKey(name: 'resize_error')  String? resizeError)?  $default,) {final _that = this;
switch (_that) {
case _ImagePreprocessingMetadata() when $default != null:
return $default(_that.autoAdjusted,_that.dimensionClamped,_that.finalDpi,_that.originalDimensions,_that.originalDpi,_that.resampleMethod,_that.scaleFactor,_that.skippedResize,_that.targetDpi,_that.calculatedDpi,_that.newDimensions,_that.resizeError);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImagePreprocessingMetadata implements ImagePreprocessingMetadata {
  const _ImagePreprocessingMetadata({@JsonKey(name: 'auto_adjusted') required this.autoAdjusted, @JsonKey(name: 'dimension_clamped') required this.dimensionClamped, @JsonKey(name: 'final_dpi') required this.finalDpi, @JsonKey(name: 'original_dimensions') required final  List<int> originalDimensions, @JsonKey(name: 'original_dpi') required final  List<double> originalDpi, @JsonKey(name: 'resample_method') required this.resampleMethod, @JsonKey(name: 'scale_factor') required this.scaleFactor, @JsonKey(name: 'skipped_resize') required this.skippedResize, @JsonKey(name: 'target_dpi') required this.targetDpi, @JsonKey(name: 'calculated_dpi') this.calculatedDpi, @JsonKey(name: 'new_dimensions') final  List<int>? newDimensions, @JsonKey(name: 'resize_error') this.resizeError}): _originalDimensions = originalDimensions,_originalDpi = originalDpi,_newDimensions = newDimensions;
  factory _ImagePreprocessingMetadata.fromJson(Map<String, dynamic> json) => _$ImagePreprocessingMetadataFromJson(json);

/// Whether DPI was auto-adjusted based on content
@override@JsonKey(name: 'auto_adjusted') final  bool autoAdjusted;
/// Whether dimensions were clamped to max_image_dimension
@override@JsonKey(name: 'dimension_clamped') final  bool dimensionClamped;
/// Final DPI after processing
@override@JsonKey(name: 'final_dpi') final  int finalDpi;
/// Original image dimensions (width, height) in pixels
 final  List<int> _originalDimensions;
/// Original image dimensions (width, height) in pixels
@override@JsonKey(name: 'original_dimensions') List<int> get originalDimensions {
  if (_originalDimensions is EqualUnmodifiableListView) return _originalDimensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_originalDimensions);
}

/// Original image DPI (horizontal, vertical)
 final  List<double> _originalDpi;
/// Original image DPI (horizontal, vertical)
@override@JsonKey(name: 'original_dpi') List<double> get originalDpi {
  if (_originalDpi is EqualUnmodifiableListView) return _originalDpi;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_originalDpi);
}

/// Resampling algorithm used ("LANCZOS3", "CATMULLROM", etc.)
@override@JsonKey(name: 'resample_method') final  String resampleMethod;
/// Scaling factor applied to the image
@override@JsonKey(name: 'scale_factor') final  double scaleFactor;
/// Whether resize was skipped (dimensions already optimal)
@override@JsonKey(name: 'skipped_resize') final  bool skippedResize;
/// Target DPI from configuration
@override@JsonKey(name: 'target_dpi') final  int targetDpi;
/// Calculated optimal DPI (if auto_adjust_dpi enabled)
@override@JsonKey(name: 'calculated_dpi') final  int? calculatedDpi;
/// New dimensions after resizing (if resized)
 final  List<int>? _newDimensions;
/// New dimensions after resizing (if resized)
@override@JsonKey(name: 'new_dimensions') List<int>? get newDimensions {
  final value = _newDimensions;
  if (value == null) return null;
  if (_newDimensions is EqualUnmodifiableListView) return _newDimensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Error message if resize failed
@override@JsonKey(name: 'resize_error') final  String? resizeError;

/// Create a copy of ImagePreprocessingMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImagePreprocessingMetadataCopyWith<_ImagePreprocessingMetadata> get copyWith => __$ImagePreprocessingMetadataCopyWithImpl<_ImagePreprocessingMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImagePreprocessingMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImagePreprocessingMetadata&&(identical(other.autoAdjusted, autoAdjusted) || other.autoAdjusted == autoAdjusted)&&(identical(other.dimensionClamped, dimensionClamped) || other.dimensionClamped == dimensionClamped)&&(identical(other.finalDpi, finalDpi) || other.finalDpi == finalDpi)&&const DeepCollectionEquality().equals(other._originalDimensions, _originalDimensions)&&const DeepCollectionEquality().equals(other._originalDpi, _originalDpi)&&(identical(other.resampleMethod, resampleMethod) || other.resampleMethod == resampleMethod)&&(identical(other.scaleFactor, scaleFactor) || other.scaleFactor == scaleFactor)&&(identical(other.skippedResize, skippedResize) || other.skippedResize == skippedResize)&&(identical(other.targetDpi, targetDpi) || other.targetDpi == targetDpi)&&(identical(other.calculatedDpi, calculatedDpi) || other.calculatedDpi == calculatedDpi)&&const DeepCollectionEquality().equals(other._newDimensions, _newDimensions)&&(identical(other.resizeError, resizeError) || other.resizeError == resizeError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,autoAdjusted,dimensionClamped,finalDpi,const DeepCollectionEquality().hash(_originalDimensions),const DeepCollectionEquality().hash(_originalDpi),resampleMethod,scaleFactor,skippedResize,targetDpi,calculatedDpi,const DeepCollectionEquality().hash(_newDimensions),resizeError);

@override
String toString() {
  return 'ImagePreprocessingMetadata(autoAdjusted: $autoAdjusted, dimensionClamped: $dimensionClamped, finalDpi: $finalDpi, originalDimensions: $originalDimensions, originalDpi: $originalDpi, resampleMethod: $resampleMethod, scaleFactor: $scaleFactor, skippedResize: $skippedResize, targetDpi: $targetDpi, calculatedDpi: $calculatedDpi, newDimensions: $newDimensions, resizeError: $resizeError)';
}


}

/// @nodoc
abstract mixin class _$ImagePreprocessingMetadataCopyWith<$Res> implements $ImagePreprocessingMetadataCopyWith<$Res> {
  factory _$ImagePreprocessingMetadataCopyWith(_ImagePreprocessingMetadata value, $Res Function(_ImagePreprocessingMetadata) _then) = __$ImagePreprocessingMetadataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'auto_adjusted') bool autoAdjusted,@JsonKey(name: 'dimension_clamped') bool dimensionClamped,@JsonKey(name: 'final_dpi') int finalDpi,@JsonKey(name: 'original_dimensions') List<int> originalDimensions,@JsonKey(name: 'original_dpi') List<double> originalDpi,@JsonKey(name: 'resample_method') String resampleMethod,@JsonKey(name: 'scale_factor') double scaleFactor,@JsonKey(name: 'skipped_resize') bool skippedResize,@JsonKey(name: 'target_dpi') int targetDpi,@JsonKey(name: 'calculated_dpi') int? calculatedDpi,@JsonKey(name: 'new_dimensions') List<int>? newDimensions,@JsonKey(name: 'resize_error') String? resizeError
});




}
/// @nodoc
class __$ImagePreprocessingMetadataCopyWithImpl<$Res>
    implements _$ImagePreprocessingMetadataCopyWith<$Res> {
  __$ImagePreprocessingMetadataCopyWithImpl(this._self, this._then);

  final _ImagePreprocessingMetadata _self;
  final $Res Function(_ImagePreprocessingMetadata) _then;

/// Create a copy of ImagePreprocessingMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autoAdjusted = null,Object? dimensionClamped = null,Object? finalDpi = null,Object? originalDimensions = null,Object? originalDpi = null,Object? resampleMethod = null,Object? scaleFactor = null,Object? skippedResize = null,Object? targetDpi = null,Object? calculatedDpi = freezed,Object? newDimensions = freezed,Object? resizeError = freezed,}) {
  return _then(_ImagePreprocessingMetadata(
autoAdjusted: null == autoAdjusted ? _self.autoAdjusted : autoAdjusted // ignore: cast_nullable_to_non_nullable
as bool,dimensionClamped: null == dimensionClamped ? _self.dimensionClamped : dimensionClamped // ignore: cast_nullable_to_non_nullable
as bool,finalDpi: null == finalDpi ? _self.finalDpi : finalDpi // ignore: cast_nullable_to_non_nullable
as int,originalDimensions: null == originalDimensions ? _self._originalDimensions : originalDimensions // ignore: cast_nullable_to_non_nullable
as List<int>,originalDpi: null == originalDpi ? _self._originalDpi : originalDpi // ignore: cast_nullable_to_non_nullable
as List<double>,resampleMethod: null == resampleMethod ? _self.resampleMethod : resampleMethod // ignore: cast_nullable_to_non_nullable
as String,scaleFactor: null == scaleFactor ? _self.scaleFactor : scaleFactor // ignore: cast_nullable_to_non_nullable
as double,skippedResize: null == skippedResize ? _self.skippedResize : skippedResize // ignore: cast_nullable_to_non_nullable
as bool,targetDpi: null == targetDpi ? _self.targetDpi : targetDpi // ignore: cast_nullable_to_non_nullable
as int,calculatedDpi: freezed == calculatedDpi ? _self.calculatedDpi : calculatedDpi // ignore: cast_nullable_to_non_nullable
as int?,newDimensions: freezed == newDimensions ? _self._newDimensions : newDimensions // ignore: cast_nullable_to_non_nullable
as List<int>?,resizeError: freezed == resizeError ? _self.resizeError : resizeError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
