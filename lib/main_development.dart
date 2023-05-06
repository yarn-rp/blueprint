import 'package:blueprint/app/app.dart';
import 'package:blueprint/bootstrap.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(App.new);
}
