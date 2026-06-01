// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pdf_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PdfConfig {

/// Bottom margin fraction to skip (0.0-1.0)
@JsonKey(name: 'bottom_margin_fraction') double? get bottomMarginFraction;/// Extract PDF annotations
@JsonKey(name: 'extract_annotations') bool? get extractAnnotations;/// Extract images from PDF
@JsonKey(name: 'extract_images') bool? get extractImages;/// Extract PDF metadata
@JsonKey(name: 'extract_metadata') bool? get extractMetadata;/// Heading hierarchy detection
 HierarchyConfig? get hierarchy;/// PDF passwords to try
 List<String>? get passwords;/// Top margin fraction to skip (0.0-1.0)
@JsonKey(name: 'top_margin_fraction') double? get topMarginFraction;
/// Create a copy of PdfConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PdfConfigCopyWith<PdfConfig> get copyWith => _$PdfConfigCopyWithImpl<PdfConfig>(this as PdfConfig, _$identity);

  /// Serializes this PdfConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PdfConfig&&(identical(other.bottomMarginFraction, bottomMarginFraction) || other.bottomMarginFraction == bottomMarginFraction)&&(identical(other.extractAnnotations, extractAnnotations) || other.extractAnnotations == extractAnnotations)&&(identical(other.extractImages, extractImages) || other.extractImages == extractImages)&&(identical(other.extractMetadata, extractMetadata) || other.extractMetadata == extractMetadata)&&(identical(other.hierarchy, hierarchy) || other.hierarchy == hierarchy)&&const DeepCollectionEquality().equals(other.passwords, passwords)&&(identical(other.topMarginFraction, topMarginFraction) || other.topMarginFraction == topMarginFraction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bottomMarginFraction,extractAnnotations,extractImages,extractMetadata,hierarchy,const DeepCollectionEquality().hash(passwords),topMarginFraction);

@override
String toString() {
  return 'PdfConfig(bottomMarginFraction: $bottomMarginFraction, extractAnnotations: $extractAnnotations, extractImages: $extractImages, extractMetadata: $extractMetadata, hierarchy: $hierarchy, passwords: $passwords, topMarginFraction: $topMarginFraction)';
}


}

/// @nodoc
abstract mixin class $PdfConfigCopyWith<$Res>  {
  factory $PdfConfigCopyWith(PdfConfig value, $Res Function(PdfConfig) _then) = _$PdfConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'bottom_margin_fraction') double? bottomMarginFraction,@JsonKey(name: 'extract_annotations') bool? extractAnnotations,@JsonKey(name: 'extract_images') bool? extractImages,@JsonKey(name: 'extract_metadata') bool? extractMetadata, HierarchyConfig? hierarchy, List<String>? passwords,@JsonKey(name: 'top_margin_fraction') double? topMarginFraction
});


$HierarchyConfigCopyWith<$Res>? get hierarchy;

}
/// @nodoc
class _$PdfConfigCopyWithImpl<$Res>
    implements $PdfConfigCopyWith<$Res> {
  _$PdfConfigCopyWithImpl(this._self, this._then);

  final PdfConfig _self;
  final $Res Function(PdfConfig) _then;

/// Create a copy of PdfConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bottomMarginFraction = freezed,Object? extractAnnotations = freezed,Object? extractImages = freezed,Object? extractMetadata = freezed,Object? hierarchy = freezed,Object? passwords = freezed,Object? topMarginFraction = freezed,}) {
  return _then(_self.copyWith(
bottomMarginFraction: freezed == bottomMarginFraction ? _self.bottomMarginFraction : bottomMarginFraction // ignore: cast_nullable_to_non_nullable
as double?,extractAnnotations: freezed == extractAnnotations ? _self.extractAnnotations : extractAnnotations // ignore: cast_nullable_to_non_nullable
as bool?,extractImages: freezed == extractImages ? _self.extractImages : extractImages // ignore: cast_nullable_to_non_nullable
as bool?,extractMetadata: freezed == extractMetadata ? _self.extractMetadata : extractMetadata // ignore: cast_nullable_to_non_nullable
as bool?,hierarchy: freezed == hierarchy ? _self.hierarchy : hierarchy // ignore: cast_nullable_to_non_nullable
as HierarchyConfig?,passwords: freezed == passwords ? _self.passwords : passwords // ignore: cast_nullable_to_non_nullable
as List<String>?,topMarginFraction: freezed == topMarginFraction ? _self.topMarginFraction : topMarginFraction // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of PdfConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HierarchyConfigCopyWith<$Res>? get hierarchy {
    if (_self.hierarchy == null) {
    return null;
  }

  return $HierarchyConfigCopyWith<$Res>(_self.hierarchy!, (value) {
    return _then(_self.copyWith(hierarchy: value));
  });
}
}


/// Adds pattern-matching-related methods to [PdfConfig].
extension PdfConfigPatterns on PdfConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PdfConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PdfConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PdfConfig value)  $default,){
final _that = this;
switch (_that) {
case _PdfConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PdfConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PdfConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'bottom_margin_fraction')  double? bottomMarginFraction, @JsonKey(name: 'extract_annotations')  bool? extractAnnotations, @JsonKey(name: 'extract_images')  bool? extractImages, @JsonKey(name: 'extract_metadata')  bool? extractMetadata,  HierarchyConfig? hierarchy,  List<String>? passwords, @JsonKey(name: 'top_margin_fraction')  double? topMarginFraction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PdfConfig() when $default != null:
return $default(_that.bottomMarginFraction,_that.extractAnnotations,_that.extractImages,_that.extractMetadata,_that.hierarchy,_that.passwords,_that.topMarginFraction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'bottom_margin_fraction')  double? bottomMarginFraction, @JsonKey(name: 'extract_annotations')  bool? extractAnnotations, @JsonKey(name: 'extract_images')  bool? extractImages, @JsonKey(name: 'extract_metadata')  bool? extractMetadata,  HierarchyConfig? hierarchy,  List<String>? passwords, @JsonKey(name: 'top_margin_fraction')  double? topMarginFraction)  $default,) {final _that = this;
switch (_that) {
case _PdfConfig():
return $default(_that.bottomMarginFraction,_that.extractAnnotations,_that.extractImages,_that.extractMetadata,_that.hierarchy,_that.passwords,_that.topMarginFraction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'bottom_margin_fraction')  double? bottomMarginFraction, @JsonKey(name: 'extract_annotations')  bool? extractAnnotations, @JsonKey(name: 'extract_images')  bool? extractImages, @JsonKey(name: 'extract_metadata')  bool? extractMetadata,  HierarchyConfig? hierarchy,  List<String>? passwords, @JsonKey(name: 'top_margin_fraction')  double? topMarginFraction)?  $default,) {final _that = this;
switch (_that) {
case _PdfConfig() when $default != null:
return $default(_that.bottomMarginFraction,_that.extractAnnotations,_that.extractImages,_that.extractMetadata,_that.hierarchy,_that.passwords,_that.topMarginFraction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PdfConfig implements PdfConfig {
  const _PdfConfig({@JsonKey(name: 'bottom_margin_fraction') this.bottomMarginFraction, @JsonKey(name: 'extract_annotations') this.extractAnnotations, @JsonKey(name: 'extract_images') this.extractImages, @JsonKey(name: 'extract_metadata') this.extractMetadata, this.hierarchy, final  List<String>? passwords, @JsonKey(name: 'top_margin_fraction') this.topMarginFraction}): _passwords = passwords;
  factory _PdfConfig.fromJson(Map<String, dynamic> json) => _$PdfConfigFromJson(json);

/// Bottom margin fraction to skip (0.0-1.0)
@override@JsonKey(name: 'bottom_margin_fraction') final  double? bottomMarginFraction;
/// Extract PDF annotations
@override@JsonKey(name: 'extract_annotations') final  bool? extractAnnotations;
/// Extract images from PDF
@override@JsonKey(name: 'extract_images') final  bool? extractImages;
/// Extract PDF metadata
@override@JsonKey(name: 'extract_metadata') final  bool? extractMetadata;
/// Heading hierarchy detection
@override final  HierarchyConfig? hierarchy;
/// PDF passwords to try
 final  List<String>? _passwords;
/// PDF passwords to try
@override List<String>? get passwords {
  final value = _passwords;
  if (value == null) return null;
  if (_passwords is EqualUnmodifiableListView) return _passwords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Top margin fraction to skip (0.0-1.0)
@override@JsonKey(name: 'top_margin_fraction') final  double? topMarginFraction;

/// Create a copy of PdfConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PdfConfigCopyWith<_PdfConfig> get copyWith => __$PdfConfigCopyWithImpl<_PdfConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PdfConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PdfConfig&&(identical(other.bottomMarginFraction, bottomMarginFraction) || other.bottomMarginFraction == bottomMarginFraction)&&(identical(other.extractAnnotations, extractAnnotations) || other.extractAnnotations == extractAnnotations)&&(identical(other.extractImages, extractImages) || other.extractImages == extractImages)&&(identical(other.extractMetadata, extractMetadata) || other.extractMetadata == extractMetadata)&&(identical(other.hierarchy, hierarchy) || other.hierarchy == hierarchy)&&const DeepCollectionEquality().equals(other._passwords, _passwords)&&(identical(other.topMarginFraction, topMarginFraction) || other.topMarginFraction == topMarginFraction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bottomMarginFraction,extractAnnotations,extractImages,extractMetadata,hierarchy,const DeepCollectionEquality().hash(_passwords),topMarginFraction);

@override
String toString() {
  return 'PdfConfig(bottomMarginFraction: $bottomMarginFraction, extractAnnotations: $extractAnnotations, extractImages: $extractImages, extractMetadata: $extractMetadata, hierarchy: $hierarchy, passwords: $passwords, topMarginFraction: $topMarginFraction)';
}


}

/// @nodoc
abstract mixin class _$PdfConfigCopyWith<$Res> implements $PdfConfigCopyWith<$Res> {
  factory _$PdfConfigCopyWith(_PdfConfig value, $Res Function(_PdfConfig) _then) = __$PdfConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'bottom_margin_fraction') double? bottomMarginFraction,@JsonKey(name: 'extract_annotations') bool? extractAnnotations,@JsonKey(name: 'extract_images') bool? extractImages,@JsonKey(name: 'extract_metadata') bool? extractMetadata, HierarchyConfig? hierarchy, List<String>? passwords,@JsonKey(name: 'top_margin_fraction') double? topMarginFraction
});


@override $HierarchyConfigCopyWith<$Res>? get hierarchy;

}
/// @nodoc
class __$PdfConfigCopyWithImpl<$Res>
    implements _$PdfConfigCopyWith<$Res> {
  __$PdfConfigCopyWithImpl(this._self, this._then);

  final _PdfConfig _self;
  final $Res Function(_PdfConfig) _then;

/// Create a copy of PdfConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bottomMarginFraction = freezed,Object? extractAnnotations = freezed,Object? extractImages = freezed,Object? extractMetadata = freezed,Object? hierarchy = freezed,Object? passwords = freezed,Object? topMarginFraction = freezed,}) {
  return _then(_PdfConfig(
bottomMarginFraction: freezed == bottomMarginFraction ? _self.bottomMarginFraction : bottomMarginFraction // ignore: cast_nullable_to_non_nullable
as double?,extractAnnotations: freezed == extractAnnotations ? _self.extractAnnotations : extractAnnotations // ignore: cast_nullable_to_non_nullable
as bool?,extractImages: freezed == extractImages ? _self.extractImages : extractImages // ignore: cast_nullable_to_non_nullable
as bool?,extractMetadata: freezed == extractMetadata ? _self.extractMetadata : extractMetadata // ignore: cast_nullable_to_non_nullable
as bool?,hierarchy: freezed == hierarchy ? _self.hierarchy : hierarchy // ignore: cast_nullable_to_non_nullable
as HierarchyConfig?,passwords: freezed == passwords ? _self._passwords : passwords // ignore: cast_nullable_to_non_nullable
as List<String>?,topMarginFraction: freezed == topMarginFraction ? _self.topMarginFraction : topMarginFraction // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of PdfConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HierarchyConfigCopyWith<$Res>? get hierarchy {
    if (_self.hierarchy == null) {
    return null;
  }

  return $HierarchyConfigCopyWith<$Res>(_self.hierarchy!, (value) {
    return _then(_self.copyWith(hierarchy: value));
  });
}
}

// dart format on
