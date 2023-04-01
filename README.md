# poll-e-task
A simple task manager for multiple projects. Also a very bad name to a project.

## What is this?

This is a simple task manager for multiple projects. It's an app that you can use to manage your tasks and projects. The idea is to have a simple way to unify all your tasks in one place, and to have a simple way to manage them. It's not a replacement for a full blown project management tool, but it's a good way to keep track of your tasks and projects.

## How to use it?

Inside the folder `flutter_app` you will find the source code for the app. You can use it as a template for your own app, or you can use it as a reference to build your own app. The app is built using Flutter, so you will need to install Flutter to run it. You can find the instructions to install Flutter [here](https://flutter.dev/docs/get-started/install).

If you just want to try the app, you can download the executable from the release folder. You can find the latest builds [here](flutter_app/build).

## How to contribute?

If you want to contribute to this project, you can fork the repository and make a pull request. If you want to add a feature, please open an issue first so we can discuss it. If you want to report a bug, please open an issue and describe the bug.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Initial model

```ts
class User {
  displayName: string;

  platformUrl: string;

  iconUrl?: string;
}

class Platform {
  // kick-off id
  id: string;

  displayName: string;

  // explanation of how to integrate the platform to kick off (rich-text)
  //? what is this used for?
  howToIntegrateGuide: string;

  iconUrl?: string;
}

class Project {
  // kick-off id
  id: string;

  // platform-specific id
  platformId: string;

  // platform-specific URL (Jira URL etc.)
  platformURL: URL;

  //ex: Jira,Trello
  platform: Platform;

  // project name
  name: string;

  // project description
  description: string;

  // project icon
  iconUrl?: string;

  // project members
  members: User[];
}



export class Task {
  // Kick off creation date
  createdAt: Date;

  // Kick off creation date
  updatedAt: Date;

  // Kick off id
  id: string;

  // Project to which the ticket belongs
  project: Project;

  // The url of the ticket in the platform
  ticketURL: URL;

  // Title of the ticket
  title: string;

  //maybe rich text (markdown || html)
  description: string;

  startDate: Date;

  dueDate: Date;

  estimatedTime: Duration;

  // if we implement the time-logger
  // these would be the hours worked on the ticket
  loggedTime: Duration;

  assigned: User[]; // me included

  creator: User;

  completed: boolean;

  // the workflow to which the task belongs,
  // each project may have several workflows,
  // a workflow may be the cycle or sprint for which the task is planned
  // workflow: Workflow; // a workflow has reference to a project
  state: State; //state in platform

  // ideally we should find a way to unify
  // priorities across the different tasks providers
  priority: Priority; //maybe a float
}
```