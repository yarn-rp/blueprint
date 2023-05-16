import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

class EmailAlreadyInUseException extends SignUpException {
  EmailAlreadyInUseException([String? message])
      : super(message ?? ErrorMessages.emailAlreadyInUse);
}
