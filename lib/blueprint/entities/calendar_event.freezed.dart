// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'event':
      return GeneralCalendarEvent.fromJson(json);
    case 'task':
      return TaskCalendarEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'CalendarEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$CalendarEvent {
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  String? get colorHex => throw _privateConstructorUsedError;
  bool get isAllDay => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)
        event,
    required TResult Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)
        task,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        event,
    TResult? Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        task,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        event,
    TResult Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        task,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GeneralCalendarEvent value) event,
    required TResult Function(TaskCalendarEvent value) task,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GeneralCalendarEvent value)? event,
    TResult? Function(TaskCalendarEvent value)? task,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GeneralCalendarEvent value)? event,
    TResult Function(TaskCalendarEvent value)? task,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarEventCopyWith<CalendarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEventCopyWith<$Res> {
  factory $CalendarEventCopyWith(
          CalendarEvent value, $Res Function(CalendarEvent) then) =
      _$CalendarEventCopyWithImpl<$Res, CalendarEvent>;
  @useResult
  $Res call(
      {DateTime startTime,
      DateTime endTime,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson) String? colorHex,
      bool isAllDay});
}

/// @nodoc
class _$CalendarEventCopyWithImpl<$Res, $Val extends CalendarEvent>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? colorHex = freezed,
    Object? isAllDay = null,
  }) {
    return _then(_value.copyWith(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      colorHex: freezed == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeneralCalendarEventCopyWith<$Res>
    implements $CalendarEventCopyWith<$Res> {
  factory _$$GeneralCalendarEventCopyWith(_$GeneralCalendarEvent value,
          $Res Function(_$GeneralCalendarEvent) then) =
      __$$GeneralCalendarEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime startTime,
      DateTime endTime,
      String subject,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson) String? colorHex,
      bool isAllDay});
}

/// @nodoc
class __$$GeneralCalendarEventCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$GeneralCalendarEvent>
    implements _$$GeneralCalendarEventCopyWith<$Res> {
  __$$GeneralCalendarEventCopyWithImpl(_$GeneralCalendarEvent _value,
      $Res Function(_$GeneralCalendarEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? subject = null,
    Object? colorHex = freezed,
    Object? isAllDay = null,
  }) {
    return _then(_$GeneralCalendarEvent(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: freezed == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeneralCalendarEvent extends GeneralCalendarEvent {
  const _$GeneralCalendarEvent(
      {required this.startTime,
      required this.endTime,
      required this.subject,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson) this.colorHex,
      this.isAllDay = false,
      final String? $type})
      : $type = $type ?? 'event',
        super._();

  factory _$GeneralCalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$$GeneralCalendarEventFromJson(json);

  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String subject;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final String? colorHex;
  @override
  @JsonKey()
  final bool isAllDay;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CalendarEvent.event(startTime: $startTime, endTime: $endTime, subject: $subject, colorHex: $colorHex, isAllDay: $isAllDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneralCalendarEvent &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startTime, endTime, subject, colorHex, isAllDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneralCalendarEventCopyWith<_$GeneralCalendarEvent> get copyWith =>
      __$$GeneralCalendarEventCopyWithImpl<_$GeneralCalendarEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)
        event,
    required TResult Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)
        task,
  }) {
    return event(startTime, endTime, subject, colorHex, isAllDay);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        event,
    TResult? Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        task,
  }) {
    return event?.call(startTime, endTime, subject, colorHex, isAllDay);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        event,
    TResult Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        task,
    required TResult orElse(),
  }) {
    if (event != null) {
      return event(startTime, endTime, subject, colorHex, isAllDay);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GeneralCalendarEvent value) event,
    required TResult Function(TaskCalendarEvent value) task,
  }) {
    return event(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GeneralCalendarEvent value)? event,
    TResult? Function(TaskCalendarEvent value)? task,
  }) {
    return event?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GeneralCalendarEvent value)? event,
    TResult Function(TaskCalendarEvent value)? task,
    required TResult orElse(),
  }) {
    if (event != null) {
      return event(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GeneralCalendarEventToJson(
      this,
    );
  }
}

abstract class GeneralCalendarEvent extends CalendarEvent {
  const factory GeneralCalendarEvent(
      {required final DateTime startTime,
      required final DateTime endTime,
      required final String subject,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
          final String? colorHex,
      final bool isAllDay}) = _$GeneralCalendarEvent;
  const GeneralCalendarEvent._() : super._();

  factory GeneralCalendarEvent.fromJson(Map<String, dynamic> json) =
      _$GeneralCalendarEvent.fromJson;

  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  String get subject;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  String? get colorHex;
  @override
  bool get isAllDay;
  @override
  @JsonKey(ignore: true)
  _$$GeneralCalendarEventCopyWith<_$GeneralCalendarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskCalendarEventCopyWith<$Res>
    implements $CalendarEventCopyWith<$Res> {
  factory _$$TaskCalendarEventCopyWith(
          _$TaskCalendarEvent value, $Res Function(_$TaskCalendarEvent) then) =
      __$$TaskCalendarEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
          Task task,
      DateTime startTime,
      DateTime endTime,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
          String? colorHex,
      bool isAllDay});
}

/// @nodoc
class __$$TaskCalendarEventCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$TaskCalendarEvent>
    implements _$$TaskCalendarEventCopyWith<$Res> {
  __$$TaskCalendarEventCopyWithImpl(
      _$TaskCalendarEvent _value, $Res Function(_$TaskCalendarEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? colorHex = freezed,
    Object? isAllDay = null,
  }) {
    return _then(_$TaskCalendarEvent(
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      colorHex: freezed == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskCalendarEvent extends TaskCalendarEvent {
  const _$TaskCalendarEvent(
      {@JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
          required this.task,
      required this.startTime,
      required this.endTime,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
          this.colorHex,
      this.isAllDay = false,
      final String? $type})
      : $type = $type ?? 'task',
        super._();

  factory _$TaskCalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$$TaskCalendarEventFromJson(json);

// ignore: invalid_annotation_target
  @override
  @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
  final Task task;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final String? colorHex;
  @override
  @JsonKey()
  final bool isAllDay;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CalendarEvent.task(task: $task, startTime: $startTime, endTime: $endTime, colorHex: $colorHex, isAllDay: $isAllDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskCalendarEvent &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, task, startTime, endTime, colorHex, isAllDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskCalendarEventCopyWith<_$TaskCalendarEvent> get copyWith =>
      __$$TaskCalendarEventCopyWithImpl<_$TaskCalendarEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)
        event,
    required TResult Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)
        task,
  }) {
    return task(this.task, startTime, endTime, colorHex, isAllDay);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        event,
    TResult? Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        task,
  }) {
    return task?.call(this.task, startTime, endTime, colorHex, isAllDay);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DateTime startTime,
            DateTime endTime,
            String subject,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        event,
    TResult Function(
            @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
                Task task,
            DateTime startTime,
            DateTime endTime,
            @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
                String? colorHex,
            bool isAllDay)?
        task,
    required TResult orElse(),
  }) {
    if (task != null) {
      return task(this.task, startTime, endTime, colorHex, isAllDay);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GeneralCalendarEvent value) event,
    required TResult Function(TaskCalendarEvent value) task,
  }) {
    return task(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GeneralCalendarEvent value)? event,
    TResult? Function(TaskCalendarEvent value)? task,
  }) {
    return task?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GeneralCalendarEvent value)? event,
    TResult Function(TaskCalendarEvent value)? task,
    required TResult orElse(),
  }) {
    if (task != null) {
      return task(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskCalendarEventToJson(
      this,
    );
  }
}

abstract class TaskCalendarEvent extends CalendarEvent {
  const factory TaskCalendarEvent(
      {@JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
          required final Task task,
      required final DateTime startTime,
      required final DateTime endTime,
      @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
          final String? colorHex,
      final bool isAllDay}) = _$TaskCalendarEvent;
  const TaskCalendarEvent._() : super._();

  factory TaskCalendarEvent.fromJson(Map<String, dynamic> json) =
      _$TaskCalendarEvent.fromJson;

// ignore: invalid_annotation_target
  @JsonKey(fromJson: TaskJsonMapper.fromJson, toJson: TaskJsonMapper.toJson)
  Task get task;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  String? get colorHex;
  @override
  bool get isAllDay;
  @override
  @JsonKey(ignore: true)
  _$$TaskCalendarEventCopyWith<_$TaskCalendarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
