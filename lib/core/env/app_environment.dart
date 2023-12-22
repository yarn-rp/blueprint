import 'package:injectable/injectable.dart';

/// {@template app_environment}
/// Use [AppEnvironment] to provide/access some information about the
/// Environment app is running.
///
/// Access [AppEnvironment] name with the [name] property.
///
/// Currently has supported 3 environments:
/// 1. [AppEnvironment.local] : Use it for local dependencies. This is the one
/// you should use to inject dependencies in `main_local.dart` file. This is
/// the default environment for development purposes. This env requires you run
/// the app passing environment variables to connect to emulators. Please
/// read README.md file for more information.
/// 2. [AppEnvironment.development] : Use it for develop dependencies. This is
/// the one you should use to inject dependencies in `main_development.dart`
/// file. Typically you want to use it to do development phase stuff like a
/// different backend url, or some very dev dependencies like a console logger.
/// 3. [AppEnvironment.staging] : Use it for staging dependencies. This is
/// the one you should use to inject dependencies in `main_staging.dart` file.
/// 4. [AppEnvironment.production] : Use if for production dependencies.
/// This file is the one you should use to inject dependencies in
/// `main_production.dart` file. Typically, you want to use it
/// to avoid development and staging dependencies.
/// {@endtemplate}
class AppEnvironment implements Environment {
  /// {@macro app_environment}
  const AppEnvironment(this.name);

  static const AppEnvironment local = AppEnvironment('local');
  static const AppEnvironment development = AppEnvironment('dev');
  static const AppEnvironment production = AppEnvironment('prod');
  static const AppEnvironment staging = AppEnvironment('stg');

  @override
  final String name;
}

/// Decorator for dependencies that are meant to run in `local`
/// environment.
///
/// Annotate a class with `@local` to mark it as a `local`
/// dependency.
/// Example:
/// ```dart
/// @local
/// @Singleton(as: ContractClass)
/// // Or @LazySingleton
/// class ContractImplementation implements ContractClass {
///  ...
/// }
/// ```
///
/// Avoid using `@local` if you want to provide more than 1 environment.
/// If that's the case, check [EnvironmentFilter] class.
const local = AppEnvironment.local;

/// Decorator for dependencies that are meant to run in `development`
/// environment.
///
/// Annotate a class with `@development` to mark it as a `development`
/// dependency.
/// Example:
/// ```dart
/// @development
/// @Singleton(as: ContractClass)
/// // Or @LazySingleton
/// class ContractImplementation implements ContractClass {
///   ...
/// }
/// ```
///
/// Avoid using `@development` if you want to provide more than 1 environment.
/// If that's the case, check [EnvironmentFilter] class.
const development = AppEnvironment.development;

/// Decorator for dependencies that are meant to run in `production`
/// environment.
///
/// Annotate a class with `@production` to mark it as a `production`
/// dependency.
/// Example:
/// ```dart
/// @production
/// @Singleton(as: ContractClass)
/// // Or @LazySingleton
/// class ContractImplementation implements ContractClass {
///   ...
/// }
/// ```
///
/// Avoid using `@production` if you want to provide more than 1 environment.
/// If that's the case, check [EnvironmentFilter] class.
const production = AppEnvironment.production;

/// Decorator for dependencies that are meant to run in `staging`
/// environment.
///
/// Annotate a class with `@staging` to mark it as a `staging`
/// dependency.
/// Example:
/// ```dart
/// @staging
/// @Singleton(as: ContractClass)
/// // Or @LazySingleton
/// class ContractImplementation implements ContractClass {
///   ...
/// }
/// ```
///
/// Avoid using `@staging` if you want to provide more than 1 environment.
/// If that's the case, check [EnvironmentFilter] class.
const staging = AppEnvironment.staging;
