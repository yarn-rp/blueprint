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
    as _i17;
import 'package:blueprint/authentication/state_management/forgot_password_cubit/forgot_password_cubit.dart'
    as _i11;
import 'package:blueprint/authentication/state_management/sign_in_cubit/sign_in_cubit.dart'
    as _i13;
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart'
    as _i14;
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart'
    as _i15;
import 'package:blueprint/blueprint/module/blueprint_module.dart' as _i26;
import 'package:blueprint/blueprint/state_management/todays_blueprint/todays_blueprint_cubit.dart'
    as _i7;
import 'package:blueprint/core/module/core_module.dart' as _i22;
import 'package:blueprint/core/module/firebase_module.dart' as _i23;
import 'package:blueprint/integrations/module/integrations_module.dart' as _i24;
import 'package:blueprint/integrations/state_management/available_platforms/available_platforms_cubit.dart'
    as _i18;
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart'
    as _i19;
import 'package:blueprint/settings/module/settings_module.dart' as _i20;
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart'
    as _i6;
import 'package:blueprint/tasks/module/task_module.dart' as _i21;
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart'
    as _i16;
import 'package:cloud_firestore/cloud_firestore.dart' as _i9;
import 'package:cloud_functions/cloud_functions.dart' as _i10;
import 'package:firebase_auth/firebase_auth.dart' as _i8;
import 'package:firebase_core/firebase_core.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:integrations_repository/integrations_repository.dart' as _i12;

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
    final settingsModule = _$SettingsModule();
    final blueprintModule = _$BlueprintModule();
    final integrationsModule = _$IntegrationsModule();
    final taskModule = _$TaskModule();
    gh.lazySingleton<_i3.AppleAuthenticationProvider>(
        () => authenticationModule.appleAuthenticationProvider());
    gh.lazySingleton<_i3.FacebookAuthenticationProvider>(
        () => authenticationModule.facebookAuthenticationProvider());
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.developmentFirebaseOptions,
      registerFor: {_dev},
    );
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.productionFirebaseOptions,
      registerFor: {_prod},
    );
    gh.singleton<_i4.FirebaseOptions>(
      firebaseModule.stagingFirebaseOptions,
      registerFor: {_stg},
    );
    gh.lazySingleton<_i5.FlutterSecureStorage>(
        () => coreModule.flutterSecureStorage());
    gh.lazySingleton<_i6.GitHubRepository>(() =>
        integrationsModule.githubRepository(gh<_i5.FlutterSecureStorage>()));
    gh.lazySingleton<_i3.GoogleAuthenticationProvider>(
        () => authenticationModule.googleAuthenticationProvider());
    gh.lazySingleton<_i6.SettingsBloc>(() => settingsModule.settingsBloc());
    gh.lazySingleton<_i7.TodaysBlueprintCubit>(
        () => blueprintModule.blueprintCubit(gh<_i6.SettingsBloc>()));
    await gh.singletonAsync<_i4.FirebaseApp>(
      () => firebaseModule.firebaseApp(gh<_i4.FirebaseOptions>()),
      preResolve: true,
    );
    gh.lazySingleton<_i8.FirebaseAuth>(
        () => firebaseModule.firebaseAuth(gh<_i4.FirebaseApp>()));
    gh.lazySingleton<_i9.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore(gh<_i4.FirebaseApp>()));
    gh.lazySingleton<_i10.FirebaseFunctions>(
        () => firebaseModule.firebaseFunctions(gh<_i4.FirebaseApp>()));
    gh.lazySingleton<_i11.IntegrationsRepository>(
        () => integrationsModule.integrationsRepository(
              gh<_i7.JiraRepository>(),
              gh<_i6.GitHubRepository>(),
            ));
    gh.factory<_i12.TasksCubit>(
        () => taskModule.taskCubit(gh<_i11.IntegrationsRepository>()));
    gh.lazySingleton<_i3.AuthenticationRepositoryContract>(
        () => authenticationModule.authenticationRepository(
              gh<_i3.AppleAuthenticationProvider>(),
              gh<_i3.GoogleAuthenticationProvider>(),
              gh<_i3.FacebookAuthenticationProvider>(),
              gh<_i8.FirebaseAuth>(),
            ));
    gh.factory<_i11.ForgotPasswordCubit>(() => authenticationModule
        .forgotPasswordCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i12.IntegrationsRepository>(
        () => integrationsModule.integrationsRepository(
              gh<_i9.FirebaseFirestore>(),
              gh<_i10.FirebaseFunctions>(),
              gh<_i3.AuthenticationRepositoryContract>(),
            ));
    gh.factory<_i13.SignInCubit>(() => authenticationModule
        .signInCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.factory<_i14.SignOutCubit>(() => authenticationModule
        .signOutCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.factory<_i15.SignUpCubit>(() => authenticationModule
        .signUpCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.factory<_i16.TasksCubit>(
        () => taskModule.taskCubit(gh<_i12.IntegrationsRepository>()));
    gh.lazySingleton<_i17.AuthenticationCubit>(() => authenticationModule
        .authenticationCubit(gh<_i3.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i18.AvailablePlatformsCubit>(() => integrationsModule
        .availablePlatformsCubit(gh<_i12.IntegrationsRepository>()));
    gh.lazySingleton<_i19.IntegrationsCubit>(() => integrationsModule
        .integrationsCubit(gh<_i12.IntegrationsRepository>()));
    return this;
  }
}

class _$SettingsModule extends _i20.SettingsModule {}

class _$TaskModule extends _i21.TaskModule {}

class _$CoreModule extends _i22.CoreModule {}

class _$FirebaseModule extends _i23.FirebaseModule {}

class _$IntegrationsModule extends _i24.IntegrationsModule {}

class _$AuthenticationModule extends _i25.AuthenticationModule {}

class _$BlueprintModule extends _i26.BlueprintModule {}
