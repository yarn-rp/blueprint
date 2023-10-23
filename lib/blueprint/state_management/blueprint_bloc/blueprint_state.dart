part of 'blueprint_bloc.dart';

sealed class BlueprintState extends Equatable {
  const BlueprintState();
}

class BlueprintInitial extends BlueprintState {
  const BlueprintInitial();

  @override
  List<Object?> get props => [];
}
