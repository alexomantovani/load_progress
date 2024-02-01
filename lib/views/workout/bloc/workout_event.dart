part of 'workout_bloc.dart';

sealed class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

final class CreateWorkoutEvent extends WorkoutEvent {
  final List<dynamic> body;
  final String email;
  final String tipoTreino;

  const CreateWorkoutEvent({
    required this.email,
    required this.tipoTreino,
    required this.body,
  });

  @override
  List<Object> get props => [email, tipoTreino, body];
}
