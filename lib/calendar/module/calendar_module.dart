import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter_secure_key_pair_storage/flutter_secure_key_pair_storage.dart';
import 'package:google_calendar_service/google_calendar_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CalendarModule {
  @lazySingleton
  CalendarRepository calendarRepository(
    GoogleCalendarService googleCalendarService,
  ) =>
      CalendarRepository(
        services: [
          googleCalendarService,
        ],
      );

  @lazySingleton
  GoogleCalendarService googleCalendarService(
    PlatformIntegrationStorage<GoogleCalendarPlatform,
            GoogleCalendarIntegration>
        platformIntegrationStorage,
  ) =>
      GoogleCalendarService(
        platformIntegrationStorage: platformIntegrationStorage,
      );

  @lazySingleton
  PlatformIntegrationStorage<GoogleCalendarPlatform, GoogleCalendarIntegration>
      platformIntegrationStorage(
    KeyPairStorage storage,
    GoogleCalendarIntegrationMapper mapper,
    @Named('google_calendar_storage_key') String storageKey,
  ) =>
          PlatformIntegrationStorage(
            storage: storage,
            mapper: mapper,
            storageKey: storageKey,
          );

  @lazySingleton
  GoogleCalendarIntegrationMapper googleCalendarIntegrationMapper() =>
      GoogleCalendarIntegrationMapper();

  @lazySingleton
  KeyPairStorage keyPairStorage(
    FlutterSecureStorage flutterSecureStorage,
  ) =>
      FlutterSecureKeyPairStorage(
        flutterSecureStorage: flutterSecureStorage,
      );

  @Named('google_calendar_storage_key')
  String storageKey() => 'google_calendar_storage_key';
}
