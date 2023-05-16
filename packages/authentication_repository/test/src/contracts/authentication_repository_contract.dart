import 'package:authentication_repository/src/contracts/contracts.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class FakeAuthenticationRepository extends Fake
    implements AuthenticationRepositoryContract {}

void main() {
  test('AuthenticationRepositoryContract can be implemented', () {
    expect(FakeAuthenticationRepository.new, returnsNormally);
  });
}
