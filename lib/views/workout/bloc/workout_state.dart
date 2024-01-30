part of 'workout_bloc.dart';

sealed class WorkoutState extends Equatable {
  const WorkoutState();
  
  @override
  List<Object> get props => [];
}

final class WorkoutInitialState extends WorkoutState {}

final class CreatingWorkoutState extends WorkoutState {}

final class WorkoutCreatedState extends WorkoutState {
  final Map<String, dynamic> response;

  const WorkoutCreatedState({required this.response});

  @override
  List<Object> get props => [response];
}

final class WorkoutFailureState extends WorkoutState {
  final String message;

  const WorkoutFailureState({required this.message});

  @override
  List<String> get props => [message];
}
