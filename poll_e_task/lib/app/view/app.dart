import 'package:flutter/material.dart';
import 'package:poll_e_task/app/presentation/pages/intial_page.dart';
import 'package:poll_e_task/l10n/l10n.dart';
import 'package:poll_e_task/tasks/domain/entities/entities.dart';
import 'package:poll_e_task/tasks/presentation/pages/tasks_page.dart';
import 'package:poll_e_task/utils/color/hex_color_extension.dart';

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
            page: TasksPage(
              tasks: [
                TaskEntity(
                  id: '1',
                  project: Project(
                    '1',
                    'Zelfio App',
                    JiraProvider(
                      id: '1',
                      name: 'Provider 1',
                      description: 'Description 1',
                    ),
                  ),
                  title: 'Replace all the variables in the assessment messages',
                  description: 'Description 1',
                  dueDate: DateTime.now(),
                  isCompleted: false,
                  status: TaskStatus(
                    'TO-DO',
                    Theme.of(context).colorScheme.secondary.toHex(),
                  ),
                ),
              ],
            ),
          ),
          NavigationPageData(
            text: 'Another one',
            icon: Icons.list,
            page: Container(),
          ),
        ],
      ),
    );
  }
}
