import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('SignInException', () {
    test('can be instantiated', () {
      expect(
        () => SignInException('error'),
        returnsNormally,
      );
    });
  });
}
