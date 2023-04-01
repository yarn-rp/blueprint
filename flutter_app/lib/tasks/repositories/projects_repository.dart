import 'package:poll_e_task/tasks/entities/entities.dart';

/// {@template project_repository}
/// A repository that manages projects.
/// {@endtemplate}
class ProjectRepository {
  /// {@macro project_repository}
  ProjectRepository();

  /// Returns a stream of all projects, reacting to project changes.
  Stream<List<Project>> getProjects() async* {
    yield projects;
  }

  /// Returns a stream of a single project, reacting to project changes.
  Stream<Project> getProject(String id) async* {
    yield projects.firstWhere((project) => project.id == id);
  }

  /// Creates a new project.
  Future<void> createProject(Project project) async {
    projects.add(project);
  }

  /// Updates a project.
  Future<void> updateProject(Project project) async {
    final index = projects.indexWhere((element) => element.id == project.id);
    projects[index] = project;
  }

  /// Deletes a project.
  Future<void> deleteProject(Project id) async {
    projects.removeWhere((element) => element.id == id.id);
  }
}

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

final projects = [
  jiraProject,
];

final testTask = Task(
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
);
