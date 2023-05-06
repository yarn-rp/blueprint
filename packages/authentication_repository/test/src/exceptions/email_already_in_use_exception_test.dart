import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('EmailAlreadyInUseException', () {
    test('can be instantiated', () {
      expect(
        () => EmailAlreadyInUseException('error'),
        returnsNormally,
      );
    });
  });
}
