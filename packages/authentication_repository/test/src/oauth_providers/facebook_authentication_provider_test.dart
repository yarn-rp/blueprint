import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:authentication_repository/src/oauth_providers/oauth_providers.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class _MockFacebookAuth extends Mock implements FacebookAuth {}

class _MockLoginResult extends Mock implements LoginResult {}

class _MockAccessToken extends Mock implements AccessToken {}

void main() {
  late FacebookAuthenticationProvider facebookAuthenticationProvider;
  late FacebookAuth facebookAuth;

  group('Facebook Authentication provider', () {
    setUp(() {
      facebookAuth = _MockFacebookAuth();
      facebookAuthenticationProvider = FacebookAuthenticationProvider(
        facebookAuth: facebookAuth,
      );
    });

    group('GetFacebookCredential', () {
      late LoginResult loginResult;

      group('facebookAuth.login called', () {
        setUp(() {
          loginResult = _MockLoginResult();
          when(() => facebookAuth.login()).thenAnswer(
            (_) => Future.value(loginResult),
          );
        });

        test(
            'should throw UserCancelledFluxException '
            "when loginResult.status is 'cancelled'", () async {
          // Arrange -> setup test dependencies
          when(() => loginResult.status)
              .thenAnswer((_) => LoginStatus.cancelled);

          // Expect -> Compute functionality you wanna test and assert it
          await expectLater(
            facebookAuthenticationProvider.getFacebookCredential(),
            throwsA(isA<UserCancelledFluxException>()),
          );
          verify(() => facebookAuth.login()).called(1);
        });

        test(
            'should throw FacebookLoginRequestFailedException '
            "when loginResult.status is 'failed'", () async {
          // Arrange -> setup test dependencies
          when(() => loginResult.status).thenAnswer((_) => LoginStatus.failed);

          // Expect -> Compute functionality you wanna test and assert it
          await expectLater(
            facebookAuthenticationProvider.getFacebookCredential(),
            throwsA(isA<FacebookLoginRequestFailedException>()),
          );
          verify(() => facebookAuth.login()).called(1);
        });

        test(
            'should throw FacebookLoginRequestFailedException '
            "when loginResult.status is 'operationInProgress'", () async {
          // Arrange -> setup test dependencies
          when(() => loginResult.status)
              .thenAnswer((_) => LoginStatus.operationInProgress);

          // Expect -> Compute functionality you wanna test and assert it
          await expectLater(
            facebookAuthenticationProvider.getFacebookCredential(),
            throwsA(isA<FacebookLoginRequestFailedException>()),
          );
          verify(() => facebookAuth.login()).called(1);
        });

        group("when loginResult.status is 'success'", () {
          setUp(() {
            when(() => loginResult.status)
                .thenAnswer((_) => LoginStatus.success);
          });

          test(
              'should throw FacebookLoginRequestFailedException '
              'when access token is null', () async {
            // Arrange -> setup test dependencies
            when(() => loginResult.accessToken).thenAnswer((_) => null);

            // Expect -> Compute functionality you wanna test and assert it
            await expectLater(
              facebookAuthenticationProvider.getFacebookCredential(),
              throwsA(isA<FacebookLoginRequestFailedException>()),
            );
            verify(() => facebookAuth.login()).called(1);
          });

          test(
              'should return AuthCredential '
              'when access token is not null', () async {
            // Arrange -> setup test dependencies
            const token = 'token';
            final AccessToken accessToken = _MockAccessToken();
            when(() => accessToken.token).thenAnswer((_) => token);
            when(() => loginResult.accessToken).thenAnswer((_) => accessToken);

            // Act -> Compute functionality you wanna test
            final result =
                await facebookAuthenticationProvider.getFacebookCredential();

            // Expect -> Compute functionality you wanna test and assert it
            expect(
              result,
              isA<firebase_auth.OAuthCredential>().having(
                (credential) => credential.accessToken,
                'accessToken',
                token,
              ),
            );
            verify(() => facebookAuth.login()).called(1);
          });
        });
      });
    });
  });
}
