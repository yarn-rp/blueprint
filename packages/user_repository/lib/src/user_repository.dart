import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:user_repository/src/entities/user/user.dart';

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

  /// Return a stream of the current user data. If user is not authenticated,
  /// the stream will emit null.
  Stream<User?> getUserData() {
    return _currentUserIdStream.switchMap<User?>((userId) {
      print('user id: $userId');
      if (userId == null) {
        return const Stream.empty();
      }

      final userDoc = _usersCollection.doc(userId);

      return userDoc.snapshots().map((snapshot) {
        final userData = snapshot.data() as Map<String, dynamic>?;
        print('userData: $userData');
        if (userData == null) {
          return null;
        }

        final userInstance = User.fromJson(userData);
        return userInstance;
      });
    });
  }
}
