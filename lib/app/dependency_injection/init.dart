import 'dart:async';

import 'package:blueprint/app/dependency_injection/init.config.dart';
import 'package:blueprint/core/env/app_environment.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Global instance of [GetIt] service locator.
final sl = GetIt.I;

/// Configures dependencies for stuff inside lib/core folder.
@InjectableInit(
  generateForDir: ['lib'],
  preferRelativeImports: false,
)
FutureOr<void> configureDependencies(
  GetIt sl, {
  required AppEnvironment environment,
  EnvironmentFilter? environmentFilter,
}) =>
    sl.init(
      environment: environment.name,
      environmentFilter: environmentFilter,
    );
