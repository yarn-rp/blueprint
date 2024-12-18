import 'package:app_ui/src/colors/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final colorsList = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.brown,
    Colors.grey,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
    Colors.lime,
    Colors.amber,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.blueGrey,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
  ];

  group('HexColor', () {
    for (final color in colorsList) {
      test('returns the hex value of $color', () {
        expect(
          HexColor(color).toHex(),
          equals(HexColor.fromHex(HexColor(color).toHex())!.toHex()),
        );
      });
    }
  });
}
