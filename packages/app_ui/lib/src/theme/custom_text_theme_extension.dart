// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// {@template custom_text_theme}
/// A custom text theme extension class.
/// {@endtemplate}
class CustomTextTheme extends ThemeExtension<CustomTextTheme> {
  /// {@macro custom_text_theme}
  const CustomTextTheme({
    required this.textXXLarge,
    required this.textXLarge,
    required this.textLarge,
    required this.textMedium,
    required this.textSmall,
    required this.textXSmall,
    required this.navigationLarge,
    required this.navigationSmall,
    required this.titleXXLarge,
    required this.titleXLarge,
    required this.titleLarge,
    required this.titleMedium,
    required this.headline1,
    required this.headline2,
    required this.headline3,
    required this.headline4,
    required this.headlineEyebrow,
    required this.buttonLarge,
    required this.buttonMedium,
    required this.buttonSmall,
    required this.alternateNavigationLarge,
    required this.alternateNavigationSmall,
    required this.alternateTitleXXLarge,
    required this.alternateTitleXLarge,
    required this.alternateTitleLarge,
    required this.alternateTitleMedium,
  });

  final TextStyle? textXXLarge;
  final TextStyle? textXLarge;
  final TextStyle? textLarge;
  final TextStyle? textMedium;
  final TextStyle? textSmall;
  final TextStyle? textXSmall;
  final TextStyle? navigationLarge;
  final TextStyle? navigationSmall;
  final TextStyle? titleXXLarge;
  final TextStyle? titleXLarge;
  final TextStyle? titleLarge;
  final TextStyle? titleMedium;
  final TextStyle? headline1;
  final TextStyle? headline2;
  final TextStyle? headline3;
  final TextStyle? headline4;
  final TextStyle? headlineEyebrow;
  final TextStyle? buttonLarge;
  final TextStyle? buttonMedium;
  final TextStyle? buttonSmall;
  final TextStyle? alternateNavigationLarge;
  final TextStyle? alternateNavigationSmall;
  final TextStyle? alternateTitleXXLarge;
  final TextStyle? alternateTitleXLarge;
  final TextStyle? alternateTitleLarge;
  final TextStyle? alternateTitleMedium;

  @override
  CustomTextTheme copyWith({
    TextStyle? textXXLarge,
    TextStyle? textXLarge,
    TextStyle? textLarge,
    TextStyle? textMedium,
    TextStyle? textSmall,
    TextStyle? textXSmall,
    TextStyle? navigationLarge,
    TextStyle? navigationSmall,
    TextStyle? titleXXLarge,
    TextStyle? titleXLarge,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? headline3,
    TextStyle? headline4,
    TextStyle? headlineEyebrow,
    TextStyle? buttonLarge,
    TextStyle? buttonMedium,
    TextStyle? buttonSmall,
    TextStyle? alternateNavigationLarge,
    TextStyle? alternateNavigationSmall,
    TextStyle? alternateTitleXXLarge,
    TextStyle? alternateTitleXLarge,
    TextStyle? alternateTitleLarge,
    TextStyle? alternateTitleMedium,
  }) {
    return CustomTextTheme(
      textXXLarge: textXXLarge ?? this.textXXLarge,
      textXLarge: textXLarge ?? this.textXLarge,
      textLarge: textLarge ?? this.textLarge,
      textMedium: textMedium ?? this.textMedium,
      textSmall: textSmall ?? this.textSmall,
      textXSmall: textXSmall ?? this.textXSmall,
      navigationLarge: navigationLarge ?? this.navigationLarge,
      navigationSmall: navigationSmall ?? this.navigationSmall,
      titleXXLarge: titleXXLarge ?? this.titleXXLarge,
      titleXLarge: titleXLarge ?? this.titleXLarge,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      headline3: headline3 ?? this.headline3,
      headline4: headline4 ?? this.headline4,
      headlineEyebrow: headlineEyebrow ?? this.headlineEyebrow,
      buttonLarge: buttonLarge ?? this.buttonLarge,
      buttonMedium: buttonMedium ?? this.buttonMedium,
      buttonSmall: buttonSmall ?? this.buttonSmall,
      alternateNavigationLarge:
          alternateNavigationLarge ?? this.alternateNavigationLarge,
      alternateNavigationSmall:
          alternateNavigationSmall ?? this.alternateNavigationSmall,
      alternateTitleXXLarge:
          alternateTitleXXLarge ?? this.alternateTitleXXLarge,
      alternateTitleXLarge: alternateTitleXLarge ?? this.alternateTitleXLarge,
      alternateTitleLarge: alternateTitleLarge ?? this.alternateTitleLarge,
      alternateTitleMedium: alternateTitleMedium ?? this.alternateTitleMedium,
    );
  }

  @override
  CustomTextTheme lerp(ThemeExtension<CustomTextTheme>? other, double t) {
    if (other is! CustomTextTheme) {
      return this;
    }
    return CustomTextTheme(
      textXXLarge: TextStyle.lerp(textXXLarge, other.textXXLarge, t),
      textXLarge: TextStyle.lerp(textXLarge, other.textXLarge, t),
      textLarge: TextStyle.lerp(textLarge, other.textLarge, t),
      textMedium: TextStyle.lerp(textMedium, other.textMedium, t),
      textSmall: TextStyle.lerp(textSmall, other.textSmall, t),
      textXSmall: TextStyle.lerp(textXSmall, other.textXSmall, t),
      navigationLarge: TextStyle.lerp(
        navigationLarge,
        other.navigationLarge,
        t,
      ),
      navigationSmall: TextStyle.lerp(
        navigationSmall,
        other.navigationSmall,
        t,
      ),
      titleXXLarge: TextStyle.lerp(titleXXLarge, other.titleXXLarge, t),
      titleXLarge: TextStyle.lerp(titleXLarge, other.titleXLarge, t),
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t),
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t),
      headline1: TextStyle.lerp(headline1, other.headline1, t),
      headline2: TextStyle.lerp(headline2, other.headline2, t),
      headline3: TextStyle.lerp(headline3, other.headline3, t),
      headline4: TextStyle.lerp(headline4, other.headline4, t),
      headlineEyebrow:
          TextStyle.lerp(headlineEyebrow, other.headlineEyebrow, t),
      buttonLarge: TextStyle.lerp(buttonLarge, other.buttonLarge, t),
      buttonMedium: TextStyle.lerp(buttonMedium, other.buttonMedium, t),
      buttonSmall: TextStyle.lerp(buttonSmall, other.buttonSmall, t),
      alternateNavigationLarge: TextStyle.lerp(
        alternateNavigationLarge,
        other.alternateNavigationLarge,
        t,
      ),
      alternateNavigationSmall: TextStyle.lerp(
        alternateNavigationSmall,
        other.alternateNavigationSmall,
        t,
      ),
      alternateTitleXXLarge: TextStyle.lerp(
        alternateTitleXXLarge,
        alternateTitleXXLarge,
        t,
      ),
      alternateTitleXLarge: TextStyle.lerp(
        alternateTitleXLarge,
        other.alternateTitleXLarge,
        t,
      ),
      alternateTitleLarge: TextStyle.lerp(
        alternateTitleLarge,
        other.alternateTitleLarge,
        t,
      ),
      alternateTitleMedium: TextStyle.lerp(
        alternateTitleMedium,
        other.alternateTitleMedium,
        t,
      ),
    );
  }

  CustomTextTheme apply({
    String? fontFamily,
    double fontSizeFactor = 1.0,
    double fontSizeDelta = 0.0,
    Color? displayColor,
    Color? bodyColor,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
  }) {
    return CustomTextTheme(
      textXXLarge: textXXLarge?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      textXLarge: textXLarge?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      textLarge: textLarge?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      textMedium: textMedium?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      textSmall: textSmall?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      textXSmall: textXSmall?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      navigationLarge: navigationLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      navigationSmall: navigationSmall?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      titleXXLarge: titleXXLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      titleXLarge: titleXLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      titleLarge: titleLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      titleMedium: titleMedium?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headline1: headline1?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headline2: headline2?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headline3: headline3?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headline4: headline4?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headlineEyebrow: headlineEyebrow?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      buttonLarge: buttonLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      buttonMedium: buttonMedium?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      buttonSmall: buttonSmall?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      alternateNavigationLarge: alternateNavigationLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      alternateNavigationSmall: alternateNavigationSmall?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      alternateTitleXXLarge: alternateTitleXXLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      alternateTitleXLarge: alternateTitleXLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      alternateTitleLarge: alternateTitleLarge?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      alternateTitleMedium: alternateTitleMedium?.apply(
        color: bodyColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
    );
  }
}
