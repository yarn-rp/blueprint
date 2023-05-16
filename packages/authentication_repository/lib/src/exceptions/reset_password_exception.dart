import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

class ResetPasswordException extends AuthBaseException {
  ResetPasswordException([String? message])
      : super(message ?? ErrorMessages.invalidEmail);
}
