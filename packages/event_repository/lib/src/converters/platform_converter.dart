import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:integrations_repository/integrations_repository.dart';

/// {@template platform_converter}
/// Converts a [DocumentSnapshot] to a [Platform] and vice versa.
/// {@endtemplate}
class PlatformConverter {
  /// Converts a [DocumentSnapshot] to a [Platform].
  static Platform fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    final data = snapshot.data()!;
    return Platform.fromJson(data);
  }

  /// Converts a [Platform] to a [Map].
  static Map<String, dynamic> toFirestore(Platform platform, SetOptions? _) =>
      platform.toJson();
}
