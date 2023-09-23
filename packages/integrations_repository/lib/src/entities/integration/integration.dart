import 'package:equatable/equatable.dart';
import 'package:integrations_repository/src/entities/platform/platform.dart';

/// {@template integration}
/// Base class for integration with a third-party service.
/// Platform-specific integrations should extend this class with the proper
/// [platform] and additional properties.
/// {@endtemplate}
abstract class Integration extends Equatable {
  /// {@macro integration}
  const Integration(this.platform);

  /// The platform of the integration.
  final Platform platform;

  /// A method that returns the integration as a map to be used in the
  /// connect API. This is used to connect the integration to the app. Not
  /// all integrations have the same parameters, so this method must be
  /// implemented by the specific integration.
  Map<String, dynamic> toConnectApiParams();
}

class OAuth2Integration extends Integration {
  OAuth2Integration(super.platform, this.token)
      : assert(
          platform.authentication is OAuth2,
          'Authentication must be OAuth2',
        );
  final String token;

  @override
  List<Object?> get props => [platform];

  @override
  Map<String, dynamic> toConnectApiParams() {
    final platformPartialJson = platform.toJson();

    return {
      'code': token,
      //TODO: change this on backend side since displayName should not be used
      // as a key.
      ...platformPartialJson,
    };
  }
}
