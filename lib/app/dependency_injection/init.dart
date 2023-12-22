import 'dart:async';

import 'package:blueprint/app/dependency_injection/init.config.dart';
import 'package:blueprint/core/env/app_environment.dart';
import 'package:blueprint/core/module/firebase_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}) async {
  await sl.init(
    environment: environment.name,
    environmentFilter: environmentFilter,
  );

  if (environment == AppEnvironment.local) {
    print('Setting up firebase emulators for local...');
    await setupFirebaseEmulators(
      sl<FirebaseAuth>(),
      sl<FirebaseFirestore>(),
      sl<FirebaseFunctions>(),
    );
  }
}
