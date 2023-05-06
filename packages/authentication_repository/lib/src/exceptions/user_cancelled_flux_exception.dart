import 'package:authentication_repository/src/constants/constants.dart';
import 'package:authentication_repository/src/exceptions/exceptions.dart';

/// User stopped the flux of an authentication
class UserCancelledFluxException extends AuthBaseException {
  UserCancelledFluxException([String? message])
      : super(message ?? ErrorMessages.signInError);
}
