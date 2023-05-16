import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('WeakPasswordException', () {
    test('can be instantiated', () {
      expect(
        () => WeakPasswordException('error'),
        returnsNormally,
      );
    });
  });
}
