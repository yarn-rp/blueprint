import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('WrongPasswordException', () {
    test('can be instantiated', () {
      expect(
        () => WrongPasswordException('error'),
        returnsNormally,
      );
    });
  });
}
