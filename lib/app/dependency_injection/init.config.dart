// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ai_client/ai_client.dart' as _i3;
import 'package:authentication_repository/authentication_repository.dart'
    as _i4;
import 'package:blueprint/ai_assistant_chat/module/ai_assistant_chat_module.dart'
    as _i37;
import 'package:blueprint/ai_assistant_chat/state_management/bloc/ai_assistant_chat_bloc.dart'
    as _i26;
import 'package:blueprint/authentication/module/authentication_module.dart'
    as _i29;
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart'
    as _i21;
import 'package:blueprint/authentication/state_management/forgot_password_cubit/forgot_password_cubit.dart'
    as _i13;
import 'package:blueprint/authentication/state_management/sign_in_cubit/sign_in_cubit.dart'
    as _i15;
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart'
    as _i16;
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart'
    as _i17;
import 'package:blueprint/blueprint/module/blueprint_module.dart' as _i35;
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart'
    as _i27;
import 'package:blueprint/calendar/module/calendar_module.dart' as _i36;
import 'package:blueprint/core/module/core_module.dart' as _i28;
import 'package:blueprint/core/module/firebase_module.dart' as _i30;
import 'package:blueprint/integrations/module/integrations_module.dart' as _i32;
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart'
    as _i24;
import 'package:blueprint/settings/module/settings_module.dart' as _i31;
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart'
    as _i8;
import 'package:blueprint/tasks/module/task_module.dart' as _i33;
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart'
    as _i19;
import 'package:blueprint/users/module/user_module.dart' as _i34;
import 'package:blueprint/users/state_management/cubit/user_cubit.dart' as _i25;
import 'package:blueprint_repository/blueprint_repository.dart' as _i22;
import 'package:calendar_repository/calendar_repository.dart' as _i23;
import 'package:cloud_firestore/cloud_firestore.dart' as _i11;
import 'package:cloud_functions/cloud_functions.dart' as _i12;
import 'package:firebase_auth/firebase_auth.dart' as _i10;
import 'package:firebase_core/firebase_core.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:integrations_repository/integrations_repository.dart' as _i14;
import 'package:task_repository/task_repository.dart' as _i18;
import 'package:user_repository/user_repository.dart' as _i20;
import 'package:uuid/uuid.dart' as _i9;

const String _prod = 'prod';
const String _stg = 'stg';
const String _dev = 'dev';
const String _local = 'local';

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
    final coreModule = _$CoreModule();
    final authenticationModule = _$AuthenticationModule();
    final firebaseModule = _$FirebaseModule();
    final settingsModule = _$SettingsModule();
    final integrationsModule = _$IntegrationsModule();
    final taskModule = _$TaskModule();
    final userModule = _$UserModule();
    final blueprintModule = _$BlueprintModule();
    final calendarModule = _$CalendarModule();
    final aIAssistantChatModule = _$AIAssistantChatModule();
    gh.lazySingleton<_i3.AiClient>(() => coreModule.aiClient());
    gh.lazySingleton<_i4.AppleAuthenticationProvider>(
        () => authenticationModule.appleAuthenticationProvider());
    gh.lazySingleton<_i4.FacebookAuthenticationProvider>(
        () => authenticationModule.facebookAuthenticationProvider());
    gh.singleton<_i5.FirebaseOptions>(
      () => firebaseModule.productionFirebaseOptions,
      registerFor: {_prod},
    );
    gh.singleton<_i5.FirebaseOptions>(
      () => firebaseModule.stagingFirebaseOptions,
      registerFor: {_stg},
    );
    gh.singleton<_i5.FirebaseOptions>(
      () => firebaseModule.developmentFirebaseOptions,
      registerFor: {_dev},
    );
    gh.singleton<_i5.FirebaseOptions>(
      () => firebaseModule.localFirebaseOptions,
      registerFor: {_local},
    );
    gh.lazySingleton<_i6.FlutterSecureStorage>(
        () => coreModule.flutterSecureStorage());
    gh.lazySingleton<_i4.GoogleAuthenticationProvider>(
        () => authenticationModule.googleAuthenticationProvider());
    gh.lazySingleton<_i7.GoogleSignIn>(() => coreModule.googleSignIn());
    gh.lazySingleton<_i8.SettingsBloc>(() => settingsModule.settingsBloc());
    gh.lazySingleton<_i9.Uuid>(() => coreModule.uuid());
    await gh.singletonAsync<_i5.FirebaseApp>(
      () => firebaseModule.firebaseApp(gh<_i5.FirebaseOptions>()),
      preResolve: true,
    );
    gh.lazySingleton<_i10.FirebaseAuth>(
        () => firebaseModule.firebaseAuth(gh<_i5.FirebaseApp>()));
    gh.lazySingleton<_i11.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore(gh<_i5.FirebaseApp>()));
    gh.lazySingleton<_i12.FirebaseFunctions>(
        () => firebaseModule.firebaseFunctions(gh<_i5.FirebaseApp>()));
    gh.lazySingleton<_i4.AuthenticationRepositoryContract>(
        () => authenticationModule.authenticationRepository(
              gh<_i4.AppleAuthenticationProvider>(),
              gh<_i4.GoogleAuthenticationProvider>(),
              gh<_i4.FacebookAuthenticationProvider>(),
              gh<_i10.FirebaseAuth>(),
            ));
    gh.factory<_i13.ForgotPasswordCubit>(() => authenticationModule
        .forgotPasswordCubit(gh<_i4.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i14.IntegrationsRepository>(
        () => integrationsModule.integrationsRepository(
              gh<_i11.FirebaseFirestore>(),
              gh<_i12.FirebaseFunctions>(),
              gh<_i4.AuthenticationRepositoryContract>(),
            ));
    gh.factory<_i15.SignInCubit>(() => authenticationModule
        .signInCubit(gh<_i4.AuthenticationRepositoryContract>()));
    gh.factory<_i16.SignOutCubit>(() => authenticationModule
        .signOutCubit(gh<_i4.AuthenticationRepositoryContract>()));
    gh.factory<_i17.SignUpCubit>(() => authenticationModule
        .signUpCubit(gh<_i4.AuthenticationRepositoryContract>()));
    gh.singleton<_i18.TaskRepository>(() => taskModule.taskRepository(
          gh<_i11.FirebaseFirestore>(),
          gh<_i12.FirebaseFunctions>(),
          gh<_i14.IntegrationsRepository>(),
          gh<_i4.AuthenticationRepositoryContract>(),
        ));
    gh.factory<_i19.TasksCubit>(() => taskModule.taskCubit(
          gh<_i18.TaskRepository>(),
          gh<_i14.IntegrationsRepository>(),
        ));
    gh.lazySingleton<_i20.UserRepository>(() => userModule.userRepository(
          gh<_i11.FirebaseFirestore>(),
          gh<_i4.AuthenticationRepositoryContract>(),
        ));
    gh.lazySingleton<_i21.AuthenticationCubit>(() => authenticationModule
        .authenticationCubit(gh<_i4.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i22.BlueprintRepository>(
        () => blueprintModule.blueprintRepository(
              gh<_i11.FirebaseFirestore>(),
              gh<_i14.IntegrationsRepository>(),
              gh<_i4.AuthenticationRepositoryContract>(),
              gh<_i3.AiClient>(),
              gh<_i9.Uuid>(),
            ));
    gh.singleton<_i23.CalendarRepository>(() => calendarModule.taskRepository(
          gh<_i11.FirebaseFirestore>(),
          gh<_i12.FirebaseFunctions>(),
          gh<_i14.IntegrationsRepository>(),
          gh<_i4.AuthenticationRepositoryContract>(),
        ));
    gh.lazySingleton<_i24.IntegrationsCubit>(() => integrationsModule
        .integrationsCubit(gh<_i14.IntegrationsRepository>()));
    gh.lazySingleton<_i25.UserCubit>(
        () => userModule.userCubit(gh<_i20.UserRepository>()));
    gh.factoryParam<_i26.AiAssistantChatBloc, List<String>, dynamic>((
      initialBotMessages,
      _,
    ) =>
        aIAssistantChatModule.aiAssistantChatBloc(
          gh<_i22.BlueprintRepository>(),
          gh<_i18.TaskRepository>(),
          gh<_i9.Uuid>(),
          initialBotMessages,
        ));
    gh.lazySingleton<_i27.BlueprintBloc>(
        () => blueprintModule.blueprintBloc(gh<_i22.BlueprintRepository>()));
    return this;
  }
}

class _$CoreModule extends _i28.CoreModule {}

class _$AuthenticationModule extends _i29.AuthenticationModule {}

class _$FirebaseModule extends _i30.FirebaseModule {}

class _$SettingsModule extends _i31.SettingsModule {}

class _$IntegrationsModule extends _i32.IntegrationsModule {}

class _$TaskModule extends _i33.TaskModule {}

class _$UserModule extends _i34.UserModule {}

class _$BlueprintModule extends _i35.BlueprintModule {}

class _$CalendarModule extends _i36.CalendarModule {}

class _$AIAssistantChatModule extends _i37.AIAssistantChatModule {}
