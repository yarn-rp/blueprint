import 'package:platform_integration_repository/platform_integration_repository.dart';

/// {@template integrations_exceptions}
/// Exceptions thrown by the integrations repository.
/// {@endtemplate}
class IntegrationException implements Exception {
  /// {@macro integrations_exceptions}
  const IntegrationException(this.message);

  /// The error message.
  final String message;
}

/// {@template integrations_not_found_exception}
/// Thrown when an integration is detected to be expired, and it needs to be
/// refreshed.
/// {@endtemplate}
class IntegrationExpiredException implements IntegrationException {
  /// {@macro integrations_not_found_exception}
  const IntegrationExpiredException(this.integration);

  /// The integration that was not found.
  final Integration integration;

  @override
  String get message =>
      'Your session with ${integration.platform.displayName} has expired. '
      'Please sign in again.';
}

/// {@template integration_unsupported_exception}
/// Thrown when an integration is not supported.
/// {@endtemplate}
class IntegrationUnsupportedException implements IntegrationException {
  /// {@macro integration_unsupported_exception}
  const IntegrationUnsupportedException(this.integration);

  /// The integration that was not found.
  final Integration integration;

  @override
  String get message =>
      'The integration with ${integration.platform.displayName} is not '
      'supported.';
}

/// {@template integrations_not_found_exception}
/// Thrown when an integration is not found.
/// {@endtemplate}
class IntegrationNotFoundException implements IntegrationException {
  /// {@macro integrations_not_found_exception}
  const IntegrationNotFoundException(this.integration);

  /// The integration that was not found.
  final Integration integration;

  @override
  String get message =>
      'The integration with ${integration.platform.displayName} was not found.';
}
