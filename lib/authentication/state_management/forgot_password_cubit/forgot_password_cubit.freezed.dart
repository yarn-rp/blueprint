// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ForgotPasswordState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordStateCopyWith(
          ForgotPasswordState value, $Res Function(ForgotPasswordState) then) =
      _$ForgotPasswordStateCopyWithImpl<$Res, ForgotPasswordState>;
}

/// @nodoc
class _$ForgotPasswordStateCopyWithImpl<$Res, $Val extends ForgotPasswordState>
    implements $ForgotPasswordStateCopyWith<$Res> {
  _$ForgotPasswordStateCopyWithImpl(this._value, this._then);

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
    extends _$ForgotPasswordStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'ForgotPasswordState.initial()';
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
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
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
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ForgotPasswordState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$ResettingPasswordStateImplCopyWith<$Res> {
  factory _$$ResettingPasswordStateImplCopyWith(
          _$ResettingPasswordStateImpl value,
          $Res Function(_$ResettingPasswordStateImpl) then) =
      __$$ResettingPasswordStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ResettingPasswordStateImplCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res,
        _$ResettingPasswordStateImpl>
    implements _$$ResettingPasswordStateImplCopyWith<$Res> {
  __$$ResettingPasswordStateImplCopyWithImpl(
      _$ResettingPasswordStateImpl _value,
      $Res Function(_$ResettingPasswordStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$ResettingPasswordStateImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResettingPasswordStateImpl implements ResettingPasswordState {
  const _$ResettingPasswordStateImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordState.resettingPassword(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResettingPasswordStateImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResettingPasswordStateImplCopyWith<_$ResettingPasswordStateImpl>
      get copyWith => __$$ResettingPasswordStateImplCopyWithImpl<
          _$ResettingPasswordStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) {
    return resettingPassword(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) {
    return resettingPassword?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (resettingPassword != null) {
      return resettingPassword(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) {
    return resettingPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) {
    return resettingPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (resettingPassword != null) {
      return resettingPassword(this);
    }
    return orElse();
  }
}

abstract class ResettingPasswordState implements ForgotPasswordState {
  const factory ResettingPasswordState({required final String email}) =
      _$ResettingPasswordStateImpl;

  String get email;
  @JsonKey(ignore: true)
  _$$ResettingPasswordStateImplCopyWith<_$ResettingPasswordStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordResetStateImplCopyWith<$Res> {
  factory _$$PasswordResetStateImplCopyWith(_$PasswordResetStateImpl value,
          $Res Function(_$PasswordResetStateImpl) then) =
      __$$PasswordResetStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$PasswordResetStateImplCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res, _$PasswordResetStateImpl>
    implements _$$PasswordResetStateImplCopyWith<$Res> {
  __$$PasswordResetStateImplCopyWithImpl(_$PasswordResetStateImpl _value,
      $Res Function(_$PasswordResetStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$PasswordResetStateImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordResetStateImpl implements PasswordResetState {
  const _$PasswordResetStateImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordState.passwordReset(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordResetStateImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordResetStateImplCopyWith<_$PasswordResetStateImpl> get copyWith =>
      __$$PasswordResetStateImplCopyWithImpl<_$PasswordResetStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) {
    return passwordReset(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) {
    return passwordReset?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (passwordReset != null) {
      return passwordReset(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) {
    return passwordReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) {
    return passwordReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (passwordReset != null) {
      return passwordReset(this);
    }
    return orElse();
  }
}

abstract class PasswordResetState implements ForgotPasswordState {
  const factory PasswordResetState({required final String email}) =
      _$PasswordResetStateImpl;

  String get email;
  @JsonKey(ignore: true)
  _$$PasswordResetStateImplCopyWith<_$PasswordResetStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorResettingPasswordStateImplCopyWith<$Res> {
  factory _$$ErrorResettingPasswordStateImplCopyWith(
          _$ErrorResettingPasswordStateImpl value,
          $Res Function(_$ErrorResettingPasswordStateImpl) then) =
      __$$ErrorResettingPasswordStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object failure});
}

/// @nodoc
class __$$ErrorResettingPasswordStateImplCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res,
        _$ErrorResettingPasswordStateImpl>
    implements _$$ErrorResettingPasswordStateImplCopyWith<$Res> {
  __$$ErrorResettingPasswordStateImplCopyWithImpl(
      _$ErrorResettingPasswordStateImpl _value,
      $Res Function(_$ErrorResettingPasswordStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ErrorResettingPasswordStateImpl(
      null == failure ? _value.failure : failure,
    ));
  }
}

/// @nodoc

class _$ErrorResettingPasswordStateImpl implements ErrorResettingPasswordState {
  const _$ErrorResettingPasswordStateImpl(this.failure);

  @override
  final Object failure;

  @override
  String toString() {
    return 'ForgotPasswordState.errorResettingPassword(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorResettingPasswordStateImpl &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorResettingPasswordStateImplCopyWith<_$ErrorResettingPasswordStateImpl>
      get copyWith => __$$ErrorResettingPasswordStateImplCopyWithImpl<
          _$ErrorResettingPasswordStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String email) resettingPassword,
    required TResult Function(String email) passwordReset,
    required TResult Function(Object failure) errorResettingPassword,
  }) {
    return errorResettingPassword(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String email)? resettingPassword,
    TResult? Function(String email)? passwordReset,
    TResult? Function(Object failure)? errorResettingPassword,
  }) {
    return errorResettingPassword?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String email)? resettingPassword,
    TResult Function(String email)? passwordReset,
    TResult Function(Object failure)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (errorResettingPassword != null) {
      return errorResettingPassword(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(ResettingPasswordState value) resettingPassword,
    required TResult Function(PasswordResetState value) passwordReset,
    required TResult Function(ErrorResettingPasswordState value)
        errorResettingPassword,
  }) {
    return errorResettingPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(ResettingPasswordState value)? resettingPassword,
    TResult? Function(PasswordResetState value)? passwordReset,
    TResult? Function(ErrorResettingPasswordState value)?
        errorResettingPassword,
  }) {
    return errorResettingPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(ResettingPasswordState value)? resettingPassword,
    TResult Function(PasswordResetState value)? passwordReset,
    TResult Function(ErrorResettingPasswordState value)? errorResettingPassword,
    required TResult orElse(),
  }) {
    if (errorResettingPassword != null) {
      return errorResettingPassword(this);
    }
    return orElse();
  }
}

abstract class ErrorResettingPasswordState implements ForgotPasswordState {
  const factory ErrorResettingPasswordState(final Object failure) =
      _$ErrorResettingPasswordStateImpl;

  Object get failure;
  @JsonKey(ignore: true)
  _$$ErrorResettingPasswordStateImplCopyWith<_$ErrorResettingPasswordStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
