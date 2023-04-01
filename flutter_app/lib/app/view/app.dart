import 'package:flutter/material.dart';
import 'package:poll_e_task/app/presentation/pages/intial_page.dart';
import 'package:poll_e_task/l10n/l10n.dart';
import 'package:poll_e_task/tasks/domain/entities/entities.dart';
import 'package:poll_e_task/tasks/presentation/pages/projects.dart';
import 'package:poll_e_task/tasks/presentation/pages/tickets_page.dart';
// Dummy data

const yanJiraMember = User(
  'some url',
  'Yan Rodriguez',
  'https://avatars.githubusercontent.com/u/47568606?v=4',
);
const javierJiraMember = User(
  'some url',
  'Javier Valdes',
  'https://avatars.githubusercontent.com/u/47668606?v=4',
);
final jiraProject = Project(
  id: 'some-unique-id',
  platformId: 'some-unique-id',
  platformURL: Uri.parse(
    'https://zelfio.atlassian.net/jira/software/projects/ZAD/boards/1',
  ),
  platform: JiraPlatform(
    id: 'the jira id',
  ),
  name: 'Zelfio',
  description: 'Zelfio project description',
  members: [yanJiraMember, javierJiraMember],
  colorHex: '#228B22',
);

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
            page: TicketsPage(
              tasks: [
                Task(
                  createdAt: DateTime.now().subtract(const Duration(days: 1)),
                  updatedAt: DateTime.now().subtract(const Duration(days: 1)),
                  id: 'some-unique-id',
                  project: jiraProject,
                  ticketURL: Uri.parse('https://www.google.com'),
                  title: 'Implementation of UI for the tickets page',
                  description: '''
As a user, I want to be able to search for nearby restaurants 🍔🌮🍝 using my zip code 🔢 or address 🗺️ so that I can find the best place to eat near me.

📋 Acceptance Criteria

The search bar accepts input of either zip code or address
When valid input is entered, a list of nearby restaurants is displayed on the screen 📱
The list includes restaurant name, location, and cuisine type 🍴
User can filter the list by distance, rating ⭐, and price 💰
Clicking on a restaurant displays more details about it, such as menu items 📜, reviews 📝, and photos 📷
The app should be responsive and optimized for different screen sizes 🖥️📱''',
                  startDate: DateTime.now(),
                  dueDate: DateTime.now().add(const Duration(days: 1)),
                  estimatedTime: const Duration(days: 2),
                  loggedTime: const Duration(hours: 12),
                  assigned: [
                    yanJiraMember,
                    javierJiraMember,
                    yanJiraMember,
                    javierJiraMember,
                    yanJiraMember,
                    javierJiraMember,
                    yanJiraMember,
                    javierJiraMember,
                    yanJiraMember,
                    javierJiraMember,
                  ],
                  creator: javierJiraMember,
                  isCompleted: false,
                  status: Status('In Progress', '#FF0000'),
                  priority: 1,
                ),
              ],
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
