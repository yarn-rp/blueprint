import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poll_e_task/app/presentation/pages/intial_page.dart';
import 'package:poll_e_task/integrations/repositories/integration_repositories.dart';
import 'package:poll_e_task/l10n/l10n.dart';
import 'package:poll_e_task/tasks/presentation/pages/projects.dart';
import 'package:poll_e_task/tasks/presentation/pages/tickets_page.dart';
import 'package:poll_e_task/tasks/repositories/projects_repository.dart';
import 'package:poll_e_task/tasks/state_management/bloc/projects_bloc.dart';

/// Injects all the repositories into the widget tree.
class RepositoriesProvider extends StatelessWidget {
  const RepositoriesProvider({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final integrationRepository = IntegrationRepository();
    final projectRepository = ProjectRepository(integrationRepository);

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
                page: const TicketsPage(
                  tasks: [],
                ),
              ),
              NavigationPageData(
                text: 'Integrations',
                icon: Icons.integration_instructions,
                page: Container(),
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
