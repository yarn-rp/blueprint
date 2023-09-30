// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// {@template custom_color_theme}
/// A custom color theme extension class.
/// {@endtemplate}
class CustomColorTheme extends ThemeExtension<CustomColorTheme> {
  /// {@macro custom_color_theme}
  const CustomColorTheme({
    required this.brandPrimary,
    required this.brandSecondary,
    required this.brandTertiary,
    required this.foregroundNeutral,
    required this.inactiveInverseSurfaceSecondary,
    required this.inverseSurfaceSecondary,
    required this.inverseSurfaceSecondaryTranslucent,
    required this.neutralDark80,
    required this.neutralDark70,
    required this.neutralDark50,
    required this.neutralDark04,
    required this.neutralLight,
    required this.foregroundNeutral20,
    required this.backgroundNeutral,
    required this.surfaceSecondary,
    required this.transparent,
    required this.warningRed,
  });

  final Color brandPrimary;
  final Color brandSecondary;
  final Color brandTertiary;
  final Color foregroundNeutral;
  final Color inactiveInverseSurfaceSecondary;
  final Color inverseSurfaceSecondary;
  final Color inverseSurfaceSecondaryTranslucent;
  final Color neutralDark80;
  final Color neutralDark70;
  final Color neutralDark50;
  final Color neutralDark04;
  final Color neutralLight;
  final Color foregroundNeutral20;
  final Color backgroundNeutral;
  final Color surfaceSecondary;
  final Color transparent;
  final Color warningRed;

  @override
  CustomColorTheme copyWith({
    Color? brandPrimary,
    Color? brandSecondary,
    Color? brandTertiary,
    Color? foregroundNeutral,
    Color? inactiveInverseSurfaceSecondary,
    Color? inverseSurfaceSecondary,
    Color? inverseSurfaceSecondaryTranslucent,
    Color? neutralDark80,
    Color? neutralDark70,
    Color? neutralDark50,
    Color? neutralDark04,
    Color? neutralLight,
    Color? foregroundNeutral20,
    Color? backgroundNeutral,
    Color? surfaceSecondary,
    Color? transparent,
    Color? warningRed,
  }) {
    return CustomColorTheme(
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandSecondary: brandSecondary ?? this.brandSecondary,
      brandTertiary: brandTertiary ?? this.brandTertiary,
      foregroundNeutral: foregroundNeutral ?? this.foregroundNeutral,
      inactiveInverseSurfaceSecondary: inactiveInverseSurfaceSecondary ??
          this.inactiveInverseSurfaceSecondary,
      inverseSurfaceSecondary:
          inverseSurfaceSecondary ?? this.inverseSurfaceSecondary,
      inverseSurfaceSecondaryTranslucent: inverseSurfaceSecondaryTranslucent ??
          this.inverseSurfaceSecondaryTranslucent,
      neutralDark80: neutralDark80 ?? this.neutralDark80,
      neutralDark70: neutralDark70 ?? this.neutralDark70,
      neutralDark50: neutralDark50 ?? this.neutralDark50,
      neutralDark04: neutralDark04 ?? this.neutralDark04,
      neutralLight: neutralLight ?? this.neutralLight,
      foregroundNeutral20: foregroundNeutral20 ?? this.foregroundNeutral20,
      backgroundNeutral: backgroundNeutral ?? this.backgroundNeutral,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      transparent: transparent ?? this.transparent,
      warningRed: warningRed ?? this.warningRed,
    );
  }

  @override
  CustomColorTheme lerp(ThemeExtension<CustomColorTheme>? other, double t) {
    if (other is! CustomColorTheme) {
      return this;
    }
    return CustomColorTheme(
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      brandSecondary: Color.lerp(brandSecondary, other.brandSecondary, t)!,
      brandTertiary: Color.lerp(brandTertiary, other.brandTertiary, t)!,
      foregroundNeutral:
          Color.lerp(foregroundNeutral, other.foregroundNeutral, t)!,
      inactiveInverseSurfaceSecondary: Color.lerp(
        inactiveInverseSurfaceSecondary,
        other.inactiveInverseSurfaceSecondary,
        t,
      )!,
      inverseSurfaceSecondary: Color.lerp(
        inverseSurfaceSecondary,
        other.inverseSurfaceSecondary,
        t,
      )!,
      inverseSurfaceSecondaryTranslucent: Color.lerp(
        inverseSurfaceSecondary,
        other.inverseSurfaceSecondary,
        t,
      )!,
      neutralDark80: Color.lerp(neutralDark80, other.neutralDark80, t)!,
      neutralDark70: Color.lerp(neutralDark70, other.neutralDark70, t)!,
      neutralDark50: Color.lerp(neutralDark50, other.neutralDark50, t)!,
      neutralDark04: Color.lerp(neutralDark04, other.neutralDark04, t)!,
      neutralLight: Color.lerp(neutralLight, other.neutralLight, t)!,
      foregroundNeutral20: Color.lerp(
        foregroundNeutral20,
        other.foregroundNeutral20,
        t,
      )!,
      backgroundNeutral: Color.lerp(
        backgroundNeutral,
        other.backgroundNeutral,
        t,
      )!,
      surfaceSecondary: Color.lerp(
        surfaceSecondary,
        other.surfaceSecondary,
        t,
      )!,
      transparent: Color.lerp(transparent, other.transparent, t)!,
      warningRed: Color.lerp(warningRed, other.warningRed, t)!,
    );
  }
}
