import 'package:bloc/bloc.dart';
import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:equatable/equatable.dart';

part 'blueprint_event.dart';
part 'blueprint_state.dart';

class BlueprintBloc extends Bloc<BlueprintEvent, BlueprintState> {
  BlueprintBloc() : super(const BlueprintInitial()) {
    on<BlueprintEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
