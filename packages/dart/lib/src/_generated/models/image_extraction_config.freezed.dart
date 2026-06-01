// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_extraction_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageExtractionConfig {

/// Auto-adjust DPI based on content
@JsonKey(name: 'auto_adjust_dpi') bool? get autoAdjustDpi;/// Extract images from documents
@JsonKey(name: 'extract_images') bool? get extractImages;/// Inject image reference placeholders in markdown output
@JsonKey(name: 'inject_placeholders') bool? get injectPlaceholders;/// Maximum DPI threshold
@JsonKey(name: 'max_dpi') int? get maxDpi;/// Maximum image dimension (width or height)
@JsonKey(name: 'max_image_dimension') int? get maxImageDimension;/// Minimum DPI threshold
@JsonKey(name: 'min_dpi') int? get minDpi;/// Target DPI for image normalization
@JsonKey(name: 'target_dpi') int? get targetDpi;
/// Create a copy of ImageExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageExtractionConfigCopyWith<ImageExtractionConfig> get copyWith => _$ImageExtractionConfigCopyWithImpl<ImageExtractionConfig>(this as ImageExtractionConfig, _$identity);

  /// Serializes this ImageExtractionConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageExtractionConfig&&(identical(other.autoAdjustDpi, autoAdjustDpi) || other.autoAdjustDpi == autoAdjustDpi)&&(identical(other.extractImages, extractImages) || other.extractImages == extractImages)&&(identical(other.injectPlaceholders, injectPlaceholders) || other.injectPlaceholders == injectPlaceholders)&&(identical(other.maxDpi, maxDpi) || other.maxDpi == maxDpi)&&(identical(other.maxImageDimension, maxImageDimension) || other.maxImageDimension == maxImageDimension)&&(identical(other.minDpi, minDpi) || other.minDpi == minDpi)&&(identical(other.targetDpi, targetDpi) || other.targetDpi == targetDpi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,autoAdjustDpi,extractImages,injectPlaceholders,maxDpi,maxImageDimension,minDpi,targetDpi);

@override
String toString() {
  return 'ImageExtractionConfig(autoAdjustDpi: $autoAdjustDpi, extractImages: $extractImages, injectPlaceholders: $injectPlaceholders, maxDpi: $maxDpi, maxImageDimension: $maxImageDimension, minDpi: $minDpi, targetDpi: $targetDpi)';
}


}

/// @nodoc
abstract mixin class $ImageExtractionConfigCopyWith<$Res>  {
  factory $ImageExtractionConfigCopyWith(ImageExtractionConfig value, $Res Function(ImageExtractionConfig) _then) = _$ImageExtractionConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'auto_adjust_dpi') bool? autoAdjustDpi,@JsonKey(name: 'extract_images') bool? extractImages,@JsonKey(name: 'inject_placeholders') bool? injectPlaceholders,@JsonKey(name: 'max_dpi') int? maxDpi,@JsonKey(name: 'max_image_dimension') int? maxImageDimension,@JsonKey(name: 'min_dpi') int? minDpi,@JsonKey(name: 'target_dpi') int? targetDpi
});




}
/// @nodoc
class _$ImageExtractionConfigCopyWithImpl<$Res>
    implements $ImageExtractionConfigCopyWith<$Res> {
  _$ImageExtractionConfigCopyWithImpl(this._self, this._then);

  final ImageExtractionConfig _self;
  final $Res Function(ImageExtractionConfig) _then;

/// Create a copy of ImageExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autoAdjustDpi = freezed,Object? extractImages = freezed,Object? injectPlaceholders = freezed,Object? maxDpi = freezed,Object? maxImageDimension = freezed,Object? minDpi = freezed,Object? targetDpi = freezed,}) {
  return _then(_self.copyWith(
autoAdjustDpi: freezed == autoAdjustDpi ? _self.autoAdjustDpi : autoAdjustDpi // ignore: cast_nullable_to_non_nullable
as bool?,extractImages: freezed == extractImages ? _self.extractImages : extractImages // ignore: cast_nullable_to_non_nullable
as bool?,injectPlaceholders: freezed == injectPlaceholders ? _self.injectPlaceholders : injectPlaceholders // ignore: cast_nullable_to_non_nullable
as bool?,maxDpi: freezed == maxDpi ? _self.maxDpi : maxDpi // ignore: cast_nullable_to_non_nullable
as int?,maxImageDimension: freezed == maxImageDimension ? _self.maxImageDimension : maxImageDimension // ignore: cast_nullable_to_non_nullable
as int?,minDpi: freezed == minDpi ? _self.minDpi : minDpi // ignore: cast_nullable_to_non_nullable
as int?,targetDpi: freezed == targetDpi ? _self.targetDpi : targetDpi // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageExtractionConfig].
extension ImageExtractionConfigPatterns on ImageExtractionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageExtractionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageExtractionConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageExtractionConfig value)  $default,){
final _that = this;
switch (_that) {
case _ImageExtractionConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageExtractionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ImageExtractionConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'auto_adjust_dpi')  bool? autoAdjustDpi, @JsonKey(name: 'extract_images')  bool? extractImages, @JsonKey(name: 'inject_placeholders')  bool? injectPlaceholders, @JsonKey(name: 'max_dpi')  int? maxDpi, @JsonKey(name: 'max_image_dimension')  int? maxImageDimension, @JsonKey(name: 'min_dpi')  int? minDpi, @JsonKey(name: 'target_dpi')  int? targetDpi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageExtractionConfig() when $default != null:
return $default(_that.autoAdjustDpi,_that.extractImages,_that.injectPlaceholders,_that.maxDpi,_that.maxImageDimension,_that.minDpi,_that.targetDpi);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'auto_adjust_dpi')  bool? autoAdjustDpi, @JsonKey(name: 'extract_images')  bool? extractImages, @JsonKey(name: 'inject_placeholders')  bool? injectPlaceholders, @JsonKey(name: 'max_dpi')  int? maxDpi, @JsonKey(name: 'max_image_dimension')  int? maxImageDimension, @JsonKey(name: 'min_dpi')  int? minDpi, @JsonKey(name: 'target_dpi')  int? targetDpi)  $default,) {final _that = this;
switch (_that) {
case _ImageExtractionConfig():
return $default(_that.autoAdjustDpi,_that.extractImages,_that.injectPlaceholders,_that.maxDpi,_that.maxImageDimension,_that.minDpi,_that.targetDpi);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'auto_adjust_dpi')  bool? autoAdjustDpi, @JsonKey(name: 'extract_images')  bool? extractImages, @JsonKey(name: 'inject_placeholders')  bool? injectPlaceholders, @JsonKey(name: 'max_dpi')  int? maxDpi, @JsonKey(name: 'max_image_dimension')  int? maxImageDimension, @JsonKey(name: 'min_dpi')  int? minDpi, @JsonKey(name: 'target_dpi')  int? targetDpi)?  $default,) {final _that = this;
switch (_that) {
case _ImageExtractionConfig() when $default != null:
return $default(_that.autoAdjustDpi,_that.extractImages,_that.injectPlaceholders,_that.maxDpi,_that.maxImageDimension,_that.minDpi,_that.targetDpi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageExtractionConfig implements ImageExtractionConfig {
  const _ImageExtractionConfig({@JsonKey(name: 'auto_adjust_dpi') this.autoAdjustDpi, @JsonKey(name: 'extract_images') this.extractImages, @JsonKey(name: 'inject_placeholders') this.injectPlaceholders, @JsonKey(name: 'max_dpi') this.maxDpi, @JsonKey(name: 'max_image_dimension') this.maxImageDimension, @JsonKey(name: 'min_dpi') this.minDpi, @JsonKey(name: 'target_dpi') this.targetDpi});
  factory _ImageExtractionConfig.fromJson(Map<String, dynamic> json) => _$ImageExtractionConfigFromJson(json);

/// Auto-adjust DPI based on content
@override@JsonKey(name: 'auto_adjust_dpi') final  bool? autoAdjustDpi;
/// Extract images from documents
@override@JsonKey(name: 'extract_images') final  bool? extractImages;
/// Inject image reference placeholders in markdown output
@override@JsonKey(name: 'inject_placeholders') final  bool? injectPlaceholders;
/// Maximum DPI threshold
@override@JsonKey(name: 'max_dpi') final  int? maxDpi;
/// Maximum image dimension (width or height)
@override@JsonKey(name: 'max_image_dimension') final  int? maxImageDimension;
/// Minimum DPI threshold
@override@JsonKey(name: 'min_dpi') final  int? minDpi;
/// Target DPI for image normalization
@override@JsonKey(name: 'target_dpi') final  int? targetDpi;

/// Create a copy of ImageExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageExtractionConfigCopyWith<_ImageExtractionConfig> get copyWith => __$ImageExtractionConfigCopyWithImpl<_ImageExtractionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageExtractionConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageExtractionConfig&&(identical(other.autoAdjustDpi, autoAdjustDpi) || other.autoAdjustDpi == autoAdjustDpi)&&(identical(other.extractImages, extractImages) || other.extractImages == extractImages)&&(identical(other.injectPlaceholders, injectPlaceholders) || other.injectPlaceholders == injectPlaceholders)&&(identical(other.maxDpi, maxDpi) || other.maxDpi == maxDpi)&&(identical(other.maxImageDimension, maxImageDimension) || other.maxImageDimension == maxImageDimension)&&(identical(other.minDpi, minDpi) || other.minDpi == minDpi)&&(identical(other.targetDpi, targetDpi) || other.targetDpi == targetDpi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,autoAdjustDpi,extractImages,injectPlaceholders,maxDpi,maxImageDimension,minDpi,targetDpi);

@override
String toString() {
  return 'ImageExtractionConfig(autoAdjustDpi: $autoAdjustDpi, extractImages: $extractImages, injectPlaceholders: $injectPlaceholders, maxDpi: $maxDpi, maxImageDimension: $maxImageDimension, minDpi: $minDpi, targetDpi: $targetDpi)';
}


}

/// @nodoc
abstract mixin class _$ImageExtractionConfigCopyWith<$Res> implements $ImageExtractionConfigCopyWith<$Res> {
  factory _$ImageExtractionConfigCopyWith(_ImageExtractionConfig value, $Res Function(_ImageExtractionConfig) _then) = __$ImageExtractionConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'auto_adjust_dpi') bool? autoAdjustDpi,@JsonKey(name: 'extract_images') bool? extractImages,@JsonKey(name: 'inject_placeholders') bool? injectPlaceholders,@JsonKey(name: 'max_dpi') int? maxDpi,@JsonKey(name: 'max_image_dimension') int? maxImageDimension,@JsonKey(name: 'min_dpi') int? minDpi,@JsonKey(name: 'target_dpi') int? targetDpi
});




}
/// @nodoc
class __$ImageExtractionConfigCopyWithImpl<$Res>
    implements _$ImageExtractionConfigCopyWith<$Res> {
  __$ImageExtractionConfigCopyWithImpl(this._self, this._then);

  final _ImageExtractionConfig _self;
  final $Res Function(_ImageExtractionConfig) _then;

/// Create a copy of ImageExtractionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autoAdjustDpi = freezed,Object? extractImages = freezed,Object? injectPlaceholders = freezed,Object? maxDpi = freezed,Object? maxImageDimension = freezed,Object? minDpi = freezed,Object? targetDpi = freezed,}) {
  return _then(_ImageExtractionConfig(
autoAdjustDpi: freezed == autoAdjustDpi ? _self.autoAdjustDpi : autoAdjustDpi // ignore: cast_nullable_to_non_nullable
as bool?,extractImages: freezed == extractImages ? _self.extractImages : extractImages // ignore: cast_nullable_to_non_nullable
as bool?,injectPlaceholders: freezed == injectPlaceholders ? _self.injectPlaceholders : injectPlaceholders // ignore: cast_nullable_to_non_nullable
as bool?,maxDpi: freezed == maxDpi ? _self.maxDpi : maxDpi // ignore: cast_nullable_to_non_nullable
as int?,maxImageDimension: freezed == maxImageDimension ? _self.maxImageDimension : maxImageDimension // ignore: cast_nullable_to_non_nullable
as int?,minDpi: freezed == minDpi ? _self.minDpi : minDpi // ignore: cast_nullable_to_non_nullable
as int?,targetDpi: freezed == targetDpi ? _self.targetDpi : targetDpi // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
