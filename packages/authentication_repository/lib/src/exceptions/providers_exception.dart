import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

class ProvidersException extends AuthBaseException {
  ProvidersException([String? message])
      : super(message ?? ErrorMessages.emailAlreadyInUse);
}
