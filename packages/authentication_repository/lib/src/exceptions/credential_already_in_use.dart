import 'package:authentication_repository/authentication_repository.dart';

class CredentialAlreadyInUseException extends LinkCredential {
  CredentialAlreadyInUseException(super.credential, [super.message]);
}
