import 'package:equatable/equatable.dart';

/// {@template local_notification}
/// A model representing a local notification.
/// {@endtemplate}
class LocalNotification extends Equatable {
  /// {@macro local_notification}
  const LocalNotification({
    required this.id,
    required this.title,
    required this.description,
    this.payload,
  });

  /// The unique identifier of the notification.
  final int id;

  /// The title of the notification.
  final String title;

  /// The description of the notification.
  final String description;

  /// The payload of the notification.
  final String? payload;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        payload,
      ];
}
