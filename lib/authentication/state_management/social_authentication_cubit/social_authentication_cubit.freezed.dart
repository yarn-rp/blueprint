// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_authentication_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SocialAuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(SocialAuthenticationProvider provider) processing,
    required TResult Function(SocialAuthenticationProvider provider) success,
    required TResult Function(
            Object failure, SocialAuthenticationProvider provider)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(SocialAuthenticationProvider provider)? processing,
    TResult? Function(SocialAuthenticationProvider provider)? success,
    TResult? Function(Object failure, SocialAuthenticationProvider provider)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(SocialAuthenticationProvider provider)? processing,
    TResult Function(SocialAuthenticationProvider provider)? success,
    TResult Function(Object failure, SocialAuthenticationProvider provider)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IDLE value) idle,
    required TResult Function(SocialAuthenticationProcessing value) processing,
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IDLE value)? idle,
    TResult? Function(SocialAuthenticationProcessing value)? processing,
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IDLE value)? idle,
    TResult Function(SocialAuthenticationProcessing value)? processing,
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialAuthenticationStateCopyWith<$Res> {
  factory $SocialAuthenticationStateCopyWith(SocialAuthenticationState value,
          $Res Function(SocialAuthenticationState) then) =
      _$SocialAuthenticationStateCopyWithImpl<$Res, SocialAuthenticationState>;
}

/// @nodoc
class _$SocialAuthenticationStateCopyWithImpl<$Res,
        $Val extends SocialAuthenticationState>
    implements $SocialAuthenticationStateCopyWith<$Res> {
  _$SocialAuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$IDLEImplCopyWith<$Res> {
  factory _$$IDLEImplCopyWith(
          _$IDLEImpl value, $Res Function(_$IDLEImpl) then) =
      __$$IDLEImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IDLEImplCopyWithImpl<$Res>
    extends _$SocialAuthenticationStateCopyWithImpl<$Res, _$IDLEImpl>
    implements _$$IDLEImplCopyWith<$Res> {
  __$$IDLEImplCopyWithImpl(_$IDLEImpl _value, $Res Function(_$IDLEImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$IDLEImpl implements IDLE {
  const _$IDLEImpl();

  @override
  String toString() {
    return 'SocialAuthenticationState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IDLEImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(SocialAuthenticationProvider provider) processing,
    required TResult Function(SocialAuthenticationProvider provider) success,
    required TResult Function(
            Object failure, SocialAuthenticationProvider provider)
        error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(SocialAuthenticationProvider provider)? processing,
    TResult? Function(SocialAuthenticationProvider provider)? success,
    TResult? Function(Object failure, SocialAuthenticationProvider provider)?
        error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(SocialAuthenticationProvider provider)? processing,
    TResult Function(SocialAuthenticationProvider provider)? success,
    TResult Function(Object failure, SocialAuthenticationProvider provider)?
        error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IDLE value) idle,
    required TResult Function(SocialAuthenticationProcessing value) processing,
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IDLE value)? idle,
    TResult? Function(SocialAuthenticationProcessing value)? processing,
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IDLE value)? idle,
    TResult Function(SocialAuthenticationProcessing value)? processing,
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class IDLE implements SocialAuthenticationState {
  const factory IDLE() = _$IDLEImpl;
}

/// @nodoc
abstract class _$$SocialAuthenticationProcessingImplCopyWith<$Res> {
  factory _$$SocialAuthenticationProcessingImplCopyWith(
          _$SocialAuthenticationProcessingImpl value,
          $Res Function(_$SocialAuthenticationProcessingImpl) then) =
      __$$SocialAuthenticationProcessingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SocialAuthenticationProvider provider});
}

/// @nodoc
class __$$SocialAuthenticationProcessingImplCopyWithImpl<$Res>
    extends _$SocialAuthenticationStateCopyWithImpl<$Res,
        _$SocialAuthenticationProcessingImpl>
    implements _$$SocialAuthenticationProcessingImplCopyWith<$Res> {
  __$$SocialAuthenticationProcessingImplCopyWithImpl(
      _$SocialAuthenticationProcessingImpl _value,
      $Res Function(_$SocialAuthenticationProcessingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
  }) {
    return _then(_$SocialAuthenticationProcessingImpl(
      null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as SocialAuthenticationProvider,
    ));
  }
}

/// @nodoc

class _$SocialAuthenticationProcessingImpl
    implements SocialAuthenticationProcessing {
  const _$SocialAuthenticationProcessingImpl(this.provider);

  @override
  final SocialAuthenticationProvider provider;

  @override
  String toString() {
    return 'SocialAuthenticationState.processing(provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialAuthenticationProcessingImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialAuthenticationProcessingImplCopyWith<
          _$SocialAuthenticationProcessingImpl>
      get copyWith => __$$SocialAuthenticationProcessingImplCopyWithImpl<
          _$SocialAuthenticationProcessingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(SocialAuthenticationProvider provider) processing,
    required TResult Function(SocialAuthenticationProvider provider) success,
    required TResult Function(
            Object failure, SocialAuthenticationProvider provider)
        error,
  }) {
    return processing(provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(SocialAuthenticationProvider provider)? processing,
    TResult? Function(SocialAuthenticationProvider provider)? success,
    TResult? Function(Object failure, SocialAuthenticationProvider provider)?
        error,
  }) {
    return processing?.call(provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(SocialAuthenticationProvider provider)? processing,
    TResult Function(SocialAuthenticationProvider provider)? success,
    TResult Function(Object failure, SocialAuthenticationProvider provider)?
        error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IDLE value) idle,
    required TResult Function(SocialAuthenticationProcessing value) processing,
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationError value) error,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IDLE value)? idle,
    TResult? Function(SocialAuthenticationProcessing value)? processing,
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationError value)? error,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IDLE value)? idle,
    TResult Function(SocialAuthenticationProcessing value)? processing,
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class SocialAuthenticationProcessing
    implements SocialAuthenticationState {
  const factory SocialAuthenticationProcessing(
          final SocialAuthenticationProvider provider) =
      _$SocialAuthenticationProcessingImpl;

  SocialAuthenticationProvider get provider;
  @JsonKey(ignore: true)
  _$$SocialAuthenticationProcessingImplCopyWith<
          _$SocialAuthenticationProcessingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SocialAuthenticationSuccessImplCopyWith<$Res> {
  factory _$$SocialAuthenticationSuccessImplCopyWith(
          _$SocialAuthenticationSuccessImpl value,
          $Res Function(_$SocialAuthenticationSuccessImpl) then) =
      __$$SocialAuthenticationSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SocialAuthenticationProvider provider});
}

/// @nodoc
class __$$SocialAuthenticationSuccessImplCopyWithImpl<$Res>
    extends _$SocialAuthenticationStateCopyWithImpl<$Res,
        _$SocialAuthenticationSuccessImpl>
    implements _$$SocialAuthenticationSuccessImplCopyWith<$Res> {
  __$$SocialAuthenticationSuccessImplCopyWithImpl(
      _$SocialAuthenticationSuccessImpl _value,
      $Res Function(_$SocialAuthenticationSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
  }) {
    return _then(_$SocialAuthenticationSuccessImpl(
      null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as SocialAuthenticationProvider,
    ));
  }
}

/// @nodoc

class _$SocialAuthenticationSuccessImpl implements SocialAuthenticationSuccess {
  const _$SocialAuthenticationSuccessImpl(this.provider);

  @override
  final SocialAuthenticationProvider provider;

  @override
  String toString() {
    return 'SocialAuthenticationState.success(provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialAuthenticationSuccessImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialAuthenticationSuccessImplCopyWith<_$SocialAuthenticationSuccessImpl>
      get copyWith => __$$SocialAuthenticationSuccessImplCopyWithImpl<
          _$SocialAuthenticationSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(SocialAuthenticationProvider provider) processing,
    required TResult Function(SocialAuthenticationProvider provider) success,
    required TResult Function(
            Object failure, SocialAuthenticationProvider provider)
        error,
  }) {
    return success(provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(SocialAuthenticationProvider provider)? processing,
    TResult? Function(SocialAuthenticationProvider provider)? success,
    TResult? Function(Object failure, SocialAuthenticationProvider provider)?
        error,
  }) {
    return success?.call(provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(SocialAuthenticationProvider provider)? processing,
    TResult Function(SocialAuthenticationProvider provider)? success,
    TResult Function(Object failure, SocialAuthenticationProvider provider)?
        error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IDLE value) idle,
    required TResult Function(SocialAuthenticationProcessing value) processing,
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IDLE value)? idle,
    TResult? Function(SocialAuthenticationProcessing value)? processing,
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IDLE value)? idle,
    TResult Function(SocialAuthenticationProcessing value)? processing,
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SocialAuthenticationSuccess
    implements SocialAuthenticationState {
  const factory SocialAuthenticationSuccess(
          final SocialAuthenticationProvider provider) =
      _$SocialAuthenticationSuccessImpl;

  SocialAuthenticationProvider get provider;
  @JsonKey(ignore: true)
  _$$SocialAuthenticationSuccessImplCopyWith<_$SocialAuthenticationSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SocialAuthenticationErrorImplCopyWith<$Res> {
  factory _$$SocialAuthenticationErrorImplCopyWith(
          _$SocialAuthenticationErrorImpl value,
          $Res Function(_$SocialAuthenticationErrorImpl) then) =
      __$$SocialAuthenticationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object failure, SocialAuthenticationProvider provider});
}

/// @nodoc
class __$$SocialAuthenticationErrorImplCopyWithImpl<$Res>
    extends _$SocialAuthenticationStateCopyWithImpl<$Res,
        _$SocialAuthenticationErrorImpl>
    implements _$$SocialAuthenticationErrorImplCopyWith<$Res> {
  __$$SocialAuthenticationErrorImplCopyWithImpl(
      _$SocialAuthenticationErrorImpl _value,
      $Res Function(_$SocialAuthenticationErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
    Object? provider = null,
  }) {
    return _then(_$SocialAuthenticationErrorImpl(
      null == failure ? _value.failure : failure,
      null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as SocialAuthenticationProvider,
    ));
  }
}

/// @nodoc

class _$SocialAuthenticationErrorImpl implements SocialAuthenticationError {
  const _$SocialAuthenticationErrorImpl(this.failure, this.provider);

  @override
  final Object failure;
  @override
  final SocialAuthenticationProvider provider;

  @override
  String toString() {
    return 'SocialAuthenticationState.error(failure: $failure, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialAuthenticationErrorImpl &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(failure), provider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialAuthenticationErrorImplCopyWith<_$SocialAuthenticationErrorImpl>
      get copyWith => __$$SocialAuthenticationErrorImplCopyWithImpl<
          _$SocialAuthenticationErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(SocialAuthenticationProvider provider) processing,
    required TResult Function(SocialAuthenticationProvider provider) success,
    required TResult Function(
            Object failure, SocialAuthenticationProvider provider)
        error,
  }) {
    return error(failure, provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(SocialAuthenticationProvider provider)? processing,
    TResult? Function(SocialAuthenticationProvider provider)? success,
    TResult? Function(Object failure, SocialAuthenticationProvider provider)?
        error,
  }) {
    return error?.call(failure, provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(SocialAuthenticationProvider provider)? processing,
    TResult Function(SocialAuthenticationProvider provider)? success,
    TResult Function(Object failure, SocialAuthenticationProvider provider)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure, provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(IDLE value) idle,
    required TResult Function(SocialAuthenticationProcessing value) processing,
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(IDLE value)? idle,
    TResult? Function(SocialAuthenticationProcessing value)? processing,
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(IDLE value)? idle,
    TResult Function(SocialAuthenticationProcessing value)? processing,
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SocialAuthenticationError implements SocialAuthenticationState {
  const factory SocialAuthenticationError(
          final Object failure, final SocialAuthenticationProvider provider) =
      _$SocialAuthenticationErrorImpl;

  Object get failure;
  SocialAuthenticationProvider get provider;
  @JsonKey(ignore: true)
  _$$SocialAuthenticationErrorImplCopyWith<_$SocialAuthenticationErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
