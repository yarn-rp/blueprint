import 'package:jiffy/jiffy.dart';

extension DateTimeX on DateTime {
  /// Rounds the minutes of the [DateTime] to the nearest [minutes] interval.
  DateTime round({required int minutes}) {
    return copyWith(
      minute:
          minutes * (Jiffy.parseFromDateTime(this).minute / minutes).round(),
    );
  }

  DateTime truncate({required int minutes}) {
    return copyWith(
      minute:
          minutes * (Jiffy.parseFromDateTime(this).minute / minutes).floor(),
    );
  }
}
