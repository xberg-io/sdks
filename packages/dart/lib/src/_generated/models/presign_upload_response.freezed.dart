// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presign_upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PresignUploadResponse {
  /// Batch ID — pass this to the confirm endpoint
  @JsonKey(name: 'batch_id')
  String get batchId;

  /// Per-document upload URLs
  List<PresignedUploadInfo> get uploads;

  /// Create a copy of PresignUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PresignUploadResponseCopyWith<PresignUploadResponse> get copyWith =>
      _$PresignUploadResponseCopyWithImpl<PresignUploadResponse>(
          this as PresignUploadResponse, _$identity);

  /// Serializes this PresignUploadResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PresignUploadResponse &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            const DeepCollectionEquality().equals(other.uploads, uploads));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, batchId, const DeepCollectionEquality().hash(uploads));

  @override
  String toString() {
    return 'PresignUploadResponse(batchId: $batchId, uploads: $uploads)';
  }
}

/// @nodoc
abstract mixin class $PresignUploadResponseCopyWith<$Res> {
  factory $PresignUploadResponseCopyWith(PresignUploadResponse value,
          $Res Function(PresignUploadResponse) _then) =
      _$PresignUploadResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'batch_id') String batchId,
      List<PresignedUploadInfo> uploads});
}

/// @nodoc
class _$PresignUploadResponseCopyWithImpl<$Res>
    implements $PresignUploadResponseCopyWith<$Res> {
  _$PresignUploadResponseCopyWithImpl(this._self, this._then);

  final PresignUploadResponse _self;
  final $Res Function(PresignUploadResponse) _then;

  /// Create a copy of PresignUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? batchId = null,
    Object? uploads = null,
  }) {
    return _then(_self.copyWith(
      batchId: null == batchId
          ? _self.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String,
      uploads: null == uploads
          ? _self.uploads
          : uploads // ignore: cast_nullable_to_non_nullable
              as List<PresignedUploadInfo>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PresignUploadResponse].
extension PresignUploadResponsePatterns on PresignUploadResponse {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PresignUploadResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PresignUploadResponse() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PresignUploadResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignUploadResponse():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PresignUploadResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignUploadResponse() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(@JsonKey(name: 'batch_id') String batchId,
            List<PresignedUploadInfo> uploads)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PresignUploadResponse() when $default != null:
        return $default(_that.batchId, _that.uploads);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(@JsonKey(name: 'batch_id') String batchId,
            List<PresignedUploadInfo> uploads)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignUploadResponse():
        return $default(_that.batchId, _that.uploads);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(@JsonKey(name: 'batch_id') String batchId,
            List<PresignedUploadInfo> uploads)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignUploadResponse() when $default != null:
        return $default(_that.batchId, _that.uploads);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PresignUploadResponse implements PresignUploadResponse {
  const _PresignUploadResponse(
      {@JsonKey(name: 'batch_id') required this.batchId,
      required final List<PresignedUploadInfo> uploads})
      : _uploads = uploads;
  factory _PresignUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$PresignUploadResponseFromJson(json);

  /// Batch ID — pass this to the confirm endpoint
  @override
  @JsonKey(name: 'batch_id')
  final String batchId;

  /// Per-document upload URLs
  final List<PresignedUploadInfo> _uploads;

  /// Per-document upload URLs
  @override
  List<PresignedUploadInfo> get uploads {
    if (_uploads is EqualUnmodifiableListView) return _uploads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uploads);
  }

  /// Create a copy of PresignUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PresignUploadResponseCopyWith<_PresignUploadResponse> get copyWith =>
      __$PresignUploadResponseCopyWithImpl<_PresignUploadResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PresignUploadResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PresignUploadResponse &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            const DeepCollectionEquality().equals(other._uploads, _uploads));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, batchId, const DeepCollectionEquality().hash(_uploads));

  @override
  String toString() {
    return 'PresignUploadResponse(batchId: $batchId, uploads: $uploads)';
  }
}

/// @nodoc
abstract mixin class _$PresignUploadResponseCopyWith<$Res>
    implements $PresignUploadResponseCopyWith<$Res> {
  factory _$PresignUploadResponseCopyWith(_PresignUploadResponse value,
          $Res Function(_PresignUploadResponse) _then) =
      __$PresignUploadResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'batch_id') String batchId,
      List<PresignedUploadInfo> uploads});
}

/// @nodoc
class __$PresignUploadResponseCopyWithImpl<$Res>
    implements _$PresignUploadResponseCopyWith<$Res> {
  __$PresignUploadResponseCopyWithImpl(this._self, this._then);

  final _PresignUploadResponse _self;
  final $Res Function(_PresignUploadResponse) _then;

  /// Create a copy of PresignUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? batchId = null,
    Object? uploads = null,
  }) {
    return _then(_PresignUploadResponse(
      batchId: null == batchId
          ? _self.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String,
      uploads: null == uploads
          ? _self._uploads
          : uploads // ignore: cast_nullable_to_non_nullable
              as List<PresignedUploadInfo>,
    ));
  }
}

// dart format on
