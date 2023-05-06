import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('SignUpException', () {
    test('can be instantiated', () {
      expect(
        () => SignUpException('error'),
        returnsNormally,
      );
    });
  });
}
