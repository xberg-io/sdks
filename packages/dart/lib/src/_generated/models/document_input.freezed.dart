// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentInput {

/// Base64-encoded document data
 String get data;/// Original filename
 String get filename;/// MIME type of the document
@JsonKey(name: 'mime_type') String get mimeType;/// Optional client-supplied document identifier. When provided, this.
/// extraction is recorded as a version of that logical document and the.
/// response carries `document_id` + `version_sequence`. Server mints a.
/// new UUID when absent.
@JsonKey(name: 'document_id') String? get documentId;
/// Create a copy of DocumentInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentInputCopyWith<DocumentInput> get copyWith => _$DocumentInputCopyWithImpl<DocumentInput>(this as DocumentInput, _$identity);

  /// Serializes this DocumentInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentInput&&(identical(other.data, data) || other.data == data)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.documentId, documentId) || other.documentId == documentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,filename,mimeType,documentId);

@override
String toString() {
  return 'DocumentInput(data: $data, filename: $filename, mimeType: $mimeType, documentId: $documentId)';
}


}

/// @nodoc
abstract mixin class $DocumentInputCopyWith<$Res>  {
  factory $DocumentInputCopyWith(DocumentInput value, $Res Function(DocumentInput) _then) = _$DocumentInputCopyWithImpl;
@useResult
$Res call({
 String data, String filename,@JsonKey(name: 'mime_type') String mimeType,@JsonKey(name: 'document_id') String? documentId
});




}
/// @nodoc
class _$DocumentInputCopyWithImpl<$Res>
    implements $DocumentInputCopyWith<$Res> {
  _$DocumentInputCopyWithImpl(this._self, this._then);

  final DocumentInput _self;
  final $Res Function(DocumentInput) _then;

/// Create a copy of DocumentInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? filename = null,Object? mimeType = null,Object? documentId = freezed,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentInput].
extension DocumentInputPatterns on DocumentInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentInput value)  $default,){
final _that = this;
switch (_that) {
case _DocumentInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentInput value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String data,  String filename, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'document_id')  String? documentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentInput() when $default != null:
return $default(_that.data,_that.filename,_that.mimeType,_that.documentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String data,  String filename, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'document_id')  String? documentId)  $default,) {final _that = this;
switch (_that) {
case _DocumentInput():
return $default(_that.data,_that.filename,_that.mimeType,_that.documentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String data,  String filename, @JsonKey(name: 'mime_type')  String mimeType, @JsonKey(name: 'document_id')  String? documentId)?  $default,) {final _that = this;
switch (_that) {
case _DocumentInput() when $default != null:
return $default(_that.data,_that.filename,_that.mimeType,_that.documentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentInput implements DocumentInput {
  const _DocumentInput({required this.data, required this.filename, @JsonKey(name: 'mime_type') required this.mimeType, @JsonKey(name: 'document_id') this.documentId});
  factory _DocumentInput.fromJson(Map<String, dynamic> json) => _$DocumentInputFromJson(json);

/// Base64-encoded document data
@override final  String data;
/// Original filename
@override final  String filename;
/// MIME type of the document
@override@JsonKey(name: 'mime_type') final  String mimeType;
/// Optional client-supplied document identifier. When provided, this.
/// extraction is recorded as a version of that logical document and the.
/// response carries `document_id` + `version_sequence`. Server mints a.
/// new UUID when absent.
@override@JsonKey(name: 'document_id') final  String? documentId;

/// Create a copy of DocumentInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentInputCopyWith<_DocumentInput> get copyWith => __$DocumentInputCopyWithImpl<_DocumentInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentInput&&(identical(other.data, data) || other.data == data)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.documentId, documentId) || other.documentId == documentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data,filename,mimeType,documentId);

@override
String toString() {
  return 'DocumentInput(data: $data, filename: $filename, mimeType: $mimeType, documentId: $documentId)';
}


}

/// @nodoc
abstract mixin class _$DocumentInputCopyWith<$Res> implements $DocumentInputCopyWith<$Res> {
  factory _$DocumentInputCopyWith(_DocumentInput value, $Res Function(_DocumentInput) _then) = __$DocumentInputCopyWithImpl;
@override @useResult
$Res call({
 String data, String filename,@JsonKey(name: 'mime_type') String mimeType,@JsonKey(name: 'document_id') String? documentId
});




}
/// @nodoc
class __$DocumentInputCopyWithImpl<$Res>
    implements _$DocumentInputCopyWith<$Res> {
  __$DocumentInputCopyWithImpl(this._self, this._then);

  final _DocumentInput _self;
  final $Res Function(_DocumentInput) _then;

/// Create a copy of DocumentInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? filename = null,Object? mimeType = null,Object? documentId = freezed,}) {
  return _then(_DocumentInput(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
