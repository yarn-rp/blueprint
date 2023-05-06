import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:authentication_repository/src/models/models.dart';

class AccountExistWithDifferentCredentialException extends AuthBaseException {
  AccountExistWithDifferentCredentialException({
    required this.credential,
    required this.email,
    String? message,
  }) : super(message ?? ErrorMessages.accountExistWithDifferentCredential);

  final AuthCredential credential;
  final String email;
}
