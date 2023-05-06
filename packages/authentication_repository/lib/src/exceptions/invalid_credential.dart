import 'package:authentication_repository/authentication_repository.dart';

class InvalidCredentialException extends LinkCredential {
  InvalidCredentialException(super.credential, [super.message]);
}
