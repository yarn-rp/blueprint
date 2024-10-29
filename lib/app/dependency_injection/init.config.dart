// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ai_client/ai_client.dart' as _i150;
import 'package:authentication_repository/authentication_repository.dart'
    as _i223;
import 'package:blueprint/ai_assistant_chat/module/ai_assistant_chat_module.dart'
    as _i1028;
import 'package:blueprint/ai_assistant_chat/state_management/bloc/ai_assistant_chat_bloc.dart'
    as _i571;
import 'package:blueprint/authentication/module/authentication_module.dart'
    as _i688;
import 'package:blueprint/authentication/state_management/authentication_cubit/authentication_cubit.dart'
    as _i90;
import 'package:blueprint/authentication/state_management/forgot_password_cubit/forgot_password_cubit.dart'
    as _i479;
import 'package:blueprint/authentication/state_management/sign_in_cubit/sign_in_cubit.dart'
    as _i448;
import 'package:blueprint/authentication/state_management/sign_out_cubit/sign_out_cubit.dart'
    as _i249;
import 'package:blueprint/authentication/state_management/sign_up_cubit/sign_up_cubit.dart'
    as _i360;
import 'package:blueprint/blueprint/module/blueprint_module.dart' as _i523;
import 'package:blueprint/blueprint/state_management/blueprint_bloc/blueprint_bloc.dart'
    as _i462;
import 'package:blueprint/calendar/module/calendar_module.dart' as _i179;
import 'package:blueprint/core/module/core_module.dart' as _i324;
import 'package:blueprint/core/module/firebase_module.dart' as _i730;
import 'package:blueprint/integrations/module/integrations_module.dart' as _i65;
import 'package:blueprint/integrations/state_management/integrations_repository/integrations_cubit.dart'
    as _i527;
import 'package:blueprint/settings/module/settings_module.dart' as _i382;
import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart'
    as _i816;
import 'package:blueprint/tasks/module/task_module.dart' as _i324;
import 'package:blueprint/tasks/state_management/bloc/create_task_bloc.dart'
    as _i427;
import 'package:blueprint/tasks/state_management/cubit/tasks_cubit.dart'
    as _i91;
import 'package:blueprint/users/module/user_module.dart' as _i643;
import 'package:blueprint/users/state_management/cubit/user_cubit.dart'
    as _i515;
import 'package:blueprint_repository/blueprint_repository.dart' as _i581;
import 'package:calendar_repository/calendar_repository.dart' as _i291;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:integrations_repository/integrations_repository.dart' as _i327;
import 'package:task_repository/task_repository.dart' as _i0;
import 'package:user_repository/user_repository.dart' as _i164;
import 'package:uuid/uuid.dart' as _i706;

const String _dev = 'dev';
const String _local = 'local';
const String _prod = 'prod';
const String _stg = 'stg';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
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
    gh.lazySingleton<_i816.SettingsBloc>(() => settingsModule.settingsBloc());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => coreModule.flutterSecureStorage());
    gh.lazySingleton<_i706.Uuid>(() => coreModule.uuid());
    gh.lazySingleton<_i150.AiClient>(() => coreModule.aiClient());
    gh.lazySingleton<_i116.GoogleSignIn>(() => coreModule.googleSignIn());
    gh.lazySingleton<_i223.AppleAuthenticationProvider>(
        () => authenticationModule.appleAuthenticationProvider());
    gh.lazySingleton<_i223.FacebookAuthenticationProvider>(
        () => authenticationModule.facebookAuthenticationProvider());
    gh.lazySingleton<_i223.GoogleAuthenticationProvider>(() =>
        authenticationModule
            .googleAuthenticationProvider(gh<_i116.GoogleSignIn>()));
    gh.singleton<_i982.FirebaseOptions>(
      () => firebaseModule.developmentFirebaseOptions,
      registerFor: {_dev},
    );
    gh.singleton<_i982.FirebaseOptions>(
      () => firebaseModule.localFirebaseOptions,
      registerFor: {_local},
    );
    await gh.singletonAsync<_i982.FirebaseApp>(
      () => firebaseModule.firebaseApp(gh<_i982.FirebaseOptions>()),
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(
        () => firebaseModule.firebaseAuth(gh<_i982.FirebaseApp>()));
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore(gh<_i982.FirebaseApp>()));
    gh.lazySingleton<_i809.FirebaseFunctions>(
        () => firebaseModule.firebaseFunctions(gh<_i982.FirebaseApp>()));
    gh.singleton<_i982.FirebaseOptions>(
      () => firebaseModule.productionFirebaseOptions,
      registerFor: {_prod},
    );
    gh.singleton<_i982.FirebaseOptions>(
      () => firebaseModule.stagingFirebaseOptions,
      registerFor: {_stg},
    );
    gh.lazySingleton<_i223.AuthenticationRepositoryContract>(
        () => authenticationModule.authenticationRepository(
              gh<_i223.AppleAuthenticationProvider>(),
              gh<_i223.GoogleAuthenticationProvider>(),
              gh<_i223.FacebookAuthenticationProvider>(),
              gh<_i59.FirebaseAuth>(),
            ));
    gh.lazySingleton<_i164.UserRepository>(() => userModule.userRepository(
          gh<_i974.FirebaseFirestore>(),
          gh<_i223.AuthenticationRepositoryContract>(),
        ));
    gh.lazySingleton<_i90.AuthenticationCubit>(() => authenticationModule
        .authenticationCubit(gh<_i223.AuthenticationRepositoryContract>()));
    gh.factory<_i448.SignInCubit>(() => authenticationModule
        .signInCubit(gh<_i223.AuthenticationRepositoryContract>()));
    gh.factory<_i360.SignUpCubit>(() => authenticationModule
        .signUpCubit(gh<_i223.AuthenticationRepositoryContract>()));
    gh.factory<_i249.SignOutCubit>(() => authenticationModule
        .signOutCubit(gh<_i223.AuthenticationRepositoryContract>()));
    gh.factory<_i479.ForgotPasswordCubit>(() => authenticationModule
        .forgotPasswordCubit(gh<_i223.AuthenticationRepositoryContract>()));
    gh.lazySingleton<_i327.IntegrationsRepository>(
        () => integrationsModule.integrationsRepository(
              gh<_i974.FirebaseFirestore>(),
              gh<_i809.FirebaseFunctions>(),
              gh<_i223.AuthenticationRepositoryContract>(),
            ));
    gh.lazySingleton<_i581.BlueprintRepository>(
        () => blueprintModule.blueprintRepository(
              gh<_i974.FirebaseFirestore>(),
              gh<_i327.IntegrationsRepository>(),
              gh<_i223.AuthenticationRepositoryContract>(),
              gh<_i150.AiClient>(),
              gh<_i706.Uuid>(),
            ));
    gh.lazySingleton<_i515.UserCubit>(
        () => userModule.userCubit(gh<_i164.UserRepository>()));
    gh.lazySingleton<_i462.BlueprintBloc>(
        () => blueprintModule.blueprintBloc(gh<_i581.BlueprintRepository>()));
    gh.lazySingleton<_i527.IntegrationsCubit>(() => integrationsModule
        .integrationsCubit(gh<_i327.IntegrationsRepository>()));
    gh.singleton<_i0.TaskRepository>(() => taskModule.taskRepository(
          gh<_i974.FirebaseFirestore>(),
          gh<_i809.FirebaseFunctions>(),
          gh<_i327.IntegrationsRepository>(),
          gh<_i223.AuthenticationRepositoryContract>(),
        ));
    gh.singleton<_i291.CalendarRepository>(() => calendarModule.taskRepository(
          gh<_i974.FirebaseFirestore>(),
          gh<_i809.FirebaseFunctions>(),
          gh<_i327.IntegrationsRepository>(),
          gh<_i223.AuthenticationRepositoryContract>(),
        ));
    gh.factoryParam<_i571.AiAssistantChatBloc, List<String>, dynamic>((
      initialBotMessages,
      _,
    ) =>
        aIAssistantChatModule.aiAssistantChatBloc(
          gh<_i581.BlueprintRepository>(),
          gh<_i0.TaskRepository>(),
          gh<_i706.Uuid>(),
          initialBotMessages,
        ));
    gh.factory<_i427.CreateTaskBloc>(
        () => _i427.CreateTaskBloc(taskRepository: gh<_i0.TaskRepository>()));
    gh.factory<_i91.TasksCubit>(() => taskModule.taskCubit(
          gh<_i0.TaskRepository>(),
          gh<_i327.IntegrationsRepository>(),
        ));
    return this;
  }
}

class _$SettingsModule extends _i382.SettingsModule {}

class _$CoreModule extends _i324.CoreModule {}

class _$AuthenticationModule extends _i688.AuthenticationModule {}

class _$FirebaseModule extends _i730.FirebaseModule {}

class _$UserModule extends _i643.UserModule {}

class _$IntegrationsModule extends _i65.IntegrationsModule {}

class _$BlueprintModule extends _i523.BlueprintModule {}

class _$TaskModule extends _i324.TaskModule {}

class _$CalendarModule extends _i179.CalendarModule {}

class _$AIAssistantChatModule extends _i1028.AIAssistantChatModule {}
