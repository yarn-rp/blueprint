import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/reset_password_exception.dart';

class InvalidEmailException extends ResetPasswordException {
  InvalidEmailException([String? message])
      : super(message ?? ErrorMessages.invalidEmail);
}
