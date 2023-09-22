import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_calendar_service/google_calendar_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'integrations_cubit.freezed.dart';
part 'integrations_state.dart';

class IntegrationsCubit extends Cubit<IntegrationsState> {
  IntegrationsCubit(
    // this.integrationRepository,
    this.calendarRepository,
    this._googleSignIn,
  ) : super(const IntegrationsState.initial([], [], [])) {
    // integrationRepository.getAllIntegrations().listen(
    //       (integrations) => emit(
    //         IntegrationsState.loaded(
    //           integrations,
    //           state.calendarIntegrations,
    //         ),
    //       ),
    //     );

    calendarRepository.getAllPlatforms().listen(
          (calendarPlatforms) => emit(
            IntegrationsState.loaded(
              state.integrations,
              state.calendarIntegrations,
              calendarPlatforms,
            ),
          ),
        );

    calendarRepository.getAllIntegrations().listen((calendarIntegrations) {
      log('Cubit Got calendar integrations: $calendarIntegrations');
      emit(
        IntegrationsState.loaded(
          state.integrations,
          calendarIntegrations,
          state.calendarPlatforms,
        ),
      );
    });
  }
  // final IntegrationsRepository integrationRepository;
  final CalendarRepository calendarRepository;
  final GoogleSignIn _googleSignIn;

  Future<void> startIntegrationWithPlatform(Platform platform) =>
      switch (platform) {
        final CalendarPlatform platform =>
          startIntegrationWithCalendarPlatform(platform),
        _ => throw UnimplementedError('Unsupported platform: $platform'),
      };

  Future<void> startIntegrationWithCalendarPlatform(
    CalendarPlatform platform,
  ) async =>
      switch (platform) {
        final GoogleCalendarPlatform platform =>
          startIntegrationWithGoogleCalendarPlatform(platform),
        _ => throw UnimplementedError('Unsupported platform: $platform'),
      };

  Future<void> startIntegrationWithGoogleCalendarPlatform(
    GoogleCalendarPlatform platform,
  ) async {
    /// Sings in to Google account and returns the account.

    try {
      final account = await _googleSignIn.signIn();

      if (account == null) {
        throw Exception('Could not sign in to Google account');
      }

      final authentication = await account.authentication;

      final accessToken = authentication.accessToken;
      final displayName = account.displayName;

      if ([accessToken, displayName].any((e) => e == null)) {
        throw Exception(
          'Could not get all required authentication data $accessToken $displayName',
        );
      }

      final integration = GoogleCalendarIntegration(
        GoogleCalendarPlatform.instance,
        accessToken!,
        displayName!,
      );

      print('Got integration: $integration');
      await _googleSignIn.signOut();

      return addIntegration(integration);
    } catch (e) {
      print('Got error: $e');
    }
  }

  Future<void> addIntegration(Integration integration) async {
    emit(
      IntegrationsState.loading(
        state.integrations,
        state.calendarIntegrations,
        state.calendarPlatforms,
      ),
    );
    try {
      if (integration is CalendarIntegration) {
        await calendarRepository.addIntegration(integration);
      }
      // await integrationRepository.addIntegration(integration);
    } catch (e) {
      emit(
        IntegrationsState.error(
          state.integrations,
          state.calendarIntegrations,
          state.calendarPlatforms,
          e.toString(),
        ),
      );
    }
  }

  Future<void> deleteIntegration(Integration integration) async {
    emit(
      IntegrationsState.loading(
        state.integrations,
        state.calendarIntegrations,
        state.calendarPlatforms,
      ),
    );
    try {
      // await integrationRepository.deleteIntegration(integration);
    } catch (e) {
      emit(
        IntegrationsState.error(
          state.integrations,
          state.calendarIntegrations,
          state.calendarPlatforms,
          e.toString(),
        ),
      );
    }
  }
}
