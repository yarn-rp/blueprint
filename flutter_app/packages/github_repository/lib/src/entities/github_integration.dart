// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:integrations_repository/integrations_repository.dart';

/// An integration with Github software.
abstract class GithubIntegration extends Integration {
  /// Creates a new [GithubIntegration] instance with the provided properties.
  const GithubIntegration() : super(github);
}
