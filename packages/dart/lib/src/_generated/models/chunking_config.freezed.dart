// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chunking_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChunkingConfig {

/// Chunker type: "text", "markdown", "yaml"
@JsonKey(name: 'chunker_type') String? get chunkerType;/// Embedding generation configuration
 EmbeddingConfig? get embedding;/// Maximum chunk size in characters
@JsonKey(name: 'max_characters') int? get maxCharacters;/// Overlap between adjacent chunks in characters
 int? get overlap;/// Preset name (overrides other settings)
 String? get preset;/// Trim whitespace from chunk boundaries
 bool? get trim;
/// Create a copy of ChunkingConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChunkingConfigCopyWith<ChunkingConfig> get copyWith => _$ChunkingConfigCopyWithImpl<ChunkingConfig>(this as ChunkingConfig, _$identity);

  /// Serializes this ChunkingConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChunkingConfig&&(identical(other.chunkerType, chunkerType) || other.chunkerType == chunkerType)&&(identical(other.embedding, embedding) || other.embedding == embedding)&&(identical(other.maxCharacters, maxCharacters) || other.maxCharacters == maxCharacters)&&(identical(other.overlap, overlap) || other.overlap == overlap)&&(identical(other.preset, preset) || other.preset == preset)&&(identical(other.trim, trim) || other.trim == trim));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chunkerType,embedding,maxCharacters,overlap,preset,trim);

@override
String toString() {
  return 'ChunkingConfig(chunkerType: $chunkerType, embedding: $embedding, maxCharacters: $maxCharacters, overlap: $overlap, preset: $preset, trim: $trim)';
}


}

/// @nodoc
abstract mixin class $ChunkingConfigCopyWith<$Res>  {
  factory $ChunkingConfigCopyWith(ChunkingConfig value, $Res Function(ChunkingConfig) _then) = _$ChunkingConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'chunker_type') String? chunkerType, EmbeddingConfig? embedding,@JsonKey(name: 'max_characters') int? maxCharacters, int? overlap, String? preset, bool? trim
});


$EmbeddingConfigCopyWith<$Res>? get embedding;

}
/// @nodoc
class _$ChunkingConfigCopyWithImpl<$Res>
    implements $ChunkingConfigCopyWith<$Res> {
  _$ChunkingConfigCopyWithImpl(this._self, this._then);

  final ChunkingConfig _self;
  final $Res Function(ChunkingConfig) _then;

/// Create a copy of ChunkingConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chunkerType = freezed,Object? embedding = freezed,Object? maxCharacters = freezed,Object? overlap = freezed,Object? preset = freezed,Object? trim = freezed,}) {
  return _then(_self.copyWith(
chunkerType: freezed == chunkerType ? _self.chunkerType : chunkerType // ignore: cast_nullable_to_non_nullable
as String?,embedding: freezed == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as EmbeddingConfig?,maxCharacters: freezed == maxCharacters ? _self.maxCharacters : maxCharacters // ignore: cast_nullable_to_non_nullable
as int?,overlap: freezed == overlap ? _self.overlap : overlap // ignore: cast_nullable_to_non_nullable
as int?,preset: freezed == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as String?,trim: freezed == trim ? _self.trim : trim // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of ChunkingConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmbeddingConfigCopyWith<$Res>? get embedding {
    if (_self.embedding == null) {
    return null;
  }

  return $EmbeddingConfigCopyWith<$Res>(_self.embedding!, (value) {
    return _then(_self.copyWith(embedding: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChunkingConfig].
extension ChunkingConfigPatterns on ChunkingConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChunkingConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChunkingConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChunkingConfig value)  $default,){
final _that = this;
switch (_that) {
case _ChunkingConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChunkingConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ChunkingConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'chunker_type')  String? chunkerType,  EmbeddingConfig? embedding, @JsonKey(name: 'max_characters')  int? maxCharacters,  int? overlap,  String? preset,  bool? trim)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChunkingConfig() when $default != null:
return $default(_that.chunkerType,_that.embedding,_that.maxCharacters,_that.overlap,_that.preset,_that.trim);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'chunker_type')  String? chunkerType,  EmbeddingConfig? embedding, @JsonKey(name: 'max_characters')  int? maxCharacters,  int? overlap,  String? preset,  bool? trim)  $default,) {final _that = this;
switch (_that) {
case _ChunkingConfig():
return $default(_that.chunkerType,_that.embedding,_that.maxCharacters,_that.overlap,_that.preset,_that.trim);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'chunker_type')  String? chunkerType,  EmbeddingConfig? embedding, @JsonKey(name: 'max_characters')  int? maxCharacters,  int? overlap,  String? preset,  bool? trim)?  $default,) {final _that = this;
switch (_that) {
case _ChunkingConfig() when $default != null:
return $default(_that.chunkerType,_that.embedding,_that.maxCharacters,_that.overlap,_that.preset,_that.trim);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChunkingConfig implements ChunkingConfig {
  const _ChunkingConfig({@JsonKey(name: 'chunker_type') this.chunkerType, this.embedding, @JsonKey(name: 'max_characters') this.maxCharacters, this.overlap, this.preset, this.trim});
  factory _ChunkingConfig.fromJson(Map<String, dynamic> json) => _$ChunkingConfigFromJson(json);

/// Chunker type: "text", "markdown", "yaml"
@override@JsonKey(name: 'chunker_type') final  String? chunkerType;
/// Embedding generation configuration
@override final  EmbeddingConfig? embedding;
/// Maximum chunk size in characters
@override@JsonKey(name: 'max_characters') final  int? maxCharacters;
/// Overlap between adjacent chunks in characters
@override final  int? overlap;
/// Preset name (overrides other settings)
@override final  String? preset;
/// Trim whitespace from chunk boundaries
@override final  bool? trim;

/// Create a copy of ChunkingConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChunkingConfigCopyWith<_ChunkingConfig> get copyWith => __$ChunkingConfigCopyWithImpl<_ChunkingConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChunkingConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChunkingConfig&&(identical(other.chunkerType, chunkerType) || other.chunkerType == chunkerType)&&(identical(other.embedding, embedding) || other.embedding == embedding)&&(identical(other.maxCharacters, maxCharacters) || other.maxCharacters == maxCharacters)&&(identical(other.overlap, overlap) || other.overlap == overlap)&&(identical(other.preset, preset) || other.preset == preset)&&(identical(other.trim, trim) || other.trim == trim));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chunkerType,embedding,maxCharacters,overlap,preset,trim);

@override
String toString() {
  return 'ChunkingConfig(chunkerType: $chunkerType, embedding: $embedding, maxCharacters: $maxCharacters, overlap: $overlap, preset: $preset, trim: $trim)';
}


}

/// @nodoc
abstract mixin class _$ChunkingConfigCopyWith<$Res> implements $ChunkingConfigCopyWith<$Res> {
  factory _$ChunkingConfigCopyWith(_ChunkingConfig value, $Res Function(_ChunkingConfig) _then) = __$ChunkingConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'chunker_type') String? chunkerType, EmbeddingConfig? embedding,@JsonKey(name: 'max_characters') int? maxCharacters, int? overlap, String? preset, bool? trim
});


@override $EmbeddingConfigCopyWith<$Res>? get embedding;

}
/// @nodoc
class __$ChunkingConfigCopyWithImpl<$Res>
    implements _$ChunkingConfigCopyWith<$Res> {
  __$ChunkingConfigCopyWithImpl(this._self, this._then);

  final _ChunkingConfig _self;
  final $Res Function(_ChunkingConfig) _then;

/// Create a copy of ChunkingConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chunkerType = freezed,Object? embedding = freezed,Object? maxCharacters = freezed,Object? overlap = freezed,Object? preset = freezed,Object? trim = freezed,}) {
  return _then(_ChunkingConfig(
chunkerType: freezed == chunkerType ? _self.chunkerType : chunkerType // ignore: cast_nullable_to_non_nullable
as String?,embedding: freezed == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as EmbeddingConfig?,maxCharacters: freezed == maxCharacters ? _self.maxCharacters : maxCharacters // ignore: cast_nullable_to_non_nullable
as int?,overlap: freezed == overlap ? _self.overlap : overlap // ignore: cast_nullable_to_non_nullable
as int?,preset: freezed == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as String?,trim: freezed == trim ? _self.trim : trim // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of ChunkingConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmbeddingConfigCopyWith<$Res>? get embedding {
    if (_self.embedding == null) {
    return null;
  }

  return $EmbeddingConfigCopyWith<$Res>(_self.embedding!, (value) {
    return _then(_self.copyWith(embedding: value));
  });
}
}

// dart format on
