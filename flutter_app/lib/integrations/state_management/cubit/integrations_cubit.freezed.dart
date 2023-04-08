// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'integrations_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IntegrationsState {
  Iterable<Integration> get integrations => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Integration> integrations) initial,
    required TResult Function(Iterable<Integration> integrations) loading,
    required TResult Function(Iterable<Integration> integrations) loaded,
    required TResult Function(
            Iterable<Integration> integrations, String message)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Integration> integrations)? initial,
    TResult? Function(Iterable<Integration> integrations)? loading,
    TResult? Function(Iterable<Integration> integrations)? loaded,
    TResult? Function(Iterable<Integration> integrations, String message)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Integration> integrations)? initial,
    TResult Function(Iterable<Integration> integrations)? loading,
    TResult Function(Iterable<Integration> integrations)? loaded,
    TResult Function(Iterable<Integration> integrations, String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegrationsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IntegrationsInitial value)? initial,
    TResult? Function(IntegrationsLoading value)? loading,
    TResult? Function(IntegrationsLoaded value)? loaded,
    TResult? Function(IntegrationsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IntegrationsInitial value)? initial,
    TResult Function(IntegrationsLoading value)? loading,
    TResult Function(IntegrationsLoaded value)? loaded,
    TResult Function(IntegrationsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IntegrationsStateCopyWith<IntegrationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntegrationsStateCopyWith<$Res> {
  factory $IntegrationsStateCopyWith(
          IntegrationsState value, $Res Function(IntegrationsState) then) =
      _$IntegrationsStateCopyWithImpl<$Res, IntegrationsState>;
  @useResult
  $Res call({Iterable<Integration> integrations});
}

/// @nodoc
class _$IntegrationsStateCopyWithImpl<$Res, $Val extends IntegrationsState>
    implements $IntegrationsStateCopyWith<$Res> {
  _$IntegrationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? integrations = null,
  }) {
    return _then(_value.copyWith(
      integrations: null == integrations
          ? _value.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as Iterable<Integration>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntegrationsInitialCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegrationsInitialCopyWith(_$IntegrationsInitial value,
          $Res Function(_$IntegrationsInitial) then) =
      __$$IntegrationsInitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Iterable<Integration> integrations});
}

/// @nodoc
class __$$IntegrationsInitialCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegrationsInitial>
    implements _$$IntegrationsInitialCopyWith<$Res> {
  __$$IntegrationsInitialCopyWithImpl(
      _$IntegrationsInitial _value, $Res Function(_$IntegrationsInitial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? integrations = null,
  }) {
    return _then(_$IntegrationsInitial(
      null == integrations
          ? _value.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as Iterable<Integration>,
    ));
  }
}

/// @nodoc

class _$IntegrationsInitial implements IntegrationsInitial {
  const _$IntegrationsInitial(this.integrations);

  @override
  final Iterable<Integration> integrations;

  @override
  String toString() {
    return 'IntegrationsState.initial(integrations: $integrations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationsInitial &&
            const DeepCollectionEquality()
                .equals(other.integrations, integrations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(integrations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationsInitialCopyWith<_$IntegrationsInitial> get copyWith =>
      __$$IntegrationsInitialCopyWithImpl<_$IntegrationsInitial>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Integration> integrations) initial,
    required TResult Function(Iterable<Integration> integrations) loading,
    required TResult Function(Iterable<Integration> integrations) loaded,
    required TResult Function(
            Iterable<Integration> integrations, String message)
        error,
  }) {
    return initial(integrations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Integration> integrations)? initial,
    TResult? Function(Iterable<Integration> integrations)? loading,
    TResult? Function(Iterable<Integration> integrations)? loaded,
    TResult? Function(Iterable<Integration> integrations, String message)?
        error,
  }) {
    return initial?.call(integrations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Integration> integrations)? initial,
    TResult Function(Iterable<Integration> integrations)? loading,
    TResult Function(Iterable<Integration> integrations)? loaded,
    TResult Function(Iterable<Integration> integrations, String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(integrations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegrationsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IntegrationsInitial value)? initial,
    TResult? Function(IntegrationsLoading value)? loading,
    TResult? Function(IntegrationsLoaded value)? loaded,
    TResult? Function(IntegrationsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IntegrationsInitial value)? initial,
    TResult Function(IntegrationsLoading value)? loading,
    TResult Function(IntegrationsLoaded value)? loaded,
    TResult Function(IntegrationsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class IntegrationsInitial implements IntegrationsState {
  const factory IntegrationsInitial(final Iterable<Integration> integrations) =
      _$IntegrationsInitial;

  @override
  Iterable<Integration> get integrations;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationsInitialCopyWith<_$IntegrationsInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntegrationsLoadingCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegrationsLoadingCopyWith(_$IntegrationsLoading value,
          $Res Function(_$IntegrationsLoading) then) =
      __$$IntegrationsLoadingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Iterable<Integration> integrations});
}

/// @nodoc
class __$$IntegrationsLoadingCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegrationsLoading>
    implements _$$IntegrationsLoadingCopyWith<$Res> {
  __$$IntegrationsLoadingCopyWithImpl(
      _$IntegrationsLoading _value, $Res Function(_$IntegrationsLoading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? integrations = null,
  }) {
    return _then(_$IntegrationsLoading(
      null == integrations
          ? _value.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as Iterable<Integration>,
    ));
  }
}

/// @nodoc

class _$IntegrationsLoading implements IntegrationsLoading {
  const _$IntegrationsLoading(this.integrations);

  @override
  final Iterable<Integration> integrations;

  @override
  String toString() {
    return 'IntegrationsState.loading(integrations: $integrations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationsLoading &&
            const DeepCollectionEquality()
                .equals(other.integrations, integrations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(integrations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationsLoadingCopyWith<_$IntegrationsLoading> get copyWith =>
      __$$IntegrationsLoadingCopyWithImpl<_$IntegrationsLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Integration> integrations) initial,
    required TResult Function(Iterable<Integration> integrations) loading,
    required TResult Function(Iterable<Integration> integrations) loaded,
    required TResult Function(
            Iterable<Integration> integrations, String message)
        error,
  }) {
    return loading(integrations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Integration> integrations)? initial,
    TResult? Function(Iterable<Integration> integrations)? loading,
    TResult? Function(Iterable<Integration> integrations)? loaded,
    TResult? Function(Iterable<Integration> integrations, String message)?
        error,
  }) {
    return loading?.call(integrations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Integration> integrations)? initial,
    TResult Function(Iterable<Integration> integrations)? loading,
    TResult Function(Iterable<Integration> integrations)? loaded,
    TResult Function(Iterable<Integration> integrations, String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(integrations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegrationsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IntegrationsInitial value)? initial,
    TResult? Function(IntegrationsLoading value)? loading,
    TResult? Function(IntegrationsLoaded value)? loaded,
    TResult? Function(IntegrationsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IntegrationsInitial value)? initial,
    TResult Function(IntegrationsLoading value)? loading,
    TResult Function(IntegrationsLoaded value)? loaded,
    TResult Function(IntegrationsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class IntegrationsLoading implements IntegrationsState {
  const factory IntegrationsLoading(final Iterable<Integration> integrations) =
      _$IntegrationsLoading;

  @override
  Iterable<Integration> get integrations;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationsLoadingCopyWith<_$IntegrationsLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntegrationsLoadedCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegrationsLoadedCopyWith(_$IntegrationsLoaded value,
          $Res Function(_$IntegrationsLoaded) then) =
      __$$IntegrationsLoadedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Iterable<Integration> integrations});
}

/// @nodoc
class __$$IntegrationsLoadedCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegrationsLoaded>
    implements _$$IntegrationsLoadedCopyWith<$Res> {
  __$$IntegrationsLoadedCopyWithImpl(
      _$IntegrationsLoaded _value, $Res Function(_$IntegrationsLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? integrations = null,
  }) {
    return _then(_$IntegrationsLoaded(
      null == integrations
          ? _value.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as Iterable<Integration>,
    ));
  }
}

/// @nodoc

class _$IntegrationsLoaded implements IntegrationsLoaded {
  const _$IntegrationsLoaded(this.integrations);

  @override
  final Iterable<Integration> integrations;

  @override
  String toString() {
    return 'IntegrationsState.loaded(integrations: $integrations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationsLoaded &&
            const DeepCollectionEquality()
                .equals(other.integrations, integrations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(integrations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationsLoadedCopyWith<_$IntegrationsLoaded> get copyWith =>
      __$$IntegrationsLoadedCopyWithImpl<_$IntegrationsLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Integration> integrations) initial,
    required TResult Function(Iterable<Integration> integrations) loading,
    required TResult Function(Iterable<Integration> integrations) loaded,
    required TResult Function(
            Iterable<Integration> integrations, String message)
        error,
  }) {
    return loaded(integrations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Integration> integrations)? initial,
    TResult? Function(Iterable<Integration> integrations)? loading,
    TResult? Function(Iterable<Integration> integrations)? loaded,
    TResult? Function(Iterable<Integration> integrations, String message)?
        error,
  }) {
    return loaded?.call(integrations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Integration> integrations)? initial,
    TResult Function(Iterable<Integration> integrations)? loading,
    TResult Function(Iterable<Integration> integrations)? loaded,
    TResult Function(Iterable<Integration> integrations, String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(integrations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegrationsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IntegrationsInitial value)? initial,
    TResult? Function(IntegrationsLoading value)? loading,
    TResult? Function(IntegrationsLoaded value)? loaded,
    TResult? Function(IntegrationsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IntegrationsInitial value)? initial,
    TResult Function(IntegrationsLoading value)? loading,
    TResult Function(IntegrationsLoaded value)? loaded,
    TResult Function(IntegrationsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class IntegrationsLoaded implements IntegrationsState {
  const factory IntegrationsLoaded(final Iterable<Integration> integrations) =
      _$IntegrationsLoaded;

  @override
  Iterable<Integration> get integrations;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationsLoadedCopyWith<_$IntegrationsLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntegrationsErrorCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegrationsErrorCopyWith(
          _$IntegrationsError value, $Res Function(_$IntegrationsError) then) =
      __$$IntegrationsErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Iterable<Integration> integrations, String message});
}

/// @nodoc
class __$$IntegrationsErrorCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegrationsError>
    implements _$$IntegrationsErrorCopyWith<$Res> {
  __$$IntegrationsErrorCopyWithImpl(
      _$IntegrationsError _value, $Res Function(_$IntegrationsError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? integrations = null,
    Object? message = null,
  }) {
    return _then(_$IntegrationsError(
      null == integrations
          ? _value.integrations
          : integrations // ignore: cast_nullable_to_non_nullable
              as Iterable<Integration>,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$IntegrationsError implements IntegrationsError {
  const _$IntegrationsError(this.integrations, this.message);

  @override
  final Iterable<Integration> integrations;
  @override
  final String message;

  @override
  String toString() {
    return 'IntegrationsState.error(integrations: $integrations, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationsError &&
            const DeepCollectionEquality()
                .equals(other.integrations, integrations) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(integrations), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationsErrorCopyWith<_$IntegrationsError> get copyWith =>
      __$$IntegrationsErrorCopyWithImpl<_$IntegrationsError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Integration> integrations) initial,
    required TResult Function(Iterable<Integration> integrations) loading,
    required TResult Function(Iterable<Integration> integrations) loaded,
    required TResult Function(
            Iterable<Integration> integrations, String message)
        error,
  }) {
    return error(integrations, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Integration> integrations)? initial,
    TResult? Function(Iterable<Integration> integrations)? loading,
    TResult? Function(Iterable<Integration> integrations)? loaded,
    TResult? Function(Iterable<Integration> integrations, String message)?
        error,
  }) {
    return error?.call(integrations, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Integration> integrations)? initial,
    TResult Function(Iterable<Integration> integrations)? loading,
    TResult Function(Iterable<Integration> integrations)? loaded,
    TResult Function(Iterable<Integration> integrations, String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(integrations, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegrationsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IntegrationsInitial value)? initial,
    TResult? Function(IntegrationsLoading value)? loading,
    TResult? Function(IntegrationsLoaded value)? loaded,
    TResult? Function(IntegrationsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IntegrationsInitial value)? initial,
    TResult Function(IntegrationsLoading value)? loading,
    TResult Function(IntegrationsLoaded value)? loaded,
    TResult Function(IntegrationsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class IntegrationsError implements IntegrationsState {
  const factory IntegrationsError(
          final Iterable<Integration> integrations, final String message) =
      _$IntegrationsError;

  @override
  Iterable<Integration> get integrations;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationsErrorCopyWith<_$IntegrationsError> get copyWith =>
      throw _privateConstructorUsedError;
}
