import 'package:blueprint/settings/state_management/bloc/settings_bloc.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SettingsModule {
  @lazySingleton
  SettingsBloc settingsBloc() => SettingsBloc();
}
