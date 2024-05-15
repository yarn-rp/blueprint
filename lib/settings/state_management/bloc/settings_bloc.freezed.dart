// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DaysOfWeek day, List<WorkTime> workingHours)
        changeWorkingHours,
    required TResult Function(AppBrightness brightness) changeBrightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DaysOfWeek day, List<WorkTime> workingHours)?
        changeWorkingHours,
    TResult? Function(AppBrightness brightness)? changeBrightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DaysOfWeek day, List<WorkTime> workingHours)?
        changeWorkingHours,
    TResult Function(AppBrightness brightness)? changeBrightness,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeWorkingHours value) changeWorkingHours,
    required TResult Function(ChangeBrightness value) changeBrightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeWorkingHours value)? changeWorkingHours,
    TResult? Function(ChangeBrightness value)? changeBrightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeWorkingHours value)? changeWorkingHours,
    TResult Function(ChangeBrightness value)? changeBrightness,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEventCopyWith<$Res> {
  factory $SettingsEventCopyWith(
          SettingsEvent value, $Res Function(SettingsEvent) then) =
      _$SettingsEventCopyWithImpl<$Res, SettingsEvent>;
}

/// @nodoc
class _$SettingsEventCopyWithImpl<$Res, $Val extends SettingsEvent>
    implements $SettingsEventCopyWith<$Res> {
  _$SettingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChangeWorkingHoursImplCopyWith<$Res> {
  factory _$$ChangeWorkingHoursImplCopyWith(_$ChangeWorkingHoursImpl value,
          $Res Function(_$ChangeWorkingHoursImpl) then) =
      __$$ChangeWorkingHoursImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DaysOfWeek day, List<WorkTime> workingHours});
}

/// @nodoc
class __$$ChangeWorkingHoursImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$ChangeWorkingHoursImpl>
    implements _$$ChangeWorkingHoursImplCopyWith<$Res> {
  __$$ChangeWorkingHoursImplCopyWithImpl(_$ChangeWorkingHoursImpl _value,
      $Res Function(_$ChangeWorkingHoursImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? workingHours = null,
  }) {
    return _then(_$ChangeWorkingHoursImpl(
      null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DaysOfWeek,
      null == workingHours
          ? _value._workingHours
          : workingHours // ignore: cast_nullable_to_non_nullable
              as List<WorkTime>,
    ));
  }
}

/// @nodoc

class _$ChangeWorkingHoursImpl implements ChangeWorkingHours {
  const _$ChangeWorkingHoursImpl(this.day, final List<WorkTime> workingHours)
      : _workingHours = workingHours;

  @override
  final DaysOfWeek day;
  final List<WorkTime> _workingHours;
  @override
  List<WorkTime> get workingHours {
    if (_workingHours is EqualUnmodifiableListView) return _workingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workingHours);
  }

  @override
  String toString() {
    return 'SettingsEvent.changeWorkingHours(day: $day, workingHours: $workingHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeWorkingHoursImpl &&
            (identical(other.day, day) || other.day == day) &&
            const DeepCollectionEquality()
                .equals(other._workingHours, _workingHours));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, day, const DeepCollectionEquality().hash(_workingHours));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeWorkingHoursImplCopyWith<_$ChangeWorkingHoursImpl> get copyWith =>
      __$$ChangeWorkingHoursImplCopyWithImpl<_$ChangeWorkingHoursImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DaysOfWeek day, List<WorkTime> workingHours)
        changeWorkingHours,
    required TResult Function(AppBrightness brightness) changeBrightness,
  }) {
    return changeWorkingHours(day, workingHours);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DaysOfWeek day, List<WorkTime> workingHours)?
        changeWorkingHours,
    TResult? Function(AppBrightness brightness)? changeBrightness,
  }) {
    return changeWorkingHours?.call(day, workingHours);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DaysOfWeek day, List<WorkTime> workingHours)?
        changeWorkingHours,
    TResult Function(AppBrightness brightness)? changeBrightness,
    required TResult orElse(),
  }) {
    if (changeWorkingHours != null) {
      return changeWorkingHours(day, workingHours);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeWorkingHours value) changeWorkingHours,
    required TResult Function(ChangeBrightness value) changeBrightness,
  }) {
    return changeWorkingHours(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeWorkingHours value)? changeWorkingHours,
    TResult? Function(ChangeBrightness value)? changeBrightness,
  }) {
    return changeWorkingHours?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeWorkingHours value)? changeWorkingHours,
    TResult Function(ChangeBrightness value)? changeBrightness,
    required TResult orElse(),
  }) {
    if (changeWorkingHours != null) {
      return changeWorkingHours(this);
    }
    return orElse();
  }
}

abstract class ChangeWorkingHours implements SettingsEvent {
  const factory ChangeWorkingHours(
          final DaysOfWeek day, final List<WorkTime> workingHours) =
      _$ChangeWorkingHoursImpl;

  DaysOfWeek get day;
  List<WorkTime> get workingHours;
  @JsonKey(ignore: true)
  _$$ChangeWorkingHoursImplCopyWith<_$ChangeWorkingHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeBrightnessImplCopyWith<$Res> {
  factory _$$ChangeBrightnessImplCopyWith(_$ChangeBrightnessImpl value,
          $Res Function(_$ChangeBrightnessImpl) then) =
      __$$ChangeBrightnessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppBrightness brightness});
}

/// @nodoc
class __$$ChangeBrightnessImplCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$ChangeBrightnessImpl>
    implements _$$ChangeBrightnessImplCopyWith<$Res> {
  __$$ChangeBrightnessImplCopyWithImpl(_$ChangeBrightnessImpl _value,
      $Res Function(_$ChangeBrightnessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brightness = null,
  }) {
    return _then(_$ChangeBrightnessImpl(
      null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as AppBrightness,
    ));
  }
}

/// @nodoc

class _$ChangeBrightnessImpl implements ChangeBrightness {
  const _$ChangeBrightnessImpl(this.brightness);

  @override
  final AppBrightness brightness;

  @override
  String toString() {
    return 'SettingsEvent.changeBrightness(brightness: $brightness)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeBrightnessImpl &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brightness);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeBrightnessImplCopyWith<_$ChangeBrightnessImpl> get copyWith =>
      __$$ChangeBrightnessImplCopyWithImpl<_$ChangeBrightnessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DaysOfWeek day, List<WorkTime> workingHours)
        changeWorkingHours,
    required TResult Function(AppBrightness brightness) changeBrightness,
  }) {
    return changeBrightness(brightness);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DaysOfWeek day, List<WorkTime> workingHours)?
        changeWorkingHours,
    TResult? Function(AppBrightness brightness)? changeBrightness,
  }) {
    return changeBrightness?.call(brightness);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DaysOfWeek day, List<WorkTime> workingHours)?
        changeWorkingHours,
    TResult Function(AppBrightness brightness)? changeBrightness,
    required TResult orElse(),
  }) {
    if (changeBrightness != null) {
      return changeBrightness(brightness);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeWorkingHours value) changeWorkingHours,
    required TResult Function(ChangeBrightness value) changeBrightness,
  }) {
    return changeBrightness(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeWorkingHours value)? changeWorkingHours,
    TResult? Function(ChangeBrightness value)? changeBrightness,
  }) {
    return changeBrightness?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeWorkingHours value)? changeWorkingHours,
    TResult Function(ChangeBrightness value)? changeBrightness,
    required TResult orElse(),
  }) {
    if (changeBrightness != null) {
      return changeBrightness(this);
    }
    return orElse();
  }
}

abstract class ChangeBrightness implements SettingsEvent {
  const factory ChangeBrightness(final AppBrightness brightness) =
      _$ChangeBrightnessImpl;

  AppBrightness get brightness;
  @JsonKey(ignore: true)
  _$$ChangeBrightnessImplCopyWith<_$ChangeBrightnessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
