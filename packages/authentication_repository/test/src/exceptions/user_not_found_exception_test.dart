import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('UserNotFoundException', () {
    test('can be instantiated', () {
      expect(
        () => UserNotFoundException('error'),
        returnsNormally,
      );
    });
  });
}
