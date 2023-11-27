import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:user_repository/src/entities/user/user.dart';

/// [User] converter for firestore
final userConverter = (
  fromFirestore: (
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return User.fromJson(data);
  },
  toFirestore: (User user, SetOptions? options) => user.toJson(),
);
const String _usersCollectionName = 'users';

/// {@template user_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required Stream<String?> currentUserIdStream,
    required FirebaseFirestore firestore,
  }) {
    _currentUserIdStream = currentUserIdStream;
    _usersCollection = firestore.collection(_usersCollectionName);
  }
  late final Stream<String?> _currentUserIdStream;

  late final CollectionReference _usersCollection;

  /// Return a stream of the current user data.
  Stream<User> getUserData() {
    return _currentUserIdStream.switchMap<User>((userId) {
      if (userId == null) {
        return const Stream.empty();
      }

      final userDoc = _usersCollection.doc(userId);

      return userDoc.snapshots().map((snapshot) {
        final userData = snapshot.data()! as User;
        return userData;
      });
    });
  }
}
