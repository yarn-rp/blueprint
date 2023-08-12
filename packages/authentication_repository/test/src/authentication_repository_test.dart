import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class _MockUserCredential extends Mock
    implements firebase_auth.UserCredential {}

class _MockUser extends Mock implements firebase_auth.User {}

class _FakeOAuthCredential extends Fake
    implements firebase_auth.OAuthCredential {}

class MockGoogleAuthenticationProvider extends Mock
    implements GoogleAuthenticationProvider {}

class MockFacebookAuthenticationProvider extends Mock
    implements FacebookAuthenticationProvider {}

class MockAppleAuthenticationProvider extends Mock
    implements AppleAuthenticationProvider {}

void main() {
  group('AuthenticationRepository', () {
    setUp(() {
      registerFallbackValue(_FakeOAuthCredential());
    });

    test('can be instantiated', () {
      expect(
        AuthenticationRepository(
          firebaseAuth: _MockFirebaseAuth(),
          googleAuthenticationProvider: MockGoogleAuthenticationProvider(),
          facebookAuthenticationProvider: MockFacebookAuthenticationProvider(),
          appleAuthenticationProvider: MockAppleAuthenticationProvider(),
        ),
        isNotNull,
      );
    });

    group('currentUser', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late firebase_auth.FirebaseAuth firebaseAuth;
      setUp(() {
        firebaseAuth = _MockFirebaseAuth();
        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: MockGoogleAuthenticationProvider(),
          facebookAuthenticationProvider: MockFacebookAuthenticationProvider(),
          appleAuthenticationProvider: MockAppleAuthenticationProvider(),
        );
      });

      void mockCurrentUser(firebase_auth.User? user) {
        when(() => firebaseAuth.currentUser).thenReturn(user);
      }

      test('returns a UserModel', () {
        const userId = 'userId';
        const email = 'email';
        const name = 'name';
        final mockedUser = _MockUser();
        when(() => mockedUser.uid).thenReturn(userId);
        when(() => mockedUser.displayName).thenReturn(name);
        when(() => mockedUser.email).thenReturn(email);

        mockCurrentUser(mockedUser);

        const expectedUser = UserModel(id: userId, email: email, name: name);

        expect(authenticationRepositoryLogic.currentUser, expectedUser);
      });

      test('returns null', () {
        mockCurrentUser(null);

        expect(authenticationRepositoryLogic.currentUser, isNull);
      });
    });

    group('SignInWithEmailAndPassword', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late String email;
      late String password;
      late firebase_auth.FirebaseAuth firebaseAuth;

      setUp(() {
        email = 'email@email.com';
        password = 'password';

        firebaseAuth = _MockFirebaseAuth();
        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: MockGoogleAuthenticationProvider(),
          facebookAuthenticationProvider: MockFacebookAuthenticationProvider(),
          appleAuthenticationProvider: MockAppleAuthenticationProvider(),
        );
      });

      void mockFirebaseAuthSignInWithEmailAndPassword() {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) => Future.value(_MockUserCredential()));
      }

      void mockFirebaseAuthSignInWithEmailAndPasswordThrowsException(
        Exception exception,
      ) {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenThrow(exception);
      }

      test('completes', () async {
        mockFirebaseAuthSignInWithEmailAndPassword();

        await expectLater(
          authenticationRepositoryLogic.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          completes,
        );
      });

      test('returns normally', () async {
        mockFirebaseAuthSignInWithEmailAndPassword();

        await expectLater(
          () => authenticationRepositoryLogic.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          returnsNormally,
        );
      });

      test('verify calls signInWithEmailAndPassword', () async {
        mockFirebaseAuthSignInWithEmailAndPassword();

        await authenticationRepositoryLogic.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      group('throws a', () {
        test(
            'UserNotFoundException '
            "when firebase auth throws 'user-not-found' error code", () async {
          mockFirebaseAuthSignInWithEmailAndPasswordThrowsException(
            firebase_auth.FirebaseAuthException(code: ErrorCodes.userNotFound),
          );

          await expectLater(
            authenticationRepositoryLogic.signInWithEmailAndPassword(
              email: email,
              password: password,
            ),
            throwsA(isA<UserNotFoundException>()),
          );
        });

        test(
            'WrongPasswordException '
            "when firebase auth throws 'wrong-password' error code", () async {
          mockFirebaseAuthSignInWithEmailAndPasswordThrowsException(
            firebase_auth.FirebaseAuthException(code: ErrorCodes.wrongPassword),
          );

          await expectLater(
            authenticationRepositoryLogic.signInWithEmailAndPassword(
              email: email,
              password: password,
            ),
            throwsA(isA<WrongPasswordException>()),
          );
        });

        group('SignInException', () {
          test('when firebase auth throws a non matching error code', () async {
            mockFirebaseAuthSignInWithEmailAndPasswordThrowsException(
              firebase_auth.FirebaseAuthException(code: 'any'),
            );

            await expectLater(
              authenticationRepositoryLogic.signInWithEmailAndPassword(
                email: email,
                password: password,
              ),
              throwsA(isA<SignInException>()),
            );
          });

          test('when firebase auth throws a non matching exception', () async {
            mockFirebaseAuthSignInWithEmailAndPasswordThrowsException(
              Exception(),
            );

            await expectLater(
              authenticationRepositoryLogic.signInWithEmailAndPassword(
                email: email,
                password: password,
              ),
              throwsA(isA<SignInException>()),
            );
          });
        });
      });
    });

    group('SignUpWithEmailAndPassword', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late firebase_auth.FirebaseAuth firebaseAuth;
      late _MockUserCredential userCredential;
      late firebase_auth.User user;
      late String id;
      late String email;
      late String password;

      setUp(() {
        email = 'email@email.com';
        password = 'password';
        id = '1234567';
        userCredential = _MockUserCredential();
        user = _MockUser();
        firebaseAuth = _MockFirebaseAuth();
        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: MockGoogleAuthenticationProvider(),
          facebookAuthenticationProvider: MockFacebookAuthenticationProvider(),
          appleAuthenticationProvider: MockAppleAuthenticationProvider(),
        );
      });

      void mockUserId(String id) {
        when(() => user.uid).thenReturn(id);
      }

      void mockUserCredentialUser(firebase_auth.User? user) {
        when(() => userCredential.user).thenReturn(user);
      }

      void mockFirebaseAuthCreateUserWithEmailAndPassword() {
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) => Future.value(userCredential));
      }

      void mockFirebaseAuthCreateUserWithEmailAndPasswordThrowsException(
        Exception exception,
      ) {
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenThrow(exception);
      }

      test('completes', () async {
        mockFirebaseAuthCreateUserWithEmailAndPassword();
        mockUserCredentialUser(user);
        mockUserId(id);

        await expectLater(
          authenticationRepositoryLogic.signUpWithEmailAndPassword(
            email: email,
            password: password,
          ),
          completes,
        );
      });

      test('returns normally', () async {
        mockFirebaseAuthCreateUserWithEmailAndPassword();
        mockUserCredentialUser(user);
        mockUserId(id);

        await expectLater(
          () => authenticationRepositoryLogic.signUpWithEmailAndPassword(
            email: email,
            password: password,
          ),
          returnsNormally,
        );
      });

      test('verify calls signInWithEmailAndPassword', () async {
        mockFirebaseAuthCreateUserWithEmailAndPassword();
        mockUserCredentialUser(user);
        mockUserId(id);

        await authenticationRepositoryLogic.signUpWithEmailAndPassword(
          email: email,
          password: password,
        );

        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('returns the correct id', () async {
        mockFirebaseAuthCreateUserWithEmailAndPassword();
        mockUserCredentialUser(user);
        mockUserId(id);

        final userModel =
            await authenticationRepositoryLogic.signUpWithEmailAndPassword(
          email: email,
          password: password,
        );

        expect(userModel.id, id);
      });

      group('throws a', () {
        test(
            'signUpException '
            'when returns null user', () async {
          mockFirebaseAuthCreateUserWithEmailAndPassword();
          mockUserCredentialUser(null);

          await expectLater(
            authenticationRepositoryLogic.signUpWithEmailAndPassword(
              email: email,
              password: password,
            ),
            throwsA(isA<SignUpException>()),
          );
        });

        test(
            'WeakPasswordException '
            "when firebase auth throws 'weak-password' error code", () async {
          mockFirebaseAuthCreateUserWithEmailAndPasswordThrowsException(
            firebase_auth.FirebaseAuthException(code: ErrorCodes.weakPassword),
          );

          await expectLater(
            authenticationRepositoryLogic.signUpWithEmailAndPassword(
              email: email,
              password: password,
            ),
            throwsA(isA<WeakPasswordException>()),
          );
        });

        test(
            'EmailAlreadyInUseException '
            "when firebase auth throws 'email-already-in-use' error code",
            () async {
          mockFirebaseAuthCreateUserWithEmailAndPasswordThrowsException(
            firebase_auth.FirebaseAuthException(
              code: ErrorCodes.emailAlreadyUsed,
            ),
          );

          await expectLater(
            authenticationRepositoryLogic.signUpWithEmailAndPassword(
              email: email,
              password: password,
            ),
            throwsA(isA<EmailAlreadyInUseException>()),
          );
        });

        group('SignUpException', () {
          test('when firebase auth throws a non matching error code', () async {
            mockFirebaseAuthCreateUserWithEmailAndPasswordThrowsException(
              firebase_auth.FirebaseAuthException(code: 'any'),
            );

            await expectLater(
              authenticationRepositoryLogic.signUpWithEmailAndPassword(
                email: email,
                password: password,
              ),
              throwsA(isA<SignUpException>()),
            );
          });

          test('when firebase auth throws a non matching exception', () async {
            mockFirebaseAuthCreateUserWithEmailAndPasswordThrowsException(
              Exception(),
            );

            await expectLater(
              authenticationRepositoryLogic.signUpWithEmailAndPassword(
                email: email,
                password: password,
              ),
              throwsA(isA<SignUpException>()),
            );
          });
        });
      });
    });

    group('SignOut', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late firebase_auth.FirebaseAuth firebaseAuth;
      late GoogleAuthenticationProvider googleAuthenticationProvider;
      late FacebookAuthenticationProvider facebookAuthenticationProvider;
      late AppleAuthenticationProvider appleAuthenticationProvider;
      setUp(() {
        registerFallbackValue(Exception());
        firebaseAuth = _MockFirebaseAuth();
        googleAuthenticationProvider = MockGoogleAuthenticationProvider();
        facebookAuthenticationProvider = MockFacebookAuthenticationProvider();
        appleAuthenticationProvider = MockAppleAuthenticationProvider();

        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: googleAuthenticationProvider,
          facebookAuthenticationProvider: facebookAuthenticationProvider,
          appleAuthenticationProvider: appleAuthenticationProvider,
        );
      });

      void mockFirebaseSignOutSuccessCall() {
        when(
          () => firebaseAuth.signOut(),
        ).thenAnswer((_) => Future.value());
        when(() => googleAuthenticationProvider.signOut()).thenAnswer(
          (_) => Future.value(),
        );
        when(() => facebookAuthenticationProvider.signOut()).thenAnswer(
          (_) => Future.value(),
        );
      }

      void mockFirebaseSignOutThrowsException(
        Exception exception,
      ) {
        when(
          () => firebaseAuth.signOut(),
        ).thenThrow(exception);
      }

      test('completes', () async {
        mockFirebaseSignOutSuccessCall();

        await expectLater(
          authenticationRepositoryLogic.signOut(),
          completes,
        );
      });

      test('returns normally', () async {
        mockFirebaseSignOutSuccessCall();

        await expectLater(
          () => authenticationRepositoryLogic.signOut(),
          returnsNormally,
        );
      });

      test('verify calls sigOut', () async {
        mockFirebaseSignOutSuccessCall();

        await authenticationRepositoryLogic.signOut();

        verify(
          () => firebaseAuth.signOut(),
        ).called(1);
      });

      group('throws a', () {
        test(
            'SignOutException '
            'when firebase auth throws any FirebaseAuthException', () async {
          mockFirebaseSignOutThrowsException(
            firebase_auth.FirebaseAuthException(
              code: 'any',
            ),
          );

          await expectLater(
            authenticationRepositoryLogic.signOut(),
            throwsA(isA<SignOutException>()),
          );
        });
        test(
            'SignOutException '
            'when methods throws any Exception', () async {
          mockFirebaseSignOutThrowsException(Exception());

          await expectLater(
            authenticationRepositoryLogic.signOut(),
            throwsA(isA<SignOutException>()),
          );
        });
      });
    });

    group('SignInWithCredentials', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late firebase_auth.AuthCredential signInCredentials;
      late firebase_auth.FirebaseAuth firebaseAuth;
      late _MockUserCredential userCredential;
      late firebase_auth.User user;
      const id = 'userId';

      setUp(() {
        user = _MockUser();

        userCredential = _MockUserCredential();
        firebaseAuth = _MockFirebaseAuth();

        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: MockGoogleAuthenticationProvider(),
          facebookAuthenticationProvider: MockFacebookAuthenticationProvider(),
          appleAuthenticationProvider: MockAppleAuthenticationProvider(),
        );
      });

      void mockUserAttributes() {
        const email = 'email';
        const name = 'name';
        when(() => user.uid).thenReturn(id);
        when(() => user.displayName).thenReturn(name);
        when(() => user.email).thenReturn(email);
      }

      void mockUserCredentialUser(firebase_auth.User? user) {
        when(() => userCredential.user).thenReturn(user);
      }

      void mockFirebaseAuthSignInWithCredential() {
        when(
          () => firebaseAuth.signInWithCredential(
            any<firebase_auth.AuthCredential>(),
          ),
        ).thenAnswer((_) => Future.value(userCredential));
      }

      void mockFirebaseAuthSignInWithCredentialsThrowsException(
        Exception exception,
      ) {
        when(
          () => firebaseAuth.signInWithCredential(
            any<firebase_auth.AuthCredential>(),
          ),
        ).thenThrow(exception);
      }

      firebase_auth.AuthCredential getTestCredentialFunction() =>
          signInCredentials;
      group('With OAuth credentials', () {
        setUp(() {
          signInCredentials = _FakeOAuthCredential();
        });

        test('completes', () async {
          mockFirebaseAuthSignInWithCredential();
          mockUserCredentialUser(user);
          mockUserAttributes();

          await expectLater(
            authenticationRepositoryLogic.signInWithCredentials(
              credential: getTestCredentialFunction(),
            ),
            completes,
          );
        });

        test('returns normally', () async {
          mockFirebaseAuthSignInWithCredential();
          mockUserCredentialUser(user);
          mockUserAttributes();

          await expectLater(
            () => authenticationRepositoryLogic.signInWithCredentials(
              credential: getTestCredentialFunction(),
            ),
            returnsNormally,
          );
        });

        test('returns correct id', () async {
          mockFirebaseAuthSignInWithCredential();
          mockUserCredentialUser(user);
          mockUserAttributes();

          final firebaseUser =
              await authenticationRepositoryLogic.signInWithCredentials(
            credential: getTestCredentialFunction(),
          );

          expect(firebaseUser.uid, id);
        });

        test('verify calls signInWithEmailAndPassword', () async {
          mockFirebaseAuthSignInWithCredential();
          mockUserCredentialUser(user);
          mockUserAttributes();

          await authenticationRepositoryLogic.signInWithCredentials(
            credential: getTestCredentialFunction(),
          );

          verify(
            () => firebaseAuth.signInWithCredential(signInCredentials),
          ).called(1);
        });

        group('throws a', () {
          test(
              'signInException '
              'when returns null user', () async {
            mockFirebaseAuthSignInWithCredential();
            mockUserCredentialUser(null);

            await expectLater(
              authenticationRepositoryLogic.signInWithCredentials(
                credential: getTestCredentialFunction(),
              ),
              throwsA(isA<SignInException>()),
            );
          });

          test(
              'UserNotFoundException '
              "when firebase auth throws 'user-not-found' error code",
              () async {
            mockFirebaseAuthSignInWithCredentialsThrowsException(
              firebase_auth.FirebaseAuthException(
                code: ErrorCodes.userNotFound,
              ),
            );

            await expectLater(
              authenticationRepositoryLogic.signInWithCredentials(
                credential: getTestCredentialFunction(),
              ),
              throwsA(isA<UserNotFoundException>()),
            );
          });

          test(
              'WrongPasswordException '
              "when firebase auth throws 'wrong-password' error code",
              () async {
            mockFirebaseAuthSignInWithCredentialsThrowsException(
              firebase_auth.FirebaseAuthException(
                code: ErrorCodes.wrongPassword,
              ),
            );

            await expectLater(
              authenticationRepositoryLogic.signInWithCredentials(
                credential: getTestCredentialFunction(),
              ),
              throwsA(isA<WrongPasswordException>()),
            );
          });

          group('SignInException', () {
            test('when firebase auth throws a non matching error code',
                () async {
              mockFirebaseAuthSignInWithCredentialsThrowsException(
                firebase_auth.FirebaseAuthException(code: 'any'),
              );

              await expectLater(
                authenticationRepositoryLogic.signInWithCredentials(
                  credential: getTestCredentialFunction(),
                ),
                throwsA(isA<SignInException>()),
              );
            });

            test('when firebase auth throws a non matching exception',
                () async {
              mockFirebaseAuthSignInWithCredentialsThrowsException(
                Exception(),
              );

              await expectLater(
                authenticationRepositoryLogic.signInWithCredentials(
                  credential: getTestCredentialFunction(),
                ),
                throwsA(isA<SignInException>()),
              );
            });
          });
        });
      });
    });

    group('SignInWithGoogle', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late firebase_auth.FirebaseAuth firebaseAuth;
      late GoogleAuthenticationProvider googleAuthenticationProvider;
      late firebase_auth.AuthCredential googleCredential;
      late _MockUserCredential userCredential;
      late firebase_auth.User user;
      late String id;

      setUp(() {
        id = '1234567';
        userCredential = _MockUserCredential();
        user = _MockUser();
        firebaseAuth = _MockFirebaseAuth();
        googleCredential = _FakeOAuthCredential();
        googleAuthenticationProvider = MockGoogleAuthenticationProvider();

        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: googleAuthenticationProvider,
          facebookAuthenticationProvider: MockFacebookAuthenticationProvider(),
          appleAuthenticationProvider: MockAppleAuthenticationProvider(),
        );
        when(() => user.uid).thenReturn(id);
        when(() => userCredential.user).thenReturn(user);
      });

      group('GoogleAuthenticationProvider returns a credential', () {
        void mockFirebaseAuthSignInWithCredential() {
          when(
            () => firebaseAuth.signInWithCredential(
              any<firebase_auth.AuthCredential>(),
            ),
          ).thenAnswer((_) => Future.value(userCredential));
        }

        void mockFirebaseAuthSignInWithCredentialsThrowsException(
          Exception exception,
        ) {
          when(
            () => firebaseAuth.signInWithCredential(
              any<firebase_auth.AuthCredential>(),
            ),
          ).thenThrow(exception);
        }

        setUp(() {
          when(() => googleAuthenticationProvider.getGoogleCredential())
              .thenAnswer(
            (invocation) => Future.value(googleCredential),
          );
        });

        test(
            'Should return normally when Firebase '
            "signInWithCredential don't throw exception ", () async {
          // Arrange -> setup test dependencies
          mockFirebaseAuthSignInWithCredential();

          when(() => googleAuthenticationProvider.getGoogleCredential())
              .thenAnswer((_) => Future.value(googleCredential));

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithGoogle,
            returnsNormally,
          );
        });

        test(
            'Should throw exception when Firebase '
            'signInWithCredential throw exception ', () async {
          // Arrange -> setup test dependencies
          mockFirebaseAuthSignInWithCredentialsThrowsException(Exception());

          when(() => googleAuthenticationProvider.getGoogleCredential())
              .thenAnswer(
            (invocation) => Future.value(googleCredential),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithGoogle,
            throwsException,
          );
        });
      });

      group('GoogleAuthenticationProvider throws exception', () {
        void mockGoogleAuthenticationGetCredentialThrowsException(
          Exception exception,
        ) {
          when(
            () => googleAuthenticationProvider.getGoogleCredential(),
          ).thenThrow(exception);
        }

        test(
            'Should throw UserCancelledFluxException when getGoogleCredential '
            'throws UserCancelledFluxException', () async {
          // Arrange -> setup test dependencies
          mockGoogleAuthenticationGetCredentialThrowsException(
            UserCancelledFluxException(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithGoogle,
            throwsA(isA<UserCancelledFluxException>()),
          );
        });

        test(
            'Should throw SignInException when getGoogleCredential '
            'throws any other exception', () async {
          // Arrange -> setup test dependencies
          mockGoogleAuthenticationGetCredentialThrowsException(
            Exception(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithGoogle,
            throwsA(isA<SignInException>()),
          );
        });
      });
    });

    group('SignInWithFacebook', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late firebase_auth.FirebaseAuth firebaseAuth;
      late FacebookAuthenticationProvider facebookAuthenticationProvider;
      late firebase_auth.AuthCredential facebookCredential;
      late _MockUserCredential userCredential;
      late firebase_auth.User user;
      late String id;

      setUp(() {
        id = '1234567';
        userCredential = _MockUserCredential();
        user = _MockUser();
        firebaseAuth = _MockFirebaseAuth();
        facebookCredential = _FakeOAuthCredential();
        facebookAuthenticationProvider = MockFacebookAuthenticationProvider();

        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: MockGoogleAuthenticationProvider(),
          facebookAuthenticationProvider: facebookAuthenticationProvider,
          appleAuthenticationProvider: MockAppleAuthenticationProvider(),
        );

        when(() => user.uid).thenReturn(id);
        when(() => userCredential.user).thenReturn(user);
      });

      group('FacebookAuthenticationProvider returns a credential', () {
        void mockFirebaseAuthSignInWithCredential() {
          when(
            () => firebaseAuth.signInWithCredential(
              any<firebase_auth.AuthCredential>(),
            ),
          ).thenAnswer((_) => Future.value(userCredential));
        }

        void mockFirebaseAuthSignInWithCredentialsThrowsException(
          Exception exception,
        ) {
          when(
            () => firebaseAuth.signInWithCredential(
              any<firebase_auth.AuthCredential>(),
            ),
          ).thenThrow(exception);
        }

        setUp(() {
          when(() => facebookAuthenticationProvider.getFacebookCredential())
              .thenAnswer((_) => Future.value(facebookCredential));
        });

        test(
            'Should return normally when Firebase '
            "signInWithCredential don't throw exception ", () async {
          // Arrange -> setup test dependencies
          mockFirebaseAuthSignInWithCredential();

          when(() => facebookAuthenticationProvider.getFacebookCredential())
              .thenAnswer((_) => Future.value(facebookCredential));

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithFacebook,
            returnsNormally,
          );
        });

        test(
            'Should throw exception when Firebase '
            'signInWithCredential throw exception ', () async {
          // Arrange -> setup test dependencies
          mockFirebaseAuthSignInWithCredentialsThrowsException(Exception());

          when(() => facebookAuthenticationProvider.getFacebookCredential())
              .thenAnswer(
            (invocation) => Future.value(facebookCredential),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithFacebook,
            throwsException,
          );
        });
      });

      group('FacebookAuthenticationProvider throws exception', () {
        void mockFacebookAuthenticationGetCredentialThrowsException(
          Exception exception,
        ) {
          when(
            () => facebookAuthenticationProvider.getFacebookCredential(),
          ).thenThrow(exception);
        }

        test(
            'Should throw UserCancelledFluxException '
            'when getFacebookCredential throws UserCancelledFluxException',
            () async {
          // Arrange -> setup test dependencies
          mockFacebookAuthenticationGetCredentialThrowsException(
            UserCancelledFluxException(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithFacebook,
            throwsA(isA<UserCancelledFluxException>()),
          );
        });

        test(
            'Should throw FacebookLoginRequestFailedException '
            'when getFacebookCredential throws '
            'FacebookLoginRequestFailedException', () async {
          // Arrange -> setup test dependencies
          mockFacebookAuthenticationGetCredentialThrowsException(
            FacebookLoginRequestFailedException(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithFacebook,
            throwsA(isA<FacebookLoginRequestFailedException>()),
          );
        });

        test(
            'Should throw SignInException  '
            'when getFacebookCredential throws any other exception', () async {
          // Arrange -> setup test dependencies
          mockFacebookAuthenticationGetCredentialThrowsException(
            Exception(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithFacebook,
            throwsA(isA<SignInException>()),
          );
        });
      });
    });

    group('SignInWithApple', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late firebase_auth.FirebaseAuth firebaseAuth;
      late AppleAuthenticationProvider appleAuthenticationProvider;
      late firebase_auth.AuthCredential appleCredential;
      late _MockUserCredential userCredential;
      late firebase_auth.User user;
      late String id;

      setUp(() {
        id = '1234567';
        userCredential = _MockUserCredential();
        user = _MockUser();
        firebaseAuth = _MockFirebaseAuth();
        appleCredential = _FakeOAuthCredential();
        appleAuthenticationProvider = MockAppleAuthenticationProvider();

        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: MockGoogleAuthenticationProvider(),
          facebookAuthenticationProvider: MockFacebookAuthenticationProvider(),
          appleAuthenticationProvider: appleAuthenticationProvider,
        );

        when(() => user.uid).thenReturn(id);
        when(() => userCredential.user).thenReturn(user);
      });

      group('AppleAuthenticationProvider returns a credential', () {
        void mockFirebaseAuthSignInWithCredential() {
          when(
            () => firebaseAuth.signInWithCredential(
              any<firebase_auth.AuthCredential>(),
            ),
          ).thenAnswer((_) => Future.value(userCredential));
        }

        void mockFirebaseAuthSignInWithCredentialsThrowsException(
          Exception exception,
        ) {
          when(
            () => firebaseAuth.signInWithCredential(
              any<firebase_auth.AuthCredential>(),
            ),
          ).thenThrow(exception);
        }

        setUp(() {
          when(() => appleAuthenticationProvider.getAppleCredential())
              .thenAnswer((_) => Future.value(appleCredential));
        });

        test(
            'Should return normally when Firebase '
            "signInWithCredential don't throw exception ", () async {
          // Arrange -> setup test dependencies
          mockFirebaseAuthSignInWithCredential();

          when(() => appleAuthenticationProvider.getAppleCredential())
              .thenAnswer((_) => Future.value(appleCredential));

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithApple,
            returnsNormally,
          );
        });

        test(
            'Should throw exception when Firebase '
            'signInWithCredential throw exception ', () async {
          // Arrange -> setup test dependencies
          mockFirebaseAuthSignInWithCredentialsThrowsException(Exception());

          when(() => appleAuthenticationProvider.getAppleCredential())
              .thenAnswer(
            (invocation) => Future.value(appleCredential),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithApple,
            throwsException,
          );
        });
      });

      group('AppleAuthenticationProvider throws exception', () {
        void mockAppleAuthenticationGetCredentialThrowsException(
          Exception exception,
        ) {
          when(
            () => appleAuthenticationProvider.getAppleCredential(),
          ).thenThrow(exception);
        }

        test(
            'Should throw UserCancelledFluxException '
            'when getAppleCredential throws UserCancelledFluxException',
            () async {
          // Arrange -> setup test dependencies
          mockAppleAuthenticationGetCredentialThrowsException(
            UserCancelledFluxException(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithApple,
            throwsA(isA<UserCancelledFluxException>()),
          );
        });

        test(
            'Should throw AppleSignInException '
            'when getAppleCredential throws '
            'AppleSignInException', () async {
          // Arrange -> setup test dependencies
          mockAppleAuthenticationGetCredentialThrowsException(
            AppleSignInException(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithApple,
            throwsA(isA<AppleSignInException>()),
          );
        });

        test(
            'Should throw AppleNotSupportedException '
            'when getAppleCredential throws '
            'AppleNotSupportedException', () async {
          // Arrange -> setup test dependencies
          mockAppleAuthenticationGetCredentialThrowsException(
            AppleNotSupportedException(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithApple,
            throwsA(isA<AppleNotSupportedException>()),
          );
        });

        test(
            'Should throw SignInException  '
            'when getFacebookCredential throws any other exception', () async {
          // Arrange -> setup test dependencies
          mockAppleAuthenticationGetCredentialThrowsException(
            Exception(),
          );

          // Assert -> Verify the output and behavior is the expected
          await expectLater(
            authenticationRepositoryLogic.signInWithApple,
            throwsA(isA<SignInException>()),
          );
        });
      });
    });

    group('ResetPassword', () {
      late AuthenticationRepository authenticationRepositoryLogic;
      late firebase_auth.FirebaseAuth firebaseAuth;
      late String email;
      setUp(() {
        email = 'email@email.com';
        registerFallbackValue(Exception());
        firebaseAuth = _MockFirebaseAuth();
        authenticationRepositoryLogic = AuthenticationRepository(
          firebaseAuth: firebaseAuth,
          googleAuthenticationProvider: MockGoogleAuthenticationProvider(),
          facebookAuthenticationProvider: MockFacebookAuthenticationProvider(),
          appleAuthenticationProvider: MockAppleAuthenticationProvider(),
        );
      });

      void mockFirebaseSendPasswordResetEmailSuccessCall() => when(
            () => firebaseAuth.sendPasswordResetEmail(
              email: any<String>(named: 'email'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

      void mockFirebaseSendPasswordResetEmailThrowsException(
        Exception exception,
      ) {
        when(
          () => firebaseAuth.sendPasswordResetEmail(
            email: any<String>(named: 'email'),
          ),
        ).thenThrow(exception);
      }

      test('completes', () async {
        mockFirebaseSendPasswordResetEmailSuccessCall();

        await expectLater(
          authenticationRepositoryLogic.resetPassword(email: email),
          completes,
        );
      });

      test('returns normally', () async {
        mockFirebaseSendPasswordResetEmailSuccessCall();

        await expectLater(
          () => authenticationRepositoryLogic.resetPassword(email: email),
          returnsNormally,
        );
      });

      test('verify calls signInWithEmailAndPassword', () async {
        mockFirebaseSendPasswordResetEmailSuccessCall();

        await authenticationRepositoryLogic.resetPassword(email: email);

        verify(
          () => firebaseAuth.sendPasswordResetEmail(email: email),
        ).called(1);
      });

      group('throws a', () {
        test(
            'InvalidEmailException '
            'when firebase auth throws FirebaseAuthException with error code: '
            'auth/invalid-email', () async {
          mockFirebaseSendPasswordResetEmailThrowsException(
            firebase_auth.FirebaseAuthException(
              code: ErrorCodes.authInvalidEmail,
            ),
          );

          await expectLater(
            authenticationRepositoryLogic.resetPassword(email: email),
            throwsA(isA<InvalidEmailException>()),
          );
        });
        test(
            'InvalidEmailException '
            'when firebase auth throws FirebaseAuthException with error code: '
            'auth/user-not-found', () async {
          mockFirebaseSendPasswordResetEmailThrowsException(
            firebase_auth.FirebaseAuthException(
              code: ErrorCodes.userNotFound,
            ),
          );

          await expectLater(
            authenticationRepositoryLogic.resetPassword(email: email),
            throwsA(isA<UserNotFoundException>()),
          );
        });
        test(
            'ResetPasswordException '
            'when methods throws any Exception', () async {
          mockFirebaseSendPasswordResetEmailThrowsException(Exception());

          await expectLater(
            authenticationRepositoryLogic.resetPassword(email: email),
            throwsA(isA<ResetPasswordException>()),
          );
        });
      });
    });
  });
}
