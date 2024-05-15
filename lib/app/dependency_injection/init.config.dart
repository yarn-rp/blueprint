// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ai_client/ai_client.dart' as _i6;
import 'package:authentication_repository/authentication_repository.dart'
    as _i8;
import 'package:blueprint/ai_assistant_chat/module/ai_assistant_chat_module.dart'
    as _i37;
import 'package:blueprint/ai_assistant_chat/state_management/bloc/ai_assistant_chat_bloc.dart'
    as _i26;
import 'package:blueprint/authentication/module/authentication_module.dart'
    as _i30;
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart'
    as _i14;
import 'package:blueprint/authentication/state_management/forgot_password_cubit/forgot_password_cubit.dart'
    as _i18;
import 'package:blueprint/authentication/state_management/sign_in_cubit/sign_in_cubit.dart'
    as _i15;
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart'
    as _i17;
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart'
    as _i16;
import 'package:blueprint/blueprint/module/blueprint_module.dart' as _i34;
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart'
    as _i22;
import 'package:blueprint/calendar/module/calendar_module.dart' as _i36;
import 'package:blueprint/core/module/core_module.dart' as _i29;
import 'package:blueprint/core/module/firebase_module.dart' as _i31;
import 'package:blueprint/integrations/module/integrations_module.dart' as _i33;
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart'
    as _i23;
import 'package:blueprint/settings/module/settings_module.dart' as _i28;
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart'
    as _i3;
import 'package:blueprint/tasks/module/task_module.dart' as _i35;
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart'
    as _i27;
import 'package:blueprint/users/module/user_module.dart' as _i32;
import 'package:blueprint/users/state_management/cubit/user_cubit.dart' as _i21;
import 'package:blueprint_repository/blueprint_repository.dart' as _i20;
import 'package:calendar_repository/calendar_repository.dart' as _i25;
import 'package:cloud_firestore/cloud_firestore.dart' as _i11;
import 'package:cloud_functions/cloud_functions.dart' as _i12;
import 'package:firebase_auth/firebase_auth.dart' as _i10;
import 'package:firebase_core/firebase_core.dart' as _i9;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:integrations_repository/integrations_repository.dart' as _i19;
import 'package:task_repository/task_repository.dart' as _i24;
import 'package:user_repository/user_repository.dart' as _i13;
import 'package:uuid/uuid.dart' as _i5;

const String _dev = 'dev';
const String _local = 'local';
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
    final settingsModule = _$SettingsModule();
    final coreModule = _$CoreModule();
    final authenticationModule = _$AuthenticationModule();
    final firebaseModule = _$FirebaseModule();
    final userModule = _$UserModule();
    final integrationsModule = _$IntegrationsModule();
    final blueprintModule = _$BlueprintModule();
    final taskModule = _$TaskModule();
    final calendarModule = _$CalendarModule();
    final aIAssistantChatModule = _$AIAssistantChatModule();
    gh.lazySingleton<_i3.SettingsBloc>(() => settingsModule.settingsBloc());
    gh.lazySingleton<_i4.FlutterSecureStorage>(
        () => coreModule.flutterSecureStorage());
    gh.lazySingleton<_i5.Uuid>(() => coreModule.uuid());
    gh.lazySingleton<_i6.AiClient>(() => coreModule.aiClient());
    gh.lazySingleton<_i7.GoogleSignIn>(() => coreModule.googleSignIn());
    gh.lazySingleton<_i8.AppleAuthenticationProvider>(
        () => authenticationModule.appleAuthenticationProvider());
    gh.lazySingleton<_i8.FacebookAuthenticationProvider>(
        () => authenticationModule.facebookAuthenticationProvider());
    gh.lazySingleton<_i8.GoogleAuthenticationProvider>(() =>
        authenticationModule
            .googleAuthenticationProvider(gh<_i7.GoogleSignIn>()));
    gh.singleton<_i9.FirebaseOptions>(
      () => firebaseModule.developmentFirebaseOptions,
      registerFor: {_dev},
    );
    gh.singleton<_i9.FirebaseOptions>(
      () => firebaseModule.localFirebaseOptions,
      registerFor: {_local},
    );
    await gh.singletonAsync<_i9.FirebaseApp>(
      () => firebaseModule.firebaseApp(gh<_i9.FirebaseOptions>()),
      preResolve: true,
    );
    gh.lazySingleton<_i10.FirebaseAuth>(
        () => firebaseModule.firebaseAuth(gh<_i9.FirebaseApp>()));
    gh.lazySingleton<_i11.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore(gh<_i9.FirebaseApp>()));
    gh.lazySingleton<_i12.FirebaseFunctions>(
        () => firebaseModule.firebaseFunctions(gh<_i9.FirebaseApp>()));
    gh.singleton<_i9.FirebaseOptions>(
      () => firebaseModule.productionFirebaseOptions,
      registerFor: {_prod},
    );
    gh.singleton<_i9.FirebaseOptions>(
      () => firebaseModule.stagingFirebaseOptions,
      registerFor: {_stg},
    );
    gh.lazySingleton<_i8.AuthenticationRepositoryContract>(
        () => authenticationModule.authenticationRepository(
              gh<_i8.AppleAuthenticationProvider>(),
              gh<_i8.GoogleAuthenticationProvider>(),
              gh<_i8.FacebookAuthenticationProvider>(),
              gh<_i10.FirebaseAuth>(),
            ));
    gh.lazySingleton<_i13.UserRepository>(() => userModule.userRepository(
          gh<_i11.FirebaseFirestore>(),
          gh<_i8.AuthenticationRepositoryContract>(),
        ));
    gh.lazySingleton<_i14.AuthenticationCubit>(() => authenticationModule
        .authenticationCubit(gh<_i8.AuthenticationRepositoryContract>()));
    gh.factory<_i15.SignInCubit>(() => authenticationModule
        .signInCubit(gh<_i8.AuthenticationRepositoryContract>()));
    gh.factory<_i16.SignUpCubit>(() => authenticationModule
        .signUpCubit(gh<_i8.AuthenticationRepositoryContract>()));
    gh.factory<_i17.SignOutCubit>(() => authenticationModule
        .signOutCubit(gh<_i8.AuthenticationRepositoryContract>()));
    gh.factory<_i18.ForgotPasswordCubit>(() => authenticationModule
        .forgotPasswordCubit(gh<_i8.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i19.IntegrationsRepository>(
        () => integrationsModule.integrationsRepository(
              gh<_i11.FirebaseFirestore>(),
              gh<_i12.FirebaseFunctions>(),
              gh<_i8.AuthenticationRepositoryContract>(),
            ));
    gh.lazySingleton<_i20.BlueprintRepository>(
        () => blueprintModule.blueprintRepository(
              gh<_i11.FirebaseFirestore>(),
              gh<_i19.IntegrationsRepository>(),
              gh<_i8.AuthenticationRepositoryContract>(),
              gh<_i6.AiClient>(),
              gh<_i5.Uuid>(),
            ));
    gh.lazySingleton<_i21.UserCubit>(
        () => userModule.userCubit(gh<_i13.UserRepository>()));
    gh.lazySingleton<_i22.BlueprintBloc>(
        () => blueprintModule.blueprintBloc(gh<_i20.BlueprintRepository>()));
    gh.lazySingleton<_i23.IntegrationsCubit>(() => integrationsModule
        .integrationsCubit(gh<_i19.IntegrationsRepository>()));
    gh.singleton<_i24.TaskRepository>(() => taskModule.taskRepository(
          gh<_i11.FirebaseFirestore>(),
          gh<_i12.FirebaseFunctions>(),
          gh<_i19.IntegrationsRepository>(),
          gh<_i8.AuthenticationRepositoryContract>(),
        ));
    gh.singleton<_i25.CalendarRepository>(() => calendarModule.taskRepository(
          gh<_i11.FirebaseFirestore>(),
          gh<_i12.FirebaseFunctions>(),
          gh<_i19.IntegrationsRepository>(),
          gh<_i8.AuthenticationRepositoryContract>(),
        ));
    gh.factoryParam<_i26.AiAssistantChatBloc, List<String>, dynamic>((
      initialBotMessages,
      _,
    ) =>
        aIAssistantChatModule.aiAssistantChatBloc(
          gh<_i20.BlueprintRepository>(),
          gh<_i24.TaskRepository>(),
          gh<_i5.Uuid>(),
          initialBotMessages,
        ));
    gh.factory<_i27.TasksCubit>(() => taskModule.taskCubit(
          gh<_i24.TaskRepository>(),
          gh<_i19.IntegrationsRepository>(),
        ));
    return this;
  }
}

class _$SettingsModule extends _i28.SettingsModule {}

class _$CoreModule extends _i29.CoreModule {}

class _$AuthenticationModule extends _i30.AuthenticationModule {}

class _$FirebaseModule extends _i31.FirebaseModule {}

class _$UserModule extends _i32.UserModule {}

class _$IntegrationsModule extends _i33.IntegrationsModule {}

class _$BlueprintModule extends _i34.BlueprintModule {}

class _$TaskModule extends _i35.TaskModule {}

class _$CalendarModule extends _i36.CalendarModule {}

class _$AIAssistantChatModule extends _i37.AIAssistantChatModule {}
