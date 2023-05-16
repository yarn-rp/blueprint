import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/constants/constants.dart';

class AppleNotSupportedException extends AppleSignInException {
  AppleNotSupportedException([String? message])
      : super(message ?? ErrorMessages.appleSignInNotSupported);
}
