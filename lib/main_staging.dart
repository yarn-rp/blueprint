import 'package:blueprint/app/app.dart';

import 'package:blueprint/bootstrap.dart';
import 'package:blueprint/core/env/app_environment.dart';
import 'package:blueprint/core/firebase_options/firebase_options_stg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await bootstrap(
    () => const App(),
    environment: AppEnvironment.staging,
  );
}
