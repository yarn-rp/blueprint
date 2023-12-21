import 'package:app_ui/src/colors/colors.dart';
import 'package:app_ui/src/spacing/app_spacing.dart';

import 'package:app_ui/src/typography/typography.dart';
import 'package:flutter/material.dart';

const _buttonMinHeight = 52.0;
const _buttonMinWidth = 100.0;
const _buttonBorderRadius = 36.0;

/// {@template app_theme}
/// The light theme for the app.
/// {@endtemplate}
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: customTextTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.background,
    foregroundColor: lightColorScheme.onBackground,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(_buttonMinWidth, _buttonMinHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonBorderRadius),
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    height: _buttonMinHeight,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(_buttonMinWidth, _buttonMinHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonBorderRadius),
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      minimumSize: const Size(_buttonMinHeight, _buttonMinHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonBorderRadius),
      ),
    ),
  ),
  navigationDrawerTheme: NavigationDrawerThemeData(
    backgroundColor: lightColorScheme.surface,
    elevation: 0,
  ),
  searchBarTheme: SearchBarThemeData(
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    ),
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
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.background,
    foregroundColor: darkColorScheme.onBackground,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(_buttonMinWidth, _buttonMinHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonBorderRadius),
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    height: _buttonMinHeight,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(_buttonMinWidth, _buttonMinHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonBorderRadius),
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      minimumSize: const Size(_buttonMinHeight, _buttonMinHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonBorderRadius),
      ),
    ),
  ),
  navigationDrawerTheme: NavigationDrawerThemeData(
    backgroundColor: darkColorScheme.surface,
    elevation: 0,
  ),
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
