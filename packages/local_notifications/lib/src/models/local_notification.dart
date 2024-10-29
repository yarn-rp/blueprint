import 'package:equatable/equatable.dart';

class LocalNotification extends Equatable {
  LocalNotification({
    required this.id,
    required this.title,
    required this.description,
    this.payload,
  });

  final int id;
  final String title;
  final String description;
  final String? payload;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        payload,
      ];
}
