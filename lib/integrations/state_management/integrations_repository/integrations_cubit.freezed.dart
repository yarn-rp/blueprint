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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IntegrationsState {
  Iterable<Platform> get availablePlatforms =>
      throw _privateConstructorUsedError;
  Iterable<Authenticator> get authenticators =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        initial,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loading,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loaded,
    required TResult Function(
            String platformId,
            Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        integratedPlatform,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult? Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegratedPlatform value) integratedPlatform,
    required TResult Function(IntegrationsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IntegrationsInitial value)? initial,
    TResult? Function(IntegrationsLoading value)? loading,
    TResult? Function(IntegrationsLoaded value)? loaded,
    TResult? Function(IntegratedPlatform value)? integratedPlatform,
    TResult? Function(IntegrationsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IntegrationsInitial value)? initial,
    TResult Function(IntegrationsLoading value)? loading,
    TResult Function(IntegrationsLoaded value)? loaded,
    TResult Function(IntegratedPlatform value)? integratedPlatform,
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
  $Res call(
      {Iterable<Platform> availablePlatforms,
      Iterable<Authenticator> authenticators});
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
    Object? availablePlatforms = null,
    Object? authenticators = null,
  }) {
    return _then(_value.copyWith(
      availablePlatforms: null == availablePlatforms
          ? _value.availablePlatforms
          : availablePlatforms // ignore: cast_nullable_to_non_nullable
              as Iterable<Platform>,
      authenticators: null == authenticators
          ? _value.authenticators
          : authenticators // ignore: cast_nullable_to_non_nullable
              as Iterable<Authenticator>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntegrationsInitialImplCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegrationsInitialImplCopyWith(_$IntegrationsInitialImpl value,
          $Res Function(_$IntegrationsInitialImpl) then) =
      __$$IntegrationsInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Iterable<Platform> availablePlatforms,
      Iterable<Authenticator> authenticators});
}

/// @nodoc
class __$$IntegrationsInitialImplCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegrationsInitialImpl>
    implements _$$IntegrationsInitialImplCopyWith<$Res> {
  __$$IntegrationsInitialImplCopyWithImpl(_$IntegrationsInitialImpl _value,
      $Res Function(_$IntegrationsInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availablePlatforms = null,
    Object? authenticators = null,
  }) {
    return _then(_$IntegrationsInitialImpl(
      null == availablePlatforms
          ? _value.availablePlatforms
          : availablePlatforms // ignore: cast_nullable_to_non_nullable
              as Iterable<Platform>,
      null == authenticators
          ? _value.authenticators
          : authenticators // ignore: cast_nullable_to_non_nullable
              as Iterable<Authenticator>,
    ));
  }
}

/// @nodoc

class _$IntegrationsInitialImpl implements IntegrationsInitial {
  const _$IntegrationsInitialImpl(this.availablePlatforms, this.authenticators);

  @override
  final Iterable<Platform> availablePlatforms;
  @override
  final Iterable<Authenticator> authenticators;

  @override
  String toString() {
    return 'IntegrationsState.initial(availablePlatforms: $availablePlatforms, authenticators: $authenticators)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationsInitialImpl &&
            const DeepCollectionEquality()
                .equals(other.availablePlatforms, availablePlatforms) &&
            const DeepCollectionEquality()
                .equals(other.authenticators, authenticators));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(availablePlatforms),
      const DeepCollectionEquality().hash(authenticators));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationsInitialImplCopyWith<_$IntegrationsInitialImpl> get copyWith =>
      __$$IntegrationsInitialImplCopyWithImpl<_$IntegrationsInitialImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        initial,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loading,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loaded,
    required TResult Function(
            String platformId,
            Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        integratedPlatform,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)
        error,
  }) {
    return initial(availablePlatforms, authenticators);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult? Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
  }) {
    return initial?.call(availablePlatforms, authenticators);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(availablePlatforms, authenticators);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegratedPlatform value) integratedPlatform,
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
    TResult? Function(IntegratedPlatform value)? integratedPlatform,
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
    TResult Function(IntegratedPlatform value)? integratedPlatform,
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
  const factory IntegrationsInitial(final Iterable<Platform> availablePlatforms,
      final Iterable<Authenticator> authenticators) = _$IntegrationsInitialImpl;

  @override
  Iterable<Platform> get availablePlatforms;
  @override
  Iterable<Authenticator> get authenticators;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationsInitialImplCopyWith<_$IntegrationsInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntegrationsLoadingImplCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegrationsLoadingImplCopyWith(_$IntegrationsLoadingImpl value,
          $Res Function(_$IntegrationsLoadingImpl) then) =
      __$$IntegrationsLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Iterable<Platform> availablePlatforms,
      Iterable<Authenticator> authenticators});
}

/// @nodoc
class __$$IntegrationsLoadingImplCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegrationsLoadingImpl>
    implements _$$IntegrationsLoadingImplCopyWith<$Res> {
  __$$IntegrationsLoadingImplCopyWithImpl(_$IntegrationsLoadingImpl _value,
      $Res Function(_$IntegrationsLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availablePlatforms = null,
    Object? authenticators = null,
  }) {
    return _then(_$IntegrationsLoadingImpl(
      null == availablePlatforms
          ? _value.availablePlatforms
          : availablePlatforms // ignore: cast_nullable_to_non_nullable
              as Iterable<Platform>,
      null == authenticators
          ? _value.authenticators
          : authenticators // ignore: cast_nullable_to_non_nullable
              as Iterable<Authenticator>,
    ));
  }
}

/// @nodoc

class _$IntegrationsLoadingImpl implements IntegrationsLoading {
  const _$IntegrationsLoadingImpl(this.availablePlatforms, this.authenticators);

  @override
  final Iterable<Platform> availablePlatforms;
  @override
  final Iterable<Authenticator> authenticators;

  @override
  String toString() {
    return 'IntegrationsState.loading(availablePlatforms: $availablePlatforms, authenticators: $authenticators)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationsLoadingImpl &&
            const DeepCollectionEquality()
                .equals(other.availablePlatforms, availablePlatforms) &&
            const DeepCollectionEquality()
                .equals(other.authenticators, authenticators));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(availablePlatforms),
      const DeepCollectionEquality().hash(authenticators));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationsLoadingImplCopyWith<_$IntegrationsLoadingImpl> get copyWith =>
      __$$IntegrationsLoadingImplCopyWithImpl<_$IntegrationsLoadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        initial,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loading,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loaded,
    required TResult Function(
            String platformId,
            Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        integratedPlatform,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)
        error,
  }) {
    return loading(availablePlatforms, authenticators);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult? Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
  }) {
    return loading?.call(availablePlatforms, authenticators);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(availablePlatforms, authenticators);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegratedPlatform value) integratedPlatform,
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
    TResult? Function(IntegratedPlatform value)? integratedPlatform,
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
    TResult Function(IntegratedPlatform value)? integratedPlatform,
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
  const factory IntegrationsLoading(final Iterable<Platform> availablePlatforms,
      final Iterable<Authenticator> authenticators) = _$IntegrationsLoadingImpl;

  @override
  Iterable<Platform> get availablePlatforms;
  @override
  Iterable<Authenticator> get authenticators;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationsLoadingImplCopyWith<_$IntegrationsLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntegrationsLoadedImplCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegrationsLoadedImplCopyWith(_$IntegrationsLoadedImpl value,
          $Res Function(_$IntegrationsLoadedImpl) then) =
      __$$IntegrationsLoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Iterable<Platform> availablePlatforms,
      Iterable<Authenticator> authenticators});
}

/// @nodoc
class __$$IntegrationsLoadedImplCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegrationsLoadedImpl>
    implements _$$IntegrationsLoadedImplCopyWith<$Res> {
  __$$IntegrationsLoadedImplCopyWithImpl(_$IntegrationsLoadedImpl _value,
      $Res Function(_$IntegrationsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availablePlatforms = null,
    Object? authenticators = null,
  }) {
    return _then(_$IntegrationsLoadedImpl(
      null == availablePlatforms
          ? _value.availablePlatforms
          : availablePlatforms // ignore: cast_nullable_to_non_nullable
              as Iterable<Platform>,
      null == authenticators
          ? _value.authenticators
          : authenticators // ignore: cast_nullable_to_non_nullable
              as Iterable<Authenticator>,
    ));
  }
}

/// @nodoc

class _$IntegrationsLoadedImpl implements IntegrationsLoaded {
  const _$IntegrationsLoadedImpl(this.availablePlatforms, this.authenticators);

  @override
  final Iterable<Platform> availablePlatforms;
  @override
  final Iterable<Authenticator> authenticators;

  @override
  String toString() {
    return 'IntegrationsState.loaded(availablePlatforms: $availablePlatforms, authenticators: $authenticators)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationsLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other.availablePlatforms, availablePlatforms) &&
            const DeepCollectionEquality()
                .equals(other.authenticators, authenticators));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(availablePlatforms),
      const DeepCollectionEquality().hash(authenticators));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationsLoadedImplCopyWith<_$IntegrationsLoadedImpl> get copyWith =>
      __$$IntegrationsLoadedImplCopyWithImpl<_$IntegrationsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        initial,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loading,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loaded,
    required TResult Function(
            String platformId,
            Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        integratedPlatform,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)
        error,
  }) {
    return loaded(availablePlatforms, authenticators);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult? Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
  }) {
    return loaded?.call(availablePlatforms, authenticators);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(availablePlatforms, authenticators);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegratedPlatform value) integratedPlatform,
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
    TResult? Function(IntegratedPlatform value)? integratedPlatform,
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
    TResult Function(IntegratedPlatform value)? integratedPlatform,
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
  const factory IntegrationsLoaded(final Iterable<Platform> availablePlatforms,
      final Iterable<Authenticator> authenticators) = _$IntegrationsLoadedImpl;

  @override
  Iterable<Platform> get availablePlatforms;
  @override
  Iterable<Authenticator> get authenticators;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationsLoadedImplCopyWith<_$IntegrationsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntegratedPlatformImplCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegratedPlatformImplCopyWith(_$IntegratedPlatformImpl value,
          $Res Function(_$IntegratedPlatformImpl) then) =
      __$$IntegratedPlatformImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String platformId,
      Iterable<Platform> availablePlatforms,
      Iterable<Authenticator> authenticators});
}

/// @nodoc
class __$$IntegratedPlatformImplCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegratedPlatformImpl>
    implements _$$IntegratedPlatformImplCopyWith<$Res> {
  __$$IntegratedPlatformImplCopyWithImpl(_$IntegratedPlatformImpl _value,
      $Res Function(_$IntegratedPlatformImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platformId = null,
    Object? availablePlatforms = null,
    Object? authenticators = null,
  }) {
    return _then(_$IntegratedPlatformImpl(
      null == platformId
          ? _value.platformId
          : platformId // ignore: cast_nullable_to_non_nullable
              as String,
      null == availablePlatforms
          ? _value.availablePlatforms
          : availablePlatforms // ignore: cast_nullable_to_non_nullable
              as Iterable<Platform>,
      null == authenticators
          ? _value.authenticators
          : authenticators // ignore: cast_nullable_to_non_nullable
              as Iterable<Authenticator>,
    ));
  }
}

/// @nodoc

class _$IntegratedPlatformImpl implements IntegratedPlatform {
  const _$IntegratedPlatformImpl(
      this.platformId, this.availablePlatforms, this.authenticators);

  @override
  final String platformId;
  @override
  final Iterable<Platform> availablePlatforms;
  @override
  final Iterable<Authenticator> authenticators;

  @override
  String toString() {
    return 'IntegrationsState.integratedPlatform(platformId: $platformId, availablePlatforms: $availablePlatforms, authenticators: $authenticators)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegratedPlatformImpl &&
            (identical(other.platformId, platformId) ||
                other.platformId == platformId) &&
            const DeepCollectionEquality()
                .equals(other.availablePlatforms, availablePlatforms) &&
            const DeepCollectionEquality()
                .equals(other.authenticators, authenticators));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      platformId,
      const DeepCollectionEquality().hash(availablePlatforms),
      const DeepCollectionEquality().hash(authenticators));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegratedPlatformImplCopyWith<_$IntegratedPlatformImpl> get copyWith =>
      __$$IntegratedPlatformImplCopyWithImpl<_$IntegratedPlatformImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        initial,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loading,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loaded,
    required TResult Function(
            String platformId,
            Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        integratedPlatform,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)
        error,
  }) {
    return integratedPlatform(platformId, availablePlatforms, authenticators);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult? Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
  }) {
    return integratedPlatform?.call(
        platformId, availablePlatforms, authenticators);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
    required TResult orElse(),
  }) {
    if (integratedPlatform != null) {
      return integratedPlatform(platformId, availablePlatforms, authenticators);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegratedPlatform value) integratedPlatform,
    required TResult Function(IntegrationsError value) error,
  }) {
    return integratedPlatform(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IntegrationsInitial value)? initial,
    TResult? Function(IntegrationsLoading value)? loading,
    TResult? Function(IntegrationsLoaded value)? loaded,
    TResult? Function(IntegratedPlatform value)? integratedPlatform,
    TResult? Function(IntegrationsError value)? error,
  }) {
    return integratedPlatform?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IntegrationsInitial value)? initial,
    TResult Function(IntegrationsLoading value)? loading,
    TResult Function(IntegrationsLoaded value)? loaded,
    TResult Function(IntegratedPlatform value)? integratedPlatform,
    TResult Function(IntegrationsError value)? error,
    required TResult orElse(),
  }) {
    if (integratedPlatform != null) {
      return integratedPlatform(this);
    }
    return orElse();
  }
}

abstract class IntegratedPlatform implements IntegrationsState {
  const factory IntegratedPlatform(
      final String platformId,
      final Iterable<Platform> availablePlatforms,
      final Iterable<Authenticator> authenticators) = _$IntegratedPlatformImpl;

  String get platformId;
  @override
  Iterable<Platform> get availablePlatforms;
  @override
  Iterable<Authenticator> get authenticators;
  @override
  @JsonKey(ignore: true)
  _$$IntegratedPlatformImplCopyWith<_$IntegratedPlatformImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IntegrationsErrorImplCopyWith<$Res>
    implements $IntegrationsStateCopyWith<$Res> {
  factory _$$IntegrationsErrorImplCopyWith(_$IntegrationsErrorImpl value,
          $Res Function(_$IntegrationsErrorImpl) then) =
      __$$IntegrationsErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Iterable<Platform> availablePlatforms,
      Iterable<Authenticator> authenticators,
      String message});
}

/// @nodoc
class __$$IntegrationsErrorImplCopyWithImpl<$Res>
    extends _$IntegrationsStateCopyWithImpl<$Res, _$IntegrationsErrorImpl>
    implements _$$IntegrationsErrorImplCopyWith<$Res> {
  __$$IntegrationsErrorImplCopyWithImpl(_$IntegrationsErrorImpl _value,
      $Res Function(_$IntegrationsErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availablePlatforms = null,
    Object? authenticators = null,
    Object? message = null,
  }) {
    return _then(_$IntegrationsErrorImpl(
      null == availablePlatforms
          ? _value.availablePlatforms
          : availablePlatforms // ignore: cast_nullable_to_non_nullable
              as Iterable<Platform>,
      null == authenticators
          ? _value.authenticators
          : authenticators // ignore: cast_nullable_to_non_nullable
              as Iterable<Authenticator>,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$IntegrationsErrorImpl implements IntegrationsError {
  const _$IntegrationsErrorImpl(
      this.availablePlatforms, this.authenticators, this.message);

  @override
  final Iterable<Platform> availablePlatforms;
  @override
  final Iterable<Authenticator> authenticators;
  @override
  final String message;

  @override
  String toString() {
    return 'IntegrationsState.error(availablePlatforms: $availablePlatforms, authenticators: $authenticators, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegrationsErrorImpl &&
            const DeepCollectionEquality()
                .equals(other.availablePlatforms, availablePlatforms) &&
            const DeepCollectionEquality()
                .equals(other.authenticators, authenticators) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(availablePlatforms),
      const DeepCollectionEquality().hash(authenticators),
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegrationsErrorImplCopyWith<_$IntegrationsErrorImpl> get copyWith =>
      __$$IntegrationsErrorImplCopyWithImpl<_$IntegrationsErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        initial,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loading,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        loaded,
    required TResult Function(
            String platformId,
            Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)
        integratedPlatform,
    required TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)
        error,
  }) {
    return error(availablePlatforms, authenticators, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult? Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult? Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
  }) {
    return error?.call(availablePlatforms, authenticators, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        initial,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loading,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        loaded,
    TResult Function(String platformId, Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators)?
        integratedPlatform,
    TResult Function(Iterable<Platform> availablePlatforms,
            Iterable<Authenticator> authenticators, String message)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(availablePlatforms, authenticators, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IntegrationsInitial value) initial,
    required TResult Function(IntegrationsLoading value) loading,
    required TResult Function(IntegrationsLoaded value) loaded,
    required TResult Function(IntegratedPlatform value) integratedPlatform,
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
    TResult? Function(IntegratedPlatform value)? integratedPlatform,
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
    TResult Function(IntegratedPlatform value)? integratedPlatform,
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
      final Iterable<Platform> availablePlatforms,
      final Iterable<Authenticator> authenticators,
      final String message) = _$IntegrationsErrorImpl;

  @override
  Iterable<Platform> get availablePlatforms;
  @override
  Iterable<Authenticator> get authenticators;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$IntegrationsErrorImplCopyWith<_$IntegrationsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
