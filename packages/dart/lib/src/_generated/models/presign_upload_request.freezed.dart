// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presign_upload_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PresignUploadRequest {
  /// Document metadata (no file data)
  List<PresignDocumentInput> get documents;

  /// Batch-level extraction configuration (applied to all documents)
  ExtractionConfig? get config;

  /// Webhook configuration for async result delivery
  WebhookConfig? get webhook;

  /// Create a copy of PresignUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PresignUploadRequestCopyWith<PresignUploadRequest> get copyWith =>
      _$PresignUploadRequestCopyWithImpl<PresignUploadRequest>(
          this as PresignUploadRequest, _$identity);

  /// Serializes this PresignUploadRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PresignUploadRequest &&
            const DeepCollectionEquality().equals(other.documents, documents) &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.webhook, webhook) || other.webhook == webhook));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(documents), config, webhook);

  @override
  String toString() {
    return 'PresignUploadRequest(documents: $documents, config: $config, webhook: $webhook)';
  }
}

/// @nodoc
abstract mixin class $PresignUploadRequestCopyWith<$Res> {
  factory $PresignUploadRequestCopyWith(PresignUploadRequest value,
          $Res Function(PresignUploadRequest) _then) =
      _$PresignUploadRequestCopyWithImpl;
  @useResult
  $Res call(
      {List<PresignDocumentInput> documents,
      ExtractionConfig? config,
      WebhookConfig? webhook});

  $ExtractionConfigCopyWith<$Res>? get config;
  $WebhookConfigCopyWith<$Res>? get webhook;
}

/// @nodoc
class _$PresignUploadRequestCopyWithImpl<$Res>
    implements $PresignUploadRequestCopyWith<$Res> {
  _$PresignUploadRequestCopyWithImpl(this._self, this._then);

  final PresignUploadRequest _self;
  final $Res Function(PresignUploadRequest) _then;

  /// Create a copy of PresignUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? config = freezed,
    Object? webhook = freezed,
  }) {
    return _then(_self.copyWith(
      documents: null == documents
          ? _self.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<PresignDocumentInput>,
      config: freezed == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as ExtractionConfig?,
      webhook: freezed == webhook
          ? _self.webhook
          : webhook // ignore: cast_nullable_to_non_nullable
              as WebhookConfig?,
    ));
  }

  /// Create a copy of PresignUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtractionConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
      return null;
    }

    return $ExtractionConfigCopyWith<$Res>(_self.config!, (value) {
      return _then(_self.copyWith(config: value));
    });
  }

  /// Create a copy of PresignUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebhookConfigCopyWith<$Res>? get webhook {
    if (_self.webhook == null) {
      return null;
    }

    return $WebhookConfigCopyWith<$Res>(_self.webhook!, (value) {
      return _then(_self.copyWith(webhook: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PresignUploadRequest].
extension PresignUploadRequestPatterns on PresignUploadRequest {
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
    TResult Function(_PresignUploadRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PresignUploadRequest() when $default != null:
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
    TResult Function(_PresignUploadRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignUploadRequest():
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
    TResult? Function(_PresignUploadRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignUploadRequest() when $default != null:
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
    TResult Function(List<PresignDocumentInput> documents,
            ExtractionConfig? config, WebhookConfig? webhook)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PresignUploadRequest() when $default != null:
        return $default(_that.documents, _that.config, _that.webhook);
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
    TResult Function(List<PresignDocumentInput> documents,
            ExtractionConfig? config, WebhookConfig? webhook)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignUploadRequest():
        return $default(_that.documents, _that.config, _that.webhook);
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
    TResult? Function(List<PresignDocumentInput> documents,
            ExtractionConfig? config, WebhookConfig? webhook)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PresignUploadRequest() when $default != null:
        return $default(_that.documents, _that.config, _that.webhook);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PresignUploadRequest implements PresignUploadRequest {
  const _PresignUploadRequest(
      {required final List<PresignDocumentInput> documents,
      this.config,
      this.webhook})
      : _documents = documents;
  factory _PresignUploadRequest.fromJson(Map<String, dynamic> json) =>
      _$PresignUploadRequestFromJson(json);

  /// Document metadata (no file data)
  final List<PresignDocumentInput> _documents;

  /// Document metadata (no file data)
  @override
  List<PresignDocumentInput> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  /// Batch-level extraction configuration (applied to all documents)
  @override
  final ExtractionConfig? config;

  /// Webhook configuration for async result delivery
  @override
  final WebhookConfig? webhook;

  /// Create a copy of PresignUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PresignUploadRequestCopyWith<_PresignUploadRequest> get copyWith =>
      __$PresignUploadRequestCopyWithImpl<_PresignUploadRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PresignUploadRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PresignUploadRequest &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.webhook, webhook) || other.webhook == webhook));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_documents), config, webhook);

  @override
  String toString() {
    return 'PresignUploadRequest(documents: $documents, config: $config, webhook: $webhook)';
  }
}

/// @nodoc
abstract mixin class _$PresignUploadRequestCopyWith<$Res>
    implements $PresignUploadRequestCopyWith<$Res> {
  factory _$PresignUploadRequestCopyWith(_PresignUploadRequest value,
          $Res Function(_PresignUploadRequest) _then) =
      __$PresignUploadRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<PresignDocumentInput> documents,
      ExtractionConfig? config,
      WebhookConfig? webhook});

  @override
  $ExtractionConfigCopyWith<$Res>? get config;
  @override
  $WebhookConfigCopyWith<$Res>? get webhook;
}

/// @nodoc
class __$PresignUploadRequestCopyWithImpl<$Res>
    implements _$PresignUploadRequestCopyWith<$Res> {
  __$PresignUploadRequestCopyWithImpl(this._self, this._then);

  final _PresignUploadRequest _self;
  final $Res Function(_PresignUploadRequest) _then;

  /// Create a copy of PresignUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? documents = null,
    Object? config = freezed,
    Object? webhook = freezed,
  }) {
    return _then(_PresignUploadRequest(
      documents: null == documents
          ? _self._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<PresignDocumentInput>,
      config: freezed == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as ExtractionConfig?,
      webhook: freezed == webhook
          ? _self.webhook
          : webhook // ignore: cast_nullable_to_non_nullable
              as WebhookConfig?,
    ));
  }

  /// Create a copy of PresignUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExtractionConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
      return null;
    }

    return $ExtractionConfigCopyWith<$Res>(_self.config!, (value) {
      return _then(_self.copyWith(config: value));
    });
  }

  /// Create a copy of PresignUploadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WebhookConfigCopyWith<$Res>? get webhook {
    if (_self.webhook == null) {
      return null;
    }

    return $WebhookConfigCopyWith<$Res>(_self.webhook!, (value) {
      return _then(_self.copyWith(webhook: value));
    });
  }
}

// dart format on
