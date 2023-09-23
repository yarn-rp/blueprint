// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:authentication_repository/authentication_repository.dart'
    as _i3;
import 'package:blueprint/authentication/module/authentication_module.dart'
    as _i25;
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart'
    as _i23;
import 'package:blueprint/authentication/state_management/forgot_password_cubit/forgot_password_cubit.dart'
    as _i16;
import 'package:blueprint/authentication/state_management/sign_in_cubit/sign_in_cubit.dart'
    as _i18;
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart'
    as _i19;
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart'
    as _i20;
import 'package:blueprint/blueprint/module/blueprint_module.dart' as _i32;
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart'
    as _i24;
import 'package:blueprint/calendar/module/calendar_module.dart' as _i28;
import 'package:blueprint/core/module/core_module.dart' as _i27;
import 'package:blueprint/core/module/firebase_module.dart' as _i26;
import 'package:blueprint/integrations/module/integrations_module.dart' as _i30;
import 'package:blueprint/integrations/state_management/available_platforms/available_platforms_cubit.dart'
    as _i15;
import 'package:blueprint/integrations/state_management/integrations_cubit/integrations_cubit.dart'
    as _i17;
import 'package:blueprint/settings/module/settings_module.dart' as _i29;
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart'
    as _i10;
import 'package:blueprint/tasks/module/task_module.dart' as _i31;
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart'
    as _i22;
import 'package:calendar_repository/calendar_repository.dart' as _i8;
import 'package:cloud_firestore/cloud_firestore.dart' as _i12;
import 'package:cloud_functions/cloud_functions.dart' as _i13;
import 'package:firebase_auth/firebase_auth.dart' as _i11;
import 'package:firebase_core/firebase_core.dart' as _i4;
import 'package:flutter_secure_key_pair_storage/flutter_secure_key_pair_storage.dart'
    as _i9;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_calendar_service/google_calendar_service.dart' as _i6;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:integrations_repository/integrations_repository.dart' as _i14;
import 'package:task_repository/task_repository.dart' as _i21;

const String _dev = 'dev';
const String _prod = 'prod';
const String _stg = 'stg';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final authenticationModule = _$AuthenticationModule();
    final firebaseModule = _$FirebaseModule();
    final coreModule = _$CoreModule();
    final calendarModule = _$CalendarModule();
    final settingsModule = _$SettingsModule();
    final integrationsModule = _$IntegrationsModule();
    final taskModule = _$TaskModule();
    final blueprintModule = _$BlueprintModule();
    gh.lazySingleton<_i3.AppleAuthenticationProvider>(
        () => authenticationModule.appleAuthenticationProvider());
    gh.lazySingleton<_i3.FacebookAuthenticationProvider>(
        () => authenticationModule.facebookAuthenticationProvider());
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.productionFirebaseOptions,
      registerFor: {_prod},
    );
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.stagingFirebaseOptions,
      registerFor: {_stg},
    );
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.developmentFirebaseOptions,
      registerFor: {_dev},
    );
    gh.lazySingleton<_i5.FlutterSecureStorage>(
        () => coreModule.flutterSecureStorage());
    gh.lazySingleton<_i3.GoogleAuthenticationProvider>(
        () => authenticationModule.googleAuthenticationProvider());
    gh.lazySingleton<_i6.GoogleCalendarIntegrationMapper>(
        () => calendarModule.googleCalendarIntegrationMapper());
    gh.lazySingleton<_i7.GoogleSignIn>(() => coreModule.googleSignIn());
    gh.lazySingleton<_i8.KeyPairStorage>(
        () => calendarModule.keyPairStorage(gh<_i9.FlutterSecureStorage>()));
    gh.lazySingleton<_i10.SettingsBloc>(() => settingsModule.settingsBloc());
    gh.factory<String>(
      () => calendarModule.storageKey(),
      instanceName: 'google_calendar_storage_key',
    );
    await gh.singletonAsync<_i4.FirebaseApp>(
      () => firebaseModule.firebaseApp(gh<_i4.FirebaseOptions>()),
      preResolve: true,
    );
    gh.lazySingleton<_i11.FirebaseAuth>(
        () => firebaseModule.firebaseAuth(gh<_i4.FirebaseApp>()));
    gh.lazySingleton<_i12.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore(gh<_i4.FirebaseApp>()));
    gh.lazySingleton<_i13.FirebaseFunctions>(
        () => firebaseModule.firebaseFunctions(gh<_i4.FirebaseApp>()));
    gh.lazySingleton<_i14.IntegrationsRepository>(
        () => integrationsModule.integrationsRepository(
              gh<_i12.FirebaseFirestore>(),
              gh<_i13.FirebaseFunctions>(),
            ));
    gh.lazySingleton<
            _i8.PlatformIntegrationStorage<_i6.GoogleCalendarPlatform,
                _i6.GoogleCalendarIntegration>>(
        () => calendarModule.platformIntegrationStorage(
              gh<_i8.KeyPairStorage>(),
              gh<_i6.GoogleCalendarIntegrationMapper>(),
              gh<String>(instanceName: 'google_calendar_storage_key'),
            ));
    gh.lazySingleton<_i3.AuthenticationRepositoryContract>(
        () => authenticationModule.authenticationRepository(
              gh<_i3.AppleAuthenticationProvider>(),
              gh<_i3.GoogleAuthenticationProvider>(),
              gh<_i3.FacebookAuthenticationProvider>(),
              gh<_i11.FirebaseAuth>(),
            ));
    gh.lazySingleton<_i15.AvailablePlatformsCubit>(() => integrationsModule
        .availablePlatformsCubit(gh<_i14.IntegrationsRepository>()));
    gh.factory<_i16.ForgotPasswordCubit>(() => authenticationModule
        .forgotPasswordCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i6.GoogleCalendarService>(() =>
        calendarModule.googleCalendarService(gh<
            _i8.PlatformIntegrationStorage<_i6.GoogleCalendarPlatform,
                _i6.GoogleCalendarIntegration>>()));
    gh.lazySingleton<_i17.IntegrationsCubit>(() => integrationsModule
        .integrationsCubit(gh<_i14.IntegrationsRepository>()));
    gh.factory<_i18.SignInCubit>(() => authenticationModule
        .signInCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.factory<_i19.SignOutCubit>(() => authenticationModule
        .signOutCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.factory<_i20.SignUpCubit>(() => authenticationModule
        .signUpCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i21.TaskRepository>(() => taskModule.taskRepository(
          gh<_i12.FirebaseFirestore>(),
          gh<_i13.FirebaseFunctions>(),
          gh<_i3.AuthenticationRepositoryContract>(),
        ));
    gh.factory<_i22.TasksCubit>(
        () => taskModule.taskCubit(gh<_i21.TaskRepository>()));
    gh.lazySingleton<_i23.AuthenticationCubit>(() => authenticationModule
        .authenticationCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i8.CalendarRepository>(() =>
        calendarModule.calendarRepository(gh<_i6.GoogleCalendarService>()));
    gh.lazySingleton<_i24.TodaysBlueprintCubit>(
        () => blueprintModule.blueprintCubit(
              gh<_i10.SettingsBloc>(),
              gh<_i8.CalendarRepository>(),
            ));
    return this;
  }
}

class _$AuthenticationModule extends _i25.AuthenticationModule {}

class _$FirebaseModule extends _i26.FirebaseModule {}

class _$CoreModule extends _i27.CoreModule {}

class _$CalendarModule extends _i28.CalendarModule {}

class _$SettingsModule extends _i29.SettingsModule {}

class _$IntegrationsModule extends _i30.IntegrationsModule {}

class _$TaskModule extends _i31.TaskModule {}

class _$BlueprintModule extends _i32.BlueprintModule {}
