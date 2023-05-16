import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

class WeakPasswordException extends SignUpException {
  WeakPasswordException([String? message])
      : super(message ?? ErrorMessages.weakPassword);
}
