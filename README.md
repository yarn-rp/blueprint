<img src="docs/assets/images/blueprint_background.png" alt="Blueprint background">

![coverage][coverage_badge]
[style: very good analysis][very_good_analysis_link]
[License: MIT][license_link]

Simple yet powerful solution to manage your tasks across multiple platforms. Built with Flutter 💙

---

## Blueprint

This is a task manager for multiple projects. It allows you to manage your tasks in one place, even if they are in different platforms. It is built using Flutter, so it can run on Android, iOS, Web, MacOS, Windows and Linux. Flutter is nice right? :)

## Why using it?

If you are a productivity freak like me, you probably have tasks in different platforms. For example, you may have tasks in Jira, Trello, GitHub, etc. It is hard to keep track of all your tasks, specially if you are working at the same time in different projects, cause not all of them are in the same platform, and sometimes the same platform is used for different projects. Blueprint allows you to manage all your tasks in one place, by integrating with the different platforms you use. It is not a replacement for those platforms, it is just a way to keep track of all your tasks in one place.

## Data privacy

Blueprint is a completely serverless solution(not anymore). That means that everything is happening on the client side. That means that you don't need to create an account, or to give your credentials to any third party. Blueprint is just a client that connects to the different platforms you use, and fetches your tasks. It is not storing any of your data, it is just fetching it from the different platforms you use. That means that you can use it without any worries about your data. It is also open source, so you can check the code and see that it is not doing anything weird with your data.

## Getting started

Blueprint is not yet ready for production, but you can install it in your machine and try it out. To install it, you need to have Flutter installed in your machine. You can follow the instructions [here](https://flutter.dev/docs/get-started/install). Once you have Flutter installed, you can clone this repository.

This project contains 3 flavors:

- [ ] development
- [ ] staging
- [ ] production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Blueprint works on iOS, Android, Web, and Windows._

### How to use it?

Once you have the app running, you will see a screen like this:

TODO: Insert image of the might do screen

To add some integrations, go to settings and click integrations. That will take you to the integrations page:

TODO: Insert image of the integrations screen

There you can add the integrations you want. Currently supports only Jira and GitHub, but more integrations are planned to be added in the future. Once you have added the integrations you want, you can go back to the might do screen and you will see your tasks there:

TODO: Insert image of the might do screen with tasks

### Might do

The might do screen contains all the tasks that are assigned to you or somehow require your attention. You can click on a task to see more details about it:

TODO: Insert image of the task details screen

There you can see more details about the task. You can also click on the links that will take you to the platform where the task is located.

We use the `might do` name, since this is the place where you can see all the tasks that you might do. It is not a place where you can see all the tasks that you have to do, since time is limited and you will have to prioritize from all your tasks which ones you are going to implement in a day. This is a place where you can see all the tasks that you might do, and you can decide which ones you want to do.

To add a task to your day, you can click on the add to day button:

This will add the task to `Todays Blueprint`. You can also add a task to your day by clicking on the task and then clicking on the add to day button in the task details screen.

### Todays Blueprint

This is the most important screen of the app. This is where you can see all the tasks that you have planned for the day. It will highlight the current plan and the next 3 tasks so you can get an idea of what you have planned for the next moment.

All the tasks that you have added to your day are presented in a timeline format. You can click on a task to see more details about it. Integrations with calendars is also planned to be added in the future, so you see your calendar events here too, and can make more realistic plans for your day.

In here you can move the tasks around to change their order. You can also remove them from your day. To do that, you can click on the task and then click on the remove from day button in the task details screen.

## Features planned to be added in the future

This project is still in its early stages, so there are a lot of features that are planned to be added in the future. Some of them are:

TODO: add links to issues

- [ ] Add more integrations (Trello, Asana, etc.)
- [ ] Add calendar integration
- [ ] Add more features to the Todays Blueprint screen like tracking time, etc.
- [ ] Add more features to the Might Do screen like filtering, etc.
- [ ] Adding notifications to remind you of your tasks
- [ ] Adding ChatGPT integration to help you choose the tasks for a day
- [ ] Generate a stand-up report with the tasks you have done in a day and what you are going to do today. This report can be sent to your team so they know what you are doing.

## How to contribute?

For each of these features, there is an issue in the repository. If you want to contribute to this project, you can take a look at the issues and see if there is something you want to work on. If you want to add a feature that is not in the issues, you can open an issue and describe the feature you want to add.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
