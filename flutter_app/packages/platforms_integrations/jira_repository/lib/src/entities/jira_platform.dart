import 'package:platform_integration_repository/platform_integration_repository.dart';

class JiraPlatform extends Platform {
  JiraPlatform({
    required super.id,
    required super.displayName,
    required super.iconUrl,
  }) : super(displayName: 'Jira');
}
