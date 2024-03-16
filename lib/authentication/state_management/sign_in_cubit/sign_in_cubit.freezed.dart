// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignInState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInStateCopyWith<$Res> {
  factory $SignInStateCopyWith(
          SignInState value, $Res Function(SignInState) then) =
      _$SignInStateCopyWithImpl<$Res, SignInState>;
}

/// @nodoc
class _$SignInStateCopyWithImpl<$Res, $Val extends SignInState>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SignInState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SignInState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SignInProcessingImplCopyWith<$Res> {
  factory _$$SignInProcessingImplCopyWith(_$SignInProcessingImpl value,
          $Res Function(_$SignInProcessingImpl) then) =
      __$$SignInProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInProcessingImplCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInProcessingImpl>
    implements _$$SignInProcessingImplCopyWith<$Res> {
  __$$SignInProcessingImplCopyWithImpl(_$SignInProcessingImpl _value,
      $Res Function(_$SignInProcessingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignInProcessingImpl implements SignInProcessing {
  const _$SignInProcessingImpl();

  @override
  String toString() {
    return 'SignInState.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignInProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) {
    return processing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) {
    return processing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class SignInProcessing implements SignInState {
  const factory SignInProcessing() = _$SignInProcessingImpl;
}

/// @nodoc
abstract class _$$SignInSuccessfulImplCopyWith<$Res> {
  factory _$$SignInSuccessfulImplCopyWith(_$SignInSuccessfulImpl value,
          $Res Function(_$SignInSuccessfulImpl) then) =
      __$$SignInSuccessfulImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInSuccessfulImplCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInSuccessfulImpl>
    implements _$$SignInSuccessfulImplCopyWith<$Res> {
  __$$SignInSuccessfulImplCopyWithImpl(_$SignInSuccessfulImpl _value,
      $Res Function(_$SignInSuccessfulImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignInSuccessfulImpl implements SignInSuccessful {
  const _$SignInSuccessfulImpl();

  @override
  String toString() {
    return 'SignInState.successful()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignInSuccessfulImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) {
    return successful();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) {
    return successful?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) {
    return successful(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) {
    return successful?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (successful != null) {
      return successful(this);
    }
    return orElse();
  }
}

abstract class SignInSuccessful implements SignInState {
  const factory SignInSuccessful() = _$SignInSuccessfulImpl;
}

/// @nodoc
abstract class _$$SignInErrorImplCopyWith<$Res> {
  factory _$$SignInErrorImplCopyWith(
          _$SignInErrorImpl value, $Res Function(_$SignInErrorImpl) then) =
      __$$SignInErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object failure});
}

/// @nodoc
class __$$SignInErrorImplCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInErrorImpl>
    implements _$$SignInErrorImplCopyWith<$Res> {
  __$$SignInErrorImplCopyWithImpl(
      _$SignInErrorImpl _value, $Res Function(_$SignInErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$SignInErrorImpl(
      null == failure ? _value.failure : failure,
    ));
  }
}

/// @nodoc

class _$SignInErrorImpl implements SignInError {
  const _$SignInErrorImpl(this.failure);

  @override
  final Object failure;

  @override
  String toString() {
    return 'SignInState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInErrorImpl &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInErrorImplCopyWith<_$SignInErrorImpl> get copyWith =>
      __$$SignInErrorImplCopyWithImpl<_$SignInErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() successful,
    required TResult Function(Object failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? successful,
    TResult? Function(Object failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? successful,
    TResult Function(Object failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SignInProcessing value) processing,
    required TResult Function(SignInSuccessful value) successful,
    required TResult Function(SignInError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SignInProcessing value)? processing,
    TResult? Function(SignInSuccessful value)? successful,
    TResult? Function(SignInError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SignInProcessing value)? processing,
    TResult Function(SignInSuccessful value)? successful,
    TResult Function(SignInError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SignInError implements SignInState {
  const factory SignInError(final Object failure) = _$SignInErrorImpl;

  Object get failure;
  @JsonKey(ignore: true)
  _$$SignInErrorImplCopyWith<_$SignInErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
