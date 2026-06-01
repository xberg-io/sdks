// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presign_document_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PresignDocumentInput {

/// Original filename
 String get filename;/// MIME type of the document
@JsonKey(name: 'mime_type') String get mimeType;/// Per-file extraction config override.
/// Merged with batch-level `config` at confirm time. None = use batch default.
 FileExtractionConfig? get config;
/// Create a copy of PresignDocumentInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresignDocumentInputCopyWith<PresignDocumentInput> get copyWith => _$PresignDocumentInputCopyWithImpl<PresignDocumentInput>(this as PresignDocumentInput, _$identity);

  /// Serializes this PresignDocumentInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresignDocumentInput&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filename,mimeType,config);

@override
String toString() {
  return 'PresignDocumentInput(filename: $filename, mimeType: $mimeType, config: $config)';
}


}

/// @nodoc
abstract mixin class $PresignDocumentInputCopyWith<$Res>  {
  factory $PresignDocumentInputCopyWith(PresignDocumentInput value, $Res Function(PresignDocumentInput) _then) = _$PresignDocumentInputCopyWithImpl;
@useResult
$Res call({
 String filename,@JsonKey(name: 'mime_type') String mimeType, FileExtractionConfig? config
});


$FileExtractionConfigCopyWith<$Res>? get config;

}
/// @nodoc
class _$PresignDocumentInputCopyWithImpl<$Res>
    implements $PresignDocumentInputCopyWith<$Res> {
  _$PresignDocumentInputCopyWithImpl(this._self, this._then);

  final PresignDocumentInput _self;
  final $Res Function(PresignDocumentInput) _then;

/// Create a copy of PresignDocumentInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filename = null,Object? mimeType = null,Object? config = freezed,}) {
  return _then(_self.copyWith(
filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as FileExtractionConfig?,
  ));
}
/// Create a copy of PresignDocumentInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FileExtractionConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
    return null;
  }

  return $FileExtractionConfigCopyWith<$Res>(_self.config!, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [PresignDocumentInput].
extension PresignDocumentInputPatterns on PresignDocumentInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PresignDocumentInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PresignDocumentInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PresignDocumentInput value)  $default,){
final _that = this;
switch (_that) {
case _PresignDocumentInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PresignDocumentInput value)?  $default,){
final _that = this;
switch (_that) {
case _PresignDocumentInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String filename, @JsonKey(name: 'mime_type')  String mimeType,  FileExtractionConfig? config)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PresignDocumentInput() when $default != null:
return $default(_that.filename,_that.mimeType,_that.config);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String filename, @JsonKey(name: 'mime_type')  String mimeType,  FileExtractionConfig? config)  $default,) {final _that = this;
switch (_that) {
case _PresignDocumentInput():
return $default(_that.filename,_that.mimeType,_that.config);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String filename, @JsonKey(name: 'mime_type')  String mimeType,  FileExtractionConfig? config)?  $default,) {final _that = this;
switch (_that) {
case _PresignDocumentInput() when $default != null:
return $default(_that.filename,_that.mimeType,_that.config);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PresignDocumentInput implements PresignDocumentInput {
  const _PresignDocumentInput({required this.filename, @JsonKey(name: 'mime_type') required this.mimeType, this.config});
  factory _PresignDocumentInput.fromJson(Map<String, dynamic> json) => _$PresignDocumentInputFromJson(json);

/// Original filename
@override final  String filename;
/// MIME type of the document
@override@JsonKey(name: 'mime_type') final  String mimeType;
/// Per-file extraction config override.
/// Merged with batch-level `config` at confirm time. None = use batch default.
@override final  FileExtractionConfig? config;

/// Create a copy of PresignDocumentInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PresignDocumentInputCopyWith<_PresignDocumentInput> get copyWith => __$PresignDocumentInputCopyWithImpl<_PresignDocumentInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PresignDocumentInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PresignDocumentInput&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filename,mimeType,config);

@override
String toString() {
  return 'PresignDocumentInput(filename: $filename, mimeType: $mimeType, config: $config)';
}


}

/// @nodoc
abstract mixin class _$PresignDocumentInputCopyWith<$Res> implements $PresignDocumentInputCopyWith<$Res> {
  factory _$PresignDocumentInputCopyWith(_PresignDocumentInput value, $Res Function(_PresignDocumentInput) _then) = __$PresignDocumentInputCopyWithImpl;
@override @useResult
$Res call({
 String filename,@JsonKey(name: 'mime_type') String mimeType, FileExtractionConfig? config
});


@override $FileExtractionConfigCopyWith<$Res>? get config;

}
/// @nodoc
class __$PresignDocumentInputCopyWithImpl<$Res>
    implements _$PresignDocumentInputCopyWith<$Res> {
  __$PresignDocumentInputCopyWithImpl(this._self, this._then);

  final _PresignDocumentInput _self;
  final $Res Function(_PresignDocumentInput) _then;

/// Create a copy of PresignDocumentInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filename = null,Object? mimeType = null,Object? config = freezed,}) {
  return _then(_PresignDocumentInput(
filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as FileExtractionConfig?,
  ));
}

/// Create a copy of PresignDocumentInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FileExtractionConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
    return null;
  }

  return $FileExtractionConfigCopyWith<$Res>(_self.config!, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

// dart format on
