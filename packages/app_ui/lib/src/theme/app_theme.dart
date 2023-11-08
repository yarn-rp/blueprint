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
  searchBarTheme: SearchBarThemeData(
    backgroundColor: MaterialStateProperty.all(
      lightColorScheme.surface,
    ),
    textStyle: MaterialStateProperty.all(
      customTextTheme.bodyLarge,
    ),
  ),
  cardTheme: CardTheme(
    color: lightColorScheme.surface,
  ),
  cardColor: lightColorScheme.surface,
);

/// {@template app_theme}
/// The dark theme for the app.
/// {@endtemplate}
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: customTextTheme,
  searchBarTheme: SearchBarThemeData(
    backgroundColor: MaterialStateProperty.all(
      darkColorScheme.surface,
    ),
    textStyle: MaterialStateProperty.all(
      customTextTheme.bodyLarge,
    ),
  ),
  cardTheme: CardTheme(
    color: darkColorScheme.surface,
  ),
  cardColor: darkColorScheme.surface,
);
