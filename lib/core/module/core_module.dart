import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CoreModule {
  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() => const FlutterSecureStorage();

  @lazySingleton
  GoogleSignIn googleSignIn() {
    try {
      return GoogleSignIn(
        clientId:
            '333437725100-3i5ul6dvb0gnkj031j2vukmfbud5qva9.apps.googleusercontent.com',
        scopes: [
          'email',
          'https://www.googleapis.com/auth/calendar.events',
          'https://www.googleapis.com/auth/calendar.readonly',
        ],
      );
    } catch (e) {
      print('Error creating GoogleSignIn: $e');
      rethrow;
    }
  }
}
