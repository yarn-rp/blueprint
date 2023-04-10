import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_repository/github_repository.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/jira_repository.dart';
import 'package:poll_e_task/app/presentation/pages/intial_page.dart';
import 'package:poll_e_task/blueprint/presentation/pages/todays_blueprint.dart';
import 'package:poll_e_task/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart';
import 'package:poll_e_task/integrations/presentation/pages/integrations_page.dart';
import 'package:poll_e_task/integrations/state_management/cubit/integrations_cubit.dart';
import 'package:poll_e_task/l10n/l10n.dart';
import 'package:poll_e_task/projects/presentation/pages/projects.dart';
import 'package:poll_e_task/projects/state_management/projects_cubit/projects_cubit.dart';
import 'package:poll_e_task/tasks/presentation/pages/tasks_page.dart';
import 'package:poll_e_task/tasks/state_management/cubit/tasks_cubit.dart';

/// Injects all the repositories into the widget tree.
class RepositoriesProvider extends StatelessWidget {
  const RepositoriesProvider({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const secureStorage = FlutterSecureStorage();
    final jiraRepository = JiraRepository(secureStorage: secureStorage);
    final githubRepository = GithubRepository(secureStorage: secureStorage);

    final integrationRepository = IntegrationsRepository(
      repositories: [
        jiraRepository,
        githubRepository,
      ],
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: integrationRepository,
        ),
      ],
      child: child,
    );
  }
}

/// Injects all the blocs that are used like global state into the widget tree.
class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ProjectsCubit(
            context.read<IntegrationsRepository>(),
          )..loadProjects(),
        ),
        BlocProvider.value(
          value: TasksCubit(
            context.read<IntegrationsRepository>(),
          )..loadTasks(),
        ),
        BlocProvider.value(
          value: IntegrationsCubit(
            context.read<IntegrationsRepository>(),
          ),
        ),
        BlocProvider.value(
          value: TodaysBlueprintCubit(),
        )
      ],
      child: child,
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoriesProvider(
      child: BlocsProvider(
        child: MaterialApp(
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: InitialPage(
            navigationPages: [
              NavigationPageData(
                text: 'Todays Blueprint',
                icon: Icons.today,
                page: const TodaysBlueprint(),
              ),
              NavigationPageData(
                text: 'Tasks',
                icon: Icons.task_sharp,
                page: const TasksPage(),
              ),
              NavigationPageData(
                text: 'Integrations',
                icon: Icons.integration_instructions,
                page: const IntegrationsPage(),
              ),
              NavigationPageData(
                text: 'Projects',
                icon: Icons.work,
                page: const ProjectsPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
