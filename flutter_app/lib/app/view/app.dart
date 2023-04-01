import 'package:flutter/material.dart';
import 'package:poll_e_task/app/presentation/pages/intial_page.dart';
import 'package:poll_e_task/l10n/l10n.dart';
import 'package:poll_e_task/tasks/presentation/pages/projects.dart';
import 'package:poll_e_task/tasks/presentation/pages/tickets_page.dart';
import 'package:poll_e_task/tasks/repositories/projects_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            page: ProjectsPage(
              projects: [
                jiraProject,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
