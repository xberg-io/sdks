// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmailMetadata {

/// List of attachment filenames
 List<String> get attachments;/// BCC recipients
@JsonKey(name: 'bcc_emails') List<String> get bccEmails;/// CC recipients
@JsonKey(name: 'cc_emails') List<String> get ccEmails;/// Primary recipients
@JsonKey(name: 'to_emails') List<String> get toEmails;/// Sender's email address
@JsonKey(name: 'from_email') String? get fromEmail;/// Sender's display name
@JsonKey(name: 'from_name') String? get fromName;/// Message-ID header value
@JsonKey(name: 'message_id') String? get messageId;
/// Create a copy of EmailMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailMetadataCopyWith<EmailMetadata> get copyWith => _$EmailMetadataCopyWithImpl<EmailMetadata>(this as EmailMetadata, _$identity);

  /// Serializes this EmailMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailMetadata&&const DeepCollectionEquality().equals(other.attachments, attachments)&&const DeepCollectionEquality().equals(other.bccEmails, bccEmails)&&const DeepCollectionEquality().equals(other.ccEmails, ccEmails)&&const DeepCollectionEquality().equals(other.toEmails, toEmails)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.fromName, fromName) || other.fromName == fromName)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(attachments),const DeepCollectionEquality().hash(bccEmails),const DeepCollectionEquality().hash(ccEmails),const DeepCollectionEquality().hash(toEmails),fromEmail,fromName,messageId);

@override
String toString() {
  return 'EmailMetadata(attachments: $attachments, bccEmails: $bccEmails, ccEmails: $ccEmails, toEmails: $toEmails, fromEmail: $fromEmail, fromName: $fromName, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class $EmailMetadataCopyWith<$Res>  {
  factory $EmailMetadataCopyWith(EmailMetadata value, $Res Function(EmailMetadata) _then) = _$EmailMetadataCopyWithImpl;
@useResult
$Res call({
 List<String> attachments,@JsonKey(name: 'bcc_emails') List<String> bccEmails,@JsonKey(name: 'cc_emails') List<String> ccEmails,@JsonKey(name: 'to_emails') List<String> toEmails,@JsonKey(name: 'from_email') String? fromEmail,@JsonKey(name: 'from_name') String? fromName,@JsonKey(name: 'message_id') String? messageId
});




}
/// @nodoc
class _$EmailMetadataCopyWithImpl<$Res>
    implements $EmailMetadataCopyWith<$Res> {
  _$EmailMetadataCopyWithImpl(this._self, this._then);

  final EmailMetadata _self;
  final $Res Function(EmailMetadata) _then;

/// Create a copy of EmailMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attachments = null,Object? bccEmails = null,Object? ccEmails = null,Object? toEmails = null,Object? fromEmail = freezed,Object? fromName = freezed,Object? messageId = freezed,}) {
  return _then(_self.copyWith(
attachments: null == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,bccEmails: null == bccEmails ? _self.bccEmails : bccEmails // ignore: cast_nullable_to_non_nullable
as List<String>,ccEmails: null == ccEmails ? _self.ccEmails : ccEmails // ignore: cast_nullable_to_non_nullable
as List<String>,toEmails: null == toEmails ? _self.toEmails : toEmails // ignore: cast_nullable_to_non_nullable
as List<String>,fromEmail: freezed == fromEmail ? _self.fromEmail : fromEmail // ignore: cast_nullable_to_non_nullable
as String?,fromName: freezed == fromName ? _self.fromName : fromName // ignore: cast_nullable_to_non_nullable
as String?,messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailMetadata].
extension EmailMetadataPatterns on EmailMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailMetadata value)  $default,){
final _that = this;
switch (_that) {
case _EmailMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _EmailMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> attachments, @JsonKey(name: 'bcc_emails')  List<String> bccEmails, @JsonKey(name: 'cc_emails')  List<String> ccEmails, @JsonKey(name: 'to_emails')  List<String> toEmails, @JsonKey(name: 'from_email')  String? fromEmail, @JsonKey(name: 'from_name')  String? fromName, @JsonKey(name: 'message_id')  String? messageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailMetadata() when $default != null:
return $default(_that.attachments,_that.bccEmails,_that.ccEmails,_that.toEmails,_that.fromEmail,_that.fromName,_that.messageId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> attachments, @JsonKey(name: 'bcc_emails')  List<String> bccEmails, @JsonKey(name: 'cc_emails')  List<String> ccEmails, @JsonKey(name: 'to_emails')  List<String> toEmails, @JsonKey(name: 'from_email')  String? fromEmail, @JsonKey(name: 'from_name')  String? fromName, @JsonKey(name: 'message_id')  String? messageId)  $default,) {final _that = this;
switch (_that) {
case _EmailMetadata():
return $default(_that.attachments,_that.bccEmails,_that.ccEmails,_that.toEmails,_that.fromEmail,_that.fromName,_that.messageId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> attachments, @JsonKey(name: 'bcc_emails')  List<String> bccEmails, @JsonKey(name: 'cc_emails')  List<String> ccEmails, @JsonKey(name: 'to_emails')  List<String> toEmails, @JsonKey(name: 'from_email')  String? fromEmail, @JsonKey(name: 'from_name')  String? fromName, @JsonKey(name: 'message_id')  String? messageId)?  $default,) {final _that = this;
switch (_that) {
case _EmailMetadata() when $default != null:
return $default(_that.attachments,_that.bccEmails,_that.ccEmails,_that.toEmails,_that.fromEmail,_that.fromName,_that.messageId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailMetadata implements EmailMetadata {
  const _EmailMetadata({required final  List<String> attachments, @JsonKey(name: 'bcc_emails') required final  List<String> bccEmails, @JsonKey(name: 'cc_emails') required final  List<String> ccEmails, @JsonKey(name: 'to_emails') required final  List<String> toEmails, @JsonKey(name: 'from_email') this.fromEmail, @JsonKey(name: 'from_name') this.fromName, @JsonKey(name: 'message_id') this.messageId}): _attachments = attachments,_bccEmails = bccEmails,_ccEmails = ccEmails,_toEmails = toEmails;
  factory _EmailMetadata.fromJson(Map<String, dynamic> json) => _$EmailMetadataFromJson(json);

/// List of attachment filenames
 final  List<String> _attachments;
/// List of attachment filenames
@override List<String> get attachments {
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachments);
}

/// BCC recipients
 final  List<String> _bccEmails;
/// BCC recipients
@override@JsonKey(name: 'bcc_emails') List<String> get bccEmails {
  if (_bccEmails is EqualUnmodifiableListView) return _bccEmails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bccEmails);
}

/// CC recipients
 final  List<String> _ccEmails;
/// CC recipients
@override@JsonKey(name: 'cc_emails') List<String> get ccEmails {
  if (_ccEmails is EqualUnmodifiableListView) return _ccEmails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ccEmails);
}

/// Primary recipients
 final  List<String> _toEmails;
/// Primary recipients
@override@JsonKey(name: 'to_emails') List<String> get toEmails {
  if (_toEmails is EqualUnmodifiableListView) return _toEmails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_toEmails);
}

/// Sender's email address
@override@JsonKey(name: 'from_email') final  String? fromEmail;
/// Sender's display name
@override@JsonKey(name: 'from_name') final  String? fromName;
/// Message-ID header value
@override@JsonKey(name: 'message_id') final  String? messageId;

/// Create a copy of EmailMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailMetadataCopyWith<_EmailMetadata> get copyWith => __$EmailMetadataCopyWithImpl<_EmailMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailMetadata&&const DeepCollectionEquality().equals(other._attachments, _attachments)&&const DeepCollectionEquality().equals(other._bccEmails, _bccEmails)&&const DeepCollectionEquality().equals(other._ccEmails, _ccEmails)&&const DeepCollectionEquality().equals(other._toEmails, _toEmails)&&(identical(other.fromEmail, fromEmail) || other.fromEmail == fromEmail)&&(identical(other.fromName, fromName) || other.fromName == fromName)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_attachments),const DeepCollectionEquality().hash(_bccEmails),const DeepCollectionEquality().hash(_ccEmails),const DeepCollectionEquality().hash(_toEmails),fromEmail,fromName,messageId);

@override
String toString() {
  return 'EmailMetadata(attachments: $attachments, bccEmails: $bccEmails, ccEmails: $ccEmails, toEmails: $toEmails, fromEmail: $fromEmail, fromName: $fromName, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class _$EmailMetadataCopyWith<$Res> implements $EmailMetadataCopyWith<$Res> {
  factory _$EmailMetadataCopyWith(_EmailMetadata value, $Res Function(_EmailMetadata) _then) = __$EmailMetadataCopyWithImpl;
@override @useResult
$Res call({
 List<String> attachments,@JsonKey(name: 'bcc_emails') List<String> bccEmails,@JsonKey(name: 'cc_emails') List<String> ccEmails,@JsonKey(name: 'to_emails') List<String> toEmails,@JsonKey(name: 'from_email') String? fromEmail,@JsonKey(name: 'from_name') String? fromName,@JsonKey(name: 'message_id') String? messageId
});




}
/// @nodoc
class __$EmailMetadataCopyWithImpl<$Res>
    implements _$EmailMetadataCopyWith<$Res> {
  __$EmailMetadataCopyWithImpl(this._self, this._then);

  final _EmailMetadata _self;
  final $Res Function(_EmailMetadata) _then;

/// Create a copy of EmailMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attachments = null,Object? bccEmails = null,Object? ccEmails = null,Object? toEmails = null,Object? fromEmail = freezed,Object? fromName = freezed,Object? messageId = freezed,}) {
  return _then(_EmailMetadata(
attachments: null == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<String>,bccEmails: null == bccEmails ? _self._bccEmails : bccEmails // ignore: cast_nullable_to_non_nullable
as List<String>,ccEmails: null == ccEmails ? _self._ccEmails : ccEmails // ignore: cast_nullable_to_non_nullable
as List<String>,toEmails: null == toEmails ? _self._toEmails : toEmails // ignore: cast_nullable_to_non_nullable
as List<String>,fromEmail: freezed == fromEmail ? _self.fromEmail : fromEmail // ignore: cast_nullable_to_non_nullable
as String?,fromName: freezed == fromName ? _self.fromName : fromName // ignore: cast_nullable_to_non_nullable
as String?,messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
