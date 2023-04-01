import 'package:flutter/material.dart';
import 'package:poll_e_task/tasks/domain/entities/entities.dart';
import 'package:poll_e_task/tasks/presentation/widgets/project.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: GridView.builder(
          itemCount: projects.length + 1,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            maxCrossAxisExtent: 500,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == projects.length) {
              return const Card(
                child: Center(
                  child: Text('Add new project'),
                ),
              );
            }
            final project = projects[index];

            return ProjectCard(
              project: project,
            );
          },
        ),
      ),
    );
  }
}
