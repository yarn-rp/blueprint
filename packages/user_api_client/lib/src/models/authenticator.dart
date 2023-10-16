/// Authenticator model
typedef AuthenticatorModel = ({
  String id,
  String platformName,
  String type,
  AuthenticatorUserModel user,
});

/// Represents the user on the authenticated platform.
typedef AuthenticatorUserModel = ({
  String email,
  String name,
});
