import 'package:equatable/equatable.dart';
import 'package:local_platform_integration_repository/src/entities/platform/platform.dart';

/// {@template integration}
/// Base class for integration with a third-party service.
/// Platform-specific integrations should extend this class with the proper
/// [platform] and additional properties.
/// {@endtemplate}
abstract class Integration<T extends Platform> extends Equatable {
  /// {@macro integration}
  const Integration(this.platform);

  /// The platform of the integration.
  final T platform;
}
