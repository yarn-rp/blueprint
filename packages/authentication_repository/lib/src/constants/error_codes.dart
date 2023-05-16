class ErrorCodes {
  //Sign in error codes
  static const userNotFound = 'user-not-found';
  static const wrongPassword = 'wrong-password';

  //Sign up error codes
  static const weakPassword = 'weak-password';
  static const emailAlreadyUsed = 'email-already-in-use';
  static const invalidCredential = 'invalid-credential';
  static const providerAlreadyLinked = 'provider-already-linked';
  static const credentialAlreadyInUse = 'credential-already-in-use';

  static const accountExistWithDifferentCredential =
      'account-exists-with-different-credential';
  static const authInvalidEmail = 'invalid-email';
}
