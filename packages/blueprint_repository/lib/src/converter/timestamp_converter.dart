import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    try {
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
    } catch (e) {
      print('TimestampConverter: fromJson: $e');
      rethrow;
    }
  }

  @override
  dynamic toJson(DateTime date) {
    // convert to TimeStamp
    return Timestamp.fromDate(date);
  }
}

// class TimestampOrNullConverter implements JsonConverter<DateTime?, Timestamp?> {
//   const TimestampOrNullConverter();

//   @override
//   DateTime? fromJson(Timestamp? timestamp) {
//     return timestamp?.toDate();
//   }

//   @override
//   Timestamp? toJson(DateTime? date) =>
//       date == null ? null : Timestamp.fromDate(date);
// }
