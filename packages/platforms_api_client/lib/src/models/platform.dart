import 'package:cloud_firestore/cloud_firestore.dart';

final platformConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return (
      id: snapshot.id,
      name: data['name'] as String,
      iconUrl: data['iconUrl'] as String,
      type: data['type'] as String,
      description: data['description'] as String?,
      auth: (
        type: data['auth']['type'] as String,
        url: data['auth']['url'] as String,
      ),
    );
  },
  toFirestore: (
    PlatformModel value,
    SetOptions? options,
  ) {
    return {
      'name': value.name,
      'iconUrl': value.iconUrl,
      'type': value.type,
      'description': value.description,
      'auth': {
        'type': value.auth.type,
        'url': value.auth.url,
      },
    };
  },
);

/// {@template platform_model}
/// Platform model.
/// {@endtemplate}
typedef PlatformModel = ({
  String id,
  String name,
  String iconUrl,
  String type,
  String? description,
  AuthenticationModel auth,
});

/// {@template authentication_model}
/// Authentication model.
/// {@endtemplate}
typedef AuthenticationModel = ({
  String type,
  String url,
});
