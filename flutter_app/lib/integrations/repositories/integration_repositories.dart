import 'package:poll_e_task/integrations/entities/integration.dart';

class IntegrationRepository {
  IntegrationRepository();

  Stream<List<Integration>> getIntegrations() {
    return Stream.value(integrations);
  }
}

final List<Integration> integrations = [
  JiraBasicAuthIntegration(
    username: 'yrodriguez@createthrive.com',
    password:
        'ATATT3xFfGF0ROm4PXsExTla0DCAxYJvcyJorJLpfxBsxAzStl0c-VyKiUtxAbQte33JDbymAkBLYVZeyEHiWMAFZPMrM3TzC6-dakF4JXFMfMHRwvxqjbnGVTfWhgGbJGm-GqrYAkb1gALE0iDksLgKDptWSOwmVQeaJcU-Y8ODifK4iQ9Ch2I=7363C57A',
    url: 'zelfio.atlassian.net',
  ),
];
