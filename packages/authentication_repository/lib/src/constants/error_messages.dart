class ErrorMessages {
  static const authBaseError = 'An unknown exception occurred.';

  //Sing in errors
  static const signInError = 'An unknown exception occurred while signing in.';
  static const wrongPassword = 'Incorrect password, please try again.';
  static const userNotFound = 'Email was not found, please create an account.';

  //Sign up errors
  static const signUpError = 'An unknown exception occurred while signing up.';
  static const weakPassword = 'The password provided is too weak.';
  static const emailAlreadyInUse = 'The account already exists for that email.';
  static const invalidEmail = 'Email is not valid';

  //Facebook errors
  static const facebookLoginRequestFailed = 'Facebook login request has failed';
  static const accountExistWithDifferentCredential =
      'This account has another authentication provider associated';

  //Apple errors
  static const appleSignInError = 'Apple sing in request has failed';
  static const appleSignInNotSupported = 'Sign in with Apple is not supported';
}
