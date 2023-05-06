import 'package:authentication_repository/src/constants/constants.dart';

class AuthBaseException implements Exception {
  AuthBaseException([this.message]);
  final String? message;

  @override
  String toString() {
    return message ?? ErrorMessages.authBaseError;
  }
}
