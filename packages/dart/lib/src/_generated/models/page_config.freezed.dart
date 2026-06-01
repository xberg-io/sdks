// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageConfig {

/// Extract pages as separate array in result
@JsonKey(name: 'extract_pages') bool? get extractPages;/// Insert page markers in content text
@JsonKey(name: 'insert_page_markers') bool? get insertPageMarkers;/// Page marker format template (e.g., "\n\n<!-- PAGE {page_num} -->\n\n")
@JsonKey(name: 'marker_format') String? get markerFormat;
/// Create a copy of PageConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageConfigCopyWith<PageConfig> get copyWith => _$PageConfigCopyWithImpl<PageConfig>(this as PageConfig, _$identity);

  /// Serializes this PageConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageConfig&&(identical(other.extractPages, extractPages) || other.extractPages == extractPages)&&(identical(other.insertPageMarkers, insertPageMarkers) || other.insertPageMarkers == insertPageMarkers)&&(identical(other.markerFormat, markerFormat) || other.markerFormat == markerFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,extractPages,insertPageMarkers,markerFormat);

@override
String toString() {
  return 'PageConfig(extractPages: $extractPages, insertPageMarkers: $insertPageMarkers, markerFormat: $markerFormat)';
}


}

/// @nodoc
abstract mixin class $PageConfigCopyWith<$Res>  {
  factory $PageConfigCopyWith(PageConfig value, $Res Function(PageConfig) _then) = _$PageConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'extract_pages') bool? extractPages,@JsonKey(name: 'insert_page_markers') bool? insertPageMarkers,@JsonKey(name: 'marker_format') String? markerFormat
});




}
/// @nodoc
class _$PageConfigCopyWithImpl<$Res>
    implements $PageConfigCopyWith<$Res> {
  _$PageConfigCopyWithImpl(this._self, this._then);

  final PageConfig _self;
  final $Res Function(PageConfig) _then;

/// Create a copy of PageConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? extractPages = freezed,Object? insertPageMarkers = freezed,Object? markerFormat = freezed,}) {
  return _then(_self.copyWith(
extractPages: freezed == extractPages ? _self.extractPages : extractPages // ignore: cast_nullable_to_non_nullable
as bool?,insertPageMarkers: freezed == insertPageMarkers ? _self.insertPageMarkers : insertPageMarkers // ignore: cast_nullable_to_non_nullable
as bool?,markerFormat: freezed == markerFormat ? _self.markerFormat : markerFormat // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PageConfig].
extension PageConfigPatterns on PageConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageConfig value)  $default,){
final _that = this;
switch (_that) {
case _PageConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PageConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'extract_pages')  bool? extractPages, @JsonKey(name: 'insert_page_markers')  bool? insertPageMarkers, @JsonKey(name: 'marker_format')  String? markerFormat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageConfig() when $default != null:
return $default(_that.extractPages,_that.insertPageMarkers,_that.markerFormat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'extract_pages')  bool? extractPages, @JsonKey(name: 'insert_page_markers')  bool? insertPageMarkers, @JsonKey(name: 'marker_format')  String? markerFormat)  $default,) {final _that = this;
switch (_that) {
case _PageConfig():
return $default(_that.extractPages,_that.insertPageMarkers,_that.markerFormat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'extract_pages')  bool? extractPages, @JsonKey(name: 'insert_page_markers')  bool? insertPageMarkers, @JsonKey(name: 'marker_format')  String? markerFormat)?  $default,) {final _that = this;
switch (_that) {
case _PageConfig() when $default != null:
return $default(_that.extractPages,_that.insertPageMarkers,_that.markerFormat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageConfig implements PageConfig {
  const _PageConfig({@JsonKey(name: 'extract_pages') this.extractPages, @JsonKey(name: 'insert_page_markers') this.insertPageMarkers, @JsonKey(name: 'marker_format') this.markerFormat});
  factory _PageConfig.fromJson(Map<String, dynamic> json) => _$PageConfigFromJson(json);

/// Extract pages as separate array in result
@override@JsonKey(name: 'extract_pages') final  bool? extractPages;
/// Insert page markers in content text
@override@JsonKey(name: 'insert_page_markers') final  bool? insertPageMarkers;
/// Page marker format template (e.g., "\n\n<!-- PAGE {page_num} -->\n\n")
@override@JsonKey(name: 'marker_format') final  String? markerFormat;

/// Create a copy of PageConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageConfigCopyWith<_PageConfig> get copyWith => __$PageConfigCopyWithImpl<_PageConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageConfig&&(identical(other.extractPages, extractPages) || other.extractPages == extractPages)&&(identical(other.insertPageMarkers, insertPageMarkers) || other.insertPageMarkers == insertPageMarkers)&&(identical(other.markerFormat, markerFormat) || other.markerFormat == markerFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,extractPages,insertPageMarkers,markerFormat);

@override
String toString() {
  return 'PageConfig(extractPages: $extractPages, insertPageMarkers: $insertPageMarkers, markerFormat: $markerFormat)';
}


}

/// @nodoc
abstract mixin class _$PageConfigCopyWith<$Res> implements $PageConfigCopyWith<$Res> {
  factory _$PageConfigCopyWith(_PageConfig value, $Res Function(_PageConfig) _then) = __$PageConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'extract_pages') bool? extractPages,@JsonKey(name: 'insert_page_markers') bool? insertPageMarkers,@JsonKey(name: 'marker_format') String? markerFormat
});




}
/// @nodoc
class __$PageConfigCopyWithImpl<$Res>
    implements _$PageConfigCopyWith<$Res> {
  __$PageConfigCopyWithImpl(this._self, this._then);

  final _PageConfig _self;
  final $Res Function(_PageConfig) _then;

/// Create a copy of PageConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? extractPages = freezed,Object? insertPageMarkers = freezed,Object? markerFormat = freezed,}) {
  return _then(_PageConfig(
extractPages: freezed == extractPages ? _self.extractPages : extractPages // ignore: cast_nullable_to_non_nullable
as bool?,insertPageMarkers: freezed == insertPageMarkers ? _self.insertPageMarkers : insertPageMarkers // ignore: cast_nullable_to_non_nullable
as bool?,markerFormat: freezed == markerFormat ? _self.markerFormat : markerFormat // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
