import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

class FacebookLoginRequestFailedException extends SignInException {
  FacebookLoginRequestFailedException([String? message])
      : super(message ?? ErrorMessages.facebookLoginRequestFailed);
}
