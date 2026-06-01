// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extracted_uri.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExtractedUri {

/// Semantic classification of the URI.
 UriKind get kind;/// The URL or path string.
 String get url;/// Optional display text / label for the link.
 String? get label;/// Optional page number where the URI was found (1-indexed).
 int? get page;
/// Create a copy of ExtractedUri
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtractedUriCopyWith<ExtractedUri> get copyWith => _$ExtractedUriCopyWithImpl<ExtractedUri>(this as ExtractedUri, _$identity);

  /// Serializes this ExtractedUri to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtractedUri&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.url, url) || other.url == url)&&(identical(other.label, label) || other.label == label)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,url,label,page);

@override
String toString() {
  return 'ExtractedUri(kind: $kind, url: $url, label: $label, page: $page)';
}


}

/// @nodoc
abstract mixin class $ExtractedUriCopyWith<$Res>  {
  factory $ExtractedUriCopyWith(ExtractedUri value, $Res Function(ExtractedUri) _then) = _$ExtractedUriCopyWithImpl;
@useResult
$Res call({
 UriKind kind, String url, String? label, int? page
});




}
/// @nodoc
class _$ExtractedUriCopyWithImpl<$Res>
    implements $ExtractedUriCopyWith<$Res> {
  _$ExtractedUriCopyWithImpl(this._self, this._then);

  final ExtractedUri _self;
  final $Res Function(ExtractedUri) _then;

/// Create a copy of ExtractedUri
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? url = null,Object? label = freezed,Object? page = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as UriKind,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExtractedUri].
extension ExtractedUriPatterns on ExtractedUri {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtractedUri value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtractedUri() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtractedUri value)  $default,){
final _that = this;
switch (_that) {
case _ExtractedUri():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtractedUri value)?  $default,){
final _that = this;
switch (_that) {
case _ExtractedUri() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UriKind kind,  String url,  String? label,  int? page)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtractedUri() when $default != null:
return $default(_that.kind,_that.url,_that.label,_that.page);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UriKind kind,  String url,  String? label,  int? page)  $default,) {final _that = this;
switch (_that) {
case _ExtractedUri():
return $default(_that.kind,_that.url,_that.label,_that.page);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UriKind kind,  String url,  String? label,  int? page)?  $default,) {final _that = this;
switch (_that) {
case _ExtractedUri() when $default != null:
return $default(_that.kind,_that.url,_that.label,_that.page);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtractedUri implements ExtractedUri {
  const _ExtractedUri({required this.kind, required this.url, this.label, this.page});
  factory _ExtractedUri.fromJson(Map<String, dynamic> json) => _$ExtractedUriFromJson(json);

/// Semantic classification of the URI.
@override final  UriKind kind;
/// The URL or path string.
@override final  String url;
/// Optional display text / label for the link.
@override final  String? label;
/// Optional page number where the URI was found (1-indexed).
@override final  int? page;

/// Create a copy of ExtractedUri
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtractedUriCopyWith<_ExtractedUri> get copyWith => __$ExtractedUriCopyWithImpl<_ExtractedUri>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtractedUriToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtractedUri&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.url, url) || other.url == url)&&(identical(other.label, label) || other.label == label)&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,url,label,page);

@override
String toString() {
  return 'ExtractedUri(kind: $kind, url: $url, label: $label, page: $page)';
}


}

/// @nodoc
abstract mixin class _$ExtractedUriCopyWith<$Res> implements $ExtractedUriCopyWith<$Res> {
  factory _$ExtractedUriCopyWith(_ExtractedUri value, $Res Function(_ExtractedUri) _then) = __$ExtractedUriCopyWithImpl;
@override @useResult
$Res call({
 UriKind kind, String url, String? label, int? page
});




}
/// @nodoc
class __$ExtractedUriCopyWithImpl<$Res>
    implements _$ExtractedUriCopyWith<$Res> {
  __$ExtractedUriCopyWithImpl(this._self, this._then);

  final _ExtractedUri _self;
  final $Res Function(_ExtractedUri) _then;

/// Create a copy of ExtractedUri
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? url = null,Object? label = freezed,Object? page = freezed,}) {
  return _then(_ExtractedUri(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as UriKind,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
