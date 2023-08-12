import 'package:blueprint/app/app.dart';
import 'package:blueprint/app/dependency_injection/global_dependencies_provider.dart';
import 'package:blueprint/bootstrap.dart';
import 'package:blueprint/core/env/app_environment.dart';
import 'package:blueprint/core/firebase_options/firebase_options_dev.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await bootstrap(
    () => const GlobalDependenciesProvider(
      child: App(),
    ),
    environment: AppEnvironment.development,
  );
}
