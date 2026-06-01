// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'annotation_kind.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AnnotationKind _$AnnotationKindFromJson(
  Map<String, dynamic> json
) {
        switch (json['annotation_type']) {
                  case 'bold':
          return AnnotationKindBold.fromJson(
            json
          );
                case 'italic':
          return AnnotationKindItalic.fromJson(
            json
          );
                case 'underline':
          return AnnotationKindUnderline.fromJson(
            json
          );
                case 'strikethrough':
          return AnnotationKindStrikethrough.fromJson(
            json
          );
                case 'code':
          return AnnotationKindCode.fromJson(
            json
          );
                case 'subscript':
          return AnnotationKindSubscript.fromJson(
            json
          );
                case 'superscript':
          return AnnotationKindSuperscript.fromJson(
            json
          );
                case 'link':
          return AnnotationKindLink.fromJson(
            json
          );
                case 'highlight':
          return AnnotationKindHighlight.fromJson(
            json
          );
                case 'color':
          return AnnotationKindColor.fromJson(
            json
          );
                case 'font_size':
          return AnnotationKindFontSize.fromJson(
            json
          );
                case 'custom':
          return AnnotationKindCustom.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'annotation_type',
  'AnnotationKind',
  'Invalid union type "${json['annotation_type']}"!'
);
        }
      
}

/// @nodoc
mixin _$AnnotationKind {



  /// Serializes this AnnotationKind to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKind);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind()';
}


}

/// @nodoc
class $AnnotationKindCopyWith<$Res>  {
$AnnotationKindCopyWith(AnnotationKind _, $Res Function(AnnotationKind) __);
}


/// Adds pattern-matching-related methods to [AnnotationKind].
extension AnnotationKindPatterns on AnnotationKind {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AnnotationKindBold value)?  bold,TResult Function( AnnotationKindItalic value)?  italic,TResult Function( AnnotationKindUnderline value)?  underline,TResult Function( AnnotationKindStrikethrough value)?  strikethrough,TResult Function( AnnotationKindCode value)?  code,TResult Function( AnnotationKindSubscript value)?  subscript,TResult Function( AnnotationKindSuperscript value)?  superscript,TResult Function( AnnotationKindLink value)?  link,TResult Function( AnnotationKindHighlight value)?  highlight,TResult Function( AnnotationKindColor value)?  color,TResult Function( AnnotationKindFontSize value)?  fontSize,TResult Function( AnnotationKindCustom value)?  custom,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AnnotationKindBold() when bold != null:
return bold(_that);case AnnotationKindItalic() when italic != null:
return italic(_that);case AnnotationKindUnderline() when underline != null:
return underline(_that);case AnnotationKindStrikethrough() when strikethrough != null:
return strikethrough(_that);case AnnotationKindCode() when code != null:
return code(_that);case AnnotationKindSubscript() when subscript != null:
return subscript(_that);case AnnotationKindSuperscript() when superscript != null:
return superscript(_that);case AnnotationKindLink() when link != null:
return link(_that);case AnnotationKindHighlight() when highlight != null:
return highlight(_that);case AnnotationKindColor() when color != null:
return color(_that);case AnnotationKindFontSize() when fontSize != null:
return fontSize(_that);case AnnotationKindCustom() when custom != null:
return custom(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AnnotationKindBold value)  bold,required TResult Function( AnnotationKindItalic value)  italic,required TResult Function( AnnotationKindUnderline value)  underline,required TResult Function( AnnotationKindStrikethrough value)  strikethrough,required TResult Function( AnnotationKindCode value)  code,required TResult Function( AnnotationKindSubscript value)  subscript,required TResult Function( AnnotationKindSuperscript value)  superscript,required TResult Function( AnnotationKindLink value)  link,required TResult Function( AnnotationKindHighlight value)  highlight,required TResult Function( AnnotationKindColor value)  color,required TResult Function( AnnotationKindFontSize value)  fontSize,required TResult Function( AnnotationKindCustom value)  custom,}){
final _that = this;
switch (_that) {
case AnnotationKindBold():
return bold(_that);case AnnotationKindItalic():
return italic(_that);case AnnotationKindUnderline():
return underline(_that);case AnnotationKindStrikethrough():
return strikethrough(_that);case AnnotationKindCode():
return code(_that);case AnnotationKindSubscript():
return subscript(_that);case AnnotationKindSuperscript():
return superscript(_that);case AnnotationKindLink():
return link(_that);case AnnotationKindHighlight():
return highlight(_that);case AnnotationKindColor():
return color(_that);case AnnotationKindFontSize():
return fontSize(_that);case AnnotationKindCustom():
return custom(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AnnotationKindBold value)?  bold,TResult? Function( AnnotationKindItalic value)?  italic,TResult? Function( AnnotationKindUnderline value)?  underline,TResult? Function( AnnotationKindStrikethrough value)?  strikethrough,TResult? Function( AnnotationKindCode value)?  code,TResult? Function( AnnotationKindSubscript value)?  subscript,TResult? Function( AnnotationKindSuperscript value)?  superscript,TResult? Function( AnnotationKindLink value)?  link,TResult? Function( AnnotationKindHighlight value)?  highlight,TResult? Function( AnnotationKindColor value)?  color,TResult? Function( AnnotationKindFontSize value)?  fontSize,TResult? Function( AnnotationKindCustom value)?  custom,}){
final _that = this;
switch (_that) {
case AnnotationKindBold() when bold != null:
return bold(_that);case AnnotationKindItalic() when italic != null:
return italic(_that);case AnnotationKindUnderline() when underline != null:
return underline(_that);case AnnotationKindStrikethrough() when strikethrough != null:
return strikethrough(_that);case AnnotationKindCode() when code != null:
return code(_that);case AnnotationKindSubscript() when subscript != null:
return subscript(_that);case AnnotationKindSuperscript() when superscript != null:
return superscript(_that);case AnnotationKindLink() when link != null:
return link(_that);case AnnotationKindHighlight() when highlight != null:
return highlight(_that);case AnnotationKindColor() when color != null:
return color(_that);case AnnotationKindFontSize() when fontSize != null:
return fontSize(_that);case AnnotationKindCustom() when custom != null:
return custom(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  bold,TResult Function()?  italic,TResult Function()?  underline,TResult Function()?  strikethrough,TResult Function()?  code,TResult Function()?  subscript,TResult Function()?  superscript,TResult Function( String url,  String? title)?  link,TResult Function()?  highlight,TResult Function( String value)?  color,TResult Function( String value)?  fontSize,TResult Function( String name,  String? value)?  custom,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AnnotationKindBold() when bold != null:
return bold();case AnnotationKindItalic() when italic != null:
return italic();case AnnotationKindUnderline() when underline != null:
return underline();case AnnotationKindStrikethrough() when strikethrough != null:
return strikethrough();case AnnotationKindCode() when code != null:
return code();case AnnotationKindSubscript() when subscript != null:
return subscript();case AnnotationKindSuperscript() when superscript != null:
return superscript();case AnnotationKindLink() when link != null:
return link(_that.url,_that.title);case AnnotationKindHighlight() when highlight != null:
return highlight();case AnnotationKindColor() when color != null:
return color(_that.value);case AnnotationKindFontSize() when fontSize != null:
return fontSize(_that.value);case AnnotationKindCustom() when custom != null:
return custom(_that.name,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  bold,required TResult Function()  italic,required TResult Function()  underline,required TResult Function()  strikethrough,required TResult Function()  code,required TResult Function()  subscript,required TResult Function()  superscript,required TResult Function( String url,  String? title)  link,required TResult Function()  highlight,required TResult Function( String value)  color,required TResult Function( String value)  fontSize,required TResult Function( String name,  String? value)  custom,}) {final _that = this;
switch (_that) {
case AnnotationKindBold():
return bold();case AnnotationKindItalic():
return italic();case AnnotationKindUnderline():
return underline();case AnnotationKindStrikethrough():
return strikethrough();case AnnotationKindCode():
return code();case AnnotationKindSubscript():
return subscript();case AnnotationKindSuperscript():
return superscript();case AnnotationKindLink():
return link(_that.url,_that.title);case AnnotationKindHighlight():
return highlight();case AnnotationKindColor():
return color(_that.value);case AnnotationKindFontSize():
return fontSize(_that.value);case AnnotationKindCustom():
return custom(_that.name,_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  bold,TResult? Function()?  italic,TResult? Function()?  underline,TResult? Function()?  strikethrough,TResult? Function()?  code,TResult? Function()?  subscript,TResult? Function()?  superscript,TResult? Function( String url,  String? title)?  link,TResult? Function()?  highlight,TResult? Function( String value)?  color,TResult? Function( String value)?  fontSize,TResult? Function( String name,  String? value)?  custom,}) {final _that = this;
switch (_that) {
case AnnotationKindBold() when bold != null:
return bold();case AnnotationKindItalic() when italic != null:
return italic();case AnnotationKindUnderline() when underline != null:
return underline();case AnnotationKindStrikethrough() when strikethrough != null:
return strikethrough();case AnnotationKindCode() when code != null:
return code();case AnnotationKindSubscript() when subscript != null:
return subscript();case AnnotationKindSuperscript() when superscript != null:
return superscript();case AnnotationKindLink() when link != null:
return link(_that.url,_that.title);case AnnotationKindHighlight() when highlight != null:
return highlight();case AnnotationKindColor() when color != null:
return color(_that.value);case AnnotationKindFontSize() when fontSize != null:
return fontSize(_that.value);case AnnotationKindCustom() when custom != null:
return custom(_that.name,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AnnotationKindBold implements AnnotationKind {
  const AnnotationKindBold({final  String? $type}): $type = $type ?? 'bold';
  factory AnnotationKindBold.fromJson(Map<String, dynamic> json) => _$AnnotationKindBoldFromJson(json);



@JsonKey(name: 'annotation_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindBoldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindBold);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind.bold()';
}


}




/// @nodoc
@JsonSerializable()

class AnnotationKindItalic implements AnnotationKind {
  const AnnotationKindItalic({final  String? $type}): $type = $type ?? 'italic';
  factory AnnotationKindItalic.fromJson(Map<String, dynamic> json) => _$AnnotationKindItalicFromJson(json);



@JsonKey(name: 'annotation_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindItalicToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindItalic);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind.italic()';
}


}




/// @nodoc
@JsonSerializable()

class AnnotationKindUnderline implements AnnotationKind {
  const AnnotationKindUnderline({final  String? $type}): $type = $type ?? 'underline';
  factory AnnotationKindUnderline.fromJson(Map<String, dynamic> json) => _$AnnotationKindUnderlineFromJson(json);



@JsonKey(name: 'annotation_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindUnderlineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindUnderline);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind.underline()';
}


}




/// @nodoc
@JsonSerializable()

class AnnotationKindStrikethrough implements AnnotationKind {
  const AnnotationKindStrikethrough({final  String? $type}): $type = $type ?? 'strikethrough';
  factory AnnotationKindStrikethrough.fromJson(Map<String, dynamic> json) => _$AnnotationKindStrikethroughFromJson(json);



@JsonKey(name: 'annotation_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindStrikethroughToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindStrikethrough);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind.strikethrough()';
}


}




/// @nodoc
@JsonSerializable()

class AnnotationKindCode implements AnnotationKind {
  const AnnotationKindCode({final  String? $type}): $type = $type ?? 'code';
  factory AnnotationKindCode.fromJson(Map<String, dynamic> json) => _$AnnotationKindCodeFromJson(json);



@JsonKey(name: 'annotation_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindCode);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind.code()';
}


}




/// @nodoc
@JsonSerializable()

class AnnotationKindSubscript implements AnnotationKind {
  const AnnotationKindSubscript({final  String? $type}): $type = $type ?? 'subscript';
  factory AnnotationKindSubscript.fromJson(Map<String, dynamic> json) => _$AnnotationKindSubscriptFromJson(json);



@JsonKey(name: 'annotation_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindSubscriptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindSubscript);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind.subscript()';
}


}




/// @nodoc
@JsonSerializable()

class AnnotationKindSuperscript implements AnnotationKind {
  const AnnotationKindSuperscript({final  String? $type}): $type = $type ?? 'superscript';
  factory AnnotationKindSuperscript.fromJson(Map<String, dynamic> json) => _$AnnotationKindSuperscriptFromJson(json);



@JsonKey(name: 'annotation_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindSuperscriptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindSuperscript);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind.superscript()';
}


}




/// @nodoc
@JsonSerializable()

class AnnotationKindLink implements AnnotationKind {
  const AnnotationKindLink({required this.url, this.title, final  String? $type}): $type = $type ?? 'link';
  factory AnnotationKindLink.fromJson(Map<String, dynamic> json) => _$AnnotationKindLinkFromJson(json);

 final  String url;
 final  String? title;

@JsonKey(name: 'annotation_type')
final String $type;


/// Create a copy of AnnotationKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotationKindLinkCopyWith<AnnotationKindLink> get copyWith => _$AnnotationKindLinkCopyWithImpl<AnnotationKindLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindLink&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,title);

@override
String toString() {
  return 'AnnotationKind.link(url: $url, title: $title)';
}


}

/// @nodoc
abstract mixin class $AnnotationKindLinkCopyWith<$Res> implements $AnnotationKindCopyWith<$Res> {
  factory $AnnotationKindLinkCopyWith(AnnotationKindLink value, $Res Function(AnnotationKindLink) _then) = _$AnnotationKindLinkCopyWithImpl;
@useResult
$Res call({
 String url, String? title
});




}
/// @nodoc
class _$AnnotationKindLinkCopyWithImpl<$Res>
    implements $AnnotationKindLinkCopyWith<$Res> {
  _$AnnotationKindLinkCopyWithImpl(this._self, this._then);

  final AnnotationKindLink _self;
  final $Res Function(AnnotationKindLink) _then;

/// Create a copy of AnnotationKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? title = freezed,}) {
  return _then(AnnotationKindLink(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnnotationKindHighlight implements AnnotationKind {
  const AnnotationKindHighlight({final  String? $type}): $type = $type ?? 'highlight';
  factory AnnotationKindHighlight.fromJson(Map<String, dynamic> json) => _$AnnotationKindHighlightFromJson(json);



@JsonKey(name: 'annotation_type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindHighlightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindHighlight);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnnotationKind.highlight()';
}


}




/// @nodoc
@JsonSerializable()

class AnnotationKindColor implements AnnotationKind {
  const AnnotationKindColor({required this.value, final  String? $type}): $type = $type ?? 'color';
  factory AnnotationKindColor.fromJson(Map<String, dynamic> json) => _$AnnotationKindColorFromJson(json);

 final  String value;

@JsonKey(name: 'annotation_type')
final String $type;


/// Create a copy of AnnotationKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotationKindColorCopyWith<AnnotationKindColor> get copyWith => _$AnnotationKindColorCopyWithImpl<AnnotationKindColor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindColorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindColor&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AnnotationKind.color(value: $value)';
}


}

/// @nodoc
abstract mixin class $AnnotationKindColorCopyWith<$Res> implements $AnnotationKindCopyWith<$Res> {
  factory $AnnotationKindColorCopyWith(AnnotationKindColor value, $Res Function(AnnotationKindColor) _then) = _$AnnotationKindColorCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$AnnotationKindColorCopyWithImpl<$Res>
    implements $AnnotationKindColorCopyWith<$Res> {
  _$AnnotationKindColorCopyWithImpl(this._self, this._then);

  final AnnotationKindColor _self;
  final $Res Function(AnnotationKindColor) _then;

/// Create a copy of AnnotationKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(AnnotationKindColor(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnnotationKindFontSize implements AnnotationKind {
  const AnnotationKindFontSize({required this.value, final  String? $type}): $type = $type ?? 'font_size';
  factory AnnotationKindFontSize.fromJson(Map<String, dynamic> json) => _$AnnotationKindFontSizeFromJson(json);

 final  String value;

@JsonKey(name: 'annotation_type')
final String $type;


/// Create a copy of AnnotationKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotationKindFontSizeCopyWith<AnnotationKindFontSize> get copyWith => _$AnnotationKindFontSizeCopyWithImpl<AnnotationKindFontSize>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindFontSizeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindFontSize&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'AnnotationKind.fontSize(value: $value)';
}


}

/// @nodoc
abstract mixin class $AnnotationKindFontSizeCopyWith<$Res> implements $AnnotationKindCopyWith<$Res> {
  factory $AnnotationKindFontSizeCopyWith(AnnotationKindFontSize value, $Res Function(AnnotationKindFontSize) _then) = _$AnnotationKindFontSizeCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$AnnotationKindFontSizeCopyWithImpl<$Res>
    implements $AnnotationKindFontSizeCopyWith<$Res> {
  _$AnnotationKindFontSizeCopyWithImpl(this._self, this._then);

  final AnnotationKindFontSize _self;
  final $Res Function(AnnotationKindFontSize) _then;

/// Create a copy of AnnotationKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(AnnotationKindFontSize(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnnotationKindCustom implements AnnotationKind {
  const AnnotationKindCustom({required this.name, this.value, final  String? $type}): $type = $type ?? 'custom';
  factory AnnotationKindCustom.fromJson(Map<String, dynamic> json) => _$AnnotationKindCustomFromJson(json);

 final  String name;
 final  String? value;

@JsonKey(name: 'annotation_type')
final String $type;


/// Create a copy of AnnotationKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotationKindCustomCopyWith<AnnotationKindCustom> get copyWith => _$AnnotationKindCustomCopyWithImpl<AnnotationKindCustom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnotationKindCustomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationKindCustom&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,value);

@override
String toString() {
  return 'AnnotationKind.custom(name: $name, value: $value)';
}


}

/// @nodoc
abstract mixin class $AnnotationKindCustomCopyWith<$Res> implements $AnnotationKindCopyWith<$Res> {
  factory $AnnotationKindCustomCopyWith(AnnotationKindCustom value, $Res Function(AnnotationKindCustom) _then) = _$AnnotationKindCustomCopyWithImpl;
@useResult
$Res call({
 String name, String? value
});




}
/// @nodoc
class _$AnnotationKindCustomCopyWithImpl<$Res>
    implements $AnnotationKindCustomCopyWith<$Res> {
  _$AnnotationKindCustomCopyWithImpl(this._self, this._then);

  final AnnotationKindCustom _self;
  final $Res Function(AnnotationKindCustom) _then;

/// Create a copy of AnnotationKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? value = freezed,}) {
  return _then(AnnotationKindCustom(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
