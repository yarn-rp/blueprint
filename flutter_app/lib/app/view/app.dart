import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integrations_repository/integrations_repository.dart';
import 'package:jira_repository/jira_repository.dart';
import 'package:poll_e_task/app/presentation/pages/intial_page.dart';
import 'package:poll_e_task/integrations/presentation/integrations_page.dart';
import 'package:poll_e_task/integrations/state_management/cubit/integrations_cubit.dart';
import 'package:poll_e_task/l10n/l10n.dart';
import 'package:poll_e_task/projects/presentation/pages/projects.dart';
import 'package:poll_e_task/projects/state_management/projects_bloc/projects_bloc.dart';
import 'package:poll_e_task/tasks/presentation/pages/tickets_page.dart';
import 'package:project_repository/project_repository.dart';

/// Injects all the repositories into the widget tree.
class RepositoriesProvider extends StatelessWidget {
  const RepositoriesProvider({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const jiraRepository = JiraRepository();
    const integrationRepository = IntegrationsRepository(jiraRepository);
    const projectRepository = ProjectRepository(integrationRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: integrationRepository,
        ),
        RepositoryProvider.value(
          value: projectRepository,
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
            context.read<ProjectRepository>(),
          ),
        ),
        BlocProvider.value(
          value: IntegrationsCubit(
            context.read<IntegrationsRepository>(),
          ),
        ),
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
