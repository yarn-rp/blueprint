import 'package:authentication_repository/src/exceptions/user_cancelled_flux_exception.dart';
import 'package:authentication_repository/src/oauth_providers/google_authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class _MockGoogleSignIn extends Mock implements GoogleSignIn {}

class _MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class _MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

void main() {
  late GoogleAuthenticationProvider googleAuthenticationProvider;
  late GoogleSignIn googleSignIn;
  late GoogleSignInAccount googleUser;

  group('Google Authentication provider', () {
    setUp(() {
      googleSignIn = _MockGoogleSignIn();
      googleAuthenticationProvider = GoogleAuthenticationProvider(
        googleSignIn: googleSignIn,
      );
    });

    group('GetGoogleCredential', () {
      group('GoogleSignIn Flux is completed', () {
        setUp(() {
          googleUser = _MockGoogleSignInAccount();
          when(() => googleSignIn.signIn()).thenAnswer(
            (_) => Future.value(googleUser),
          );
        });
        test(
            'Should throw exception when googleUser.authentication throws '
            'exception.', () async {
          // Arrange -> setup test dependencies
          when(() => googleUser.authentication).thenThrow(Exception());

          // Expect -> Compute functionality you wanna test and assert it
          await expectLater(
            googleAuthenticationProvider.getGoogleCredential,
            throwsException,
          );
          verify(() => googleUser.authentication).called(1);
        });

        group('googleUser.authentication returns authentication class', () {
          late GoogleSignInAuthentication googleAuth;
          late String accessToken;
          late String idToken;
          setUp(() {
            googleAuth = _MockGoogleSignInAuthentication();
            accessToken = 'access-token';
            idToken = 'id-token';

            when(() => googleUser.authentication).thenAnswer(
              (_) => Future.value(
                googleAuth,
              ),
            );
            when(() => googleAuth.accessToken).thenReturn(accessToken);
            when(() => googleAuth.idToken).thenReturn(idToken);
          });

          test(
              'Should return credential when google.userAuthentication '
              'returns properly.', () async {
            // Act -> Compute functionality you wanna test
            final result =
                await googleAuthenticationProvider.getGoogleCredential();

            // Assert -> Verify the output and behavior is the expected
            expect(result, isA<firebase_auth.OAuthCredential>());
          });
        });
      });
      group('GoogleSignIn Flux is interrupted', () {
        test(
          'throws UserCancelledFluxException when flux is signIn method '
          'returns null',
          () {
            when(() => googleSignIn.signIn()).thenAnswer(
              (_) => Future.value(),
            );

            expectLater(
              googleAuthenticationProvider.getGoogleCredential(),
              throwsA(
                isA<UserCancelledFluxException>(),
              ),
            );
          },
        );
      });
    });
  });
}
