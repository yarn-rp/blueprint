import 'package:blueprint/integrations/state_management/cubit/integrations_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_repository/github_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/jira_repository.dart';

@module
abstract class IntegrationsModule {
  @lazySingleton
  JiraRepository jiraRepository(FlutterSecureStorage secureStorage) =>
      JiraRepository(
        secureStorage: secureStorage,
      );

  @lazySingleton
  GithubRepository githubRepository(FlutterSecureStorage secureStorage) =>
      GithubRepository(
        secureStorage: secureStorage,
      );

  @lazySingleton
  IntegrationsRepository integrationsRepository(
    JiraRepository jiraRepository,
    GithubRepository githubRepository,
  ) =>
      IntegrationsRepository(
        repositories: [jiraRepository, githubRepository],
      );

  @lazySingleton
  IntegrationsCubit integrationsCubit(
    IntegrationsRepository integrationsRepository,
  ) =>
      IntegrationsCubit(
        integrationsRepository,
      );
}
