import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

class AppleSignInException extends SignInException {
  AppleSignInException([String? message])
      : super(message ?? ErrorMessages.appleSignInError);
}
