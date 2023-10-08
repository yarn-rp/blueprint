// ranges from 0.0 to 1.0

import 'package:flutter/material.dart';

/// An [amount] darker version of the [color]. [amount] ranges from 0.0 to 1.0
/// where 0.0 is the same color and 1.0 is black.
Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

/// An [amount] lighter version of the [color]. [amount] ranges from 0.0 to 1.0
/// where 0.0 is the same color and 1.0 is white.
Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
