import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

class SignInException extends AuthBaseException {
  SignInException([String? message])
      : super(message ?? ErrorMessages.signInError);
}
