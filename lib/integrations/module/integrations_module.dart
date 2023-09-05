import 'package:blueprint/integrations/state_management/cubit/integrations_cubit.dart';
import 'package:calendar_repository/calendar_repository.dart'
    show CalendarRepository;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_repository/github_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  GitHubRepository githubRepository(FlutterSecureStorage secureStorage) =>
      GitHubRepository(
        secureStorage: secureStorage,
      );

  @lazySingleton
  IntegrationsRepository integrationsRepository(
    JiraRepository jiraRepository,
    GitHubRepository githubRepository,
  ) =>
      IntegrationsRepository(
        repositories: [jiraRepository, githubRepository],
      );

  @lazySingleton
  IntegrationsCubit integrationsCubit(
    CalendarRepository integrationsRepository,
    GoogleSignIn googleSignIn,
  ) =>
      IntegrationsCubit(
        integrationsRepository,
        googleSignIn,
      );
}
