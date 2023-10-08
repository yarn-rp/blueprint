import 'package:app_ui/src/colors/colors.dart';
import 'package:app_ui/src/typography/typography.dart';
import 'package:flutter/material.dart';

/// {@template app_theme}
/// The light theme for the app.
/// {@endtemplate}
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: customTextTheme,
);

/// {@template app_theme}
/// The dark theme for the app.
/// {@endtemplate}
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: customTextTheme,
);
