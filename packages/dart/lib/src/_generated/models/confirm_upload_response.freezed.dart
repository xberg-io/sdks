// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfirmUploadResponse {
  /// Job IDs that are now queued for processing
  @JsonKey(name: 'job_ids')
  List<String> get jobIds;

  /// Status of the jobs
  String get status;

  /// Create a copy of ConfirmUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfirmUploadResponseCopyWith<ConfirmUploadResponse> get copyWith =>
      _$ConfirmUploadResponseCopyWithImpl<ConfirmUploadResponse>(
          this as ConfirmUploadResponse, _$identity);

  /// Serializes this ConfirmUploadResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfirmUploadResponse &&
            const DeepCollectionEquality().equals(other.jobIds, jobIds) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(jobIds), status);

  @override
  String toString() {
    return 'ConfirmUploadResponse(jobIds: $jobIds, status: $status)';
  }
}

/// @nodoc
abstract mixin class $ConfirmUploadResponseCopyWith<$Res> {
  factory $ConfirmUploadResponseCopyWith(ConfirmUploadResponse value,
          $Res Function(ConfirmUploadResponse) _then) =
      _$ConfirmUploadResponseCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'job_ids') List<String> jobIds, String status});
}

/// @nodoc
class _$ConfirmUploadResponseCopyWithImpl<$Res>
    implements $ConfirmUploadResponseCopyWith<$Res> {
  _$ConfirmUploadResponseCopyWithImpl(this._self, this._then);

  final ConfirmUploadResponse _self;
  final $Res Function(ConfirmUploadResponse) _then;

  /// Create a copy of ConfirmUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobIds = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      jobIds: null == jobIds
          ? _self.jobIds
          : jobIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConfirmUploadResponse].
extension ConfirmUploadResponsePatterns on ConfirmUploadResponse {
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
    TResult Function(_ConfirmUploadResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConfirmUploadResponse() when $default != null:
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
    TResult Function(_ConfirmUploadResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConfirmUploadResponse():
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
    TResult? Function(_ConfirmUploadResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConfirmUploadResponse() when $default != null:
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
    TResult Function(
            @JsonKey(name: 'job_ids') List<String> jobIds, String status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConfirmUploadResponse() when $default != null:
        return $default(_that.jobIds, _that.status);
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
    TResult Function(
            @JsonKey(name: 'job_ids') List<String> jobIds, String status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConfirmUploadResponse():
        return $default(_that.jobIds, _that.status);
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
    TResult? Function(
            @JsonKey(name: 'job_ids') List<String> jobIds, String status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConfirmUploadResponse() when $default != null:
        return $default(_that.jobIds, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ConfirmUploadResponse implements ConfirmUploadResponse {
  const _ConfirmUploadResponse(
      {@JsonKey(name: 'job_ids') required final List<String> jobIds,
      required this.status})
      : _jobIds = jobIds;
  factory _ConfirmUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmUploadResponseFromJson(json);

  /// Job IDs that are now queued for processing
  final List<String> _jobIds;

  /// Job IDs that are now queued for processing
  @override
  @JsonKey(name: 'job_ids')
  List<String> get jobIds {
    if (_jobIds is EqualUnmodifiableListView) return _jobIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_jobIds);
  }

  /// Status of the jobs
  @override
  final String status;

  /// Create a copy of ConfirmUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConfirmUploadResponseCopyWith<_ConfirmUploadResponse> get copyWith =>
      __$ConfirmUploadResponseCopyWithImpl<_ConfirmUploadResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConfirmUploadResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConfirmUploadResponse &&
            const DeepCollectionEquality().equals(other._jobIds, _jobIds) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_jobIds), status);

  @override
  String toString() {
    return 'ConfirmUploadResponse(jobIds: $jobIds, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$ConfirmUploadResponseCopyWith<$Res>
    implements $ConfirmUploadResponseCopyWith<$Res> {
  factory _$ConfirmUploadResponseCopyWith(_ConfirmUploadResponse value,
          $Res Function(_ConfirmUploadResponse) _then) =
      __$ConfirmUploadResponseCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'job_ids') List<String> jobIds, String status});
}

/// @nodoc
class __$ConfirmUploadResponseCopyWithImpl<$Res>
    implements _$ConfirmUploadResponseCopyWith<$Res> {
  __$ConfirmUploadResponseCopyWithImpl(this._self, this._then);

  final _ConfirmUploadResponse _self;
  final $Res Function(_ConfirmUploadResponse) _then;

  /// Create a copy of ConfirmUploadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? jobIds = null,
    Object? status = null,
  }) {
    return _then(_ConfirmUploadResponse(
      jobIds: null == jobIds
          ? _self._jobIds
          : jobIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
