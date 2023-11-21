import 'package:app_ui/src/colors/color_variations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color Variations', () {
    const color = Colors.blue;

    group('darken', () {
      test('returns a darker version of the color', () {
        final darkerColor = darken(color, .2);
        final darkerLuminance = darkerColor.computeLuminance();

        expect(darkerLuminance, lessThan(color.computeLuminance()));
      });
    });

    group('lighten', () {
      test('returns a lighter version of the color', () {
        final lighterColor = lighten(color, .2);
        final lighterLuminance = lighterColor.computeLuminance();

        expect(lighterLuminance, greaterThan(color.computeLuminance()));
      });
    });
  });
}
