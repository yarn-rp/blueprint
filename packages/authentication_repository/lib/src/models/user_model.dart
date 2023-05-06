import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// {@template user_model}
/// User model
/// {@endtemplate}
class UserModel extends Equatable {
  /// {@macro user_model}

  const UserModel({
    required this.id,
    this.email,
    this.name,
  });

  factory UserModel.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
    );
  }

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  @override
  List<Object?> get props => [id, name, email];
}
