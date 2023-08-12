import 'package:blueprint/projects/presentation/widgets/project.dart';
import 'package:blueprint/projects/state_management/projects_cubit/projects_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProjectsPage();
  }
}

class _ProjectsPage extends StatefulWidget {
  const _ProjectsPage();

  @override
  State<_ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<_ProjectsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        final projects = state.projects;

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
                final project = projects.elementAt(index);

                return ProjectCard(
                  project: project,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
