import 'package:ai_client/ai_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

// const _geminiProModel = 'gemini-pro';

@module
abstract class CoreModule {
  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() => const FlutterSecureStorage();

  @lazySingleton
  Uuid uuid() => const Uuid();

  @lazySingleton
  AiClient aiClient() => ChatGPTAiClient(
        apiKey: '<your-api-key-h>',
      );

  // @lazySingleton
  // AiClient aiClient() => GeminiAiClient(
  //       generativeModel: GenerativeModel(
  //         apiKey: 'AIzaSyCF5ytyGfjz_fsZz6EMrH39Q3yLJMUpHSk',
  //         params: ModelParams(
  //           model: _geminiProModel,
  //         ),
  //       ),
  //     );

  @lazySingleton
  GoogleSignIn googleSignIn() {
    try {
      return GoogleSignIn(
        clientId: kIsWeb
            ? '333437725100-3i5ul6dvb0gnkj031j2vukmfbud5qva9.apps.'
                'googleusercontent.com'
            : null,
        scopes: [
          'email',
          'https://www.googleapis.com/auth/calendar.events',
          'https://www.googleapis.com/auth/calendar.readonly',
        ],
      );
    } catch (e) {
      rethrow;
    }
  }
}
