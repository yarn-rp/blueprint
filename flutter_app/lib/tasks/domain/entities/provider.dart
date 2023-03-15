/// Refers to the tool that was used to create the task.
class Project {
  Project(
    this.id,
    this.name,
    this.provider,
  );

  final String id;
  final String name;
  final Provider provider;
}

abstract class Provider {}

class JiraProvider implements Provider {
  JiraProvider({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;
}

class GithubProvider implements Provider {
  GithubProvider({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;
}

class TrelloProvider implements Provider {
  TrelloProvider({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;
}

class AsanaProvider implements Provider {
  AsanaProvider({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;
}
