import 'package:authentication_repository/src/exceptions/exceptions.dart';
import 'package:authentication_repository/src/oauth_providers/oauth_providers.dart';
import 'package:authentication_repository/src/oauth_providers/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/services.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:test/test.dart';

class _MockAppleSignIn extends Mock implements AppleSignIn {}

class _MockCryptography extends Mock implements Cryptography {}

class _MockAuthorizationCredentialAppleID extends Mock
    implements AuthorizationCredentialAppleID {}

void main() {
  late AppleAuthenticationProvider appleAuthenticationProvider;
  late AppleSignIn appleSignIn;
  late Cryptography cryptography;
  late AuthorizationCredentialAppleID authorizationCredentialAppleID;

  group('Apple Authentication provider', () {
    setUp(() {
      authorizationCredentialAppleID = _MockAuthorizationCredentialAppleID();
      appleSignIn = _MockAppleSignIn();
      cryptography = _MockCryptography();

      appleAuthenticationProvider = AppleAuthenticationProvider(
        appleSignIn: appleSignIn,
        cryptography: cryptography,
      );
    });

    void mockGenerateNonce(String nonce) {
      when(() => cryptography.generateNonce()).thenReturn(nonce);
    }

    void mockSha256ofString(String rawNonce, String nonce256) {
      when(() => cryptography.sha256ofString(rawNonce)).thenReturn(nonce256);
    }

    group('GetAppleCredential', () {
      const rawNonce = 'nonce';
      const nonce256 = 'nonce256';
      const identityToken = 'identityToken';
      const error = 'error';

      void mockGetAppleIDCredential({
        required List<AppleIDAuthorizationScopes> scopes,
        required String nonce,
      }) {
        when(
          () => appleSignIn.getAppleIDCredential(
            scopes: scopes,
            nonce: nonce,
          ),
        ).thenAnswer((_) async => authorizationCredentialAppleID);
      }

      void mockIdentityToken() {
        when(() => authorizationCredentialAppleID.identityToken)
            .thenReturn(identityToken);
      }

      group('when successful', () {
        setUp(() {
          mockGenerateNonce(rawNonce);
          mockSha256ofString(rawNonce, nonce256);
          mockGetAppleIDCredential(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );
          mockIdentityToken();
        });

        test('should call generateNonce', () async {
          await appleAuthenticationProvider.getAppleCredential();

          verify(() => cryptography.generateNonce()).called(1);
        });

        test('should call sha256ofString', () async {
          await appleAuthenticationProvider.getAppleCredential();

          verify(() => cryptography.sha256ofString(rawNonce)).called(1);
        });

        test('should call getAppleIDCredential', () async {
          await appleAuthenticationProvider.getAppleCredential();

          verify(
            () => appleSignIn.getAppleIDCredential(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
              nonce: nonce256,
            ),
          ).called(1);
        });

        test('should return AuthCredential', () async {
          final result = await appleAuthenticationProvider.getAppleCredential();

          expect(
            result,
            isA<firebase_auth.OAuthCredential>()
                .having(
                  (credential) => credential.idToken,
                  'idToken',
                  identityToken,
                )
                .having(
                  (credential) => credential.rawNonce,
                  'rawNonce',
                  rawNonce,
                ),
          );
        });
      });

      group('throws', () {
        setUp(() {
          mockGenerateNonce(rawNonce);
          mockSha256ofString(rawNonce, nonce256);
        });

        void mockGetAppleIDCredentialThrowException({
          required Exception exception,
          required List<AppleIDAuthorizationScopes> scopes,
          required String nonce,
        }) {
          when(
            () => appleSignIn.getAppleIDCredential(
              scopes: scopes,
              nonce: nonce,
            ),
          ).thenThrow(exception);
        }

        test(
            'AppleNotSupportedException '
            'when getAppleIDCredential throws '
            'SignInWithAppleNotSupportedException', () async {
          mockGetAppleIDCredentialThrowException(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            exception:
                const SignInWithAppleNotSupportedException(message: error),
          );

          await expectLater(
            appleAuthenticationProvider.getAppleCredential(),
            throwsA(
              isA<AppleNotSupportedException>()
                  .having((err) => err.message, 'message', error),
            ),
          );
        });

        test(
            'UserCancelledFluxException '
            'when getAppleIDCredential throws '
            'SignInWithAppleAuthorizationException with canceled code',
            () async {
          mockGetAppleIDCredentialThrowException(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            exception: const SignInWithAppleAuthorizationException(
              code: AuthorizationErrorCode.canceled,
              message: error,
            ),
          );

          await expectLater(
            appleAuthenticationProvider.getAppleCredential(),
            throwsA(
              isA<UserCancelledFluxException>()
                  .having((err) => err.message, 'message', error),
            ),
          );
        });

        test(
            'AppleSignInException '
            'when getAppleIDCredential throws '
            'SignInWithAppleAuthorizationException with failed code', () async {
          mockGetAppleIDCredentialThrowException(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            exception: const SignInWithAppleAuthorizationException(
              code: AuthorizationErrorCode.failed,
              message: error,
            ),
          );

          await expectLater(
            appleAuthenticationProvider.getAppleCredential(),
            throwsA(
              isA<AppleSignInException>()
                  .having((err) => err.message, 'message', error),
            ),
          );
        });

        test(
            'AppleSignInException '
            'when getAppleIDCredential throws '
            'SignInWithAppleAuthorizationException with invalidResponse code',
            () async {
          mockGetAppleIDCredentialThrowException(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            exception: const SignInWithAppleAuthorizationException(
              code: AuthorizationErrorCode.invalidResponse,
              message: error,
            ),
          );

          await expectLater(
            appleAuthenticationProvider.getAppleCredential(),
            throwsA(
              isA<AppleSignInException>()
                  .having((err) => err.message, 'message', error),
            ),
          );
        });

        test(
            'AppleSignInException '
            'when getAppleIDCredential throws '
            'SignInWithAppleAuthorizationException with notHandled code',
            () async {
          mockGetAppleIDCredentialThrowException(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            exception: const SignInWithAppleAuthorizationException(
              code: AuthorizationErrorCode.notHandled,
              message: error,
            ),
          );

          await expectLater(
            appleAuthenticationProvider.getAppleCredential(),
            throwsA(
              isA<AppleSignInException>()
                  .having((err) => err.message, 'message', error),
            ),
          );
        });

        test(
            'AppleSignInException '
            'when getAppleIDCredential throws '
            'SignInWithAppleAuthorizationException with notInteractive code',
            () async {
          mockGetAppleIDCredentialThrowException(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            exception: const SignInWithAppleAuthorizationException(
              code: AuthorizationErrorCode.notInteractive,
              message: error,
            ),
          );

          await expectLater(
            appleAuthenticationProvider.getAppleCredential(),
            throwsA(
              isA<AppleSignInException>()
                  .having((err) => err.message, 'message', error),
            ),
          );
        });

        test(
            'AppleSignInException '
            'when getAppleIDCredential throws '
            'SignInWithAppleAuthorizationException with unknown code',
            () async {
          mockGetAppleIDCredentialThrowException(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            exception: const SignInWithAppleAuthorizationException(
              code: AuthorizationErrorCode.unknown,
              message: error,
            ),
          );

          await expectLater(
            appleAuthenticationProvider.getAppleCredential(),
            throwsA(
              isA<AppleSignInException>()
                  .having((err) => err.message, 'message', error),
            ),
          );
        });

        test(
            'AppleSignInException '
            'when getAppleIDCredential throws SignInWithAppleException',
            () async {
          mockGetAppleIDCredentialThrowException(
            nonce: nonce256,
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            exception: SignInWithAppleException.fromPlatformException(
              PlatformException(code: ''),
            ),
          );

          await expectLater(
            appleAuthenticationProvider.getAppleCredential(),
            throwsA(isA<AppleSignInException>()),
          );
        });
      });
    });
  });
}
