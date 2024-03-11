import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }

    if (timestamp is DateTime) {
      return timestamp;
    }

    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }

    throw Exception('TimestampConverter: fromJson: unknown type');
  }

  @override
  dynamic toJson(DateTime date) {
    // convert to TimeStamp
    return Timestamp.fromDate(date);
  }
}
