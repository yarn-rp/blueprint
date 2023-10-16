import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore converter for the user model
final userConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return (
      id: snapshot.id,
      displayName: data['displayName'] as String,
      email: data['email'] as String,
      photoURL: data['photoURL'] as String,
      blueprint: data['blueprint'] as List<Map<String, dynamic>>?,
    );
  },
  toFirestore: (
    UserModel value,
    SetOptions? options,
  ) {
    return {
      'displayName': value.displayName,
      'email': value.email,
      'photoURL': value.photoURL,
      'blueprint': value.blueprint,
    };
  },
);

/// The model of the user in database
typedef UserModel = ({
  String id,
  String displayName,
  String email,
  String photoURL,
  List<Map<String, dynamic>>? blueprint,
});
