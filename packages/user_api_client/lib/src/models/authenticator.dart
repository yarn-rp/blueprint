import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore converter for the authenticator model
final authenticatorConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;

    return (
      id: snapshot.id,
      platformName: data['platformName'] as String,
      type: data['type'] as String,
      user: data['user'] as AuthenticatorUserModel,
    );
  },
  toFirestore: (
    AuthenticatorModel value,
    SetOptions? options,
  ) {
    return {
      'platformName': value.platformName,
      'type': value.type,
      'user': value.user,
    };
  },
);

/// Authenticator model
typedef AuthenticatorModel = ({
  String id,
  String platformName,
  String type,
  AuthenticatorUserModel user,
});

/// Represents the user on the authenticated platform.
typedef AuthenticatorUserModel = ({
  String email,
  String name,
});
