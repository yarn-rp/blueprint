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
    backgroundColor: lightColorScheme.surface,
    foregroundColor: lightColorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  dividerColor: lightColorScheme.outlineVariant,
  dividerTheme: DividerThemeData(
    thickness: 1,
    space: 0,
    color: lightColorScheme.outlineVariant,
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
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(_buttonMinWidth, _buttonMinHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonBorderRadius),
      ),
    ),
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
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    ),
    backgroundColor: WidgetStateProperty.all(
      lightColorScheme.outlineVariant.withOpacity(.2),
    ),
    elevation: WidgetStateProperty.all(0),
    textStyle: WidgetStateProperty.all(
      customTextTheme.bodyLarge,
    ),
  ),
  cardTheme: CardTheme(
    color: lightColorScheme.outlineVariant.withOpacity(.2),
    elevation: 0,
  ),
  cardColor: lightColorScheme.outlineVariant.withOpacity(.2),
);

/// {@template app_theme}
/// The dark theme for the app.
/// {@endtemplate}
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: customTextTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  dividerColor: darkColorScheme.outlineVariant,
  dividerTheme: DividerThemeData(
    indent: 0,
    endIndent: 0,
    thickness: 1,
    space: 0,
    color: darkColorScheme.outlineVariant,
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
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(_buttonMinWidth, _buttonMinHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonBorderRadius),
      ),
    ),
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
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: AppSpacing.lg),
    ),
    backgroundColor: WidgetStateProperty.all(
      darkColorScheme.outline.withOpacity(0.2),
    ),
    elevation: WidgetStateProperty.all(0),
    textStyle: WidgetStateProperty.all(
      customTextTheme.bodyLarge,
    ),
  ),
  cardTheme: CardTheme(
    color: darkColorScheme.outline.withOpacity(0.2),
    elevation: 0,
  ),
  cardColor: darkColorScheme.outline.withOpacity(0.2),
);
